Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17948.32242.401443.930716@cargo.ozlabs.ibm.com>
Date: Wed, 11 Apr 2007 16:19:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH] POWERPC: CPU15 workaround for mpc8xx
In-Reply-To: <20070402221110.4255.74986.stgit@localhost.localdomain>
References: <20070402221110.4255.74986.stgit@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug writes:

> Implements workaround for CPU15 Silicon Errata on MPC8xx processors.
> Based on the DENX workaround patches.

> +config 8xx_CPU15_SYSCTL
> +	bool "CPU15 Silicon Errata Sysctl"
> +	depends on 8xx_CPU15
> +	default y

No help text for this one?

> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -165,6 +165,7 @@ enum
>  	KERN_MAX_LOCK_DEPTH=74,
>  	KERN_NMI_WATCHDOG=75, /* int: enable/disable nmi watchdog */
>  	KERN_PANIC_ON_NMI=76, /* int: whether we will panic on an unrecovered */
> +	KERN_8XX_CPU15=77, /* boolean: patch cpu15 errata on mpc8xx cpu */

I believe that adding new sysctls is frowned upon these days, isn't
it?

> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -158,6 +158,63 @@ extern ctl_table inotify_table[];
>  int sysctl_legacy_va_layout;
>  #endif
>  
> +static void *get_uts(ctl_table *table, int write)
> +{
> +	char *which = table->data;
> +#ifdef CONFIG_UTS_NS
> +	struct uts_namespace *uts_ns = current->nsproxy->uts_ns;
> +	which = (which - (char *)&init_uts_ns) + (char *)uts_ns;
> +#endif
> +	if (!write)
> +		down_read(&uts_sem);
> +	else
> +		down_write(&uts_sem);
> +	return which;
> +}
> +
> +static void put_uts(ctl_table *table, int write, void *which)
> +{
> +	if (!write)
> +		up_read(&uts_sem);
> +	else
> +		up_write(&uts_sem);
> +}
> +
> +#ifdef CONFIG_SYSVIPC
> +static void *get_ipc(ctl_table *table, int write)
> +{
> +	char *which = table->data;
> +	struct ipc_namespace *ipc_ns = current->nsproxy->ipc_ns;
> +	which = (which - (char *)&init_ipc_ns) + (char *)ipc_ns;
> +	return which;
> +}
> +#else
> +#define get_ipc(T,W) ((T)->data)
> +#endif
> +
> +/* /proc declarations: */
> +
> +#ifdef CONFIG_PROC_SYSCTL
> +
> +static ssize_t proc_readsys(struct file *, char __user *, size_t, loff_t *);
> +static ssize_t proc_writesys(struct file *, const char __user *, size_t, loff_t *);
> +static int proc_opensys(struct inode *, struct file *);
> +
> +const struct file_operations proc_sys_file_operations = {
> +	.open		= proc_opensys,
> +	.read		= proc_readsys,
> +	.write		= proc_writesys,
> +};
> +
> +extern struct proc_dir_entry *proc_sys_root;
> +
> +static void register_proc_table(ctl_table *, struct proc_dir_entry *, void *);
> +static void unregister_proc_table(ctl_table *, struct proc_dir_entry *);
> +#endif
> +
> +#ifdef CONFIG_8xx_CPU15_SYSCTL
> +int cpu15_fix = 0;      /* disabled by default */
> +#endif

Why is all that being added back?

Paul.
