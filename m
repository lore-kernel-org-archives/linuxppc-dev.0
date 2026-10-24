Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE37A606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2026 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=rfl5P5rT;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=aN3emRvT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBXJ83Ynbz2yFQ;
	Sat, 24 Oct 2026 18:55:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.25 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792828552;
	cv=pass; b=GcqrU0Ln3xYmfDdGjQjx8/jNWC5s834Cp08D/nIwLOGAjEOrcwphFaywQJ3ywSZ2FRaX3sTKYeszdIhERw6xTOLcnTIfjZJvdTHCcq1A6Rz5Tbpjv0YdOgPGYJoJIv0hUI+3lAtILSx5hEaKMz8cqr6x+zY8vhpgqp97CMUGkZi/7acE8s49Veo8fu4R5YtOWZmATTUJtsEtr3IW5E/W49tHzjoOS/t0dVGpI38iaUbf+CYw1gSy4dES+i58BH0FMRDFYO8QJdWvw4Kdlh/9BZxAs/OXgQES2OUuPYP1VB6t9LK88Ll9h94k6wApcw2UcOA9igWJBccDd4128dNo1w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792828552; c=relaxed/relaxed;
	bh=Me0H/FzgeqtSQ98sSRLcIuEzYWqLa5DpOUgqbEAhVoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WFWKtbMeAcplDGytggetU97HDW62BcOq1pmMQr626ZX1jWI09qSF1jxK13np+x68jl7KldejBX5kd8MyiWo4TNbkEr03uaLYcyUfAdEbjYzwqLJd4RqOqpHjobeUFi/7TT7YGVJwbm+bE/ifap/pTCtN8FeKF1Iff3UiyS3uZLpSRW2Hawuya0FtGbTgEyATcja9hle1o9CWeRkXtcfz/MR5jS4ie0EU55XLf3yfUlsz10aaMyAmAt2vWNwh3+vJOEWnefErvxnaZlcBNALgtyEyiEZNPtxMvA0rhY34fi2PtD9gYKVcMtq8VKQRBJn/LhoXBNrbYQa9gK7RMF5Qqw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=rfl5P5rT; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=aN3emRvT; dkim-atps=neutral; spf=pass (client-ip=85.215.255.25; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p00-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=rfl5P5rT;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=aN3emRvT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=85.215.255.25; helo=mo4-p00-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBXJ33cnbz2y8Z
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 18:55:44 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792828537; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Jnx/0hCTPVoxmm7GbVrDGSk7qM8lUinOkx09C9yaywTAOI6ToIIvYMdVM+8sxX+yUu
    m1TPvu/Z2S8QMJwTWjFCwTDiAz+5l6gJhSJQjYLp2x9b9gA9SbwFIUvKC9fqs9niGFDW
    ALybIhOohjMRCczXPVz8/tfSLcUO0nfGkEYAcQP3zSQyIeuQLW5Mf2rl7arJcF1f+wmL
    Qzof4UAuMgf5AlMrLds6LCGKYnsnYrbsXeaZQhZPZLUWHdUiaZLiozRfmF29EnyNDU3Y
    owuz6uO7hiVTzVRU2X5oNTxS8sGokcbb0DAxa3lWG/Des5Q5uH0moB4Piy9clPCSWRl1
    vH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792828537;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Me0H/FzgeqtSQ98sSRLcIuEzYWqLa5DpOUgqbEAhVoc=;
    b=dcvMqrA/kafm2nxeesi09EBScnoIHtPzMpXF8bfdv77S7Fz5Vj/V73aEyngMFNUKdY
    oj3Hn8lNIfc6xPZcXk7KSvC5h0ES6T6Srb1ugwlQln0u2BBC2VSQP/ReFUUUSj3yuixE
    t+DhqiWgvmqS0jcNcqqa3I/081oquz3CP2HjG5SXbigYdWyx+j1xVbKVjdcvQfaERW9y
    ou9dbYD9u3kX93Dl9bsogapAGWYQpvAMFl9chDcGKnwiN4XImQygCaqz6vFWqDUmVNw2
    B6lvn/QUC1PeK91VBXQjFGuRtTYvhc37+kzKyEMBKa898Qj8LXUQGRVVbCTUK0miGeVR
    QayA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792828537;
    s=strato-dkim-0002; d=xenosoft.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Me0H/FzgeqtSQ98sSRLcIuEzYWqLa5DpOUgqbEAhVoc=;
    b=rfl5P5rTg6xzOSQSgpfWm1nZsVWvyC5lLot7zGxPHujpDryApnyy25A2mxV+0PI1Xa
    veDzBRaxCjOuJTm4t5FZtHtYOIzcBWgxk3yHI4GV+ErZZ1+fiSDcZfNN6l4AL+7VSu0S
    ZEJzfccypersj+dWm0Tg0G6SVvS2nCJbKY5dsGIt1egdWRolh0KY2LbjLASV19dqBAyL
    OzIQ4jdPeb9J+fKKipC4yKvk2ODJqQgtMm0kj61DyVDp809z+4C29vki88Zek3cVnrQd
    H0UWpi4vyaVW4py9/RZO4YYn6+3vno1inYTnhP/653+j1wh5axm0ZiaiAufC2mk/IQfm
    taqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792828537;
    s=strato-dkim-0003; d=xenosoft.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Me0H/FzgeqtSQ98sSRLcIuEzYWqLa5DpOUgqbEAhVoc=;
    b=aN3emRvThzy25r0wqAM8p0nwTj+kOc0Ex4NGrNmZuXCnJezMCElRftzEVH2NjFM+xn
    S7oNSJeBjyAO+/rQ34DA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6P1rfO5KiO55fErqk+uEOK++8HMB2A5c2jbeAp9UP1SV590O/tA+Ow=="
Received: from buildhost.fritz.box
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id e825d929O7tabZB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 24 Oct 2026 09:55:36 +0200 (CEST)
From: chzigotzky@xenosoft.de
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au
Cc: npiggin@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	Christian Zigotzky A-EON Open Source <info@xenosoft.de>,
	Darren Stevens <darren@stevens-zone.net>,
	Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH] powerpc/pasemi: Defer Nemo IRQ initialization
