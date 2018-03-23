Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406nDf24GVzF1Wr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 13:14:57 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2N2DloY107119
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 22:14:56 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gvja7n55k-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 22:14:55 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 23 Mar 2018 02:14:53 -0000
Subject: Re: [PATCH] cxl: disable the lazy approach for irqs in POWERVM
 environment.
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Date: Fri, 23 Mar 2018 13:14:48 +1100
In-Reply-To: <1521736674-13128-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1521736674-13128-1-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521771288.16434.326.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-22 at 17:37 +0100, Christophe Lombard wrote:
> The cxl driver cannot disable the interrupt at the device level and has
> to use disable_irq[_nosync] instead.
> To avoid the implementation of the lazy optimisation (the interrupt is
> marked disabled, but the hardware is left unmasked), we can disable it,
> for a particular irq line, by calling
> 'irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY)'.

Why do you need that ? What's wrong with the lazy approach ? It makes
disable_irq/enable_irq faster...

You shouldn't need that unless your device is generating a *LOT* of
irqs while disabled.

> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/guest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> index f58b4b6c..dc476e1 100644
> --- a/drivers/misc/cxl/guest.c
> +++ b/drivers/misc/cxl/guest.c
> @@ -389,6 +389,7 @@ static void disable_afu_irqs(struct cxl_context *ctx)
>  		hwirq = ctx->irqs.offset[r];
>  		for (i = 0; i < ctx->irqs.range[r]; hwirq++, i++) {
>  			virq = irq_find_mapping(NULL, hwirq);
> +			irq_set_status_flags(virq, IRQ_DISABLE_UNLAZY);
>  			disable_irq(virq);
>  		}
>  	}
