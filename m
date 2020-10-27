Return-Path: <SRS0=voBx=EC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF114C4363A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 09:13:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376AF20735
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 09:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376AF20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CL5b949w2zDqRx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 20:13:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=107.174.27.60; helo=ozlabs.ru;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.174.27.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CL5TC1Vf0zDqMy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2020 20:07:59 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id D4AB2AE80274;
 Tue, 27 Oct 2020 05:06:42 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH kernel 2/2] powerpc/pci: Remove LSI mappings on device
 teardown
Date: Tue, 27 Oct 2020 20:06:55 +1100
Message-Id: <20201027090655.14118-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027090655.14118-1-aik@ozlabs.ru>
References: <20201027090655.14118-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Rob Herring <robh@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 Qian Cai <cai@lca.pw>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Oliver O'Halloran <oohall@gmail.com>

When a passthrough IO adapter is removed from a pseries machine using hash
MMU and the XIVE interrupt mode, the POWER hypervisor expects the guest OS
to clear all page table entries related to the adapter. If some are still
present, the RTAS call which isolates the PCI slot returns error 9001
"valid outstanding translations" and the removal of the IO adapter fails.
This is because when the PHBs are scanned, Linux maps automatically the
INTx interrupts in the Linux interrupt number space but these are never
removed.

This problem can be fixed by adding the corresponding unmap operation when
the device is removed. There's no pcibios_* hook for the remove case, but
the same effect can be achieved using a bus notifier.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/pci-common.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index be108616a721..95f4e173368a 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -404,6 +404,27 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
 	return 0;
 }
 
+static int ppc_pci_unmap_irq_line(struct notifier_block *nb,
+			       unsigned long action, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(data);
+
+	if (action == BUS_NOTIFY_DEL_DEVICE)
+		irq_dispose_mapping(pdev->irq);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ppc_pci_unmap_irq_notifier = {
+	.notifier_call = ppc_pci_unmap_irq_line,
+};
+
+static int ppc_pci_register_irq_notifier(void)
+{
+	return bus_register_notifier(&pci_bus_type, &ppc_pci_unmap_irq_notifier);
+}
+arch_initcall(ppc_pci_register_irq_notifier);
+
 /*
  * Platform support for /proc/bus/pci/X/Y mmap()s.
  *  -- paulus.
-- 
2.17.1