Date: Sat, 24 Oct 2026 09:55:19 +0200
Message-ID: <20261024075519.18877-1-chzigotzky@xenosoft.de>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Zigotzky A-EON Open Source <info@xenosoft.de>

Since pas_pci_init() is now called later during boot, the i8259
initialization in pas_init_IRQ() happens too early and accesses
registers that are not yet mapped, preventing the board from booting.

Move the Nemo-specific i8259 initialization to pas_add_bridge(),
after the ISA bridge has been discovered.

Suggested-by: Darren Stevens <darren@stevens-zone.net>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Christian Zigotzky A-EON Open Source <info@xenosoft.de>
---
 arch/powerpc/platforms/pasemi/pasemi.h |  6 ++++++
 arch/powerpc/platforms/pasemi/pci.c    |  5 +++++
 arch/powerpc/platforms/pasemi/setup.c  | 12 ++++--------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
index 6f6743b8e48d..01bcfa258625 100644
--- a/arch/powerpc/platforms/pasemi/pasemi.h
+++ b/arch/powerpc/platforms/pasemi/pasemi.h
@@ -7,6 +7,12 @@ extern void pas_pci_init(void);
 struct pci_dev;
 extern void pas_pci_dma_dev_setup(struct pci_dev *dev);
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+void __init nemo_init_IRQ(void);
+#else
+static inline void __init nemo_init_IRQ(void) { }
+#endif
+
 void __iomem *__init pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset);
 
 extern void __init pasemi_map_registers(void);
diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index 2df955274652..fb53782da7ec 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -265,6 +265,11 @@ static int __init pas_add_bridge(struct device_node *dev)
 	 */
 	isa_bridge_find_early(hose);
 
+	/*
+	 * ISA bridge is now active, add the i8259 cascade (if needed)
+	 */
+	nemo_init_IRQ();
+
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 45792ecd5dfd..7a961f2a228f 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -216,10 +216,12 @@ static void sb600_8259_cascade(struct irq_desc *desc)
 	chip->irq_eoi(&desc->irq_data);
 }
 
-static void __init nemo_init_IRQ(struct mpic *mpic)
+void __init nemo_init_IRQ(void)
 {
 	struct device_node *np;
 	int gpio_virq;
+	struct mpic *mpic;
+
 	/* Connect the SB600's legacy i8259 controller */
 	np = of_find_node_by_path("/pxp@0,e0000000");
 	i8259_init(np, 0);
@@ -230,14 +232,10 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
 	irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
 	mpic_unmask_irq(irq_get_irq_data(gpio_virq));
 
+	mpic = irq_get_chip_data(gpio_virq);
 	irq_set_default_domain(mpic->irqhost);
 }
 
-#else
-
-static inline void nemo_init_IRQ(struct mpic *mpic)
-{
-}
 #endif
 
 static __init void pas_init_IRQ(void)
@@ -300,8 +298,6 @@ static __init void pas_init_IRQ(void)
 		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
 	}
 
-	nemo_init_IRQ(mpic);
-
 	of_node_put(mpic_node);
 	of_node_put(root);
 }
-- 
2.43.0


