Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 200D41A0034
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 13:43:57 +1000 (AEST)
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9D38314056B
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 13:43:56 +1000 (AEST)
Received: by pawu10 with SMTP id u10so154220581paw.1
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 20:43:55 -0700 (PDT)
Date: Tue, 11 Aug 2015 13:44:50 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com
Subject: Re: [PATCH v2 03/10] cxl: Make IRQ release idempotent
Message-ID: <20150811134450.74a26722@camb691>
In-Reply-To: <1438061323-20710-4-git-send-email-dja@axtens.net>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
 <1438061323-20710-4-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Jul 2015 15:28:36 +1000
Daniel Axtens <dja@axtens.net> wrote:

> Check if an IRQ is mapped before releasing it.
> 
> This will simplify future EEH code by allowing unconditional unmapping
> of IRQs.
> 

Acked-by: Cyril Bur <cyrilbur@gmail.com>

> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  drivers/misc/cxl/irq.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
> index 680cd263436d..121ec48f3ab4 100644
> --- a/drivers/misc/cxl/irq.c
> +++ b/drivers/misc/cxl/irq.c
> @@ -341,6 +341,9 @@ int cxl_register_psl_err_irq(struct cxl *adapter)
>  
>  void cxl_release_psl_err_irq(struct cxl *adapter)
>  {
> +	if (adapter->err_virq != irq_find_mapping(NULL, adapter->err_hwirq))
> +		return;
> +
>  	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, 0x0000000000000000);
>  	cxl_unmap_irq(adapter->err_virq, adapter);
>  	cxl_release_one_irq(adapter, adapter->err_hwirq);
> @@ -374,6 +377,9 @@ int cxl_register_serr_irq(struct cxl_afu *afu)
>  
>  void cxl_release_serr_irq(struct cxl_afu *afu)
>  {
> +	if (afu->serr_virq != irq_find_mapping(NULL, afu->serr_hwirq))
> +		return;
> +
>  	cxl_p1n_write(afu, CXL_PSL_SERR_An, 0x0000000000000000);
>  	cxl_unmap_irq(afu->serr_virq, afu);
>  	cxl_release_one_irq(afu->adapter, afu->serr_hwirq);
> @@ -400,6 +406,9 @@ int cxl_register_psl_irq(struct cxl_afu *afu)
>  
>  void cxl_release_psl_irq(struct cxl_afu *afu)
>  {
> +	if (afu->psl_virq != irq_find_mapping(NULL, afu->psl_hwirq))
> +		return;
> +
>  	cxl_unmap_irq(afu->psl_virq, afu);
>  	cxl_release_one_irq(afu->adapter, afu->psl_hwirq);
>  	kfree(afu->psl_irq_name);
