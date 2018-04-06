Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40HsC52kGpzF1ql
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2018 06:45:05 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w36KifgK045114
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Apr 2018 16:45:01 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h6bwujkqr-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Apr 2018 16:45:01 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 6 Apr 2018 14:45:00 -0600
References: <1522112702-27853-1-git-send-email-linuxram@us.ibm.com>
 <876056645u.fsf@morokweng.localdomain>
 <20180406180126.GJ5743@ram.oc3035372033.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 fweimer@redhat.com, shuah@kernel.org, msuchanek@suse.com,
 linux-kernel@vger.kernel.org, mhocko@kernel.org, dave.hansen@intel.com,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc, pkey: make protection key 0 less special
In-reply-to: <20180406180126.GJ5743@ram.oc3035372033.ibm.com>
Date: Fri, 06 Apr 2018 17:44:49 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87vad4rrni.fsf@morokweng.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ram Pai <linuxram@us.ibm.com> writes:

> On Wed, Apr 04, 2018 at 06:41:01PM -0300, Thiago Jung Bauermann wrote:
>>
>> Hello Ram,
>>
>> Ram Pai <linuxram@us.ibm.com> writes:
>>
>> > Applications need the ability to associate an address-range with some
>> > key and latter revert to its initial default key. Pkey-0 comes close to
>> > providing this function but falls short, because the current
>> > implementation disallows applications to explicitly associate pkey-0 to
>> > the address range.
>> >
>> > Lets make pkey-0 less special and treat it almost like any other key.
>> > Thus it can be explicitly associated with any address range, and can be
>> > freed. This gives the application more flexibility and power.  The
>> > ability to free pkey-0 must be used responsibily, since pkey-0 is
>> > associated with almost all address-range by default.
>> >
>> > Even with this change pkey-0 continues to be slightly more special
>> > from the following point of view.
>> > (a) it is implicitly allocated.
>> > (b) it is the default key assigned to any address-range.
>>
>> It's also special in more ways (and if intentional, these should be part
>> of the commit message as well):
>>
>> (c) it's not possible to change permissions for key 0
>>
>>   This has two causes: this patch explicitly forbids it in
>>   arch_set_user_pkey_access(), and also because even if it's allocated,
>>   the bits for key 0 in AMOR and UAMOR aren't set.
>
> Yes. will have to capture that one aswell.
>
> we cannot let userspace change permissions on key 0 because
> doing so will hurt the kernel too. Unlike x86 where keys are effective
> only in userspace, powerpc keys are effective even in the kernel.
> So if the kernel tries to access something, it will get stuck forever.
> Almost everything in the kernel is associated with key-0.
>
> I ran a small test program which disabled access on key 0 from
> userspace, and as expected ran into softlockups. It certainly
> can lead to denial-of-service-attack. We can let apps
> shoot-itself-in-its-foot but if the shot hurts someone else, we will
> have to stop it.

Ah, I wasn't aware of that. We definitely shouldn't let userspace change
key 0 permissions then. :-) It would be good to have this information in
a comment in the code somewhere, IMHO.

> The key-semantics discussed with the x86 folks did not
> explicitly say anything about changing permissions on key-0. We will
> have to keep that part of the semantics open-ended.
>
>>
>> (d) it can be freed, but can't be allocated again later.
>>
>>   This is because mm_pkey_alloc() only calls __arch_activate_pkey(ret)
>>   if ret > 0.
>>
>> It looks like (d) is a bug. Either mm_pkey_free() should fail with key
>> 0, or mm_pkey_alloc() should work with it.
>
> Well, it can be allocated, just that we do not let userspace change the
> permissions on the key.  __arch_activate_pkey(ret) does not get called
> for pkey-0.

Yes, now I see how the allocated-but-not-enabled state makes sense.
Considering that the kernel always uses key 0, it's unworkable on
powerpc for an app to free pkey 0. In that case I think we should reject
it in mm_pkey_free().

