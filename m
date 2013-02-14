Return-Path: <STFD002@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 170202C0077
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2013 23:56:53 +1100 (EST)
Received: from mail79-db3 (localhost [127.0.0.1])	by mail79-db3-R.bigfish.com
 (Postfix) with ESMTP id 83A7912028A	for <linuxppc-dev@ozlabs.org>;
 Thu, 14 Feb 2013 12:56:49 +0000 (UTC)
Received: from DB3EHSMHS009.bigfish.com (unknown [10.3.81.232])	by
 mail79-db3.bigfish.com (Postfix) with ESMTP id 4027630004B	for
 <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2013 12:56:48 +0000 (UTC)
From: Diana Craciun <diana.craciun@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH][RFC] Replaced tlbilx with tlbwe in the initialization code
Date: Thu, 14 Feb 2013 14:56:35 +0200
Message-ID: <1360846595-3397-1-git-send-email-diana.craciun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Diana Craciun <Diana.Craciun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Diana Craciun <Diana.Craciun@freescale.com>

On Freescale e6500 cores EPCR[DGTMI] controls whether guest supervisor
state can execute TLB management instructions. If EPCR[DGTMI]=0
tlbwe and tlbilx are allowed to execute normally in the guest state.

A hypervisor may choose to virtualize TLB1 and for this purpose it
may use IPROT to protect the entries for being invalidated by the
guest. However, because tlbwe and tlbilx execution in the guest state
are sharing the same bit, it is not possible to have a scenario where
tlbwe is allowed to be executed in guest state and tlbilx traps. When
guest TLB management instructions are allowed to be executed in guest
state the guest cannot use tlbilx to invalidate TLB1 guest entries.

Linux is using tlbilx in the boot code to invalidate the temporary
entries it creates when initializing the MMU. The patch is replacing
the usage of tlbilx in initialization code with tlbwe with VALID bit
cleared.

Linux is also using tlbilx in other contexts (like huge pages or
indirect entries) but removing the tlbilx from the initialization code
offers the possibility to have scenarios under hypervisor which are
not using huge pages or indirect entries.

Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
---
 arch/powerpc/kernel/exceptions-64e.S | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 4684e33..1f0ae33 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -1010,12 +1010,9 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	mtspr	SPRN_MAS0,r3
 	tlbre
 	mfspr	r6,SPRN_MAS1
-	rlwinm	r6,r6,0,2,0	/* clear IPROT */
+	rlwinm	r6,r6,0,2,31	/* clear IPROT and VALID */
 	mtspr	SPRN_MAS1,r6
 	tlbwe
-
-	/* Invalidate TLB1 */
-	PPC_TLBILX_ALL(0,R0)
 	sync
 	isync
 
@@ -1069,12 +1066,9 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	mtspr	SPRN_MAS0,r4
 	tlbre
 	mfspr	r5,SPRN_MAS1
-	rlwinm	r5,r5,0,2,0	/* clear IPROT */
+	rlwinm	r5,r5,0,2,31	/* clear IPROT and VALID */
 	mtspr	SPRN_MAS1,r5
 	tlbwe
-
-	/* Invalidate TLB1 */
-	PPC_TLBILX_ALL(0,R0)
 	sync
 	isync
 
-- 
1.7.11.7
