Return-Path: <srs0=/4kh=4c=linux.vnet.ibm.com=fbarrat@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCZQp05f2zDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 19:24:18 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wCZQn6dZ0z8wVL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 19:24:17 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wCZQn3V9yz9s89
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 19:24:17 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3Q9Ne4s117088
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 05:24:15 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebw96e0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 05:24:15 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 26 Apr 2017 10:24:12 +0100
Subject: Re: [PATCH] cxl: Prevent IRQ storm
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org
References: <20170426064053.12009-1-alastair@au1.ibm.com>
Cc: "Alastair D'Silva" <alastair@d-silva.org>, andrew.donnellan@au1.ibm.com,
 frederic.barrat@fr.ibm.com
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 11:23:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170426064053.12009-1-alastair@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <2354ad5d-e41f-555e-f129-157444973e1c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 26/04/2017 à 08:40, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
>
> In some situations, a faulty AFU slice may create an interrupt storm,
> rendering the machine unusable. Since these interrupts are informational
> only, present the interrupt once, then mask it off to prevent it from
> being retriggered until the card is reset.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Patch looks good, thanks!
It doesn't apply cleanly on the 'next' tree due to the capi2 patchset 
though, so you should probably rebase on that tree. The bits have 
changed a bit on PSL9, but the approach still works (error type reported 
in the first byte, and the corresponding masking bits are still 
right-shifted by 32).

   Fred

>  drivers/misc/cxl/native.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 7ae7105..4e8010f 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -996,7 +996,7 @@ static void native_irq_wait(struct cxl_context *ctx)
>  static irqreturn_t native_slice_irq_err(int irq, void *data)
>  {
>  	struct cxl_afu *afu = data;
> -	u64 fir_slice, errstat, serr, afu_debug, afu_error, dsisr;
> +	u64 fir_slice, errstat, serr, afu_debug, afu_error, dsisr, irq_mask;
>
>  	/*
>  	 * slice err interrupt is only used with full PSL (no XSL)
> @@ -1014,6 +1014,10 @@ static irqreturn_t native_slice_irq_err(int irq, void *data)
>  	dev_crit(&afu->dev, "AFU_ERR_An: 0x%.16llx\n", afu_error);
>  	dev_crit(&afu->dev, "PSL_DSISR_An: 0x%.16llx\n", dsisr);
>
> +	/* mask off the IRQ so it won't retrigger until the card is reset */
> +	irq_mask = (serr & 0xff80000000000000ULL) >> 32;
> +	serr |= irq_mask;
> +
>  	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
>
>  	return IRQ_HANDLED;
>
