Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhK9X3BdfzDqLm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:53:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [PATCH] cxl: Set the valid bit in PE for dedicated mode
In-Reply-To: <20170828041522.32188-1-vaibhav@linux.vnet.ibm.com>
References: <20170828041522.32188-1-vaibhav@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 16:53:52 +1000
Message-ID: <87r2vu27b3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:

> Make sure to set the valid-bit in software-state field of the
> populated PE. This was earlier missing for dedicated mode AFUs, hence
> was causing a PSL freeze when the AFU was activated.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/native.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 4a82c313cf71..0e748c682ee9 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -897,6 +897,10 @@ int cxl_attach_dedicated_process_psl9(struct cxl_context *ctx, u64 wed, u64 amr)
>  	if (ctx->afu->adapter->native->sl_ops->update_dedicated_ivtes)
>  		afu->adapter->native->sl_ops->update_dedicated_ivtes(ctx);
>  
> +	ctx->elem->software_state = cpu_to_be32(CXL_PE_SOFTWARE_STATE_V);
> +	/* Make sure the changes to the PE are visible to the card */

A barrier orders something vs something else. So what's the something
else in this case? Is it the afu_reset() below, what does that actually do?

> +	smp_wmb();
> +
>  	result = cxl_ops->afu_reset(afu);
>  	if (result)
>  		return result;

cheers
