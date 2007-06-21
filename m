Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id E89D6DDE10
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jun 2007 14:41:08 +1000 (EST)
Date: Thu, 21 Jun 2007 14:41:08 +1000
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH/RFC] Make certain timekeeping variables __read_mostly
Message-ID: <20070621044108.GT9768@bakeyournoodle.com>
References: <20070619063557.GK9768@bakeyournoodle.com>
	<20070619145356.GA20382@lixom.net>
	<20070620020211.GO9768@bakeyournoodle.com>
	<20070620031333.GP9768@bakeyournoodle.com>
	<Pine.LNX.4.62.0706200940260.27011@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.LNX.4.62.0706200940260.27011@pademelon.sonytel.be>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2007 at 09:41:47AM +0200, Geert Uytterhoeven wrote:

Hi Geert,
 
> There's no __read_mostly support for powerpc yet (is there?), so __read_mostly
> just expands to nothing?

That's true but we may in the future! :)

Perhaps something like the patch below will start discussion.

From: Tony Breeds <tony@bakeyournoodle.com>

Initial cut to add __read_mostly support for powerpc.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

 arch/powerpc/kernel/vmlinux.lds.S |    6 ++++++
 include/asm-powerpc/cache.h       |    2 ++
 2 files changed, 8 insertions(+)

Index: working/arch/powerpc/kernel/vmlinux.lds.S
===================================================================
--- working.orig/arch/powerpc/kernel/vmlinux.lds.S
+++ working/arch/powerpc/kernel/vmlinux.lds.S
@@ -7,6 +7,7 @@
 #define PROVIDE32(x)	PROVIDE(x)
 #endif
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/cache.h>
 
 ENTRY(_stext)
 
@@ -211,6 +212,11 @@ SECTIONS
 		*(.data.cacheline_aligned)
 	}
 
+	. = ALIGN(L1_CACHE_BYTES);
+	.data.read_mostly : {
+		*(.data.read_mostly)
+	}
+
 	. = ALIGN(PAGE_SIZE);
 	__data_nosave : {
 		__nosave_begin = .;
Index: working/include/asm-powerpc/cache.h
===================================================================
--- working.orig/include/asm-powerpc/cache.h
+++ working/include/asm-powerpc/cache.h
@@ -34,5 +34,9 @@ struct ppc64_caches {
 extern struct ppc64_caches ppc64_caches;
 #endif /* __powerpc64__ && ! __ASSEMBLY__ */
 
+#if !defined(__ASSEMBLY__)
+#define __read_mostly __attribute__((__section__(".data.read_mostly")))
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_CACHE_H */

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
