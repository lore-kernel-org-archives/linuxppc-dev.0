Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3557A1A0AE1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 17:07:13 +1000 (EST)
Message-ID: <1410937632.27681.11.camel@concordia>
Subject: Re: [3/5] pseries: Create device hotplug entry point
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 17 Sep 2014 17:07:12 +1000
In-Reply-To: <54174CB7.2080704@linux.vnet.ibm.com>
References: <54174CB7.2080704@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, 2014-09-15 at 15:31 -0500, Nathan Fontenot wrote:
> For pseries system the kernel will be notified of hotplug requests in
> the form of rtas hotplug events. 

Can you flesh that design out a bit for me, I don't entirely get how it's going
to work.

The kernel gets the rtas hotplug events (in rtasd.c) and spits them out to
userspace, which then writes them back in ?

> This patch creates a common routine that can handle these requests in both
> the PowerVM anbd PowerKVM environments, handle_dlpar_errorlog(). This also
                ^
> creates the initial memory hotplug request handling stub.
>
> For PowerVM this patch also creates a new /proc file that the drmgr
> command will use to write rtas hotplug events to.

Why is this different between phyp and KVM?

> For future PowerKVM handling the rtas check-exception code can pass
> any rtas hotplug events received to handle_dlpar_errorlog().

Internally to the kernel you mean?

> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index a2450b8..574ec73 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -16,7 +16,9 @@
>  #include <linux/cpu.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/proc_fs.h>
>  #include "offline_states.h"
> +#include "pseries.h"
>  
>  #include <asm/prom.h>
>  #include <asm/machdep.h>
> @@ -530,13 +532,72 @@ static ssize_t dlpar_cpu_release(const char *buf, size_t count)
>  	return count;
>  }
>  
> +#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */

That is really confusing, but I think it's just a diff artifact?

> +static int handle_dlpar_errorlog(struct rtas_error_log *error_log)
> +{
> +	struct pseries_errorlog *pseries_log;
> +	struct pseries_hp_errorlog *hp_elog;
> +	int rc = -EINVAL;
> +
> +	pseries_log = get_pseries_errorlog(error_log,
> +					   PSERIES_ELOG_SECT_ID_HOTPLUG);
> +	if (!pseries_log)
> +		return rc;
> +
> +	hp_elog = (struct pseries_hp_errorlog *)pseries_log->data;
> +	if (!hp_elog)
> +		return rc;

I don't see how that can happen?

struct pseries_errorlog {
	__be16 id;			/* 0x00 2-byte ASCII section ID	*/
	__be16 length;			/* 0x02 Section length in bytes	*/
	uint8_t version;		/* 0x04 Section version		*/
	uint8_t subtype;		/* 0x05 Section subtype		*/
	__be16 creator_component;	/* 0x06 Creator component ID	*/
	uint8_t data[];			/* 0x08 Start of section data	*/
};

Should you be checking for length == 0 instead ?

Also I think the code will probably end up cleaner if you do the endian
conversions immediately when you read the hp_elog, rather than passing it
around in BE and having to remember to convert at all the usages.

> +	switch (hp_elog->resource) {
> +	case PSERIES_HP_ELOG_RESOURCE_MEM:
> +		rc = dlpar_memory(hp_elog);
> +		break;

Please add:

  default:
	pr_warn_ratelimited("Unknown resource ..")

Or something.


> +	}
> +
> +	return rc;
> +}
> +
> +static ssize_t dlpar_write(struct file *file, const char __user *buf,
> +			   size_t count, loff_t *offset)
> +{
> +	char *event_buf;
> +	int rc;
> +
> +	event_buf = kmalloc(count + 1, GFP_KERNEL);

Why + 1 ? It's not null-terminated AFAICS.

> +	if (!event_buf)
> +		return -ENOMEM;
> +
> +	rc = copy_from_user(event_buf, buf, count);
> +	if (rc) {
> +		kfree(event_buf);
> +		return rc;
> +	}
> +
> +	rc = handle_dlpar_errorlog((struct rtas_error_log *)event_buf);

If you start with a struct rtas_error_log * you shouldn't need any casts.

> +	kfree(event_buf);
> +	return rc ? rc : count;
> +}
> +
> +static const struct file_operations dlpar_fops = {
> +	.write = dlpar_write,
> +	.llseek = noop_llseek,
> +};
> +
>  static int __init pseries_dlpar_init(void)
>  {
> +	struct proc_dir_entry *proc_ent;
> +
> +	proc_ent = proc_create("powerpc/dlpar", S_IWUSR, NULL, &dlpar_fops);
> +	if (proc_ent)
> +		proc_set_size(proc_ent, 0);

  else
	error message at least please

Why are we putting it in /proc, can't it go in /sys/kernel like the mobility
stuff?

> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 24abc5c..0e60e15 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -20,6 +22,9 @@
>  #include <asm/machdep.h>
>  #include <asm/prom.h>
>  #include <asm/sparsemem.h>
> +#include <asm/rtas.h>
> +
> +DEFINE_MUTEX(dlpar_mem_mutex);

static ?

> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
> index b94516b..28bd994 100644
> --- a/arch/powerpc/platforms/pseries/pseries.h
> +++ b/arch/powerpc/platforms/pseries/pseries.h
> @@ -62,6 +63,15 @@ extern int dlpar_detach_node(struct device_node *);
>  extern int dlpar_acquire_drc(u32);
>  extern int dlpar_release_drc(u32);
>  
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +extern int dlpar_memory(struct pseries_hp_errorlog *);
> +#else
> +static inline int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
> +{
> +	return -ENOTSUPP;

EOPNOTSUPP is a bit more standard.

cheers
