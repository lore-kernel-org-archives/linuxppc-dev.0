Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40d4pb5tCdzDr4K
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 07:26:54 +1000 (AEST)
Date: Fri, 4 May 2018 23:26:47 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: "Ram Pai" <linuxram@us.ibm.com>
Cc: <mpe@ellerman.id.au>, <Ulrich.Weigand@de.ibm.com>,
 <bsingharora@gmail.com>, "Dave Hansen" <dave.hansen@intel.com>,
 <benh@kernel.crashing.org>, <mhocko@kernel.org>, "Ingo Molnar"
 <mingo@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Andrew Morton"
 <akpm@linux-foundation.org>, <aneesh.kumar@linux.vnet.ibm.com>,
 <bauerman@linux.vnet.ibm.com>, <linuxppc-dev@lists.ozlabs.org>,
 <fweimer@redhat.com>, <paulus@samba.org>, <hbabu@us.ibm.com>
Subject: Re: [PATCH v3] powerpc, pkey: make protection key 0 less special
Message-ID: <20180504232647.3412f563@naga.suse.cz>
In-Reply-To: <1525461778-26265-1-git-send-email-linuxram@us.ibm.com>
References: <1525461778-26265-1-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  4 May 2018 12:22:58 -0700
"Ram Pai" <linuxram@us.ibm.com> wrote:

> Applications need the ability to associate an address-range with some
> key and latter revert to its initial default key. Pkey-0 comes close
> to providing this function but falls short, because the current
> implementation disallows applications to explicitly associate pkey-0
> to the address range.
> 
> Lets make pkey-0 less special and treat it almost like any other key.
> Thus it can be explicitly associated with any address range, and can
> be freed. This gives the application more flexibility and power.  The
> ability to free pkey-0 must be used responsibily, since pkey-0 is
> associated with almost all address-range by default.
> 
> Even with this change pkey-0 continues to be slightly more special
> from the following point of view.
> (a) it is implicitly allocated.
> (b) it is the default key assigned to any address-range.
> (c) its permissions cannot be modified by userspace.
> 
> NOTE: (c) is specific to powerpc only. pkey-0 is associated by default
> with all pages including kernel pages, and pkeys are also active in
> kernel mode. If any permission is denied on pkey-0, the kernel running
> in the context of the application will be unable to operate.

If it is not ok to change permissions of pkey 0 is it ok to free it?

Thanks

Michal
> 
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
> 
> 	v3: . Corrected a comment in arch_set_user_pkey_access().
> 	    . Clarified the header, to capture the notion that
> 	      pkey-0 permissions cannot be modified by userspace on
> powerpc. -- comment from Thiago
> 
> 	v2: . mm_pkey_is_allocated() continued to treat pkey-0
> special. fixed it.
> 
>  arch/powerpc/include/asm/pkeys.h |   22 ++++++++++++++++++----
>  arch/powerpc/mm/pkeys.c          |   26 +++++++++++++++-----------
>  2 files changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pkeys.h
> b/arch/powerpc/include/asm/pkeys.h index 0409c80..31a6976 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -101,10 +101,14 @@ static inline u16 pte_to_pkey_bits(u64 pteflags)
>  
>  static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int
> pkey) {
> -	/* A reserved key is never considered as 'explicitly
> allocated' */
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
> @@ -200,6 +204,16 @@ static inline int
> arch_set_user_pkey_access(struct task_struct *tsk, int pkey, {
>  	if (static_branch_likely(&pkey_disabled))
>  		return -EINVAL;
> +
> +	/*
> +	 * userspace should not change pkey-0 permissions.
> +	 * pkey-0 is associated with every page in the kernel.
> +	 * If userspace denies any permission on pkey-0, the
> +	 * kernel cannot operate.
> +	 */
> +	if (!pkey)
> +		return init_val ? -EINVAL : 0;
> +
>  	return __arch_set_user_pkey_access(tsk, pkey, init_val);
>  }
>  
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index 0eafdf0..d6873b4 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -119,16 +119,21 @@ int pkey_initialize(void)
>  #else
>  	os_reserved = 0;
>  #endif
> +	/* Bits are in LE format. */
>  	initial_allocation_mask = ~0x0;
> +
> +	/* register mask is in BE format */
>  	pkey_amr_uamor_mask = ~0x0ul;
>  	pkey_iamr_mask = ~0x0ul;
> -	/*
> -	 * key 0, 1 are reserved.
> -	 * key 0 is the default key, which allows read/write/execute.
> -	 * key 1 is recommended not to be used. PowerISA(3.0) page
> 1015,
> -	 * programming note.
> -	 */
> -	for (i = 2; i < (pkeys_total - os_reserved); i++) {
> +
> +	for (i = 0; i < (pkeys_total - os_reserved); i++) {
> +		/*
> +		 * key 1 is recommended not to be used.
> +		 * PowerISA(3.0) page 1015,
> +		 */
> +		if (i == 1)
> +			continue;
> +
>  		initial_allocation_mask &= ~(0x1 << i);
>  		pkey_amr_uamor_mask &= ~(0x3ul << pkeyshift(i));
>  		pkey_iamr_mask &= ~(0x1ul << pkeyshift(i));
> @@ -142,7 +147,9 @@ void pkey_mm_init(struct mm_struct *mm)
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
> @@ -407,9 +414,6 @@ static bool pkey_access_permitted(int pkey, bool
> write, bool execute) int pkey_shift;
>  	u64 amr;
>  
> -	if (!pkey)
> -		return true;
> -
>  	if (!is_pkey_enabled(pkey))
>  		return true;
>  
