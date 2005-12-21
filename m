Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62D1968900
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Dec 2005 13:59:59 +1100 (EST)
Date: Tue, 20 Dec 2005 20:55:11 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0512202054490.1976-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Only call prom_init of we have true OpenFirmware
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We should only have prom_init built if we are CONFIG_PPC_OF. CONFIG_PPC_OF
is intended to imply we are booted by a full Open Firmware implementation.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 51929bc009670733f84dc5dc48711fb3f1cb1554
tree 9ee9a1d7c49f3ee0e5984b0834fb2daa89cca394
parent c9b626087d0381681d5ae4132ca2ac2295f78447
author Kumar Gala <galak@kernel.crashing.org> Tue, 20 Dec 2005 20:59:03 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 20 Dec 2005 20:59:03 -0600

 arch/powerpc/kernel/head_32.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index bf37ef2..7c9fdd5 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -120,10 +120,12 @@ __start:
  * because OF may have I/O devices mapped into that area
  * (particularly on CHRP).
  */
+#ifdef CONFIG_PPC_OF
 	cmpwi	0,r5,0
 	beq	1f
 	bl	prom_init
 	trap
+#endif
 
 /*
  * Check for BootX signature when supporting PowerMac and branch to
