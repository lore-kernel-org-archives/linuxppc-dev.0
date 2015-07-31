Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF1EC1A0775
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 19:28:29 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 88C531402B9
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2015 19:28:29 +1000 (AEST)
Message-ID: <55BB3FB8.9010606@redhat.com>
Date: Fri, 31 Jul 2015 11:28:24 +0200
From: Thomas Huth <thuth@redhat.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org, imunsie@au.ibm.com
Subject: Re: [PATCH] cxl: Fix ambiguous else warnings
References: <1438324508-30341-1-git-send-email-dja@axtens.net>
In-Reply-To: <1438324508-30341-1-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31/07/15 08:35, Daniel Axtens wrote:
> Every time I build cxl I see the following warnings:
> 
> /scratch/dja/linux-capi/drivers/misc/cxl/pci.c: In function ‘sanitise_afu_regs’:
> /scratch/dja/linux-capi/drivers/misc/cxl/pci.c:712:6: warning: suggest explicit braces to avoid ambiguous ‘else’ [-Wparentheses]
>    if (reg & CXL_PSL_DSISR_TRANS)
>       ^
> /scratch/dja/linux-capi/drivers/misc/cxl/irq.c: In function ‘fail_psl_irq’:
> /scratch/dja/linux-capi/drivers/misc/cxl/irq.c:184:5: warning: suggest explicit braces to avoid ambiguous ‘else’ [-Wparentheses]
>   if (irq_info->dsisr & CXL_PSL_DSISR_TRANS)
>      ^
> 
> They're annoying. Fix them by inserting the braces.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  drivers/misc/cxl/irq.c | 5 +++--
>  drivers/misc/cxl/pci.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
> index 121ec48f3ab4..c11e583a15a9 100644
> --- a/drivers/misc/cxl/irq.c
> +++ b/drivers/misc/cxl/irq.c
> @@ -181,10 +181,11 @@ static irqreturn_t cxl_irq(int irq, void *data, struct cxl_irq_info *irq_info)
>  
>  static irqreturn_t fail_psl_irq(struct cxl_afu *afu, struct cxl_irq_info *irq_info)
>  {
> -	if (irq_info->dsisr & CXL_PSL_DSISR_TRANS)
> +	if (irq_info->dsisr & CXL_PSL_DSISR_TRANS) {
>  		cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
> -	else
> +	} else {
>  		cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_A);
> +	}
>  
>  	return IRQ_HANDLED;
>  }

Why does your GCC complain here at all? The code doesn't look ambiguous
to me... Which version of GCC are you using?
I just did a quick test compile here, and these warnings do not occur
for me.

 Thomas
