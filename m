Return-Path: <srs0=sp/h=4i=linux.vnet.ibm.com=fbarrat@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHDqH28ZSzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 18:24:43 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wHDqH1YPYz8sxs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 18:24:43 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wHDqG3vWKz9sDF
 for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2017 18:24:42 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v428JXKJ101141
 for <linuxppc-dev@ozlabs.org>; Tue, 2 May 2017 04:24:40 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a6n89mvwf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 02 May 2017 04:24:39 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 2 May 2017 09:24:38 +0100
Subject: Re: [PATCH v4] cxl: mask slice error interrupts after first occurrence
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org
References: <20170501005331.20131-3-alastair@au1.ibm.com>
Cc: "Alastair D'Silva" <alastair@d-silva.org>, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, frederic.barrat@fr.ibm.com
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 2 May 2017 10:24:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170501005331.20131-3-alastair@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <63a4754d-6070-cfce-1f9c-5306d46a6436@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 01/05/2017 à 02:53, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
>
> In some situations, a faulty AFU slice may create an interrupt storm of
> slice errors, rendering the machine unusable. Since these interrupts are
> informational only, present the interrupt once, then mask it off to
> prevent it from being retriggered until the AFU is reset.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---


Thanks!

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>



> Changelog:
> v4:
> 	Fix duplicate/missing entries in aggregate macros
> 	Minor textual changes
> v3
>         Add CXL_PSL_SERR_An_IRQS, CXL_PSL_SERR_An_IRQ_MASKS macros
>         Explicitly reenable masked interrupts after reset
>         Issue an info line that subsequent interrupts will be masked
> v2
>         Rebase against linux-next
> ---
>  drivers/misc/cxl/cxl.h    | 18 ++++++++++++++++++
>  drivers/misc/cxl/native.c | 19 +++++++++++++++++--
>  2 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 452e209..c8568ea 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -228,6 +228,24 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
>  #define CXL_PSL_SERR_An_llcmdto	(1ull << (63-6))
>  #define CXL_PSL_SERR_An_afupar	(1ull << (63-7))
>  #define CXL_PSL_SERR_An_afudup	(1ull << (63-8))
> +#define CXL_PSL_SERR_An_IRQS	( \
> +	CXL_PSL_SERR_An_afuto | CXL_PSL_SERR_An_afudis | CXL_PSL_SERR_An_afuov | \
> +	CXL_PSL_SERR_An_badsrc | CXL_PSL_SERR_An_badctx | CXL_PSL_SERR_An_llcmdis | \
> +	CXL_PSL_SERR_An_llcmdto | CXL_PSL_SERR_An_afupar | CXL_PSL_SERR_An_afudup)
> +#define CXL_PSL_SERR_An_afuto_mask	(1ull << (63-32))
> +#define CXL_PSL_SERR_An_afudis_mask	(1ull << (63-33))
> +#define CXL_PSL_SERR_An_afuov_mask	(1ull << (63-34))
> +#define CXL_PSL_SERR_An_badsrc_mask	(1ull << (63-35))
> +#define CXL_PSL_SERR_An_badctx_mask	(1ull << (63-36))
> +#define CXL_PSL_SERR_An_llcmdis_mask	(1ull << (63-37))
> +#define CXL_PSL_SERR_An_llcmdto_mask	(1ull << (63-38))
> +#define CXL_PSL_SERR_An_afupar_mask	(1ull << (63-39))
> +#define CXL_PSL_SERR_An_afudup_mask	(1ull << (63-40))
> +#define CXL_PSL_SERR_An_IRQ_MASKS	( \
> +	CXL_PSL_SERR_An_afuto_mask | CXL_PSL_SERR_An_afudis_mask | CXL_PSL_SERR_An_afuov_mask | \
> +	CXL_PSL_SERR_An_badsrc_mask | CXL_PSL_SERR_An_badctx_mask | CXL_PSL_SERR_An_llcmdis_mask | \
> +	CXL_PSL_SERR_An_llcmdto_mask | CXL_PSL_SERR_An_afupar_mask | CXL_PSL_SERR_An_afudup_mask)
> +
>  #define CXL_PSL_SERR_An_AE	(1ull << (63-30))
>
>  /****** CXL_PSL_SCNTL_An ****************************************************/
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 194c58e..290950b 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -95,12 +95,23 @@ int cxl_afu_disable(struct cxl_afu *afu)
>  /* This will disable as well as reset */
>  static int native_afu_reset(struct cxl_afu *afu)
>  {
> +	int rc;
> +	u64 serr;
> +
>  	pr_devel("AFU reset request\n");
>
> -	return afu_control(afu, CXL_AFU_Cntl_An_RA, 0,
> +	rc = afu_control(afu, CXL_AFU_Cntl_An_RA, 0,
>  			   CXL_AFU_Cntl_An_RS_Complete | CXL_AFU_Cntl_An_ES_Disabled,
>  			   CXL_AFU_Cntl_An_RS_MASK | CXL_AFU_Cntl_An_ES_MASK,
>  			   false);
> +
> +	/* Re-enable any masked interrupts */
> +	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
> +	serr &= ~CXL_PSL_SERR_An_IRQ_MASKS;
> +	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> +
> +
> +	return rc;
>  }
>
>  static int native_afu_check_and_enable(struct cxl_afu *afu)
> @@ -1205,7 +1216,7 @@ static irqreturn_t native_slice_irq_err(int irq, void *data)
>  {
>  	struct cxl_afu *afu = data;
>  	u64 errstat, serr, afu_error, dsisr;
> -	u64 fir_slice, afu_debug;
> +	u64 fir_slice, afu_debug, irq_mask;
>
>  	/*
>  	 * slice err interrupt is only used with full PSL (no XSL)
> @@ -1226,7 +1237,11 @@ static irqreturn_t native_slice_irq_err(int irq, void *data)
>  	dev_crit(&afu->dev, "AFU_ERR_An: 0x%.16llx\n", afu_error);
>  	dev_crit(&afu->dev, "PSL_DSISR_An: 0x%.16llx\n", dsisr);
>
> +	/* mask off the IRQ so it won't retrigger until the AFU is reset */
> +	irq_mask = (serr & CXL_PSL_SERR_An_IRQS) >> 32;
> +	serr |= irq_mask;
>  	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> +	dev_info(&afu->dev, "Further such interrupts will be masked until the AFU is reset\n");
>
>  	return IRQ_HANDLED;
>  }
>
