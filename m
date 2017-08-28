Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xglzb6Mf0zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 18:58:19 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7S8v9Gm095988
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 04:58:17 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cmagbdqjn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 04:58:16 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Mon, 28 Aug 2017 09:58:14 +0100
Subject: Re: [PATCH] cxl: Set the valid bit in PE for dedicated mode
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
References: <20170828041522.32188-1-vaibhav@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 10:58:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170828041522.32188-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e937daa7-9671-c700-edf9-9a890c9af7fd@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 28/08/2017 à 06:15, Vaibhav Jain a écrit :
> Make sure to set the valid-bit in software-state field of the
> populated PE. This was earlier missing for dedicated mode AFUs, hence
> was causing a PSL freeze when the AFU was activated.

Acked-by:  Christophe Lombard <clombard@linux.vnet.ibm.com>

> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>   drivers/misc/cxl/native.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 4a82c313cf71..0e748c682ee9 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -897,6 +897,10 @@ int cxl_attach_dedicated_process_psl9(struct cxl_context *ctx, u64 wed, u64 amr)
>   	if (ctx->afu->adapter->native->sl_ops->update_dedicated_ivtes)
>   		afu->adapter->native->sl_ops->update_dedicated_ivtes(ctx);
>
> +	ctx->elem->software_state = cpu_to_be32(CXL_PE_SOFTWARE_STATE_V);
> +	/* Make sure the changes to the PE are visible to the card */
> +	smp_wmb();
> +
>   	result = cxl_ops->afu_reset(afu);
>   	if (result)
>   		return result;
