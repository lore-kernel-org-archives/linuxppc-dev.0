Return-Path: <srs0=v3ub=4c=au1.ibm.com=andrew.donnellan@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCW9x50JTzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 16:57:57 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wCW9x49S8z8svW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 16:57:57 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wCW9x19HRz9s78
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 16:57:56 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3Q6rnY2122790
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 02:57:48 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebxt7rx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 02:57:45 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 26 Apr 2017 16:57:04 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3Q6uqk962783712
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 16:57:00 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3Q6uSNf019308
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 16:56:28 +1000
Subject: Re: [PATCH] cxl: Prevent IRQ storm
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org
References: <20170426064053.12009-1-alastair@au1.ibm.com>
Cc: frederic.barrat@fr.ibm.com, "Alastair D'Silva" <alastair@d-silva.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 26 Apr 2017 16:56:03 +1000
MIME-Version: 1.0
In-Reply-To: <20170426064053.12009-1-alastair@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <359475c3-196a-7c95-eaaa-9a2212396af7@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26/04/17 16:40, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> In some situations, a faulty AFU slice may create an interrupt storm,
> rendering the machine unusable. Since these interrupts are informational
> only, present the interrupt once, then mask it off to prevent it from
> being retriggered until the card is reset.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
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

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
