Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnZGb684YzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 15:01:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH V3] cxl: Fixes for Coherent Accelerator Interface
 Architecture 2.0
In-Reply-To: <1497368465-13104-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1497368465-13104-1-git-send-email-clombard@linux.vnet.ibm.com>
Date: Wed, 14 Jun 2017 15:01:11 +1000
Message-ID: <877f0f40yw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Lombard <clombard@linux.vnet.ibm.com> writes:

> A previous set of patches "cxl: Add support for Coherent Accelerator
> Interface Architecture 2.0" has introduced a new support for the CAPI
> cards.

Which commit is that?

cheers

> These patches have been tested on Simulation environment and
> quite a bit of them have been tested on real hardware.
>
> This patch brings new fixes after a series of tests carried out on
> new equipment:
> * Add POWER9 definition.
> * Re-enable any masked interrupts when the AFU is not activated after
>   resetting the AFU.
> * Remove the api cxl_is_psl8/9 which is no longer useful.
> * Do not dump CAPI1 registers.
> * Rewrite cxl_is_page_fault() function.
> * Do not register slb callack on P9.
>
> Changelog[v3]
>  - Rebase to latest upstream.
>  - Update the patch's header.
>  - Add new test in cxl_is_page_fault().
>
> Changelog[v2]
>  - Rebase to latest upstream.
>  - Update cxl_is_page_fault() to handle the checkout response status.
>  - Add comments.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/context.c |  6 +++---
>  drivers/misc/cxl/cxl.h     | 18 +++++-------------
>  drivers/misc/cxl/fault.c   | 23 +++++++++++++++--------
>  drivers/misc/cxl/main.c    | 17 +++++++++++++----
>  drivers/misc/cxl/native.c  | 29 +++++++++++++++++------------
>  drivers/misc/cxl/pci.c     | 11 ++++-------
>  6 files changed, 57 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
> index 4472ce1..8c32040 100644
> --- a/drivers/misc/cxl/context.c
> +++ b/drivers/misc/cxl/context.c
> @@ -45,7 +45,7 @@ int cxl_context_init(struct cxl_context *ctx, struct cx=
l_afu *afu, bool master)
>  	mutex_init(&ctx->mapping_lock);
>  	ctx->mapping =3D NULL;
>=20=20
> -	if (cxl_is_psl8(afu)) {
> +	if (cxl_is_power8()) {
>  		spin_lock_init(&ctx->sste_lock);
>=20=20
>  		/*
> @@ -189,7 +189,7 @@ int cxl_context_iomap(struct cxl_context *ctx, struct=
 vm_area_struct *vma)
>  		if (start + len > ctx->afu->adapter->ps_size)
>  			return -EINVAL;
>=20=20
> -		if (cxl_is_psl9(ctx->afu)) {
> +		if (cxl_is_power9()) {
>  			/*
>  			 * Make sure there is a valid problem state
>  			 * area space for this AFU.
> @@ -324,7 +324,7 @@ static void reclaim_ctx(struct rcu_head *rcu)
>  {
>  	struct cxl_context *ctx =3D container_of(rcu, struct cxl_context, rcu);
>=20=20
> -	if (cxl_is_psl8(ctx->afu))
> +	if (cxl_is_power8())
>  		free_page((u64)ctx->sstp);
>  	if (ctx->ff_page)
>  		__free_page(ctx->ff_page);
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index c8568ea..a03f8e7 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -357,6 +357,7 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     =3D {0x=
0A0};
>  #define CXL_PSL9_DSISR_An_PF_RGP  0x0000000000000090ULL  /* PTE not foun=
d (Radix Guest (parent)) 0b10010000 */
>  #define CXL_PSL9_DSISR_An_PF_HRH  0x0000000000000094ULL  /* PTE not foun=
d (HPT/Radix Host)       0b10010100 */
>  #define CXL_PSL9_DSISR_An_PF_STEG 0x000000000000009CULL  /* PTE not foun=
d (STEG VA)              0b10011100 */
> +#define CXL_PSL9_DSISR_An_URTCH   0x00000000000000B4ULL  /* Unsupported =
Radix Tree Configuration 0b10110100 */
>=20=20
>  /****** CXL_PSL_TFC_An *************************************************=
*****/
>  #define CXL_PSL_TFC_An_A  (1ull << (63-28)) /* Acknowledge non-translati=
on fault */
> @@ -844,24 +845,15 @@ static inline bool cxl_is_power8(void)
>=20=20
>  static inline bool cxl_is_power9(void)
>  {
> -	/* intermediate solution */
> -	if (!cxl_is_power8() &&
> -	   (cpu_has_feature(CPU_FTRS_POWER9) ||
> -	    cpu_has_feature(CPU_FTR_POWER9_DD1)))
> +	if (pvr_version_is(PVR_POWER9))
>  		return true;
>  	return false;
>  }
>=20=20
> -static inline bool cxl_is_psl8(struct cxl_afu *afu)
> +static inline bool cxl_is_power9_dd1(void)
>  {
> -	if (afu->adapter->caia_major =3D=3D 1)
> -		return true;
> -	return false;
> -}
> -
> -static inline bool cxl_is_psl9(struct cxl_afu *afu)
> -{
> -	if (afu->adapter->caia_major =3D=3D 2)
> +	if ((pvr_version_is(PVR_POWER9)) &&
> +	    cpu_has_feature(CPU_FTR_POWER9_DD1))
>  		return true;
>  	return false;
>  }
> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index 5344448..c79e39b 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c
> @@ -187,7 +187,7 @@ static struct mm_struct *get_mem_context(struct cxl_c=
ontext *ctx)
>=20=20
>  static bool cxl_is_segment_miss(struct cxl_context *ctx, u64 dsisr)
>  {
> -	if ((cxl_is_psl8(ctx->afu)) && (dsisr & CXL_PSL_DSISR_An_DS))
> +	if ((cxl_is_power8() && (dsisr & CXL_PSL_DSISR_An_DS)))
>  		return true;
>=20=20
>  	return false;
> @@ -195,16 +195,23 @@ static bool cxl_is_segment_miss(struct cxl_context =
*ctx, u64 dsisr)
>=20=20
>  static bool cxl_is_page_fault(struct cxl_context *ctx, u64 dsisr)
>  {
> -	if ((cxl_is_psl8(ctx->afu)) && (dsisr & CXL_PSL_DSISR_An_DM))
> -		return true;
> +	u64 crs; /* Translation Checkout Response Status */
>=20=20
> -	if ((cxl_is_psl9(ctx->afu)) &&
> -	   ((dsisr & CXL_PSL9_DSISR_An_CO_MASK) &
> -		(CXL_PSL9_DSISR_An_PF_SLR | CXL_PSL9_DSISR_An_PF_RGC |
> -		 CXL_PSL9_DSISR_An_PF_RGP | CXL_PSL9_DSISR_An_PF_HRH |
> -		 CXL_PSL9_DSISR_An_PF_STEG)))
> +	if ((cxl_is_power8()) && (dsisr & CXL_PSL_DSISR_An_DM))
>  		return true;
>=20=20
> +	if (cxl_is_power9()) {
> +		crs =3D (dsisr & CXL_PSL9_DSISR_An_CO_MASK);
> +		if ((crs =3D=3D CXL_PSL9_DSISR_An_PF_SLR) ||
> +		    (crs =3D=3D CXL_PSL9_DSISR_An_PF_RGC) ||
> +		    (crs =3D=3D CXL_PSL9_DSISR_An_PF_RGP) ||
> +		    (crs =3D=3D CXL_PSL9_DSISR_An_PF_HRH) ||
> +		    (crs =3D=3D CXL_PSL9_DSISR_An_PF_STEG) ||
> +		    (crs =3D=3D CXL_PSL9_DSISR_An_URTCH)) {
> +			return true;
> +		}
> +	}
> +
>  	return false;
>  }
>=20=20
> diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
> index 1703655..c1ba0d4 100644
> --- a/drivers/misc/cxl/main.c
> +++ b/drivers/misc/cxl/main.c
> @@ -329,8 +329,15 @@ static int __init init_cxl(void)
>=20=20
>  	cxl_debugfs_init();
>=20=20
> -	if ((rc =3D register_cxl_calls(&cxl_calls)))
> -		goto err;
> +	/*
> +	 * we don't register the callback on P9. slb callack is only
> +	 * used for the PSL8 MMU and CX4.
> +	 */
> +	if (cxl_is_power8()) {
> +		rc =3D register_cxl_calls(&cxl_calls);
> +		if (rc)
> +			goto err;
> +	}
>=20=20
>  	if (cpu_has_feature(CPU_FTR_HVMODE)) {
>  		cxl_ops =3D &cxl_native_ops;
> @@ -347,7 +354,8 @@ static int __init init_cxl(void)
>=20=20
>  	return 0;
>  err1:
> -	unregister_cxl_calls(&cxl_calls);
> +	if (cxl_is_power8())
> +		unregister_cxl_calls(&cxl_calls);
>  err:
>  	cxl_debugfs_exit();
>  	cxl_file_exit();
> @@ -366,7 +374,8 @@ static void exit_cxl(void)
>=20=20
>  	cxl_debugfs_exit();
>  	cxl_file_exit();
> -	unregister_cxl_calls(&cxl_calls);
> +	if (cxl_is_power8())
> +		unregister_cxl_calls(&cxl_calls);
>  	idr_destroy(&cxl_adapter_idr);
>  }
>=20=20
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 8d6ea97..2b2f889 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -105,11 +105,16 @@ static int native_afu_reset(struct cxl_afu *afu)
>  			   CXL_AFU_Cntl_An_RS_MASK | CXL_AFU_Cntl_An_ES_MASK,
>  			   false);
>=20=20
> -	/* Re-enable any masked interrupts */
> -	serr =3D cxl_p1n_read(afu, CXL_PSL_SERR_An);
> -	serr &=3D ~CXL_PSL_SERR_An_IRQ_MASKS;
> -	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> -
> +	/*
> +	 * Re-enable any masked interrupts when the AFU is not
> +	 * activated to avoid side effects after attaching a process
> +	 * in dedicated mode.
> +	 */
> +	if (afu->current_mode =3D=3D 0) {
> +		serr =3D cxl_p1n_read(afu, CXL_PSL_SERR_An);
> +		serr &=3D ~CXL_PSL_SERR_An_IRQ_MASKS;
> +		cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> +	}
>=20=20
>  	return rc;
>  }
> @@ -139,9 +144,9 @@ int cxl_psl_purge(struct cxl_afu *afu)
>=20=20
>  	pr_devel("PSL purge request\n");
>=20=20
> -	if (cxl_is_psl8(afu))
> +	if (cxl_is_power8())
>  		trans_fault =3D CXL_PSL_DSISR_TRANS;
> -	if (cxl_is_psl9(afu))
> +	if (cxl_is_power9())
>  		trans_fault =3D CXL_PSL9_DSISR_An_TF;
>=20=20
>  	if (!cxl_ops->link_ok(afu->adapter, afu)) {
> @@ -603,7 +608,7 @@ static u64 calculate_sr(struct cxl_context *ctx)
>  		if (!test_tsk_thread_flag(current, TIF_32BIT))
>  			sr |=3D CXL_PSL_SR_An_SF;
>  	}
> -	if (cxl_is_psl9(ctx->afu)) {
> +	if (cxl_is_power9()) {
>  		if (radix_enabled())
>  			sr |=3D CXL_PSL_SR_An_XLAT_ror;
>  		else
> @@ -1117,10 +1122,10 @@ static irqreturn_t native_handle_psl_slice_error(=
struct cxl_context *ctx,
>=20=20
>  static bool cxl_is_translation_fault(struct cxl_afu *afu, u64 dsisr)
>  {
> -	if ((cxl_is_psl8(afu)) && (dsisr & CXL_PSL_DSISR_TRANS))
> +	if ((cxl_is_power8()) && (dsisr & CXL_PSL_DSISR_TRANS))
>  		return true;
>=20=20
> -	if ((cxl_is_psl9(afu)) && (dsisr & CXL_PSL9_DSISR_An_TF))
> +	if ((cxl_is_power9()) && (dsisr & CXL_PSL9_DSISR_An_TF))
>  		return true;
>=20=20
>  	return false;
> @@ -1194,10 +1199,10 @@ static void native_irq_wait(struct cxl_context *c=
tx)
>  		if (ph !=3D ctx->pe)
>  			return;
>  		dsisr =3D cxl_p2n_read(ctx->afu, CXL_PSL_DSISR_An);
> -		if (cxl_is_psl8(ctx->afu) &&
> +		if (cxl_is_power8() &&
>  		   ((dsisr & CXL_PSL_DSISR_PENDING) =3D=3D 0))
>  			return;
> -		if (cxl_is_psl9(ctx->afu) &&
> +		if (cxl_is_power9() &&
>  		   ((dsisr & CXL_PSL9_DSISR_PENDING) =3D=3D 0))
>  			return;
>  		/*
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 6dc1ee5..1eb9859 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -436,7 +436,7 @@ static int init_implementation_adapter_regs_psl9(stru=
ct cxl *adapter, struct pci
>  	/* nMMU_ID Defaults to: b=E2=80=99000001001=E2=80=99*/
>  	xsl_dsnctl |=3D ((u64)0x09 << (63-28));
>=20=20
> -	if (cxl_is_power9() && !cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> +	if (!(cxl_is_power9_dd1())) {
>  		/*
>  		 * Used to identify CAPI packets which should be sorted into
>  		 * the Non-Blocking queues by the PHB. This field should match
> @@ -491,7 +491,7 @@ static int init_implementation_adapter_regs_psl9(stru=
ct cxl *adapter, struct pci
>  	cxl_p1_write(adapter, CXL_PSL9_APCDEDTYPE, 0x40000003FFFF0000ULL);
>=20=20
>  	/* Disable vc dd1 fix */
> -	if ((cxl_is_power9() && cpu_has_feature(CPU_FTR_POWER9_DD1)))
> +	if (cxl_is_power9_dd1())
>  		cxl_p1_write(adapter, CXL_PSL9_GP_CT, 0x0400000000000001ULL);
>=20=20
>  	return 0;
> @@ -1439,8 +1439,7 @@ int cxl_pci_reset(struct cxl *adapter)
>  	 * The adapter is about to be reset, so ignore errors.
>  	 * Not supported on P9 DD1
>  	 */
> -	if ((cxl_is_power8()) ||
> -	    ((cxl_is_power9() && !cpu_has_feature(CPU_FTR_POWER9_DD1))))
> +	if ((cxl_is_power8()) || (!(cxl_is_power9_dd1())))
>  		cxl_data_cache_flush(adapter);
>=20=20
>  	/* pcie_warm_reset requests a fundamental pci reset which includes a
> @@ -1750,7 +1749,6 @@ static const struct cxl_service_layer_ops psl9_ops =
=3D {
>  	.debugfs_add_adapter_regs =3D cxl_debugfs_add_adapter_regs_psl9,
>  	.debugfs_add_afu_regs =3D cxl_debugfs_add_afu_regs_psl9,
>  	.psl_irq_dump_registers =3D cxl_native_irq_dump_regs_psl9,
> -	.err_irq_dump_registers =3D cxl_native_err_irq_dump_regs,
>  	.debugfs_stop_trace =3D cxl_stop_trace_psl9,
>  	.write_timebase_ctrl =3D write_timebase_ctrl_psl9,
>  	.timebase_read =3D timebase_read_psl9,
> @@ -1889,8 +1887,7 @@ static void cxl_pci_remove_adapter(struct cxl *adap=
ter)
>  	 * Flush adapter datacache as its about to be removed.
>  	 * Not supported on P9 DD1.
>  	 */
> -	if ((cxl_is_power8()) ||
> -	    ((cxl_is_power9() && !cpu_has_feature(CPU_FTR_POWER9_DD1))))
> +	if ((cxl_is_power8()) || (!(cxl_is_power9_dd1())))
>  		cxl_data_cache_flush(adapter);
>=20=20
>  	cxl_deconfigure_adapter(adapter);
> --=20
> 2.7.4
