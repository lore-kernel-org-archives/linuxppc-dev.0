Return-Path: <mohan@in.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E3184DDF13
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 04:26:19 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m91IQDuF012090
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 14:26:13 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m91IP43C204442
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 14:25:04 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m91IP4oj002896
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 14:25:04 -0400
Date: Wed, 1 Oct 2008 23:55:01 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: paulus@samba.org
Subject: [PATCH] Fix kdump kernel hang issue with relocatable kernel patches
Message-ID: <20081001182501.GA20319@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

One of the relocatable kernel support patches assumes that the target
address will be 0. But for kdump kernels (without relocation support) it
will be 32MB. The following patch fixes this issue.

Fix kdump kernel issue

Kdump kernel without relocation support needs to be moved to
PHYSICAL_START (ie 32MB) instead of 0. This patch fixes this
issue.

Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
---
 arch/powerpc/kernel/head_64.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 84856be..8934500 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -1395,7 +1395,7 @@ _STATIC(__after_prom_start)
  *
  * Note: This process overwrites the OF exception vectors.
  */
-	li	r3,0			/* target addr */
+	LOAD_REG_IMMEDIATE(r3, PHYSICAL_START) /* target addr */
 	mr.	r4,r26			/* In some cases the loader may  */
 	beq	9f			/* have already put us at zero */
 	lis	r5,(copy_to_here - _stext)@ha
-- 
1.5.5.1
