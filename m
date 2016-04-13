Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ql7Q66gDRzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 12:42:54 +1000 (AEST)
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Apr 2016 08:12:51 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3D2glt243057358
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 08:12:48 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3D2giSX001377
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 08:12:46 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH V2 01/68] powerpc/cxl: Use REGION_ID instead of opencoding
In-Reply-To: <1460182444-2468-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 13 Apr 2016 08:12:43 +0530
Message-ID: <87mvoy9ql8.fsf@skywalker.in.ibm.com>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Also note that the `~` operation is wrong.
>
> Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index 9a8650bcb042..9a236543da23 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c
> @@ -152,7 +152,7 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
>  	access = _PAGE_PRESENT;
>  	if (dsisr & CXL_PSL_DSISR_An_S)
>  		access |= _PAGE_RW;
> -	if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
> +	if ((!ctx->kernel) || (REGION_ID(dar) == USER_REGION_ID))
>  		access |= _PAGE_USER;
>
>  	if (dsisr & DSISR_NOHPTE)
> -- 
> 2.5.0

Posted an updated version of this patch alone with improved commit
message here

http://mid.gmane.org/1460482475-20782-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com

-aneesh
