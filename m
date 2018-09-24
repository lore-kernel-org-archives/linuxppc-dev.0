Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Jj4V30nGzF0RC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 21:42:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 aravinda@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/pseries: Export raw per-CPU VPA data via debugfs
In-Reply-To: <153743854746.12332.9507208773294249019.stgit@aravinda>
References: <153743854746.12332.9507208773294249019.stgit@aravinda>
Date: Mon, 24 Sep 2018 21:42:49 +1000
Message-ID: <87pnx35dfq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aravinda,

Aravinda Prasad <aravinda@linux.vnet.ibm.com> writes:

> This patch exports the raw per-CPU VPA data via debugfs.
> A per-CPU file is created which exports the VPA data of
> that CPU to help debug some of the VPA related issues or
> to analyze the per-CPU VPA related statistics.

Do we really need this in debugfs? I'm not saying we don't, but I'm also
not really clear why we need it.

If there is a good reason for exporting it, do we really want to export
it in distro kernels, or should it be behind a CONFIG ?

> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index d3992ce..cc12c12 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -48,6 +48,7 @@
>  #include <asm/kexec.h>
>  #include <asm/fadump.h>
>  #include <asm/asm-prototypes.h>
> +#include <asm/debugfs.h>
>  
>  #include "pseries.h"
>  
> @@ -64,6 +65,16 @@ EXPORT_SYMBOL(plpar_hcall);
>  EXPORT_SYMBOL(plpar_hcall9);
>  EXPORT_SYMBOL(plpar_hcall_norets);
>  
> +#ifdef CONFIG_DEBUG_FS
> +struct vpa {
> +	struct dentry	*file;

You never use this other than temporarily when creating the file.

> +	int		cpu;
> +};
> +static DEFINE_PER_CPU(struct vpa, cpu_vpa);

And you never really use the per_cpu() either.

So you don't need the vpa struct at all AFAICS.

> +
> +static struct dentry *vpa_dir;

That can just be a local in vpa_debugfs_init().

> +#endif
> +
>  void vpa_init(int cpu)
>  {
>  	int hwcpu = get_hard_smp_processor_id(cpu);
> @@ -1028,3 +1039,77 @@ static int __init reserve_vrma_context_id(void)
>  	return 0;
>  }
>  machine_device_initcall(pseries, reserve_vrma_context_id);
> +
> +#ifdef CONFIG_DEBUG_FS
> +/* debugfs file interface for vpa data */
> +static ssize_t vpa_file_read(struct file *filp, char __user *buf, size_t len,
> +		loff_t *pos)

Like this please:

static ssize_t vpa_file_read(struct file *filp, char __user *buf, size_t len,
			     loff_t *pos)

> +{
> +	long int rc;
> +	struct vpa *vpa = filp->private_data;
> +	struct lppaca *lppaca = &lppaca_of(vpa->cpu);

Once you've stashed the CPU number in private_data (see below) you can
get it back with:

	int cpu = (long)filp->private_data;
	struct lppaca *lppaca = &lppaca_of(cpu);

> +
> +	if (len < sizeof(struct lppaca))
> +		return -EINVAL;
> +
> +	rc = copy_to_user(buf, lppaca, sizeof(struct lppaca));
> +	if (rc)
> +		return -EFAULT;

You should use simple_read_from_buffer().

> +
> +	return 0;
> +}
> +
> +static int vpa_file_open(struct inode *inode, struct file *filp)
> +{
> +	struct vpa *vpa = inode->i_private;
> +
> +	filp->private_data = vpa;
> +	return 0;
> +}

You can just use simple_open().

> +static int vpa_file_release(struct inode *inode, struct file *filp)
> +{
> +	return 0;
> +}

I don't think you need release if it's empty.

> +static const struct file_operations vpa_fops = {
> +	.open		= vpa_file_open,
> +	.release	= vpa_file_release,
> +	.read		= vpa_file_read,
> +	.llseek		= no_llseek,
> +};
> +
> +static int __init vpa_debugfs_init(void)
> +{
> +	char name[10];

That's not big enough if you end up with 4 billion CPUs. Make it 16.

> +	int i;
> +
> +	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
> +		return 0;
> +
> +	vpa_dir = debugfs_create_dir("vpa", powerpc_debugfs_root);
> +	if (!vpa_dir) {
> +		pr_warn("%s: can't create vpa root dir\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	/* set up the per-cpu vpa file*/
> +	for_each_possible_cpu(i) {

What happens when you read the file for a possible but not present CPU?

> +		struct vpa *vpa = &per_cpu(cpu_vpa, i);
> +
> +		vpa->cpu = i;
> +		sprintf(name, "cpu-%d", i);
> +
> +		vpa->file = debugfs_create_file(name, 0400, vpa_dir, vpa,
> +					&vpa_fops);

Can be:
		struct dentry *d;
		d = debugfs_create_file(name, 0400, dir, (void *)cpu, &vpa_fops);

Where you're stashing the cpu number in the private_data as a void *.

> +		if (!vpa->file) {
> +			pr_warn("%s: can't create per-cpu vpa file\n",
> +					__func__);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +machine_arch_initcall(pseries, vpa_debugfs_init);
> +#endif /* CONFIG_DEBUG_FS */


cheers
