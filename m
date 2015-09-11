Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F13D01A2B0A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2015 11:24:16 +1000 (AEST)
Message-ID: <1441934656.23806.3.camel@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc32: memcpy/memset: only use dcbz once cache
 is enabled
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 sojkam1@fel.cvut.cz, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Fri, 11 Sep 2015 11:24:16 +1000
In-Reply-To: <1441922743.2909.8.camel@freescale.com>
References: <20150910064112.7B7791A241C@localhost.localdomain>
 <1441922743.2909.8.camel@freescale.com>
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

On Thu, 2015-09-10 at 17:05 -0500, Scott Wood wrote:
> On Thu, 2015-09-10 at 08:41 +0200, Christophe Leroy wrote:
> >  
> > +/* Cache related sections */
> > +#define BEGIN_CACHE_SECTION_NESTED(label)    START_FTR_SECTION(label)
> > +#define BEGIN_CACHE_SECTION                  START_FTR_SECTION(97)
> > +
> > +#define END_CACHE_SECTION_NESTED(msk, val, label)            \
> > +     FTR_SECTION_ELSE_NESTED(label)                          \
> > +     MAKE_FTR_SECTION_ENTRY(msk, val, label, __cache_fixup)
> > +
> > +#define END_CACHE_SECTION(msk, val)          \
> > +     END_CACHE_SECTION_NESTED(msk, val, 97)
> > +
> > +#define END_CACHE_SECTION_IFSET(msk) END_CACHE_SECTION((msk), (msk))
> > +#define END_CACHE_SECTION_IFCLR(msk) END_CACHE_SECTION((msk), 0)
> > +
> > +/* CACHE feature sections with alternatives, use BEGIN_FTR_SECTION to 
> > start */
> > +#define CACHE_SECTION_ELSE_NESTED(label)     FTR_SECTION_ELSE_NESTED(label)
> > +#define CACHE_SECTION_ELSE   CACHE_SECTION_ELSE_NESTED(97)
> > +#define ALT_CACHE_SECTION_END_NESTED(msk, val, label)        \
> > +     MAKE_FTR_SECTION_ENTRY(msk, val, label, __cache_fixup)
> > +#define ALT_CACHE_SECTION_END_NESTED_IFSET(msk, label)       \
> > +     ALT_CACHE_SECTION_END_NESTED(msk, msk, label)
> > +#define ALT_CACHE_SECTION_END_NESTED_IFCLR(msk, label)       \
> > +     ALT_CACHE_SECTION_END_NESTED(msk, 0, label)
> > +#define ALT_CACHE_SECTION_END(msk, val)      \
> > +     ALT_CACHE_SECTION_END_NESTED(msk, val, 97)
> > +#define ALT_CACHE_SECTION_END_IFSET(msk)     \
> > +     ALT_CACHE_SECTION_END_NESTED_IFSET(msk, 97)
> > +#define ALT_CACHE_SECTION_END_IFCLR(msk)     \
> > +     ALT_CACHE_SECTION_END_NESTED_IFCLR(msk, 97)
> 
> I don't think this duplication is what Michael meant by "the normal cpu 
> feature sections".  What else is going to use this very specific 
> infrastructure?

Yeah, sorry, I was hoping you could do it with the existing cpu feature
mechanism.

It looks like the timing doesn't work, ie. you need to patch this stuff in
machine_init(), which is later than the regular patching which gets done in
early_init().

This is one of the festering differences we have between the 32 and 64-bit
initialisation code, ie. on 64-bit we do the patching much later.


So I think the cleanest solution is to have memcpy branch to generic_memcpy by
default, and then patch that to a nop once you're up and running. Something
like:

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index bb02e9f6944e..1c1a4e8866ad 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -38,6 +38,7 @@
 #include <asm/udbg.h>
 #include <asm/mmu_context.h>
 #include <asm/epapr_hcalls.h>
+#include <asm/code-patching.h>
 
 #define DBG(fmt...)
 
@@ -119,6 +120,8 @@ notrace void __init machine_init(u64 dt_ptr)
        /* Do some early initialization based on the flat device tree */
        early_init_devtree(__va(dt_ptr));
 
+       patch_instruction((unsigned int *)&memcpy, 0x60000000);
+
        epapr_paravirt_early_init();
 
        early_init_mmu();
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 2ef50c629470..6446d2915e41 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -135,6 +135,7 @@ _GLOBAL(memmove)
        /* fall through */
 
 _GLOBAL(memcpy)
+       b       generic_memcpy
        add     r7,r3,r5                /* test if the src & dst overlap */
        add     r8,r4,r5
        cmplw   0,r4,r7

cheers
