Return-Path: <zippel@linux-m68k.org>
Received: from scrub.xs4all.nl (scrub.xs4all.nl [194.109.195.176])
	by ozlabs.org (Postfix) with ESMTP id CE234683D3
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 08:43:58 +1000 (EST)
Received: from roman (helo=localhost)
	by scrub.xs4all.nl with local-esmtp (Exim 3.36 #1 (Debian))
	id 1EJIkP-0004zL-00
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Sep 2005 00:43:57 +0200
Date: Sun, 25 Sep 2005 00:43:57 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0509250043410.19178@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH 5/8] ppc: use correct asm ops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Use the correct assembler instructions, which match
__do_in_asm/__do_out_asm.

---

 include/asm-ppc/io.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux/include/asm-ppc/io.h
===================================================================
--- linux.orig/include/asm-ppc/io.h	2005-09-23 16:20:24.000000000 +0200
+++ linux/include/asm-ppc/io.h	2005-09-23 16:20:26.000000000 +0200
@@ -294,10 +294,10 @@ extern __inline__ void name(unsigned int
 __do_out_asm(outb, "stbx")
 #ifdef CONFIG_APUS
 __do_in_asm(inb, "lbzx")
-__do_in_asm(inw, "lhz%U1%X1")
-__do_in_asm(inl, "lwz%U1%X1")
-__do_out_asm(outl,"stw%U0%X0")
-__do_out_asm(outw, "sth%U0%X0")
+__do_in_asm(inw, "lhzx")
+__do_in_asm(inl, "lwzx")
+__do_out_asm(outl,"stwx")
+__do_out_asm(outw, "sthx")
 #elif defined (CONFIG_8260_PCI9)
 /* in asm cannot be defined if PCI9 workaround is used */
 #define inb(port)		in_8((port)+___IO_BASE)
