Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 83514B6F01
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 16:17:01 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id o696DQA9012018
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:13:26 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o696H1c31478786
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:01 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o696H0E3011389
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:00 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/13] powerpc/book3e: Don't re-trigger decrementer on lazy
	irq restore
Date: Fri,  9 Jul 2010 16:16:47 +1000
Message-Id: <1278656215-24705-5-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1278656215-24705-4-git-send-email-benh@kernel.crashing.org>
References: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-3-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-4-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The decrementer on BookE acts as a level interrupt and doesn't
need to be re-triggered when going negative. It doesn't go
negative anyways (unless programmed to auto-reload with a
negative value) as it stops when reaching 0.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/irq.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 77be3d0..fa6f385 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -159,8 +159,17 @@ notrace void raw_local_irq_restore(unsigned long en)
 	 * use local_paca instead of get_paca() to avoid preemption checking.
 	 */
 	local_paca->hard_enabled = en;
+
+#ifndef CONFIG_BOOKE
+	/* On server, re-trigger the decrementer if it went negative since
+	 * some processors only trigger on edge transitions of the sign bit.
+	 *
+	 * BookE has a level sensitive decrementer (latches in TSR) so we
+	 * don't need that
+	 */
 	if ((int)mfspr(SPRN_DEC) < 0)
 		mtspr(SPRN_DEC, 1);
+#endif /* CONFIG_BOOKE */
 
 	/*
 	 * Force the delivery of pending soft-disabled interrupts on PS3.
-- 
1.6.3.3
