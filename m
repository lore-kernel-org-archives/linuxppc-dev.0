Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wknPD45b1zDqL9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jun 2017 02:12:16 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v59G8lZU086171
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Jun 2017 12:12:13 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ayw2ydr9v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Jun 2017 12:12:12 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 9 Jun 2017 17:12:10 +0100
Subject: Re: [PATCH] cxl: Fixes for Coherent Accelerator Interface
 Architecture 2.0
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1497002949-8803-1-git-send-email-clombard@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 9 Jun 2017 18:12:06 +0200
MIME-Version: 1.0
In-Reply-To: <1497002949-8803-1-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0161a33c-362c-5f5c-1856-257da20c8e85@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Salut Christophe,

It looks pretty good, but checkpatch complains about 1 or 2 items worth 
fixing.

2 small remarks below.


Le 09/06/2017 à 12:09, Christophe Lombard a écrit :
> A previous set of patches "cxl: Add support for Coherent Accelerator
> Interface Architecture 2.0" has introduced a new support for the CAPI
> cards. These patches have been tested on Simulation environment and
> quite a bit of them have been tested on real hardware.
> 
> This patch brings new fixes after a series of tests carried out on
> new equipment.
> ---
>   drivers/misc/cxl/context.c |  6 +++---
>   drivers/misc/cxl/cxl.h     | 17 ++++-------------
>   drivers/misc/cxl/fault.c   | 19 ++++++++++++-------
>   drivers/misc/cxl/main.c    | 12 ++++++++----
>   drivers/misc/cxl/native.c  | 26 ++++++++++++++------------
>   drivers/misc/cxl/pci.c     | 11 ++++-------
>   6 files changed, 45 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
> index 4472ce1..8c32040 100644
> --- a/drivers/misc/cxl/context.c
> +++ b/drivers/misc/cxl/context.c
> @@ -45,7 +45,7 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
>   	mutex_init(&ctx->mapping_lock);
>   	ctx->mapping = NULL;
> 
> -	if (cxl_is_psl8(afu)) {
> +	if (cxl_is_power8()) {
>   		spin_lock_init(&ctx->sste_lock);
> 
>   		/*
> @@ -189,7 +189,7 @@ int cxl_context_iomap(struct cxl_context *ctx, struct vm_area_struct *vma)
>   		if (start + len > ctx->afu->adapter->ps_size)
>   			return -EINVAL;
> 
> -		if (cxl_is_psl9(ctx->afu)) {
> +		if (cxl_is_power9()) {
>   			/*
>   			 * Make sure there is a valid problem state
>   			 * area space for this AFU.
> @@ -324,7 +324,7 @@ static void reclaim_ctx(struct rcu_head *rcu)
>   {
>   	struct cxl_context *ctx = container_of(rcu, struct cxl_context, rcu);
> 
> -	if (cxl_is_psl8(ctx->afu))
> +	if (cxl_is_power8())
>   		free_page((u64)ctx->sstp);
>   	if (ctx->ff_page)
>   		__free_page(ctx->ff_page);
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index c8568ea..d516353 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -844,24 +844,15 @@ static inline bool cxl_is_power8(void)
> 
>   static inline bool cxl_is_power9(void)
>   {
> -	/* intermediate solution */
> -	if (!cxl_is_power8() &&
> -	   (cpu_has_feature(CPU_FTRS_POWER9) ||
> -	    cpu_has_feature(CPU_FTR_POWER9_DD1)))
> +	if (pvr_version_is(PVR_POWER9))
>   		return true;
>   	return false;
>   }
> 
> -static inline bool cxl_is_psl8(struct cxl_afu *afu)
> +static inline bool cxl_is_power9_dd1(void)
>   {
> -	if (afu->adapter->caia_major == 1)
> -		return true;
> -	return false;
> -}
> -
> -static inline bool cxl_is_psl9(struct cxl_afu *afu)
> -{
> -	if (afu->adapter->caia_major == 2)
> +	if ((pvr_version_is(PVR_POWER9)) &&
> +	    cpu_has_feature(CPU_FTR_POWER9_DD1))
>   		return true;
>   	return false;
>   }
> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index 5344448..866ff191 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c
> @@ -187,7 +187,7 @@ static struct mm_struct *get_mem_context(struct cxl_context *ctx)
> 
>   static bool cxl_is_segment_miss(struct cxl_context *ctx, u64 dsisr)
>   {
> -	if ((cxl_is_psl8(ctx->afu)) && (dsisr & CXL_PSL_DSISR_An_DS))
> +	if ((cxl_is_power8() && (dsisr & CXL_PSL_DSISR_An_DS)))
>   		return true;
> 
>   	return false;
> @@ -195,15 +195,20 @@ static bool cxl_is_segment_miss(struct cxl_context *ctx, u64 dsisr)
> 
>   static bool cxl_is_page_fault(struct cxl_context *ctx, u64 dsisr)
>   {
> -	if ((cxl_is_psl8(ctx->afu)) && (dsisr & CXL_PSL_DSISR_An_DM))
> +	u64 crs;
> +
> +	if ((cxl_is_power8()) && (dsisr & CXL_PSL_DSISR_An_DM))
>   		return true;
> 
> -	if ((cxl_is_psl9(ctx->afu)) &&
> -	   ((dsisr & CXL_PSL9_DSISR_An_CO_MASK) &
> -		(CXL_PSL9_DSISR_An_PF_SLR | CXL_PSL9_DSISR_An_PF_RGC |
> -		 CXL_PSL9_DSISR_An_PF_RGP | CXL_PSL9_DSISR_An_PF_HRH |
> -		 CXL_PSL9_DSISR_An_PF_STEG)))
> +	if (cxl_is_power9()) {
> +		crs = (dsisr & CXL_PSL9_DSISR_An_CO_MASK);
> +		if ((crs & CXL_PSL9_DSISR_An_PF_SLR) ||
> +		    (crs & CXL_PSL9_DSISR_An_PF_RGC) ||
> +		    (crs & CXL_PSL9_DSISR_An_PF_RGP) ||
> +		    (crs & CXL_PSL9_DSISR_An_PF_HRH) ||
> +		    (crs & CXL_PSL9_DSISR_An_PF_STEG))
>   		return true;
> +	}
> 
>   	return false;
>   }
> diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
> index 1703655..40c2b05 100644
> --- a/drivers/misc/cxl/main.c
> +++ b/drivers/misc/cxl/main.c
> @@ -329,8 +329,10 @@ static int __init init_cxl(void)
> 
>   	cxl_debugfs_init();
> 
> -	if ((rc = register_cxl_calls(&cxl_calls)))
> -		goto err;
> +	if (cxl_is_power8()) {
> +		if ((rc = register_cxl_calls(&cxl_calls)))
> +			goto err;
> +	}



I would add a comment to explain why we don't register the callbacks on 
p9 (i.e. slb callack is only for the PSL8 MMU and the others are dead 
code for CX4, which I'd like to remove once the CX5 patch is in).


> 
>   	if (cpu_has_feature(CPU_FTR_HVMODE)) {
>   		cxl_ops = &cxl_native_ops;
> @@ -347,7 +349,8 @@ static int __init init_cxl(void)
> 
>   	return 0;
>   err1:
> -	unregister_cxl_calls(&cxl_calls);
> +	if (cxl_is_power8())
> +		unregister_cxl_calls(&cxl_calls);
>   err:
>   	cxl_debugfs_exit();
>   	cxl_file_exit();
> @@ -366,7 +369,8 @@ static void exit_cxl(void)
> 
>   	cxl_debugfs_exit();
>   	cxl_file_exit();
> -	unregister_cxl_calls(&cxl_calls);
> +	if (cxl_is_power8())
> +		unregister_cxl_calls(&cxl_calls);
>   	idr_destroy(&cxl_adapter_idr);
>   }
> 
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 871a2f0..6ed0bf4 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -105,11 +105,13 @@ static int native_afu_reset(struct cxl_afu *afu)
>   			   CXL_AFU_Cntl_An_RS_MASK | CXL_AFU_Cntl_An_ES_MASK,
>   			   false);
> 
> -	/* Re-enable any masked interrupts */
> -	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
> -	serr &= ~CXL_PSL_SERR_An_IRQ_MASKS;
> -	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> -
> +	if (afu->current_mode == 0) {
> +		/* Re-enable any masked interrupts when the AFU is not
> +		 * activated */
> +		serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
> +		serr &= ~CXL_PSL_SERR_An_IRQ_MASKS;
> +		cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> +	}


What happens when the AFU is activated? Is that something we missed 
before, or a different behavior on P9?



> 
>   	return rc;
>   }
> @@ -139,9 +141,9 @@ int cxl_psl_purge(struct cxl_afu *afu)
> 
>   	pr_devel("PSL purge request\n");
> 
> -	if (cxl_is_psl8(afu))
> +	if (cxl_is_power8())
>   		trans_fault = CXL_PSL_DSISR_TRANS;
> -	if (cxl_is_psl9(afu))
> +	if (cxl_is_power9())
>   		trans_fault = CXL_PSL9_DSISR_An_TF;
> 
>   	if (!cxl_ops->link_ok(afu->adapter, afu)) {
> @@ -603,7 +605,7 @@ static u64 calculate_sr(struct cxl_context *ctx)
>   		if (!test_tsk_thread_flag(current, TIF_32BIT))
>   			sr |= CXL_PSL_SR_An_SF;
>   	}
> -	if (cxl_is_psl9(ctx->afu)) {
> +	if (cxl_is_power9()) {
>   		if (radix_enabled())
>   			sr |= CXL_PSL_SR_An_XLAT_ror;
>   		else
> @@ -1117,10 +1119,10 @@ static irqreturn_t native_handle_psl_slice_error(struct cxl_context *ctx,
> 
>   static bool cxl_is_translation_fault(struct cxl_afu *afu, u64 dsisr)
>   {
> -	if ((cxl_is_psl8(afu)) && (dsisr & CXL_PSL_DSISR_TRANS))
> +	if ((cxl_is_power8()) && (dsisr & CXL_PSL_DSISR_TRANS))
>   		return true;
> 
> -	if ((cxl_is_psl9(afu)) && (dsisr & CXL_PSL9_DSISR_An_TF))
> +	if ((cxl_is_power9()) && (dsisr & CXL_PSL9_DSISR_An_TF))
>   		return true;
> 
>   	return false;
> @@ -1194,10 +1196,10 @@ static void native_irq_wait(struct cxl_context *ctx)
>   		if (ph != ctx->pe)
>   			return;
>   		dsisr = cxl_p2n_read(ctx->afu, CXL_PSL_DSISR_An);
> -		if (cxl_is_psl8(ctx->afu) &&
> +		if (cxl_is_power8() &&
>   		   ((dsisr & CXL_PSL_DSISR_PENDING) == 0))
>   			return;
> -		if (cxl_is_psl9(ctx->afu) &&
> +		if (cxl_is_power9() &&
>   		   ((dsisr & CXL_PSL9_DSISR_PENDING) == 0))
>   			return;
>   		/*
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 6dc1ee5..1eb9859 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -436,7 +436,7 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter, struct pci
>   	/* nMMU_ID Defaults to: b’000001001’*/
>   	xsl_dsnctl |= ((u64)0x09 << (63-28));
> 
> -	if (cxl_is_power9() && !cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> +	if (!(cxl_is_power9_dd1())) {
>   		/*
>   		 * Used to identify CAPI packets which should be sorted into
>   		 * the Non-Blocking queues by the PHB. This field should match
> @@ -491,7 +491,7 @@ static int init_implementation_adapter_regs_psl9(struct cxl *adapter, struct pci
>   	cxl_p1_write(adapter, CXL_PSL9_APCDEDTYPE, 0x40000003FFFF0000ULL);
> 
>   	/* Disable vc dd1 fix */
> -	if ((cxl_is_power9() && cpu_has_feature(CPU_FTR_POWER9_DD1)))
> +	if (cxl_is_power9_dd1())
>   		cxl_p1_write(adapter, CXL_PSL9_GP_CT, 0x0400000000000001ULL);
> 
>   	return 0;
> @@ -1439,8 +1439,7 @@ int cxl_pci_reset(struct cxl *adapter)
>   	 * The adapter is about to be reset, so ignore errors.
>   	 * Not supported on P9 DD1
>   	 */
> -	if ((cxl_is_power8()) ||
> -	    ((cxl_is_power9() && !cpu_has_feature(CPU_FTR_POWER9_DD1))))
> +	if ((cxl_is_power8()) || (!(cxl_is_power9_dd1())))
>   		cxl_data_cache_flush(adapter);
> 
>   	/* pcie_warm_reset requests a fundamental pci reset which includes a
> @@ -1750,7 +1749,6 @@ static const struct cxl_service_layer_ops psl9_ops = {
>   	.debugfs_add_adapter_regs = cxl_debugfs_add_adapter_regs_psl9,
>   	.debugfs_add_afu_regs = cxl_debugfs_add_afu_regs_psl9,
>   	.psl_irq_dump_registers = cxl_native_irq_dump_regs_psl9,
> -	.err_irq_dump_registers = cxl_native_err_irq_dump_regs,
>   	.debugfs_stop_trace = cxl_stop_trace_psl9,
>   	.write_timebase_ctrl = write_timebase_ctrl_psl9,
>   	.timebase_read = timebase_read_psl9,
> @@ -1889,8 +1887,7 @@ static void cxl_pci_remove_adapter(struct cxl *adapter)
>   	 * Flush adapter datacache as its about to be removed.
>   	 * Not supported on P9 DD1.
>   	 */
> -	if ((cxl_is_power8()) ||
> -	    ((cxl_is_power9() && !cpu_has_feature(CPU_FTR_POWER9_DD1))))
> +	if ((cxl_is_power8()) || (!(cxl_is_power9_dd1())))
>   		cxl_data_cache_flush(adapter);
> 
>   	cxl_deconfigure_adapter(adapter);
> 
