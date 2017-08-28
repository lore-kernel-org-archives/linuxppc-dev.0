Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgdwd46NZzDqBf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:25:21 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7S4NeHv030811
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 00:25:18 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ckp3jyjq3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 00:25:18 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 28 Aug 2017 14:25:15 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7S4PCxm43843636
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:25:12 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7S4P3G7019501
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:25:03 +1000
Subject: Re: [PATCH] cxl: Set the valid bit in PE for dedicated mode
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
References: <20170828041522.32188-1-vaibhav@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 28 Aug 2017 14:25:10 +1000
MIME-Version: 1.0
In-Reply-To: <20170828041522.32188-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e07571a2-7618-084f-cbe3-8180a36b3581@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/08/17 14:15, Vaibhav Jain wrote:
> Make sure to set the valid-bit in software-state field of the
> populated PE. This was earlier missing for dedicated mode AFUs, hence
> was causing a PSL freeze when the AFU was activated.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

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
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
