From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 4 Mar 2003 12:16:44 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: Patch boot/common/relocate.S to start kernel at 0x000c
Message-ID: <20030304191644.GA4524@rover.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


arch/ppc/boot/common/relocate.S starts the kernel at address 0
which fails if you have a second cpu running at secondary_hold.
(The code at secondary hold writes the cpu id at address 4.)

This patch starts the kernel at address 0xc instead.

Thanks,
-Dale

===== arch/ppc/boot/common/relocate.S 1.6 vs edited =====
--- 1.6/arch/ppc/boot/common/relocate.S	Thu Feb 27 12:40:14 2003
+++ edited/arch/ppc/boot/common/relocate.S	Tue Mar  4 10:09:52 2003
@@ -200,8 +200,10 @@

 	/*
 	 * Start at the begining.
+	 * Well, actually on the 4th instruction since we
+	 * overwrite the first 3 sometimes (which are 'nop').
 	 */
-	li	r9,0x0000
+	li	r9,0x000c
 	mtlr	r9
 	blr


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
