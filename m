Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GfXt4FY2zF1pC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 07:41:18 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w34LdkU2105923
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Apr 2018 17:41:16 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h53ne7rxr-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 17:41:15 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 4 Apr 2018 15:41:15 -0600
References: <1522112702-27853-1-git-send-email-linuxram@us.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 fweimer@redhat.com, shuah@kernel.org, msuchanek@suse.com,
 linux-kernel@vger.kernel.org, mhocko@kernel.org, dave.hansen@intel.com,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc, pkey: make protection key 0 less special
In-reply-to: <1522112702-27853-1-git-send-email-linuxram@us.ibm.com>
Date: Wed, 04 Apr 2018 18:41:01 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <876056645u.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello Ram,

Ram Pai <linuxram@us.ibm.com> writes:

> Applications need the ability to associate an address-range with some
> key and latter revert to its initial default key. Pkey-0 comes close to
> providing this function but falls short, because the current
> implementation disallows applications to explicitly associate pkey-0 to
> the address range.
>
> Lets make pkey-0 less special and treat it almost like any other key.
> Thus it can be explicitly associated with any address range, and can be
> freed. This gives the application more flexibility and power.  The
> ability to free pkey-0 must be used responsibily, since pkey-0 is
> associated with almost all address-range by default.
>
> Even with this change pkey-0 continues to be slightly more special
> from the following point of view.
> (a) it is implicitly allocated.
> (b) it is the default key assigned to any address-range.

It's also special in more ways (and if intentional, these should be part
of the commit message as well):

(c) it's not possible to change permissions for key 0

  This has two causes: this patch explicitly forbids it in
  arch_set_user_pkey_access(), and also because even if it's allocated,
  the bits for key 0 in AMOR and UAMOR aren't set.

(d) it can be freed, but can't be allocated again later.

  This is because mm_pkey_alloc() only calls __arch_activate_pkey(ret)
  if ret > 0.

It looks like (d) is a bug. Either mm_pkey_free() should fail with key
0, or mm_pkey_alloc() should work with it.

(c) could be a measure to prevent users from shooting themselves in
their feet. But if that is the case, then mm_pkey_free() should forbid
freeing key 0 too.

> Tested on powerpc.
>
> cc: Thomas Gleixner <tglx@linutronix.de>
> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Michael Ellermen <mpe@ellerman.id.au>
> cc: Ingo Molnar <mingo@kernel.org>
> cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
> History:
> 	v2: mm_pkey_is_allocated() continued to treat pkey-0 special.
> 	    fixed it.
>
>  arch/powerpc/include/asm/pkeys.h | 20 ++++++++++++++++----
>  arch/powerpc/mm/pkeys.c          | 20 ++++++++++++--------
>  2 files changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 0409c80..b598fa9 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -101,10 +101,14 @@ static inline u16 pte_to_pkey_bits(u64 pteflags)
>
>  static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
>  {
> -	/* A reserved key is never considered as 'explicitly allocated' */
> -	return ((pkey < arch_max_pkey()) &&
> -		!__mm_pkey_is_reserved(pkey) &&
> -		__mm_pkey_is_allocated(mm, pkey));
> +	if (pkey < 0 || pkey >= arch_max_pkey())
> +		return false;
> +
> +	/* Reserved keys are never allocated. */
> +	if (__mm_pkey_is_reserved(pkey))
> +		return false;
> +
> +	return __mm_pkey_is_allocated(mm, pkey);
>  }
>
>  extern void __arch_activate_pkey(int pkey);
> @@ -200,6 +204,14 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>  {
>  	if (static_branch_likely(&pkey_disabled))
>  		return -EINVAL;
> +
> +	/*
> +	 * userspace is discouraged from changing permissions of
> +	 * pkey-0.

They're not discouraged. They're not allowed to. :-)

> +	 * powerpc hardware does not support it anyway.

It doesn't? I don't get that impression from reading the ISA, but
perhaps I'm missing something.

> +	 */
> +	if (!pkey)
> +		return init_val ? -EINVAL : 0;
> +
>  	return __arch_set_user_pkey_access(tsk, pkey, init_val);
>  }
>
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index ba71c54..e7a9e34 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -119,19 +119,21 @@ int pkey_initialize(void)
>  #else
>  	os_reserved = 0;
>  #endif
> -	/*
> -	 * Bits are in LE format. NOTE: 1, 0 are reserved.
> -	 * key 0 is the default key, which allows read/write/execute.
> -	 * key 1 is recommended not to be used. PowerISA(3.0) page 1015,
> -	 * programming note.
> -	 */
> +	/* Bits are in LE format. */
>  	initial_allocation_mask = ~0x0;
>
>  	/* register mask is in BE format */
>  	pkey_amr_uamor_mask = ~0x0ul;
>  	pkey_iamr_mask = ~0x0ul;
>
> -	for (i = 2; i < (pkeys_total - os_reserved); i++) {
> +	for (i = 0; i < (pkeys_total - os_reserved); i++) {
> +	 	/*

There's a space between the tabs here.

> +		 * key 1 is recommended not to be used.
> +		 * PowerISA(3.0) page 1015,
> +		 */
> +		if (i == 1)
> +			continue;
> +
>  		initial_allocation_mask &= ~(0x1 << i);
>  		pkey_amr_uamor_mask &= ~(0x3ul << pkeyshift(i));
>  		pkey_iamr_mask &= ~(0x1ul << pkeyshift(i));
> @@ -145,7 +147,9 @@ void pkey_mm_init(struct mm_struct *mm)
>  {
>  	if (static_branch_likely(&pkey_disabled))
>  		return;
> -	mm_pkey_allocation_map(mm) = initial_allocation_mask;
> +
> +	/* allocate key-0 by default */
> +	mm_pkey_allocation_map(mm) = initial_allocation_mask | 0x1;
>  	/* -1 means unallocated or invalid */
>  	mm->context.execute_only_pkey = -1;
>  }

I think we should also set the AMOR and UAMOR bits for key 0. Otherwise,
key 0 will be in allocated-but-not-enabled state which is yet another
subtle way in which it will be special.

Also, pkey_access_permitted() has a special case for key 0. Should it?

--
Thiago Jung Bauermann
IBM Linux Technology Center
