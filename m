Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id E42CC67B5B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 00:17:17 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 9FD65FB874
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 16:09:51 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 7CDC7FB874
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 16:09:51 +0200 (CEST)
Received: from kah.ulm.sysgo.com (unknown [172.40.1.2])
	by donald.sysgo.com (Postfix) with ESMTP id E03D2F292F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 16:17:11 +0200 (CEST)
Received: from gja.ulm.sysgo.com (gja.ulm.sysgo.com [172.40.1.130])
	by kah.ulm.sysgo.com (8.9.3/8.8.8) with ESMTP id QAA29823
	for <linuxppc-embedded@ozlabs.org>; Mon, 11 Apr 2005 16:27:35 +0200
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Date: Mon, 11 Apr 2005 16:17:10 +0200
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200504111617.10935.g.jaeger@sysgo.com>
Subject: [PATCH] PPC44x: Fixes early bootup messages for Bamboo
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

While playing around with the Bamboo board (440EP based), I noticed,
that the early bootup messages won't work, because of the wrong TLB
setup for this processor. This patch fixes that issue.

-Gerhard

Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>

--- linux-2.6.11/arch/ppc/kernel/head_44x.S.orig	2005-04-11 15:49:47.000000000 +0200
+++ linux-2.6.11/arch/ppc/kernel/head_44x.S	2005-04-11 15:50:43.000000000 +0200
@@ -190,7 +190,9 @@ skpinv:	addi	r4,r4,1				/* Increment */
 
 	/* xlat fields */
 	lis	r4,UART0_PHYS_IO_BASE@h		/* RPN depends on SoC */
+#ifndef CONFIG_440EP
 	ori	r4,r4,0x0001		/* ERPN is 1 for second 4GB page */
+#endif /* CONFIG_440EP */
 
 	/* attrib fields */
 	li	r5,0
