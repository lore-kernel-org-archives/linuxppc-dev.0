Return-Path: <galak@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 550AD679A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 May 2005 03:30:35 +1000 (EST)
Date: Mon, 23 May 2005 12:29:56 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <Pine.LNX.4.61.0505231228070.5309@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Fix an off-by-one error in ipic_init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

(This fixes a bug and should go into 2.6.12 if possible.)

There is an off-by-one error in the IPIC code that configures the
external interrupts (Edge or Level Sensitive).

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit e8366420067384e3443e5ed95c151198e5ca6d22
tree 6aeff44236e7890cce085e65661884e4622785a7
parent 57bf2ca5c599f50428bf3f8ff9707411b2dfbae8
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 23 May 2005 12:27:15 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 23 May 2005 12:27:15 -0500

 ppc/syslib/ipic.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: arch/ppc/syslib/ipic.c
===================================================================
--- 55631465fc89fa1f96bdadaa7026113780db1c8a/arch/ppc/syslib/ipic.c  (mode:100644)
+++ 6aeff44236e7890cce085e65661884e4622785a7/arch/ppc/syslib/ipic.c  (mode:100644)
@@ -479,7 +479,7 @@
 	temp = 0;
 	for (i = 0 ; i < senses_count ; i++) {
 		if ((senses[i] & IRQ_SENSE_MASK) == IRQ_SENSE_EDGE) {
-			temp |= 1 << (16 - i);
+			temp |= 1 << (15 - i);
 			if (i != 0)
 				irq_desc[i + irq_offset + MPC83xx_IRQ_EXT1 - 1].status = 0;
 			else
