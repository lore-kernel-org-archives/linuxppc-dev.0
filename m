Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A42D81A0008
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jun 2014 04:14:48 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Sat, 7 Jun 2014 04:14:46 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 579582CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jun 2014 04:14:44 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s56HwiZc20709562
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 7 Jun 2014 03:58:44 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s56IEhee020926
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 7 Jun 2014 04:14:43 +1000
Date: Fri, 6 Jun 2014 23:44:33 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/powernv: Fix endian issues in memory error
 handling code
Message-ID: <20140606181433.GA616@in.ibm.com>
References: <20140604144848.459a15e5@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140604144848.459a15e5@kryten>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Reply-To: mahesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014-06-04 14:48:48 Wed, Anton Blanchard wrote:
> struct OpalMemoryErrorData is passed to us from firmware, so we
> have to byteswap it.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Tested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

> ---
> 
> Having enums in a firmware interface concerns me, but that cleanup
> can be in a subsequent patch.
> 
> Mahesh, could you give this a test to see if it works?
> 
> Index: b/arch/powerpc/include/asm/opal.h
> ===================================================================
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -482,7 +482,7 @@ enum OpalMemErr_DynErrType {
>  struct OpalMemoryErrorData {
>  	enum OpalMemErr_Version	version:8;	/* 0x00 */
>  	enum OpalMemErrType	type:8;		/* 0x01 */
> -	uint16_t		flags;		/* 0x02 */
> +	__be16			flags;		/* 0x02 */
>  	uint8_t			reserved_1[4];	/* 0x04 */
> 
>  	union {
> @@ -490,15 +490,15 @@ struct OpalMemoryErrorData {
>  		struct {
>  			enum OpalMemErr_ResilErrType resil_err_type:8;
>  			uint8_t		reserved_1[7];
> -			uint64_t	physical_address_start;
> -			uint64_t	physical_address_end;
> +			__be64		physical_address_start;
> +			__be64		physical_address_end;
>  		} resilience;
>  		/* Dynamic memory deallocation error info */
>  		struct {
>  			enum OpalMemErr_DynErrType dyn_err_type:8;
>  			uint8_t		reserved_1[7];
> -			uint64_t	physical_address_start;
> -			uint64_t	physical_address_end;
> +			__be64		physical_address_start;
> +			__be64		physical_address_end;
>  		} dyn_dealloc;
>  	} u;
>  };
> Index: b/arch/powerpc/platforms/powernv/opal-memory-errors.c
> ===================================================================
> --- a/arch/powerpc/platforms/powernv/opal-memory-errors.c
> +++ b/arch/powerpc/platforms/powernv/opal-memory-errors.c
> @@ -47,12 +47,12 @@ static void handle_memory_error_event(st
>  		  __func__, merr_evt->type);
>  	switch (merr_evt->type) {
>  	case OPAL_MEM_ERR_TYPE_RESILIENCE:
> -		paddr_start = merr_evt->u.resilience.physical_address_start;
> -		paddr_end = merr_evt->u.resilience.physical_address_end;
> +		paddr_start = be64_to_cpu(merr_evt->u.resilience.physical_address_start);
> +		paddr_end = be64_to_cpu(merr_evt->u.resilience.physical_address_end);
>  		break;
>  	case OPAL_MEM_ERR_TYPE_DYN_DALLOC:
> -		paddr_start = merr_evt->u.dyn_dealloc.physical_address_start;
> -		paddr_end = merr_evt->u.dyn_dealloc.physical_address_end;
> +		paddr_start = be64_to_cpu(merr_evt->u.dyn_dealloc.physical_address_start);
> +		paddr_end = be64_to_cpu(merr_evt->u.dyn_dealloc.physical_address_end);
>  		break;
>  	default:
>  		return;
> 

-- 
Mahesh J Salgaonkar
