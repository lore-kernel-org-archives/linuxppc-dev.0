Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s17wX10BhzDqPr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 22:54:36 +1000 (AEST)
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s17wW2d1rz9t1M
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jul 2016 22:54:35 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id cf3so5198999pad.2
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jul 2016 05:54:35 -0700 (PDT)
Message-ID: <1469796870.3000.1.camel@gmail.com>
Subject: Re: [PATCH v3 10/21] powerpc/mm: Define radix_enabled() in one
 place & use static inline
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, haokexin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Date: Fri, 29 Jul 2016 22:54:30 +1000
In-Reply-To: <87d1lwllgs.fsf@concordia.ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-10-git-send-email-mpe@ellerman.id.au>
 <20160728174611.1ec99066@roar.ozlabs.ibm.com>
 <87d1lwllgs.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-07-29 at 21:42 +1000, Michael Ellerman wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > 
> > On Thu, 28 Jul 2016 00:18:06 +1000
> > Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > 
> > > diff --git a/arch/powerpc/include/asm/mmu.h
> > > b/arch/powerpc/include/asm/mmu.h index eb942a446969..f413b3213a3b
> > > 100644 --- a/arch/powerpc/include/asm/mmu.h
> > > +++ b/arch/powerpc/include/asm/mmu.h
> > > @@ -163,6 +163,18 @@ static inline void assert_pte_locked(struct
> > > mm_struct *mm, unsigned long addr) }
> > >  #endif /* !CONFIG_DEBUG_VM */
> > >  
> > > +#ifdef CONFIG_PPC_RADIX_MMU
> > > +static inline bool radix_enabled(void)
> > > +{
> > > +	return mmu_has_feature(MMU_FTR_TYPE_RADIX);
> > > +}
> > > +#else
> > > +static inline bool radix_enabled(void)
> > > +{
> > > +	return false;
> > > +}
> > > +#endif
> > Won't MMU_FTRS_POSSIBLE just do the right thing when
> > !CONFIG_PPC_RADIX_MMU?
> Yes it should.
> 
> I'll have to work out why Aneesh thought he needed to do it explicitly
> and whether that is needed or not.
>

IIRC, If CONFIG_PPC_RADIX_MMU=n MMU_FTR_RAIDX will not be present in the
MMU_FTRS_POSSIBLE mask 

I'll also double check

Balbir
