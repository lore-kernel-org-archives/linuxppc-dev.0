Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEDE41A05D0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 09:15:07 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Sun, 21 Feb 2016 15:15:06 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E36E919D803E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 15:03:01 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1LMF4RK35586096
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 15:15:04 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1LMF3ah000413
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 15:15:04 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: Fwd: [PATCH v4 07/18] cxl: Update cxl_irq() prototype
References: <1455658751-16970-8-git-send-email-fbarrat@linux.vnet.ibm.com>
 <56CA2CA8.2020402@linux.vnet.ibm.com>
To: fbarrat@linux.vnet.ibm.com
Cc: Ian Munsie <imunsie@au1.ibm.com>, michael.neuling1@au1.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56CA36FA.6010300@linux.vnet.ibm.com>
Date: Sun, 21 Feb 2016 16:15:22 -0600
MIME-Version: 1.0
In-Reply-To: <56CA2CA8.2020402@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>

---
Manoj Kumar

> Subject: [PATCH v4 07/18] cxl: Update cxl_irq() prototype
> Date: Tue, 16 Feb 2016 22:39:00 +0100
> From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com,
> mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
>
> The context parameter when calling cxl_irq() should be strongly typed.
>
> Co-authored-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
>   drivers/misc/cxl/cxl.h | 2 +-
>   drivers/misc/cxl/irq.c | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 40f6783..c7ed265 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -714,7 +714,7 @@ struct cxl_irq_info {
>   };
>
>   void cxl_assign_psn_space(struct cxl_context *ctx);
> -irqreturn_t cxl_irq(int irq, void *ctx, struct cxl_irq_info *irq_info);
> +irqreturn_t cxl_irq(int irq, struct cxl_context *ctx, struct
> cxl_irq_info *irq_info);
>   int cxl_register_one_irq(struct cxl *adapter, irq_handler_t handler,
>               void *cookie, irq_hw_number_t *dest_hwirq,
>               unsigned int *dest_virq, const char *name);
> diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
> index 56ad301..5033869 100644
> --- a/drivers/misc/cxl/irq.c
> +++ b/drivers/misc/cxl/irq.c
> @@ -27,9 +27,8 @@ static irqreturn_t schedule_cxl_fault(struct
> cxl_context *ctx, u64 dsisr, u64 da
>       return IRQ_HANDLED;
>   }
>
> -irqreturn_t cxl_irq(int irq, void *data, struct cxl_irq_info *irq_info)
> +irqreturn_t cxl_irq(int irq, struct cxl_context *ctx, struct
> cxl_irq_info *irq_info)
>   {
> -    struct cxl_context *ctx = data;
>       u64 dsisr, dar;
>
>       dsisr = irq_info->dsisr;