>> (c) could be a measure to prevent users from shooting themselves in
>> their feet. But if that is the case, then mm_pkey_free() should forbid
>> freeing key 0 too.
>>
>> > Tested on powerpc.
>> >
>> > cc: Thomas Gleixner <tglx@linutronix.de>
>> > cc: Dave Hansen <dave.hansen@intel.com>
>> > cc: Michael Ellermen <mpe@ellerman.id.au>
>> > cc: Ingo Molnar <mingo@kernel.org>
>> > cc: Andrew Morton <akpm@linux-foundation.org>
>> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
>> > ---
>> > History:
>> > 	v2: mm_pkey_is_allocated() continued to treat pkey-0 special.
>> > 	    fixed it.
>> >
>> >  arch/powerpc/include/asm/pkeys.h | 20 ++++++++++++++++----
>> >  arch/powerpc/mm/pkeys.c          | 20 ++++++++++++--------
>> >  2 files changed, 28 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
>> > index 0409c80..b598fa9 100644
>> > --- a/arch/powerpc/include/asm/pkeys.h
>> > +++ b/arch/powerpc/include/asm/pkeys.h
>> > @@ -101,10 +101,14 @@ static inline u16 pte_to_pkey_bits(u64 pteflags)
>> >
>> >  static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
>> >  {
>> > -	/* A reserved key is never considered as 'explicitly allocated' */
>> > -	return ((pkey < arch_max_pkey()) &&
>> > -		!__mm_pkey_is_reserved(pkey) &&
>> > -		__mm_pkey_is_allocated(mm, pkey));
>> > +	if (pkey < 0 || pkey >= arch_max_pkey())
>> > +		return false;
>> > +
>> > +	/* Reserved keys are never allocated. */
>> > +	if (__mm_pkey_is_reserved(pkey))
>> > +		return false;
>> > +
>> > +	return __mm_pkey_is_allocated(mm, pkey);
>> >  }
>> >
>> >  extern void __arch_activate_pkey(int pkey);
>> > @@ -200,6 +204,14 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>> >  {
>> >  	if (static_branch_likely(&pkey_disabled))
>> >  		return -EINVAL;
>> > +
>> > +	/*
>> > +	 * userspace is discouraged from changing permissions of
>> > +	 * pkey-0.
>>
>> They're not discouraged. They're not allowed to. :-)
>
> ok :-)
>
>>
>> > +	 * powerpc hardware does not support it anyway.
>>
>> It doesn't? I don't get that impression from reading the ISA, but
>> perhaps I'm missing something.
>
> Good Catch. I am wrongly blaming it on powerpc hardware.
> Its a semantics enforced by our pkey code to block DOS attacks.

I think this would be a good place to explain why we can't allow
userspace to change permissions on key 0.

>
>>
>> > +	 */
>> > +	if (!pkey)
>> > +		return init_val ? -EINVAL : 0;
>> > +
>> >  	return __arch_set_user_pkey_access(tsk, pkey, init_val);
>> >  }
>> >
>> > diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
>> > index ba71c54..e7a9e34 100644
>> > --- a/arch/powerpc/mm/pkeys.c
>> > +++ b/arch/powerpc/mm/pkeys.c
>> > @@ -119,19 +119,21 @@ int pkey_initialize(void)
>> >  #else
>> >  	os_reserved = 0;
>> >  #endif
>> > -	/*
>> > -	 * Bits are in LE format. NOTE: 1, 0 are reserved.
>> > -	 * key 0 is the default key, which allows read/write/execute.
>> > -	 * key 1 is recommended not to be used. PowerISA(3.0) page 1015,
>> > -	 * programming note.
>> > -	 */
>> > +	/* Bits are in LE format. */
>> >  	initial_allocation_mask = ~0x0;
>> >
>> >  	/* register mask is in BE format */
>> >  	pkey_amr_uamor_mask = ~0x0ul;
>> >  	pkey_iamr_mask = ~0x0ul;
>> >
>> > -	for (i = 2; i < (pkeys_total - os_reserved); i++) {
>> > +	for (i = 0; i < (pkeys_total - os_reserved); i++) {
>> > +	 	/*
>>
>> There's a space between the tabs here.
>
> ok. will fix.
>
>>
>> > +		 * key 1 is recommended not to be used.
>> > +		 * PowerISA(3.0) page 1015,
>> > +		 */
>> > +		if (i == 1)
>> > +			continue;
>> > +
>> >  		initial_allocation_mask &= ~(0x1 << i);
>> >  		pkey_amr_uamor_mask &= ~(0x3ul << pkeyshift(i));
>> >  		pkey_iamr_mask &= ~(0x1ul << pkeyshift(i));
>> > @@ -145,7 +147,9 @@ void pkey_mm_init(struct mm_struct *mm)
>> >  {
>> >  	if (static_branch_likely(&pkey_disabled))
>> >  		return;
>> > -	mm_pkey_allocation_map(mm) = initial_allocation_mask;
>> > +
>> > +	/* allocate key-0 by default */
>> > +	mm_pkey_allocation_map(mm) = initial_allocation_mask | 0x1;
>> >  	/* -1 means unallocated or invalid */
>> >  	mm->context.execute_only_pkey = -1;
>> >  }
>>
>> I think we should also set the AMOR and UAMOR bits for key 0. Otherwise,
>> key 0 will be in allocated-but-not-enabled state which is yet another
>> subtle way in which it will be special.
>
> No. as explained above, it will hurt to let userspace modify
> permissions on key-0.

Indeed. Thanks for explaining and even double-checking that it's indeed
the case.

>>
>> Also, pkey_access_permitted() has a special case for key 0. Should it?
>
> we can delete that check. though it does not hurt to leave it in place.
> Access/Write/Execute on pkey-0 is always permitted.

It doesn't hurt, but it's redundant since the is_pkey_enabled() call
right below will have the same effect.

Actually I just changed my mind because I see now that the early exit
prevents the need to read the UAMOR (which is done by
is_pkey_enabled()). Since this function is called by page table code
it's probably worth avoiding the additional SPR access.

--
Thiago Jung Bauermann
IBM Linux Technology Center
