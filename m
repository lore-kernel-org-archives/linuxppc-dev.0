Date: Tue, 25 May 2004 02:29:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH 5/7] use correct asm ops
Message-ID: <Pine.LNX.4.58.0405250228550.19038@scrub.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Use the correct assembler instructions, which match __do_in_asm/__do_out_asm.

Index: 2.6/include/asm-ppc/io.h
diff -u 2.6/include/asm-ppc/io.h:1.1.1.3 2.6/include/asm-ppc/io.h:1.5
--- 2.6/include/asm-ppc/io.h:1.1.1.3	Sun May 23 15:31:13 2004
+++ 2.6/include/asm-ppc/io.h	Mon May 24 13:32:36 2004
@@ -141,10 +141,10 @@
 __do_in_asm(inb, "lbzx")
 __do_out_asm(outb, "stbx")
 #ifdef CONFIG_APUS
-__do_in_asm(inw, "lhz%U1%X1")
-__do_in_asm(inl, "lwz%U1%X1")
-__do_out_asm(outl,"stw%U0%X0")
-__do_out_asm(outw, "sth%U0%X0")
+__do_in_asm(inw, "lhzx")
+__do_in_asm(inl, "lwzx")
+__do_out_asm(outl,"stwx")
+__do_out_asm(outw, "sthx")
 #else
 __do_in_asm(inw, "lhbrx")
 __do_in_asm(inl, "lwbrx")

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
