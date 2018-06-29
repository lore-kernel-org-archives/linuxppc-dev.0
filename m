Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H1Wl1bCQzF1d1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 12:56:47 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5T2sIqr139548
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 22:56:45 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jwbrgs846-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2018 22:56:45 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Thu, 28 Jun 2018 22:56:44 -0400
References: <1529979376-7292-1-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, msuchanek@suse.de
Subject: Re: [PATCH 1/2] powerpc/pkeys: preallocate execute_only key only if
 the key is available.
In-reply-to: <1529979376-7292-1-git-send-email-linuxram@us.ibm.com>
Date: Thu, 28 Jun 2018 23:56:34 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87fu16xpul.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello,

Ram Pai <linuxram@us.ibm.com> writes:

> Key 2 is preallocated and reserved for execute-only key. In rare
> cases if key-2 is unavailable, mprotect(PROT_EXEC) will behave
> incorrectly. NOTE: mprotect(PROT_EXEC) uses execute-only key.
>
> Ensure key 2 is available for preallocation before reserving it for
> execute_only purpose.  Problem noticed by Michael Ellermen.

Since "powerpc/pkeys: Preallocate execute-only key" isn't upstream yet,
this patch could be squashed into it.

> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/mm/pkeys.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index cec990c..0b03914 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -19,6 +19,7 @@
>  u64  pkey_amr_mask;		/* Bits in AMR not to be touched */
>  u64  pkey_iamr_mask;		/* Bits in AMR not to be touched */
>  u64  pkey_uamor_mask;		/* Bits in UMOR not to be touched */
> +int  execute_only_key = 2;
>
>  #define AMR_BITS_PER_PKEY 2
>  #define AMR_RD_BIT 0x1UL
> @@ -26,7 +27,6 @@
>  #define IAMR_EX_BIT 0x1UL
>  #define PKEY_REG_BITS (sizeof(u64)*8)
>  #define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey+1) * AMR_BITS_PER_PKEY))
> -#define EXECUTE_ONLY_KEY 2
>
>  static void scan_pkey_feature(void)
>  {
> @@ -122,8 +122,12 @@ int pkey_initialize(void)
>  #else
>  	os_reserved = 0;
>  #endif
> +
> +	if ((pkeys_total - os_reserved) <= execute_only_key)
> +		execute_only_key = -1;
> +
>  	/* Bits are in LE format. */
> -	reserved_allocation_mask = (0x1 << 1) | (0x1 << EXECUTE_ONLY_KEY);
> +	reserved_allocation_mask = (0x1 << 1) | (0x1 << execute_only_key);

My understanding is that left-shifting by a negative amount is undefined
behavior in C. A quick test tells me that at least on the couple of
machines I tested, 1 < -1 = 0. Does GCC guarantee that behavior? If so,
a comment pointing this out would make this less confusing.

>  	initial_allocation_mask  = reserved_allocation_mask | (0x1 << PKEY_0);
>
>  	/* register mask is in BE format */
> @@ -132,11 +136,11 @@ int pkey_initialize(void)
>
>  	pkey_iamr_mask = ~0x0ul;
>  	pkey_iamr_mask &= ~(0x3ul << pkeyshift(PKEY_0));
> -	pkey_iamr_mask &= ~(0x3ul << pkeyshift(EXECUTE_ONLY_KEY));
> +	pkey_iamr_mask &= ~(0x3ul << pkeyshift(execute_only_key));
>
>  	pkey_uamor_mask = ~0x0ul;
>  	pkey_uamor_mask &= ~(0x3ul << pkeyshift(PKEY_0));
> -	pkey_uamor_mask &= ~(0x3ul << pkeyshift(EXECUTE_ONLY_KEY));
> +	pkey_uamor_mask &= ~(0x3ul << pkeyshift(execute_only_key));

Here the behaviour is undefined in C as well, given that pkeyshift(-1) =
64, which is the total number of bits in the left operand. Does GCC
guarantee that the result will be 0 here as well?

--
Thiago Jung Bauermann
IBM Linux Technology Center
