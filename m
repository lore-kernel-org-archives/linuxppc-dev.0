Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (mi-ob.rzone.de [81.169.146.145])
	by ozlabs.org (Postfix) with ESMTP id B43BF67BB2
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Oct 2006 00:10:42 +1000 (EST)
Date: Fri, 20 Oct 2006 15:57:15 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] stop infinite loop in start_ldr due to unaligned sections
Message-ID: <20061020135715.GA7197@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Quick fix for lack of memset(__bss_start,0,_end-__bss_start) in load_kernel()
If edata is unaligned, the loop will overwrite all memory because
r3 and r4 will never be equal.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/ppc/boot/simple/relocate.S |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.19-rc2/arch/ppc/boot/simple/relocate.S
===================================================================
--- linux-2.6.19-rc2.orig/arch/ppc/boot/simple/relocate.S
+++ linux-2.6.19-rc2/arch/ppc/boot/simple/relocate.S
@@ -154,8 +154,8 @@ do_relocate_out:
 
 start_ldr:
 /* Clear all of BSS and set up stack for C calls */
-	lis	r3,edata@h
-	ori	r3,r3,edata@l
+	lis	r3,__bss_start@h
+	ori	r3,r3,__bss_start@l
 	lis	r4,end@h
 	ori	r4,r4,end@l
 	subi	r3,r3,4
@@ -163,7 +163,7 @@ start_ldr:
 	li	r0,0
 50:	stwu	r0,4(r3)
 	cmpw	cr0,r3,r4
-	bne	50b
+	blt	50b
 90:	mr	r9,r1		/* Save old stack pointer (in case it matters) */
 	lis	r1,.stack@h
 	ori	r1,r1,.stack@l
