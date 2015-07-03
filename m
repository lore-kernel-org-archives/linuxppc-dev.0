Return-Path: <lurodriguez@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 377751A0037
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jul 2015 04:17:20 +1000 (AEST)
Date: Fri, 3 Jul 2015 20:17:09 +0200
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Cc: Borislav Petkov <bp@suse.de>,
 Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
 Arnd Bergmann <arnd@arndb.de>, Toshi Kani <toshi.kani@hp.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ingo Molnar <mingo@kernel.org>,
 "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: RFC: default ioremap_*() variant defintions
Message-ID: <20150703181709.GD7021@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The 0-day build bot detected a build issue on a patch not upstream yet that
makes a driver use iorempa_uc(), this call is now upstream but we have no
drivers yet using it, the patch in question makes the atyfb framebuffer driver
use it. The build issue was the lack of the ioremap_uc() call being implemented
on some non-x86 architectures. I *thought* I had added boiler plate code to map
the ioremap_uc() call to ioremap_nocache() for archs that do not already define
their own iorempa_uc() call, but upon further investigation it seems that was
not the case but found that this may be a bit different issue altogether.

The way include/asm-generic/io.h works for ioremap() calls and its variants is:

#ifndef CONFIG_MMU                                                              
#ifndef ioremap                                                                 
#define ioremap ioremap                                                         
static inline void __iomem *ioremap(phys_addr_t offset, size_t size)            
{                                                                               
        return (void __iomem *)(unsigned long)offset;                           
}                                                                               
#endif 
...
#define iounmap iounmap                                                         
                                                                                
static inline void iounmap(void __iomem *addr)                                  
{                                                                               
}                                                                               
#endif                                                                          
#endif /* CONFIG_MMU */  

That's the gist of it, but the catch here is the ioremap_*() variants and where
they are defined. The first variant is ioremap_nocache() and then all other
variants by default map to this one. We've been stuffing the variant definitions
within the #ifndef CONFIG_MMU and I don't think we should be as otherwise each
and everyone's archs will have to add their own variant default map to the
default ioremap_nocache() or whatever. That's exaclty what we have to day, and
from what I gather the purpose of the variant boiler plate is lost. I think
we should keep the ioremap() and ioreunmap() tucked under the CONFIG_MMU
but not the variants. For instance to address the build issue for ioremap_uc()
we either define ioremap_uc() for all archs or do something like this:

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index f56094cfdeff..6e5e80d5dd0c 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -769,14 +769,6 @@ static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
 }
 #endif
 
-#ifndef ioremap_uc
-#define ioremap_uc ioremap_uc
-static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
-{
-	return ioremap_nocache(offset, size);
-}
-#endif
-
 #ifndef ioremap_wc
 #define ioremap_wc ioremap_wc
 static inline void __iomem *ioremap_wc(phys_addr_t offset, size_t size)
@@ -802,6 +794,14 @@ static inline void iounmap(void __iomem *addr)
 #endif
 #endif /* CONFIG_MMU */
 
+#ifndef ioremap_uc
+#define ioremap_uc ioremap_uc
+static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
+{
+	return ioremap_nocache(offset, size);
+}
+#endif
+
 #ifdef CONFIG_HAS_IOPORT_MAP
 #ifndef CONFIG_GENERIC_IOMAP
 #ifndef ioport_map

This builds on x86 and other archs now and I can verify that the default
boilerplate code is not used on x86. One small caveat:

I have no idea why its not picking up asm-generic ioremap_uc() for x86,
although this is the right thing to do the guard should not work as we never
define ioremap_uc() as a macro but we do as an exported symbol. The way
archs do their ioremap calls is they define externs and then they include
asm-generic to pick up the things they don't define. In the extern calls
for ioremap_uc() we never add a define there. Adding a simple one line
#define right after the extern declaration to itself should suffice to
fix paranoia but curious why this does work as-is right now.

I'd like review and consensus from other architecture folks if this is
the Right Thing To Do (TM) and if it is decide how we want to fix this.
For instance my preference would be to just add this fix as-is after
we've figured out the guard thing above, and then define these variants
in the documentation on the asm-generic file as safe to not have, and
safe to map to the default ioremap call. If you don't have a safe call
like this we should set out different expectations, for instance having
it depend on Kconfig symbol and then drivers depend on it, archs then
implement the symbols and can HAVE_ARCH_FOO. If everyone agrees with
this then there is quite a bit of cleanup possible as tons of archs do
tons of their own variant mapping definitions.

  Luis
