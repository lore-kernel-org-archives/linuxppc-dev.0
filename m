Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D39C433E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 12:55:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE42021734
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 12:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE42021734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BscPs2J9HzDqXV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 22:55:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bsbjh1dpHzDqYV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 22:23:52 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 26AF7B35E;
 Thu, 17 Sep 2020 12:24:23 +0000 (UTC)
Date: Thu, 17 Sep 2020 14:23:48 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>
Subject: Re: [PATCH 2/3] powerpc/mce: Add debugfs interface to inject MCE
Message-ID: <20200917122348.GQ29778@kitsune.suse.cz>
References: <20200916172228.83271-1-ganeshgr@linux.ibm.com>
 <20200916172228.83271-3-ganeshgr@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916172228.83271-3-ganeshgr@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, mahesh@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

On Wed, Sep 16, 2020 at 10:52:27PM +0530, Ganesh Goudar wrote:
> To test machine check handling, add debugfs interface to inject
> slb multihit errors.
> 
> To inject slb multihit:
>  #echo 1 > /sys/kernel/debug/powerpc/mce_error_inject/inject_slb_multihit
> 
> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/Kconfig.debug             |   9 ++
>  arch/powerpc/sysdev/Makefile           |   2 +
>  arch/powerpc/sysdev/mce_error_inject.c | 148 +++++++++++++++++++++++++
>  3 files changed, 159 insertions(+)
>  create mode 100644 arch/powerpc/sysdev/mce_error_inject.c
> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index b88900f4832f..61db133f2f0d 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -398,3 +398,12 @@ config KASAN_SHADOW_OFFSET
>  	hex
>  	depends on KASAN
>  	default 0xe0000000
> +
> +config MCE_ERROR_INJECT
> +	bool "Enable MCE error injection through debugfs"
> +	depends on DEBUG_FS
> +	default y
> +	help
> +	  This option creates an mce_error_inject directory in the
> +	  powerpc debugfs directory that allows limited injection of
> +	  Machine Check Errors (MCEs).
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> index 026b3f01a991..7fc102222b77 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -52,3 +52,5 @@ obj-$(CONFIG_PPC_XICS)		+= xics/
>  obj-$(CONFIG_PPC_XIVE)		+= xive/
>  
>  obj-$(CONFIG_GE_FPGA)		+= ge/
> +
> +obj-$(CONFIG_MCE_ERROR_INJECT)	+= mce_error_inject.o
> diff --git a/arch/powerpc/sysdev/mce_error_inject.c b/arch/powerpc/sysdev/mce_error_inject.c
> new file mode 100644
> index 000000000000..ca4726bfa2d9
> --- /dev/null
> +++ b/arch/powerpc/sysdev/mce_error_inject.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Machine Check Exception injection code
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +#include <linux/fs.h>
> +#include <linux/debugfs.h>
> +#include <asm/debugfs.h>
> +
> +static inline unsigned long get_slb_index(void)
> +{
> +	unsigned long index;
> +
> +	index = get_paca()->stab_rr;
> +
> +	/*
> +	 * simple round-robin replacement of slb starting at SLB_NUM_BOLTED.
> +	 */
> +	if (index < (mmu_slb_size - 1))
> +		index++;
> +	else
> +		index = SLB_NUM_BOLTED;
> +	get_paca()->stab_rr = index;
> +	return index;
> +}
> +
> +#define slb_esid_mask(ssize)	\
> +	(((ssize) == MMU_SEGSIZE_256M) ? ESID_MASK : ESID_MASK_1T)
> +
> +static inline unsigned long mk_esid_data(unsigned long ea, int ssize,
> +					 unsigned long slot)
> +{
> +	return (ea & slb_esid_mask(ssize)) | SLB_ESID_V | slot;
> +}
> +
> +#define slb_vsid_shift(ssize)	\
> +	((ssize) == MMU_SEGSIZE_256M ? SLB_VSID_SHIFT : SLB_VSID_SHIFT_1T)
> +
> +static inline unsigned long mk_vsid_data(unsigned long ea, int ssize,
> +					 unsigned long flags)
> +{
> +	return (get_kernel_vsid(ea, ssize) << slb_vsid_shift(ssize)) | flags |
> +		((unsigned long)ssize << SLB_VSID_SSIZE_SHIFT);
> +}
> +
> +static void insert_slb_entry(char *p, int ssize)
> +{
> +	unsigned long flags, entry;
> +	struct paca_struct *paca;
> +
> +	flags = SLB_VSID_KERNEL | mmu_psize_defs[MMU_PAGE_64K].sllp;
> +
> +	preempt_disable();
> +
> +	paca = get_paca();
This seems unused?
> +
> +	entry = get_slb_index();
> +	asm volatile("slbmte %0,%1" :
> +			: "r" (mk_vsid_data((unsigned long)p, ssize, flags)),
> +			  "r" (mk_esid_data((unsigned long)p, ssize, entry))
> +			: "memory");
> +
> +	entry = get_slb_index();
> +	asm volatile("slbmte %0,%1" :
> +			: "r" (mk_vsid_data((unsigned long)p, ssize, flags)),
> +			  "r" (mk_esid_data((unsigned long)p, ssize, entry))
> +			: "memory");
> +	preempt_enable();
> +	p[0] = '!';
> +}
> +
> +static void inject_vmalloc_slb_multihit(void)
> +{
> +	char *p;
> +
> +	p = vmalloc(2048);
> +	if (!p)
> +		return;
> +
> +	insert_slb_entry(p, MMU_SEGSIZE_1T);
> +	vfree(p);
> +}
> +
> +static void inject_kmalloc_slb_multihit(void)
> +{
> +	char *p;
> +
> +	p = kmalloc(2048, GFP_KERNEL);
> +	if (!p)
> +		return;
> +
> +	insert_slb_entry(p, MMU_SEGSIZE_1T);
> +	kfree(p);
> +}
> +
> +static ssize_t inject_slb_multihit(const char __user *u_buf, size_t count)
> +{
> +	char buf[32];
> +	size_t buf_size;
> +
> +	buf_size = min(count, (sizeof(buf) - 1));
> +	if (copy_from_user(buf, u_buf, buf_size))
> +		return -EFAULT;
> +	buf[buf_size] = '\0';
> +
> +	if (buf[0] != '1')
> +		return -EINVAL;
> +
> +	inject_vmalloc_slb_multihit();
> +	inject_kmalloc_slb_multihit();
This is missing the test of multihit in paca which is for some reason
special.

Thanks

Michal
> +	return count;
> +}
> +
> +static ssize_t inject_write(struct file *file, const char __user *buf,
> +			    size_t count, loff_t *ppos)
> +{
> +	static ssize_t (*func)(const char __user *, size_t);
> +
> +	func = file->f_inode->i_private;
> +	return func(buf, count);
> +}
> +
> +static const struct file_operations inject_fops = {
> +	.write		= inject_write,
> +	.llseek		= default_llseek,
> +};
> +
> +static int mce_error_inject_setup(void)
> +{
> +	struct dentry *mce_error_inject_dir;
> +
> +	mce_error_inject_dir = debugfs_create_dir("mce_error_inject",
> +						  powerpc_debugfs_root);
> +
> +	if (mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
> +		(void)debugfs_create_file("inject_slb_multihit", 0200,
> +					  mce_error_inject_dir,
> +					  &inject_slb_multihit,
> +					  &inject_fops);
> +	}
> +
> +	return 0;
> +}
> +
> +device_initcall(mce_error_inject_setup);
> -- 
> 2.26.2
> 
