Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLkly1BsjzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 18:04:29 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9O74RRp038080
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 03:04:28 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dswxff5c2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 03:04:27 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 24 Oct 2017 03:04:24 -0400
Date: Tue, 24 Oct 2017 00:04:16 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 05/25] powerpc: helper functions to initialize AMR, IAMR
 and UAMOR registers
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-14-git-send-email-linuxram@us.ibm.com>
 <873769xdsq.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <873769xdsq.fsf@linux.vnet.ibm.com>
Message-Id: <20171024070416.GG5454@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 24, 2017 at 11:55:41AM +0530, Aneesh Kumar K.V wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > Introduce  helper functions that can initialize the bits in the AMR,
> > IAMR and UAMOR register; the bits that correspond to the given pkey.
> >
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/powerpc/include/asm/pkeys.h |    1 +
> >  arch/powerpc/mm/pkeys.c          |   46 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > index 133f8c4..5a83ed7 100644
> > --- a/arch/powerpc/include/asm/pkeys.h
> > +++ b/arch/powerpc/include/asm/pkeys.h
> > @@ -26,6 +26,7 @@
> >  #define arch_max_pkey()  pkeys_total
> >  #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
> >  				VM_PKEY_BIT3 | VM_PKEY_BIT4)
> > +#define AMR_BITS_PER_PKEY 2
> >
> >  #define pkey_alloc_mask(pkey) (0x1 << pkey)
> >
> > diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> > index ebc9e84..178aa33 100644
> > --- a/arch/powerpc/mm/pkeys.c
> > +++ b/arch/powerpc/mm/pkeys.c
> > @@ -59,3 +59,49 @@ void __init pkey_initialize(void)
> >  	for (i = 2; i < (pkeys_total - os_reserved); i++)
> >  		initial_allocation_mask &= ~(0x1<<i);
> >  }
> > +
> > +#define PKEY_REG_BITS (sizeof(u64)*8)
> > +#define pkeyshift(pkey) (PKEY_REG_BITS - ((pkey+1) * AMR_BITS_PER_PKEY))
> > +
> > +static inline void init_amr(int pkey, u8 init_bits)
> > +{
> > +	u64 new_amr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
> > +	u64 old_amr = read_amr() & ~((u64)(0x3ul) << pkeyshift(pkey));
> > +
> > +	write_amr(old_amr | new_amr_bits);
> > +}
> > +
> > +static inline void init_iamr(int pkey, u8 init_bits)
> > +{
> > +	u64 new_iamr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
> > +	u64 old_iamr = read_iamr() & ~((u64)(0x3ul) << pkeyshift(pkey));
> > +
> > +	write_iamr(old_iamr | new_iamr_bits);
> > +}
> > +
> > +static void pkey_status_change(int pkey, bool enable)
> > +{
> > +	u64 old_uamor;
> > +
> > +	/* reset the AMR and IAMR bits for this key */
> > +	init_amr(pkey, 0x0);
> > +	init_iamr(pkey, 0x0);
> > +
> > +	/* enable/disable key */
> > +	old_uamor = read_uamor();
> > +	if (enable)
> > +		old_uamor |= (0x3ul << pkeyshift(pkey));
> > +	else
> > +		old_uamor &= ~(0x3ul << pkeyshift(pkey));
> > +	write_uamor(old_uamor);
> > +}
> 
> That one is confusing, we discussed this outside the list, but want to
> bring the list to further discussion. So now the core kernel request
> for a key via mm_pkey_alloc(). Why not do the below there
> 
> static inline int mm_pkey_alloc(struct mm_struct *mm)
> {
> 	/*
> 	 * Note: this is the one and only place we make sure
> 	 * that the pkey is valid as far as the hardware is
> 	 * concerned.  The rest of the kernel trusts that
> 	 * only good, valid pkeys come out of here.
> 	 */
> 	u32 all_pkeys_mask = (u32)(~(0x0));
> 	int ret;
> 
> 	if (!pkey_inited)
> 		return -1;
> 	/*
> 	 * Are we out of pkeys?  We must handle this specially
> 	 * because ffz() behavior is undefined if there are no
> 	 * zeros.
> 	 */
> 	if (mm_pkey_allocation_map(mm) == all_pkeys_mask)
> 		return -1;
> 
> 	ret = ffz((u32)mm_pkey_allocation_map(mm));
> 	mm_set_pkey_allocated(mm, ret);
> 
> 	return ret;
> }
> 
> your mm_pkey_allocation_map() should have the keys specified in AMOR and
> UAMOR marked as allocatied. It is in use by hypervisor and OS respectively.
> 
> 
> There is no need of __arch_activate_key() etc. and by default if the OS
> has not requested for a key for its internal use UAMOR should be
> 0xFFFFFFFF and that AMOR value you derive from the device tree based of
> what keys hypervisor has reserved.


Ok. You are suggesting a programming model where
a) keys that are reserved by hypervisor are enabled by default.
b) keys that are reserved by the OS are enabled by default.
c) keys that are not yet allocated to userspace is enabled by default.

The problem with this model is that, the userspace can change the
permissions of an unallocated key, and those permissions will go into
effect immediately, because every key is enabled by default. If it
happens to be a key that is reserved by the OS or the hypervisor, bad
things can happen.


the programming model that I have implemented; **which is the programming
model expected by linux**, is

a)  keys that are reserved by hypervisor are left to the hypervisor to
	enable/disable whenever it needs to.
b)  keys that are reserved by the OS are left to the OS to
	enable/disable whenever it needs to.
c)  keys that are not yet allocated to userspace are not yet enabled.
	Will be enabled when the key is allocated to userspace
	through sys_pkey_alloc() syscall.

In this programming model, userspace is expected to use only keys that
are allocated. And in case it inadvertetly uses a key that is not
allocated, nothing bad happens because that key is not activated unless
it is allocated.  And in case it uses a key that is reserved by the
hypervisor or OS, bad things will still not happen because those keys
should not be kept enabled when the process is in userspace. 


These are my thoughts, I will let the jury decide. :)
RP


> 
> -aneesh

-- 
Ram Pai
