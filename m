Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xm5Ds0ckXzDqkh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 20:09:48 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v84A9S9U137075
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Sep 2017 06:09:46 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cs15bu3wk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Sep 2017 06:09:45 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 4 Sep 2017 11:09:43 +0100
Subject: Re: [PATCH v2] cxl: Set the valid bit in PE for dedicated mode
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
References: <20170904084825.22172-1-vaibhav@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 4 Sep 2017 12:09:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170904084825.22172-1-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <ff10e314-893c-54b6-2602-b834411b9560@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/09/2017 à 10:48, Vaibhav Jain a écrit :
> Make sure to set the valid-bit in software-state field of the
> populated PE. This was earlier missing for dedicated mode AFUs, hence
> was causing a PSL freeze when the AFU was activated.
> 
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
> Changelog:
> 
> v2 -> Removed a call to smp_wmb() after setting the bit [Michael Ellerman]
> ---

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


> 
>   drivers/misc/cxl/native.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 4a82c313cf71..75df74d59527 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -897,6 +897,14 @@ int cxl_attach_dedicated_process_psl9(struct cxl_context *ctx, u64 wed, u64 amr)
>   	if (ctx->afu->adapter->native->sl_ops->update_dedicated_ivtes)
>   		afu->adapter->native->sl_ops->update_dedicated_ivtes(ctx);
> 
> +	ctx->elem->software_state = cpu_to_be32(CXL_PE_SOFTWARE_STATE_V);
> +	/*
> +	 * Ideally we should do a wmb() here to make sure the changes to the
> +	 * PE are visible to the card before we call afu_enable.
> +	 * On ppc64 though all mmios are preceded by a 'sync' instruction hence
> +	 * we dont dont need one here.
> +	 */
> +
>   	result = cxl_ops->afu_reset(afu);
>   	if (result)
>   		return result;
> 
