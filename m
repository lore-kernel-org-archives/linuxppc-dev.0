Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHvm21662zDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 03:39:45 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9JGXm7o024839
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 12:39:43 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dpws20udj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 12:39:43 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 19 Oct 2017 10:39:42 -0600
Date: Thu, 19 Oct 2017 09:39:34 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Subject: Re: [PATCH 13/25] powerpc: implementation for
 arch_override_mprotect_pkey()
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-22-git-send-email-linuxram@us.ibm.com>
 <20171018153635.1ab9765d@firefly.ozlabs.ibm.com>
 <20171018211041.GI5617@ram.oc3035372033.ibm.com>
 <20171019100440.7fca1bd4@MiWiFi-R3-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171019100440.7fca1bd4@MiWiFi-R3-srv>
Message-Id: <20171019163934.GS5617@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 19, 2017 at 10:04:40AM +1100, Balbir Singh wrote:
> On Wed, 18 Oct 2017 14:10:41 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > On Wed, Oct 18, 2017 at 03:36:35PM +1100, Balbir Singh wrote:
> > > On Fri,  8 Sep 2017 15:45:01 -0700
> > > Ram Pai <linuxram@us.ibm.com> wrote:
> > >   
> > > > arch independent code calls arch_override_mprotect_pkey()
> > > > to return a pkey that best matches the requested protection.
> > > > 
> > > > This patch provides the implementation.
> > > > 
> > > > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > > > ---
> > > >  arch/powerpc/include/asm/mmu_context.h |    5 +++
> > > >  arch/powerpc/include/asm/pkeys.h       |   17 ++++++++++-
> > > >  arch/powerpc/mm/pkeys.c                |   47 ++++++++++++++++++++++++++++++++
> > > >  3 files changed, 67 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> > > > index c705a5d..8e5a87e 100644
> > > > --- a/arch/powerpc/include/asm/mmu_context.h
> > > > +++ b/arch/powerpc/include/asm/mmu_context.h
> > > > @@ -145,6 +145,11 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
> > > >  #ifndef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > > >  #define pkey_initialize()
> > > >  #define pkey_mm_init(mm)
> > > > +
> > > > +static inline int vma_pkey(struct vm_area_struct *vma)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > >  #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > > >  
> > > >  #endif /* __KERNEL__ */
> > > > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > > > index f13e913..d2fffef 100644
> > > > --- a/arch/powerpc/include/asm/pkeys.h
> > > > +++ b/arch/powerpc/include/asm/pkeys.h
> > > > @@ -41,6 +41,16 @@ static inline u64 pkey_to_vmflag_bits(u16 pkey)
> > > >  		((pkey & 0x10UL) ? VM_PKEY_BIT4 : 0x0UL));
> > > >  }
> > > >  
> > > > +#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
> > > > +				VM_PKEY_BIT3 | VM_PKEY_BIT4)
> > > > +
> > > > +static inline int vma_pkey(struct vm_area_struct *vma)
> > > > +{
> > > > +	if (!pkey_inited)
> > > > +		return 0;  
> > > 
> > > We don't want pkey_inited to be present in all functions, why do we need
> > > a conditional branch for all functions. Even if we do, it should be a jump
> > > label. I would rather we just removed !pkey_inited unless really really
> > > required.  
> > 
> > No. we really really need it.  For example when we build a kernel with
> > PROTECTION_KEYS config enabled and run that kernel on a older processor
> > or on a system where the key feature is not enabled in the device tree,
> > we have fail all the calls that get called-in by the arch-neutral code.
> > 
> > Hence we need this check.
> > 
> 
> Use a mmu_feature then, it's already designed and optimized for that
> purpose

We rely on a combination of cpu_feature and firmware_feature. But that
is still not sufficient. It is also gated on !radix_enabled().

In other words,  the pkey system is enabled if
a) if we are in a lpar and device tree has the feature enabled, and
	there are more than zero keys enabled and radix is not enabled.

	OR

b) if we in baremetal, and the CPU is power5 or later and radix is not
	enabled.

All these criteria determine the value of 'pkey_inited'.

> 
> > BTW: jump labels are awkward IMHO, unless absolutely needed.
> >
> 
> The if checks across the place will hurt performance and we want to have
> this enabled by default, we may need a mmu feature or jump labels

I like the idea of jump_label now that I googled for it.

Thanks,
RP

> 
> Balbir Singh.

-- 
Ram Pai
