Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rk3ff1qd5zDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 09:50:18 +1000 (AEST)
Message-ID: <1467676217.30027.15.camel@neuling.org>
Subject: Re: [PATCH v2] cxl: Refine slice error debug messages
From: Michael Neuling <mikey@neuling.org>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com
Date: Tue, 05 Jul 2016 09:50:17 +1000
In-Reply-To: <1467644856-762-1-git-send-email-felix@linux.vnet.ibm.com>
References: <1467644856-762-1-git-send-email-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This needs a description. =C2=A0How are you "refining it?

Mikey


On Mon, 2016-07-04 at 17:07 +0200, Philippe Bergheaud wrote:
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
> Changes since v1:
> =C2=A0 - Rebased on Ian's patch
> =C2=A0=C2=A0=C2=A0=C2=A0"cxl: Abstract the differences between the PSL an=
d XSL"
>=20
> =C2=A0drivers/misc/cxl/cxl.h=C2=A0=C2=A0=C2=A0=C2=A0| 15 +++++++++++++++
> =C2=A0drivers/misc/cxl/guest.c=C2=A0=C2=A0|=C2=A0=C2=A09 ++++++---
> =C2=A0drivers/misc/cxl/irq.c=C2=A0=C2=A0=C2=A0=C2=A0| 29 ++++++++++++++++=
+++++++++++++
> =C2=A0drivers/misc/cxl/native.c | 12 +++++++-----
> =C2=A04 files changed, 57 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 7745252..d928a8c 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -188,6 +188,18 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=3D
> {0x0A0};
> =C2=A0#define CXL_PSL_ID_An_F	(1ull << (63-31))
> =C2=A0#define CXL_PSL_ID_An_L	(1ull << (63-30))
> =C2=A0
> +/****** CXL_PSL_SERR_An
> ****************************************************/
> +#define CXL_PSL_SERR_An_afuto	(1ull << (63-0))
> +#define CXL_PSL_SERR_An_afudis	(1ull << (63-1))
> +#define CXL_PSL_SERR_An_afuov	(1ull << (63-2))
> +#define CXL_PSL_SERR_An_badsrc	(1ull << (63-3))
> +#define CXL_PSL_SERR_An_badctx	(1ull << (63-4))
> +#define CXL_PSL_SERR_An_llcmdis	(1ull << (63-5))
> +#define CXL_PSL_SERR_An_llcmdto	(1ull << (63-6))
> +#define CXL_PSL_SERR_An_afupar	(1ull << (63-7))
> +#define CXL_PSL_SERR_An_afudup	(1ull << (63-8))
> +#define CXL_PSL_SERR_An_AE	(1ull << (63-30))
> +
> =C2=A0/****** CXL_PSL_SCNTL_An
> ****************************************************/
> =C2=A0#define CXL_PSL_SCNTL_An_CR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0(0x1ull << (63-15))
> =C2=A0/* Programming Modes: */
> @@ -905,4 +917,7 @@ extern const struct cxl_backend_ops *cxl_ops;
> =C2=A0
> =C2=A0/* check if the given pci_dev is on the the cxl vphb bus */
> =C2=A0bool cxl_pci_is_vphb_device(struct pci_dev *dev);
> +
> +/* decode AFU error bits in the PSL register PSL_SERR_An */
> +void cxl_afu_decode_psl_serr(struct cxl_afu *afu, u64 serr);
> =C2=A0#endif
> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> index bc8d0b9..d516d0a 100644
> --- a/drivers/misc/cxl/guest.c
> +++ b/drivers/misc/cxl/guest.c
> @@ -196,15 +196,18 @@ static irqreturn_t guest_slice_irq_err(int irq,
> void *data)
> =C2=A0{
> =C2=A0	struct cxl_afu *afu =3D data;
> =C2=A0	int rc;
> -	u64 serr;
> +	u64 serr, afu_error, dsisr;
> =C2=A0
> -	WARN(irq, "CXL SLICE ERROR interrupt %i\n", irq);
> =C2=A0	rc =3D cxl_h_get_fn_error_interrupt(afu->guest->handle, &serr);
> =C2=A0	if (rc) {
> =C2=A0		dev_crit(&afu->dev, "Couldn't read PSL_SERR_An: %d\n",
> rc);
> =C2=A0		return IRQ_HANDLED;
> =C2=A0	}
> -	dev_crit(&afu->dev, "PSL_SERR_An: 0x%.16llx\n", serr);
> +	afu_error =3D cxl_p2n_read(afu, CXL_AFU_ERR_An);
> +	dsisr =3D cxl_p2n_read(afu, CXL_PSL_DSISR_An);
> +	cxl_afu_decode_psl_serr(afu, serr);
> +	dev_crit(&afu->dev, "AFU_ERR_An: 0x%.16llx\n", afu_error);
> +	dev_crit(&afu->dev, "PSL_DSISR_An: 0x%.16llx\n", dsisr);
> =C2=A0
> =C2=A0	rc =3D cxl_h_ack_fn_error_interrupt(afu->guest->handle, serr);
> =C2=A0	if (rc)
> diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
> index 8def455..40fffe4 100644
> --- a/drivers/misc/cxl/irq.c
> +++ b/drivers/misc/cxl/irq.c
> @@ -374,3 +374,32 @@ void afu_release_irqs(struct cxl_context *ctx, void
> *cookie)
> =C2=A0
> =C2=A0	ctx->irq_count =3D 0;
> =C2=A0}
> +
> +void cxl_afu_decode_psl_serr(struct cxl_afu *afu, u64 serr)
> +{
> +	dev_crit(&afu->dev,
> +		=C2=A0"PSL Slice error received. Check AFU for root
> cause.\n");
> +	dev_crit(&afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
> +	if (serr & CXL_PSL_SERR_An_afuto)
> +		dev_crit(&afu->dev, "AFU MMIO Timeout\n");
> +	if (serr & CXL_PSL_SERR_An_afudis)
> +		dev_crit(&afu->dev,
> +			=C2=A0"MMIO targeted Accelerator that was not
> enabled\n");
> +	if (serr & CXL_PSL_SERR_An_afuov)
> +		dev_crit(&afu->dev, "AFU CTAG Overflow\n");
> +	if (serr & CXL_PSL_SERR_An_badsrc)
> +		dev_crit(&afu->dev, "Bad Interrupt Source\n");
> +	if (serr & CXL_PSL_SERR_An_badctx)
> +		dev_crit(&afu->dev, "Bad Context Handle\n");
> +	if (serr & CXL_PSL_SERR_An_llcmdis)
> +		dev_crit(&afu->dev, "LLCMD to Disabled AFU\n");
> +	if (serr & CXL_PSL_SERR_An_llcmdto)
> +		dev_crit(&afu->dev, "LLCMD Timeout to AFU\n");
> +	if (serr & CXL_PSL_SERR_An_afupar)
> +		dev_crit(&afu->dev, "AFU MMIO Parity Error\n");
> +	if (serr & CXL_PSL_SERR_An_afudup)
> +		dev_crit(&afu->dev, "AFU MMIO Duplicate CTAG Error\n");
> +	if (serr & CXL_PSL_SERR_An_AE)
> +		dev_crit(&afu->dev,
> +			=C2=A0"AFU asserted JDONE with JERROR in AFU Directed
> Mode\n");
> +}
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index d867326..c4d8815 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -767,7 +767,7 @@ void cxl_native_psl_irq_dump_regs(struct cxl_context
> *ctx)
> =C2=A0	dev_crit(&ctx->afu->dev, "PSL_FIR2: 0x%016llx\n", fir2);
> =C2=A0	if (ctx->afu->adapter->native->sl_ops->register_serr_irq) {
> =C2=A0		serr =3D cxl_p1n_read(ctx->afu, CXL_PSL_SERR_An);
> -		dev_crit(&ctx->afu->dev, "PSL_SERR_An: 0x%016llx\n",
> serr);
> +		cxl_afu_decode_psl_serr(ctx->afu, serr);
> =C2=A0	}
> =C2=A0	dev_crit(&ctx->afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n",
> fir_slice);
> =C2=A0	dev_crit(&ctx->afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n",
> afu_debug);
> @@ -861,21 +861,23 @@ void native_irq_wait(struct cxl_context *ctx)
> =C2=A0static irqreturn_t native_slice_irq_err(int irq, void *data)
> =C2=A0{
> =C2=A0	struct cxl_afu *afu =3D data;
> -	u64 fir_slice, errstat, serr, afu_debug;
> +	u64 fir_slice, errstat, serr, afu_debug, afu_error, dsisr;
> =C2=A0
> =C2=A0	/*
> =C2=A0	=C2=A0* slice err interrupt is only used with full PSL (no XSL)
> =C2=A0	=C2=A0*/
> -	WARN(irq, "CXL SLICE ERROR interrupt %i\n", irq);
> -
> =C2=A0	serr =3D cxl_p1n_read(afu, CXL_PSL_SERR_An);
> =C2=A0	fir_slice =3D cxl_p1n_read(afu, CXL_PSL_FIR_SLICE_An);
> =C2=A0	errstat =3D cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
> =C2=A0	afu_debug =3D cxl_p1n_read(afu, CXL_AFU_DEBUG_An);
> -	dev_crit(&afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
> +	afu_error =3D cxl_p2n_read(afu, CXL_AFU_ERR_An);
> +	dsisr =3D cxl_p2n_read(afu, CXL_PSL_DSISR_An);
> +	cxl_afu_decode_psl_serr(afu, serr);
> =C2=A0	dev_crit(&afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
> =C2=A0	dev_crit(&afu->dev, "CXL_PSL_ErrStat_An: 0x%016llx\n", errstat);
> =C2=A0	dev_crit(&afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n",
> afu_debug);
> +	dev_crit(&afu->dev, "AFU_ERR_An: 0x%.16llx\n", afu_error);
> +	dev_crit(&afu->dev, "PSL_DSISR_An: 0x%.16llx\n", dsisr);
> =C2=A0
> =C2=A0	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> =C2=A0
