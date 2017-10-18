Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHSLq3nvwzDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 10:04:51 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id t188so5056179pfd.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 16:04:51 -0700 (PDT)
Date: Thu, 19 Oct 2017 10:04:40 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 13/25] powerpc: implementation for
 arch_override_mprotect_pkey()
Message-ID: <20171019100440.7fca1bd4@MiWiFi-R3-srv>
In-Reply-To: <20171018211041.GI5617@ram.oc3035372033.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-22-git-send-email-linuxram@us.ibm.com>
 <20171018153635.1ab9765d@firefly.ozlabs.ibm.com>
 <20171018211041.GI5617@ram.oc3035372033.ibm.com>
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

On Wed, 18 Oct 2017 14:10:41 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> On Wed, Oct 18, 2017 at 03:36:35PM +1100, Balbir Singh wrote:
> > On Fri,  8 Sep 2017 15:45:01 -0700
> > Ram Pai <linuxram@us.ibm.com> wrote:
> >   
> > > arch independent code calls arch_override_mprotect_pkey()
> > > to return a pkey that best matches the requested protection.
> > > 
> > > This patch provides the implementation.
> > > 
> > > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > > ---
> > >  arch/powerpc/include/asm/mmu_context.h |    5 +++
> > >  arch/powerpc/include/asm/pkeys.h       |   17 ++++++++++-
> > >  arch/powerpc/mm/pkeys.c                |   47 ++++++++++++++++++++++++++++++++
> > >  3 files changed, 67 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> > > index c705a5d..8e5a87e 100644
> > > --- a/arch/powerpc/include/asm/mmu_context.h
> > > +++ b/arch/powerpc/include/asm/mmu_context.h
> > > @@ -145,6 +145,11 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
> > >  #ifndef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > >  #define pkey_initialize()
> > >  #define pkey_mm_init(mm)
> > > +
> > > +static inline int vma_pkey(struct vm_area_struct *vma)
> > > +{
> > > +	return 0;
> > > +}
> > >  #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> > >  
> > >  #endif /* __KERNEL__ */
> > > diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> > > index f13e913..d2fffef 100644
> > > --- a/arch/powerpc/include/asm/pkeys.h
> > > +++ b/arch/powerpc/include/asm/pkeys.h
> > > @@ -41,6 +41,16 @@ static inline u64 pkey_to_vmflag_bits(u16 pkey)
> > >  		((pkey & 0x10UL) ? VM_PKEY_BIT4 : 0x0UL));
> > >  }
> > >  
> > > +#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
> > > +				VM_PKEY_BIT3 | VM_PKEY_BIT4)
> > > +
> > > +static inline int vma_pkey(struct vm_area_struct *vma)
> > > +{
> > > +	if (!pkey_inited)
> > > +		return 0;  
> > 
> > We don't want pkey_inited to be present in all functions, why do we need
> > a conditional branch for all functions. Even if we do, it should be a jump
> > label. I would rather we just removed !pkey_inited unless really really
> > required.  
> 
> No. we really really need it.  For example when we build a kernel with
> PROTECTION_KEYS config enabled and run that kernel on a older processor
> or on a system where the key feature is not enabled in the device tree,
> we have fail all the calls that get called-in by the arch-neutral code.
> 
> Hence we need this check.
> 

Use a mmu_feature then, it's already designed and optimized for that
purpose

> BTW: jump labels are awkward IMHO, unless absolutely needed.
>

The if checks across the place will hurt performance and we want to have
this enabled by default, we may need a mmu feature or jump labels

Balbir Singh.
