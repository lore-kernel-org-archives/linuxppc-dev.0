Return-Path: <linuxppc-dev+bounces-23298-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788D2C43327
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 10:58:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqxpD6VqDz2xKh;
	Wed, 01 Jul 2026 20:58:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.166 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782903524;
	cv=pass; b=KTX+IdrcmnfYPdmgDvdPoU9wMUo4lYDAbC/w5tdNYzO3NQvSdzPOD18LT38VyjApVXAKWprtreGixr0uHxuByE95nfcKXimoRLpJSMr6IPqGgAf+FLvWVN5lvnGuehjO8pXzgAZ71UTv+8Hy9evfVDAqYe/k5M12yzPRclULNCwkjiGA5p0MFL6pIshITzGC68wLFKP5K7GoHuLoLYfeLdperWXKX1dZetLqJTk9yfRbx7GaE7WwIs4aS+I2bfKirWpjNqUfdbqx5jN97G9OpQDYsHE7hF0UqV35tPgdiWlAeUDOV/OiXdL5UkR2GTJC7Is8aZHB53ZOaEFZc3W4CA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782903524; c=relaxed/relaxed;
	bh=dUYAUXkJMw6pnMgvNTxJrQyZPFRvQ5X9Spg8T1Q9gAk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VpvhBWe+lo9hebhteLEB6pxpQinnKsjCLuUyevpqqzCQh4CgUjr4w1PppaTez09s3cCecNaWBSPTiJQv7gKmXAPXpXwSEzToEitV7tSosWJo+lnVFKv09M93aBPgiCaQKRezoep53CZFjyu4ufSYWaY/7Jeezc/8AjaaTb5TA4EkPYJeCh8FhZcZucZJvy97y1eaUB54EZY2zMkH6BCllF6W7UanW1euL7C6xXDj1W5yElLMA7ROdpzU44mfgV1g0qim9ee8PQrW870ikkOKxikuLe/gdlYs9aJLIpALm9/BELmQEkqcDx2E3lUU/ZZP6+kxbJZhDkQdWXh2P9cCXQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mQgP4Wan; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=c/w6PdYr; dkim-atps=neutral; spf=pass (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mQgP4Wan;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=c/w6PdYr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 177 seconds by postgrey-1.37 at boromir; Wed, 01 Jul 2026 20:58:39 AEST
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqxp73d4qz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 20:58:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1782903326; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AHyjOGzjYIWtNloPOlv4rFncjyqLy0vIAdyIyv0Lk0yED3g5K9MsOJw0U3CisAVeyA
    t1Pj+jpX7FQrytFpVoGBeOmWMFgI/5lq2bM59MPsvqZmzIiGTRj+YdP3SAxqXet7zG25
    IpjkN9qohKflhQuNUPJsTIwtz9Jzh6TnbMFvvuNPxCmZ7MCP2WR72gY/ZnfaVdqtMNGn
    w663e973oJSanH4hGDNIq3+izOYsNPAHAb5Va2yhT04DL3jOR6ggyLnjfz72Rxttez/c
    dDS5KY9Ha5Itqm+wLNDL8mB/uyHG6Cis+iLHwOdeFQLdLaHPn+kgTa01F57f6YZ2Rez5
    dXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1782903326;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=dUYAUXkJMw6pnMgvNTxJrQyZPFRvQ5X9Spg8T1Q9gAk=;
    b=tia/45C/jv3RCb5gGio4RX2voPP5y+rFRCUr0dyVeR519vQDSygVSYI3A9zhauphf7
    W9yhoUaaE79NJxUqzwtfPSU1F7vkdVjibnwc7vhHdW+kLzj/czTbEMZWXblalH8iCDyq
    5wyIjYCNLReyOytFBZy0TVmWQZq3s+ObBtAkzuk12FUGr1xhpEw7DkSicyWkEFDFp1N6
    qzZrht6Kxh70AWoEpecUP1V3+IE6aF4FOROUQNCHWel0lEcUluCc3E4qHHMVGPYAUt8D
    ETovhaSxFsYdDsxHDNEqv2rpd5p9wDLiNcXNEzmZjSo3xLxRvzXAgpMZ47I/zzx/29iM
    J2MQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1782903326;
    s=strato-dkim-0002; d=xenosoft.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=dUYAUXkJMw6pnMgvNTxJrQyZPFRvQ5X9Spg8T1Q9gAk=;
    b=mQgP4WanVCjcjaRDtrIeDjiqbrWlkkmw4SSB555Zntrut44lFVFedHyRlKjQZ9gFLn
    FcMfHjz/rBrRszGLVCee7eVVA5eLtA5Hp81009AoSsqmWm2XU9KjDPnL3RMwoHTjzdcN
    s3fMXc7IdiJdOdNRielaAv0QID5qb9AOgtAj9/DoMum0Fw3T5MtnsYZiVs0PdXQFe50Z
    khP6iAqC5auc4WfIgypAsG7n28UwBVxq5qZho2U/+/rKtwKvkwUfF6JDLyLF2wNbu1Ah
    vKzrNMowbCu3iNKzWsx1egEfFI9FGKkWp+NaDMHS+EXqcyakGlg+PIkucfs4c7SsVgGQ
    8pjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1782903326;
    s=strato-dkim-0003; d=xenosoft.de;
    h=Message-ID:Date:Subject:To:From:Cc:Date:From:Subject:Sender;
    bh=dUYAUXkJMw6pnMgvNTxJrQyZPFRvQ5X9Spg8T1Q9gAk=;
    b=c/w6PdYrxb85iLDOAFamYoLD9kke7qsMob7Xsg+NlQojobGUbKNjzVWEgJBLsmP5t1
    gUBhqVHWbQT6mlHnw3Dg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6PxsY+ZPjaJwNagAH4FDfQ=="
Received: from INTER8676
    by smtp.strato.de (RZmta 55.5.6 AUTH)
    with ESMTPSA id e4c84d261AtPQ6a
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 1 Jul 2026 12:55:25 +0200 (CEST)
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Connecting the SB600's i8259 controller rather in pasemi's pci.c than in pasemi's setup.c.
Date: Wed,  1 Jul 2026 12:54:57 +0200
Message-ID: <20260701105501.2093-1-chzigotzky@xenosoft.de>
X-Mailer: git-send-email 2.55.0.windows.1
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

 "pas_pci_init" was before "nemo_init_IRQ".
 Now "pas_pci_init" is after "nemo_init_IRQ" in the official kernel source
 code.
 I think "pas_pci_init" scans (discovers) the PCI(e) devices
 and after that, "nemo_init_IRQ" assigns interrupt numbers
 to these devices if required.
 It's not possible to assigns interrupt numbers to PCI(e) devices
 which have not been discovered yet.

Signed-off-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/platforms/pasemi/pci.c   | 7 +++++++
 arch/powerpc/platforms/pasemi/setup.c | 7 ++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index 2df955274652..7208c325bfc5 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -25,6 +25,8 @@
 
 #define PA_PXP_CFA(bus, devfn, off) (((bus) << 20) | ((devfn) << 12) | (off))
 
+extern void nemo_init_IRQ(void);
+
 static inline int pa_pxp_offset_valid(u8 bus, u8 devfn, int offset)
 {
 	/* Device 0 Function 0 is special: It's config space spans function 1 as
@@ -265,6 +267,11 @@ static int __init pas_add_bridge(struct device_node *dev)
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
index d03b41336901..eec74611be46 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -214,10 +214,12 @@ static void sb600_8259_cascade(struct irq_desc *desc)
 	chip->irq_eoi(&desc->irq_data);
 }
 
-static void __init nemo_init_IRQ(struct mpic *mpic)
+void nemo_init_IRQ(void)
 {
 	struct device_node *np;
 	int gpio_virq;
+	struct mpic *mpic;
+
 	/* Connect the SB600's legacy i8259 controller */
 	np = of_find_node_by_path("/pxp@0,e0000000");
 	i8259_init(np, 0);
@@ -228,6 +230,7 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
 	irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
 	mpic_unmask_irq(irq_get_irq_data(gpio_virq));
 
+	mpic = irq_get_chip_data(gpio_virq);
 	irq_set_default_domain(mpic->irqhost);
 }
 
@@ -298,8 +301,6 @@ static __init void pas_init_IRQ(void)
 		mpic_unmask_irq(irq_get_irq_data(nmi_virq));
 	}
 
-	nemo_init_IRQ(mpic);
-
 	of_node_put(mpic_node);
 	of_node_put(root);
 }
-- 
2.55.0.windows.1


