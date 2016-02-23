Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AF061A07C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 06:09:02 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Tue, 23 Feb 2016 12:08:59 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7A14A19D8047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 11:56:54 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1NJ8vKN32637180
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 12:08:57 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1NJ8vL6016059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 12:08:57 -0700
Received: from [9.41.250.246] (manoj.austin.ibm.com [9.41.250.246])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u1NJ8uNn016027
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 12:08:57 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH v5 03/18] cxl: Define process problem state area at attach
 time only
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1456244519-18934-4-git-send-email-fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56CCAE5E.5040308@linux.vnet.ibm.com>
Date: Tue, 23 Feb 2016 13:09:18 -0600
MIME-Version: 1.0
In-Reply-To: <1456244519-18934-4-git-send-email-fbarrat@linux.vnet.ibm.com>
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


On 2/23/2016 10:21 AM, Frederic Barrat wrote:
> CXL kernel API was defining the process problem state area during
> context initialization, making it possible to map the problem state
> area before attaching the context. This won't work on a powerVM
> guest. So force the logical behavior, like in userspace: attach first,
> then map the problem state area.
> Remove calls to cxl_assign_psn_space during init. The function is
> already called on the attach paths.
>
> Co-authored-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> ---
>   drivers/misc/cxl/api.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index ea3eeb7..b45d857 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -51,8 +51,6 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
>   	if (rc)
>   		goto err_mapping;
>
> -	cxl_assign_psn_space(ctx);
> -
>   	return ctx;
>
>   err_mapping:
> @@ -207,7 +205,6 @@ EXPORT_SYMBOL_GPL(cxl_stop_context);
>   void cxl_set_master(struct cxl_context *ctx)
>   {
>   	ctx->master = true;
> -	cxl_assign_psn_space(ctx);
>   }
>   EXPORT_SYMBOL_GPL(cxl_set_master);
>
> @@ -325,15 +322,11 @@ EXPORT_SYMBOL_GPL(cxl_start_work);
>
>   void __iomem *cxl_psa_map(struct cxl_context *ctx)
>   {
> -	struct cxl_afu *afu = ctx->afu;
> -	int rc;
> -
> -	rc = cxl_afu_check_and_enable(afu);
> -	if (rc)
> +	if (ctx->status != STARTED)
>   		return NULL;
>
>   	pr_devel("%s: psn_phys%llx size:%llx\n",
> -		 __func__, afu->psn_phys, afu->adapter->ps_size);
> +		__func__, ctx->psn_phys, ctx->psn_size);
>   	return ioremap(ctx->psn_phys, ctx->psn_size);
>   }
>   EXPORT_SYMBOL_GPL(cxl_psa_map);
>
