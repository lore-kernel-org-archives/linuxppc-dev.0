Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA777C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 06:43:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4285620849
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 06:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4285620849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Fkf41cJwzDqgS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 17:43:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43Fk5b0FWjzDqcp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 17:18:42 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id C3A3CAE80492;
 Thu, 13 Dec 2018 01:18:08 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v5 07/20] powerpc/pseries/npu: Enable platform support
Date: Thu, 13 Dec 2018 17:17:21 +1100
Message-Id: <20181213061734.16651-8-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213061734.16651-1-aik@ozlabs.ru>
References: <20181213061734.16651-1-aik@ozlabs.ru>
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We already changed NPU API for GPUs to not to call OPAL and the remaining
bit is initializing NPU structures.

This searches for POWER9 NVLinks attached to any device on a PHB and
initializes an NPU structure if any found.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v5:
* added WARN_ON_ONCE

v4:
* dropped "IBM,npu-vphb" compatible type on PHB and use the type of NVLink
---
 arch/powerpc/platforms/pseries/pci.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 41d8a4d..7725825 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -29,6 +29,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/prom.h>
 #include <asm/ppc-pci.h>
+#include <asm/pci.h>
 #include "pseries.h"
 
 #if 0
@@ -237,6 +238,8 @@ static void __init pSeries_request_regions(void)
 
 void __init pSeries_final_fixup(void)
 {
+	struct pci_controller *hose;
+
 	pSeries_request_regions();
 
 	eeh_probe_devices();
@@ -246,6 +249,25 @@ void __init pSeries_final_fixup(void)
 	ppc_md.pcibios_sriov_enable = pseries_pcibios_sriov_enable;
 	ppc_md.pcibios_sriov_disable = pseries_pcibios_sriov_disable;
 #endif
+	list_for_each_entry(hose, &hose_list, list_node) {
+		struct device_node *dn = hose->dn, *nvdn;
+
+		while (1) {
+			dn = of_find_all_nodes(dn);
+			if (!dn)
+				break;
+			nvdn = of_parse_phandle(dn, "ibm,nvlink", 0);
+			if (!nvdn)
+				continue;
+			if (!of_device_is_compatible(nvdn, "ibm,npu-link"))
+				continue;
+			if (!of_device_is_compatible(nvdn->parent,
+						"ibm,power9-npu"))
+				continue;
+			WARN_ON_ONCE(pnv_npu2_init(hose));
+			break;
+		}
+	}
 }
 
 /*
-- 
2.17.1

