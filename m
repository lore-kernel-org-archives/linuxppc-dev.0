Date: Sat, 6 May 2000 14:44:36 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: ISA memory space
Message-ID: <Pine.LNX.4.10.10005061442360.406-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


2.3.x lacks the macros to access ISA memory space (untested):

--- include/asm-ppc/io.h.orig	Wed May  3 14:33:53 2000
+++ include/asm-ppc/io.h	Sat May  6 14:41:08 2000
@@ -54,6 +54,16 @@
 #define writel(b,addr) out_le32((volatile u32 *)(addr),(b))
 #endif

+#define isa_readb(a)			readb(_ISA_MEM_BASE+(a))
+#define isa_readw(a)			readw(_ISA_MEM_BASE+(a))
+#define isa_readl(a)			readl(_ISA_MEM_BASE+(a))
+#define isa_writeb(b,a)			writeb(b,_ISA_MEM_BASE+(a))
+#define isa_writew(w,a)			writew(w,_ISA_MEM_BASE+(a))
+#define isa_writel(l,a)			writel(l,_ISA_MEM_BASE+(a))
+#define isa_memset_io(a,b,c)		memset_io(_ISA_MEM_BASE+(a),(b),(c))
+#define isa_memcpy_fromio(a,b,c)	memcpy_fromio((a),_ISA_MEM_BASE+(b),(c))
+#define isa_memcpy_toio(a,b,c)		memcpy_toio(_ISA_MEM_BASE+(a),(b),(c))
+
 /*
  * The insw/outsw/insl/outsl macros don't do byte-swapping.
  * They are only used in practice for transferring buffers which

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
