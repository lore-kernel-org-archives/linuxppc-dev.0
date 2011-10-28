Return-Path: <B38951@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
 [65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9EC131007DB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 20:19:42 +1100 (EST)
Received: from mail122-tx2 (localhost.localdomain [127.0.0.1])	by
 mail122-tx2-R.bigfish.com (Postfix) with ESMTP id 982B4D504A4	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 09:19:34 +0000 (UTC)
Received: from TX2EHSMHS040.bigfish.com (unknown [10.9.14.251])	by
 mail122-tx2.bigfish.com (Postfix) with ESMTP id 7762A1568050	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 09:19:34 +0000 (UTC)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] Do not hide resource for pci/pcie when configured as Agent/EP
Date: Fri, 28 Oct 2011 16:08:00 +0800
Message-ID: <1319789280-12091-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B11780@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jason Jin <Jason.jin@freescale.com>

Current pci/pcie init code will hide the pci/pcie host resource.
But did not judge it is host/RC or agent/EP. If configured as
agent/EP, we should avoid hiding its resource in the host side.

In PCI system, the Programing Interface can be used to judge the
host/agent status:
Programing Interface = 0: host
Programing Interface = 1: Agent

In PCIE system, both the Programing Interface and Header type can
be used to judge the RC/EP status.
Header Type = 0: EP
Header Type = 1: RC

Signed-off-by: Jason Jin <Jason.jin@freescale.com>
Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/kernel/pci-common.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 4f134132c..bc61a69 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1732,10 +1732,13 @@ void __devinit pcibios_scan_phb(struct pci_controller *hose)
 static void fixup_hide_host_resource_fsl(struct pci_dev *dev)
 {
 	int i, class = dev->class >> 8;
+	/* When configured as agent, programing interface = 1 */
+	int prog_if = dev->class & 0xf;
 
 	if ((class == PCI_CLASS_PROCESSOR_POWERPC ||
 	     class == PCI_CLASS_BRIDGE_OTHER) &&
 		(dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
+		(prog_if == 0) &&
 		(dev->bus->parent == NULL)) {
 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 			dev->resource[i].start = 0;
-- 
1.7.5.1
