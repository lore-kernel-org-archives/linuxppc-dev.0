Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KB2K6VyszDrSK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 16:27:37 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8P6PnVO066608
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 02:27:35 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mqctce3k3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 02:27:34 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Tue, 25 Sep 2018 02:24:46 -0400
Subject: Re: [PATCH] powerpc/pseries: Export raw per-CPU VPA data via debugfs
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com
References: <153743854746.12332.9507208773294249019.stgit@aravinda>
 <87pnx35dfq.fsf@concordia.ellerman.id.au>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Tue, 25 Sep 2018 11:54:39 +0530
MIME-Version: 1.0
In-Reply-To: <87pnx35dfq.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <98002595-211a-4a73-f258-5201e8cc9293@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Monday 24 September 2018 05:12 PM, Michael Ellerman wrote:
> Hi Aravinda,
> 
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> writes:
> 
>> This patch exports the raw per-CPU VPA data via debugfs.
>> A per-CPU file is created which exports the VPA data of
>> that CPU to help debug some of the VPA related issues or
>> to analyze the per-CPU VPA related statistics.
> 
> Do we really need this in debugfs? I'm not saying we don't, but I'm also
> not really clear why we need it.

Two reasons. First, if a new stat from VPA needs to be exported to user,
then we end up with a kernel patch. By exporting the VPA data, only the
user space tool needs to be updated.

Second is that we need this if we want to debug any per-CPU statistics
like stolen time etc.

> 
> If there is a good reason for exporting it, do we really want to export
> it in distro kernels, or should it be behind a CONFIG ?

I am fine to put this behind a CONFIG.

> 
>> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
>> index d3992ce..cc12c12 100644
>> --- a/arch/powerpc/platforms/pseries/lpar.c
>> +++ b/arch/powerpc/platforms/pseries/lpar.c
>> @@ -48,6 +48,7 @@
>>  #include <asm/kexec.h>
>>  #include <asm/fadump.h>
>>  #include <asm/asm-prototypes.h>
>> +#include <asm/debugfs.h>
>>  
>>  #include "pseries.h"
>>  
>> @@ -64,6 +65,16 @@ EXPORT_SYMBOL(plpar_hcall);
>>  EXPORT_SYMBOL(plpar_hcall9);
>>  EXPORT_SYMBOL(plpar_hcall_norets);
>>  
>> +#ifdef CONFIG_DEBUG_FS
>> +struct vpa {
>> +	struct dentry	*file;
> 
> You never use this other than temporarily when creating the file.
> 
>> +	int		cpu;
>> +};
>> +static DEFINE_PER_CPU(struct vpa, cpu_vpa);
> 
> And you never really use the per_cpu() either.
> 
> So you don't need the vpa struct at all AFAICS.

I now think so. Will rework on the patch.

> 
>> +
>> +static struct dentry *vpa_dir;
> 
> That can just be a local in vpa_debugfs_init().

ok.

> 
>> +#endif
>> +
>>  void vpa_init(int cpu)
>>  {
>>  	int hwcpu = get_hard_smp_processor_id(cpu);
>> @@ -1028,3 +1039,77 @@ static int __init reserve_vrma_context_id(void)
>>  	return 0;
>>  }
>>  machine_device_initcall(pseries, reserve_vrma_context_id);
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +/* debugfs file interface for vpa data */
>> +static ssize_t vpa_file_read(struct file *filp, char __user *buf, size_t len,
>> +		loff_t *pos)
> 
> Like this please:
> 
> static ssize_t vpa_file_read(struct file *filp, char __user *buf, size_t len,
> 			     loff_t *pos)
> 

noted

>> +{
>> +	long int rc;
>> +	struct vpa *vpa = filp->private_data;
>> +	struct lppaca *lppaca = &lppaca_of(vpa->cpu);
> 
> Once you've stashed the CPU number in private_data (see below) you can
> get it back with:
> 
> 	int cpu = (long)filp->private_data;
> 	struct lppaca *lppaca = &lppaca_of(cpu);

sure

> 
>> +
>> +	if (len < sizeof(struct lppaca))
>> +		return -EINVAL;
>> +
>> +	rc = copy_to_user(buf, lppaca, sizeof(struct lppaca));
>> +	if (rc)
>> +		return -EFAULT;
> 
> You should use simple_read_from_buffer().

ok

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int vpa_file_open(struct inode *inode, struct file *filp)
>> +{
>> +	struct vpa *vpa = inode->i_private;
>> +
>> +	filp->private_data = vpa;
>> +	return 0;
>> +}
> 
> You can just use simple_open().

ok

> 
>> +static int vpa_file_release(struct inode *inode, struct file *filp)
>> +{
>> +	return 0;
>> +}
> 
> I don't think you need release if it's empty.

noted

> 
>> +static const struct file_operations vpa_fops = {
>> +	.open		= vpa_file_open,
>> +	.release	= vpa_file_release,
>> +	.read		= vpa_file_read,
>> +	.llseek		= no_llseek,
>> +};
>> +
>> +static int __init vpa_debugfs_init(void)
>> +{
>> +	char name[10];
> 
> That's not big enough if you end up with 4 billion CPUs. Make it 16.

Will make it 16.

> 
>> +	int i;
>> +
>> +	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
>> +		return 0;
>> +
>> +	vpa_dir = debugfs_create_dir("vpa", powerpc_debugfs_root);
>> +	if (!vpa_dir) {
>> +		pr_warn("%s: can't create vpa root dir\n", __func__);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* set up the per-cpu vpa file*/
>> +	for_each_possible_cpu(i) {
> 
> What happens when you read the file for a possible but not present CPU?

Right now the VPA data is still fetched. We can have an additional check
in open or read to check if the CPU is online and return error if the
CPU is offline.

> 
>> +		struct vpa *vpa = &per_cpu(cpu_vpa, i);
>> +
>> +		vpa->cpu = i;
>> +		sprintf(name, "cpu-%d", i);
>> +
>> +		vpa->file = debugfs_create_file(name, 0400, vpa_dir, vpa,
>> +					&vpa_fops);
> 
> Can be:
> 		struct dentry *d;
> 		d = debugfs_create_file(name, 0400, dir, (void *)cpu, &vpa_fops);
> 
> Where you're stashing the cpu number in the private_data as a void *.

ok.

Regards,
Aravinda

> 
>> +		if (!vpa->file) {
>> +			pr_warn("%s: can't create per-cpu vpa file\n",
>> +					__func__);
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +machine_arch_initcall(pseries, vpa_debugfs_init);
>> +#endif /* CONFIG_DEBUG_FS */
> 
> 
> cheers
> 

-- 
Regards,
Aravinda
