Return-Path: <SRS0=lNhQ=UZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B883EC48BD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Jun 2019 02:40:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852742147A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Jun 2019 02:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852742147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45YS1M5bGyzDqcG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Jun 2019 12:40:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 45YRzL1Q17zDq9W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2019 12:38:22 +1000 (AEST)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 44129AE80017;
 Tue, 25 Jun 2019 22:37:48 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v2] powerpc/pci/of: Parse unassigned resources
Date: Wed, 26 Jun 2019 12:37:46 +1000
Message-Id: <20190626023746.94250-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>, Sam Bobroff <sbobroff@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Oliver O'Halloran <oohall@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pseries platform uses the PCI_PROBE_DEVTREE method of PCI probing
which reads "assigned-addresses" of every PCI device and initializes
the device resources. However if the property is missing or zero sized,
then there is no fallback of any kind and the PCI resources remain
undiscovered, i.e. pdev->resource[] array remains empty.

This adds a fallback which parses the "reg" property in pretty much same
way except it marks resources as "unset" which later make Linux assign
those resources proper addresses.

This has an effect when:
1. a hypervisor failed to assign any resource for a device;
2. /chosen/linux,pci-probe-only=0 is in the DT so the system may try
assigning a resource.
Neither is likely to happen under PowerVM.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is an attempts to boot linux directly under QEMU without slof/rtas;
the aim is to use petitboot instead and let the guest kernel configure
devices.

QEMU does not allocate resources, it creates correct "reg" and zero length
"assigned-addresses" (which is probably a bug on its own) which is
normally populated by SLOF later but not during this exercise.

---
Changes:
v2:
* updated commit log
* fixed a bug with checking "addrs" which made the whole patch pointless
* s/unset/mark_unset/
---
 arch/powerpc/kernel/pci_of_scan.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 64ad92016b63..bd78f325a636 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -82,10 +82,16 @@ static void of_pci_parse_addrs(struct device_node *node, struct pci_dev *dev)
 	const __be32 *addrs;
 	u32 i;
 	int proplen;
+	bool mark_unset = false;
 
 	addrs = of_get_property(node, "assigned-addresses", &proplen);
-	if (!addrs)
-		return;
+	if (!addrs || !proplen) {
+		addrs = of_get_property(node, "reg", &proplen);
+		if (!addrs || !proplen)
+			return;
+		mark_unset = true;
+	}
+
 	pr_debug("    parse addresses (%d bytes) @ %p\n", proplen, addrs);
 	for (; proplen >= 20; proplen -= 20, addrs += 5) {
 		flags = pci_parse_of_flags(of_read_number(addrs, 1), 0);
@@ -110,6 +116,8 @@ static void of_pci_parse_addrs(struct device_node *node, struct pci_dev *dev)
 			continue;
 		}
 		res->flags = flags;
+		if (mark_unset)
+			res->flags |= IORESOURCE_UNSET;
 		res->name = pci_name(dev);
 		region.start = base;
 		region.end = base + size - 1;
-- 
2.17.1

