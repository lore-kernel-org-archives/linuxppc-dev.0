Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EC95C1400D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 15:30:48 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Apr 2014 11:00:44 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CB9E6E005F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 11:01:02 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3U5UoYF53543092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 11:00:50 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3U5Uggg030867
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 11:00:42 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Liu Ping Fan <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc: mm: use macro PGTABLE_EADDR_SIZE instead of
 digital
In-Reply-To: <1385000275-5988-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1385000275-5988-1-git-send-email-pingfank@linux.vnet.ibm.com>
Date: Wed, 30 Apr 2014 11:00:39 +0530
Message-ID: <87tx9bbczk.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Liu Ping Fan <kernelfans@gmail.com> writes:

> In case of extending the eaddr in future, use this macro
> PGTABLE_EADDR_SIZE to ease the maintenance of the code.
>
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>  arch/powerpc/mm/slb_low.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
> index 17aa6df..e0b3cf4 100644
> --- a/arch/powerpc/mm/slb_low.S
> +++ b/arch/powerpc/mm/slb_low.S
> @@ -35,7 +35,7 @@ _GLOBAL(slb_allocate_realmode)
>  	 * check for bad kernel/user address
>  	 * (ea & ~REGION_MASK) >= PGTABLE_RANGE
>  	 */
> -	rldicr. r9,r3,4,(63 - 46 - 4)
> +	rldicr. r9,r3,4,(63 - PGTABLE_EADDR_SIZE - 4)
>  	bne-	8f
>
>  	srdi	r9,r3,60		/* get region */
> -- 
> 1.8.1.4
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
