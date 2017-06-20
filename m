Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsjcN3RsRzDqhp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 08:45:56 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5KMhUTB073580
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 18:45:54 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7an74q2b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 18:45:53 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Tue, 20 Jun 2017 16:45:53 -0600
Date: Tue, 20 Jun 2017 15:45:44 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com
Subject: Re: [RFC v2 03/12] powerpc: Implement sys_pkey_alloc and
 sys_pkey_free system call.
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-4-git-send-email-linuxram@us.ibm.com>
 <874lvcuq6e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <874lvcuq6e.fsf@concordia.ellerman.id.au>
Message-Id: <20170620224544.GE17588@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 19, 2017 at 10:18:01PM +1000, Michael Ellerman wrote:
> Hi Ram,
> 
> Ram Pai <linuxram@us.ibm.com> writes:
> > Sys_pkey_alloc() allocates and returns available pkey
> > Sys_pkey_free()  frees up the pkey.
> >
> > Total 32 keys are supported on powerpc. However pkey 0,1 and 31
> > are reserved. So effectively we have 29 pkeys.
> >
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  include/linux/mm.h                           |  31 ++++---
> >  include/uapi/asm-generic/mman-common.h       |   2 +-
> 
> Those changes need to be split out and acked by mm folks.
> 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 7cb17c6..34ddac7 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -204,26 +204,35 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
> >  #define VM_MERGEABLE	0x80000000	/* KSM may merge identical pages */
> >  
> >  #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
> > -#define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit architectures */
> > -#define VM_HIGH_ARCH_BIT_1	33	/* bit only usable on 64-bit architectures */
> > -#define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
> > -#define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
> > +#define VM_HIGH_ARCH_BIT_0	32	/* bit only usable on 64-bit arch */
> > +#define VM_HIGH_ARCH_BIT_1	33	/* bit only usable on 64-bit arch */
> > +#define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit arch */
> > +#define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit arch */
> 
> Please don't change the comments, it makes the diff harder to read.

The lines were surpassing 80 columns. tried to compress the comments
without loosing meaning. will restore.

> 
> You're actually just adding this AFAICS:
> 
> > +#define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit arch */
> 
> >  #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
> >  #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
> >  #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
> >  #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
> > +#define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
> >  #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
> >  
> >  #if defined(CONFIG_X86)
>                ^
> >  # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
> > -#if defined (CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)
> > -# define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
> > -# define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
> > -# define VM_PKEY_BIT1	VM_HIGH_ARCH_1
> > -# define VM_PKEY_BIT2	VM_HIGH_ARCH_2
> > -# define VM_PKEY_BIT3	VM_HIGH_ARCH_3
> > -#endif
> > +#if defined(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS) \
> > +	|| defined(CONFIG_PPC64_MEMORY_PROTECTION_KEYS)
> > +#define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
> > +#define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 5-bit value */
>                                                                  ^ 4?
> > +#define VM_PKEY_BIT1	VM_HIGH_ARCH_1
> > +#define VM_PKEY_BIT2	VM_HIGH_ARCH_2
> > +#define VM_PKEY_BIT3	VM_HIGH_ARCH_3
> > +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> 
> That appears to be inside an #if defined(CONFIG_X86) ?
> 
> >  #elif defined(CONFIG_PPC)
>                  ^
> Should be CONFIG_PPC64_MEMORY_PROTECTION_KEYS no?

Its a little garbled. Will fix it.
> 
> > +#define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 5-bit value */
> > +#define VM_PKEY_BIT1	VM_HIGH_ARCH_1
> > +#define VM_PKEY_BIT2	VM_HIGH_ARCH_2
> > +#define VM_PKEY_BIT3	VM_HIGH_ARCH_3
> > +#define VM_PKEY_BIT4	VM_HIGH_ARCH_4  /* intel does not use this bit */
> > +					/* but reserved for future expansion */
> 
> But this hunk is for PPC ?
> 
> Is it OK for the other arches & generic code to add another VM_PKEY_BIT4 ?

No. it has to be PPC specific.

> 
> Do you need to update show_smap_vma_flags() ?
> 
> >  # define VM_SAO		VM_ARCH_1	/* Strong Access Ordering (powerpc) */
> >  #elif defined(CONFIG_PARISC)
> >  # define VM_GROWSUP	VM_ARCH_1
> 
> > diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> > index 8c27db0..b13ecc6 100644
> > --- a/include/uapi/asm-generic/mman-common.h
> > +++ b/include/uapi/asm-generic/mman-common.h
> > @@ -76,5 +76,5 @@
> >  #define PKEY_DISABLE_WRITE	0x2
> >  #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
> >  				 PKEY_DISABLE_WRITE)
> > -
> > +#define PKEY_DISABLE_EXECUTE	0x4
> 
> How you can set that if it's not in PKEY_ACCESS_MASK?

I was wondering how to handle this. x86 does not support this flag.
However powerpc has the ability to enable/disable execute permission
on a key. It cannot be done from userspace, but can be done through
the sys_mprotect_pkey() sys call. Initially I was thinking of not
enabling it in powerpc aswell, but than i think we should be not block
the hardware feature from being used.  I will make
PKEY_DISABLE_EXECUTE as part of the PKEY_ACCESS_MASK, and have powerpc
handle it. Also will x86 patch that return error if the flag is
provided.

makes sense?


Thanks for your comments,
RP

> 
> See:
> 
> SYSCALL_DEFINE2(pkey_alloc, unsigned long, flags, unsigned long, init_val)
> {
> 	int pkey;
> 	int ret;
> 
> 	/* No flags supported yet. */
> 	if (flags)
> 		return -EINVAL;
> 	/* check for unsupported init values */
> 	if (init_val & ~PKEY_ACCESS_MASK)
> 		return -EINVAL;
> 
> 
> cheers

-- 
Ram Pai
