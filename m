Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLmf60jFczDqkr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 19:29:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 05/25] powerpc: helper functions to initialize AMR,
 IAMR and UAMOR registers
In-Reply-To: <20171024070416.GG5454@ram.oc3035372033.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-14-git-send-email-linuxram@us.ibm.com>
 <873769xdsq.fsf@linux.vnet.ibm.com>
 <20171024070416.GG5454@ram.oc3035372033.ibm.com>
Date: Tue, 24 Oct 2017 10:29:26 +0200
Message-ID: <87fua93q55.fsf@concordia.ellerman.id.au>
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

Ram Pai <linuxram@us.ibm.com> writes:
> On Tue, Oct 24, 2017 at 11:55:41AM +0530, Aneesh Kumar K.V wrote:
>> Ram Pai <linuxram@us.ibm.com> writes:
>> > +
>> > +static void pkey_status_change(int pkey, bool enable)
>> > +{
>> > +	u64 old_uamor;
>> > +
>> > +	/* reset the AMR and IAMR bits for this key */
>> > +	init_amr(pkey, 0x0);
>> > +	init_iamr(pkey, 0x0);
>> > +
>> > +	/* enable/disable key */
>> > +	old_uamor = read_uamor();
>> > +	if (enable)
>> > +		old_uamor |= (0x3ul << pkeyshift(pkey));
>> > +	else
>> > +		old_uamor &= ~(0x3ul << pkeyshift(pkey));
>> > +	write_uamor(old_uamor);
>> > +}
>> 
>> That one is confusing, we discussed this outside the list, but want to
>> bring the list to further discussion. So now the core kernel request
>> for a key via mm_pkey_alloc(). Why not do the below there
>> 
>> static inline int mm_pkey_alloc(struct mm_struct *mm)
>> {
>> 	/*
>> 	 * Note: this is the one and only place we make sure
>> 	 * that the pkey is valid as far as the hardware is
>> 	 * concerned.  The rest of the kernel trusts that
>> 	 * only good, valid pkeys come out of here.
>> 	 */
>> 	u32 all_pkeys_mask = (u32)(~(0x0));
>> 	int ret;
>> 
>> 	if (!pkey_inited)
>> 		return -1;
>> 	/*
>> 	 * Are we out of pkeys?  We must handle this specially
>> 	 * because ffz() behavior is undefined if there are no
>> 	 * zeros.
>> 	 */
>> 	if (mm_pkey_allocation_map(mm) == all_pkeys_mask)
>> 		return -1;
>> 
>> 	ret = ffz((u32)mm_pkey_allocation_map(mm));
>> 	mm_set_pkey_allocated(mm, ret);
>> 
>> 	return ret;
>> }
>> 
>> your mm_pkey_allocation_map() should have the keys specified in AMOR and
>> UAMOR marked as allocatied. It is in use by hypervisor and OS respectively.
>> 
>> 
>> There is no need of __arch_activate_key() etc. and by default if the OS
>> has not requested for a key for its internal use UAMOR should be
>> 0xFFFFFFFF and that AMOR value you derive from the device tree based of
>> what keys hypervisor has reserved.
>
>
> Ok. You are suggesting a programming model where
> a) keys that are reserved by hypervisor are enabled by default.

No he's not saying that.

> b) keys that are reserved by the OS are enabled by default.

Or that.

> c) keys that are not yet allocated to userspace is enabled by default.

But he is saying this.

> The problem with this model is that, the userspace can change the
> permissions of an unallocated key, and those permissions will go into
> effect immediately,

Correct, but an unallocated key should not be used anywhere, so it
should have no effect, unless there's a bug.

> because every key is enabled by default. If it

Not every key, every key that is not reserved by the hypervisor or OS.

> happens to be a key that is reserved by the OS or the hypervisor, bad
> things can happen.

So no nothing bad should be able to happen.

> the programming model that I have implemented; **which is the programming
> model expected by linux**, is

>
> a)  keys that are reserved by hypervisor are left to the hypervisor to
> 	enable/disable whenever it needs to.

We agree on that.

> b)  keys that are reserved by the OS are left to the OS to
> 	enable/disable whenever it needs to.

And that.

> c)  keys that are not yet allocated to userspace are not yet enabled.
> 	Will be enabled when the key is allocated to userspace
> 	through sys_pkey_alloc() syscall.

This is the only part that is under discussion.

> In this programming model, userspace is expected to use only keys that
> are allocated. And in case it inadvertetly uses a key that is not
> allocated, nothing bad happens because that key is not activated unless
> it is allocated.

This sames like a good design to me.

The only downside I see is we have to switch an extra SPR, but that's
not much in the scheme of things.

cheers
