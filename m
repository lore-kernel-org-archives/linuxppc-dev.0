Return-Path: <SRS0=zlGz=J2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F370AC433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 00:54:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B3116141E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 00:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3116141E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FVxpX329Cz30Fb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 10:54:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=GTME8irL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=GTME8irL; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FVxp14jY4z2xg1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Apr 2021 10:53:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=ias16OQcBsl8ZkDBEGSPojETSjzryLxJi3zCN7d/i4E=; b=GTME8irLh4yirVajHMss5bhE0m
 7i1RAaFww73oFMbbYd0JrHof4s+TMXrucW6CGr3kkbhsBf8q6s5DdEMDqGDJGD0LWfOKw5Wj6+hXJ
 gpb68XEd42+3C5w2QFfuLtvXv/1ExB9xhRjty8Wc5BsnGBX/32nQiIQlP78e31U/5YRWDyCIwQLxs
 UBQ/lr6+8zb8wwDxweO7GwWWjEVzEb/QKLsU34ZkxKy6Wt3lhT4YV4tr0/OTWb/oxitrSkJzYBj/N
 aMp6SjGofFyNorhZU3fAsN//GPO+gx9GiFBOObxJHnXKrWN3XPozkuT9WBmaOffhc9TgtjUqUKnB0
 e5+LOTsg==;
Received: from [2601:1c0:6280:3f0::3bc5] (helo=casper.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lbuvn-0090nA-OF; Thu, 29 Apr 2021 00:53:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: mpc52xx: fix some pr_debug() issues
Date: Wed, 28 Apr 2021 17:53:23 -0700
Message-Id: <20210429005323.8195-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Randy Dunlap <rdunlap@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Anatolij Gustschin <agust@denx.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fix some pr_debug() issues in mpc52xx_pci.c:

- use __func__ to print function names
- use "%pr" to print struct resource entries
- use "%pa" to print a resource_size_t (phys_addr_t)

The latter two fix several build warnings:

../arch/powerpc/platforms/52xx/mpc52xx_pci.c: In function 'mpc52xx_pci_setup':
../include/linux/kern_levels.h:5:18: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
../arch/powerpc/platforms/52xx/mpc52xx_pci.c:277:40: note: format string is defined here
  277 |   pr_debug("mem_resource[1] = {.start=%x, .end=%x, .flags=%lx}\n",
      |                                       ~^
      |                                        |
      |                                        unsigned int
      |                                       %llx
../include/linux/kern_levels.h:5:18: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
../arch/powerpc/platforms/52xx/mpc52xx_pci.c:277:49: note: format string is defined here
  277 |   pr_debug("mem_resource[1] = {.start=%x, .end=%x, .flags=%lx}\n",
      |                                                ~^
      |                                                 |
      |                                                 unsigned int
      |                                                %llx

../arch/powerpc/platforms/52xx/mpc52xx_pci.c:299:36: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  299 |    (unsigned long long)res->flags, (void*)hose->io_base_phys);
      |                                    ^
../arch/powerpc/platforms/52xx/mpc52xx_pci.c:295:2: note: in expansion of macro 'pr_debug'
  295 |  pr_debug(".io_resource={.start=%llx,.end=%llx,.flags=%llx} "
      |  ^~~~~~~~

The change to print mem_resource[0] is for consistency within this
source file and to use the kernel API -- there were no warnings here.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/52xx/mpc52xx_pci.c |   22 ++++++--------------
 1 file changed, 7 insertions(+), 15 deletions(-)

--- linux-next-20210427.orig/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ linux-next-20210427/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -242,7 +242,7 @@ mpc52xx_pci_setup(struct pci_controller
 	u32 tmp;
 	int iwcr0 = 0, iwcr1 = 0, iwcr2 = 0;
 
-	pr_debug("mpc52xx_pci_setup(hose=%p, pci_regs=%p)\n", hose, pci_regs);
+	pr_debug("%s(hose=%p, pci_regs=%p)\n", __func__, hose, pci_regs);
 
 	/* pci_process_bridge_OF_ranges() found all our addresses for us;
 	 * now store them in the right places */
@@ -257,11 +257,7 @@ mpc52xx_pci_setup(struct pci_controller
 	/* Memory windows */
 	res = &hose->mem_resources[0];
 	if (res->flags) {
-		pr_debug("mem_resource[0] = "
-		         "{.start=%llx, .end=%llx, .flags=%llx}\n",
-		         (unsigned long long)res->start,
-			 (unsigned long long)res->end,
-			 (unsigned long long)res->flags);
+		pr_debug("mem_resource[0] = %pr\n", res);
 		out_be32(&pci_regs->iw0btar,
 		         MPC52xx_PCI_IWBTAR_TRANSLATION(res->start, res->start,
 							resource_size(res)));
@@ -274,8 +270,7 @@ mpc52xx_pci_setup(struct pci_controller
 
 	res = &hose->mem_resources[1];
 	if (res->flags) {
-		pr_debug("mem_resource[1] = {.start=%x, .end=%x, .flags=%lx}\n",
-		         res->start, res->end, res->flags);
+		pr_debug("mem_resource[1] = %pr\n", res);
 		out_be32(&pci_regs->iw1btar,
 		         MPC52xx_PCI_IWBTAR_TRANSLATION(res->start, res->start,
 							resource_size(res)));
@@ -292,11 +287,8 @@ mpc52xx_pci_setup(struct pci_controller
 		printk(KERN_ERR "%s: Didn't find IO resources\n", __FILE__);
 		return;
 	}
-	pr_debug(".io_resource={.start=%llx,.end=%llx,.flags=%llx} "
-	         ".io_base_phys=0x%p\n",
-	         (unsigned long long)res->start,
-		 (unsigned long long)res->end,
-		 (unsigned long long)res->flags, (void*)hose->io_base_phys);
+	pr_debug(".io_resource = %pr .io_base_phys=0x%pa\n",
+			res, &hose->io_base_phys);
 	out_be32(&pci_regs->iw2btar,
 	         MPC52xx_PCI_IWBTAR_TRANSLATION(hose->io_base_phys,
 	                                        res->start,
@@ -336,8 +328,8 @@ mpc52xx_pci_fixup_resources(struct pci_d
 {
 	int i;
 
-	pr_debug("mpc52xx_pci_fixup_resources() %.4x:%.4x\n",
-	         dev->vendor, dev->device);
+	pr_debug("%s() %.4x:%.4x\n",
+	         __func__, dev->vendor, dev->device);
 
 	/* We don't rely on boot loader for PCI and resets all
 	   devices */
