Return-Path: <linuxppc-dev+bounces-24792-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156E1C531FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 15:43:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6C242l2Cz2xYh;
	Sat, 25 Jul 2026 01:43:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:1000::53df:5fcc:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784907804;
	cv=none; b=JZngS2gdwX0I3lZS79yzWx2GZI0bs1KpumBQWqWChUoH9b+dVVaLlUWizxWrmEzSaDFXEhfkVat5KRZ4iFmSHaJc7TePU1gNu2J3WJEpb+VeSAF+wmD8J96nNdRJpqAIzLAhUol1hvyYIQJhPhhqaOxyBsWU8Pymd9CQfC/lX2P8uVArTruNJ/Awj08EMbTXWNVHfmMSBCHoQrDiMoI4Qjau+yZsXSG7R14eVjxjtGAS0DRo0428NCGHoHZ8gRVkXMAKrq8sEPAluh1JcLQ0X6yczZSeTVQd13j43Q7pK1nVzunRbtFuK9EexTZdtYnMIWfPGZwKxifW4pbDsjSDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784907804; c=relaxed/relaxed;
	bh=QSTGlt8iWORgcz/dthehyWRd43/ZaOt45pi3Ksk1k9E=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=cV1pHik+mr0DoQ3lPWSt55Ks1g63qWj9d0l+yVWXZSwjwmoEJW6GvktYfPUB4/cyQcoNu28y5Z3zNpZ3hPRjyBJ2ck7DPNlwVuPhjBvhJGS87oVfouVP5lWm+LqTE6ZZ2H33jq4dZYgSCVtKmAoOrdSMOiH2h/SVpMV4hSmU04+qSAUEHlkdraz2m8RwyE6UdgLcEf3H4606YBIuSIToV6wpJYtiM2/Rgoz37Y4iRZ+1SkD3kn2qWdW4zPUyNo4lPrb0eZ7QEs0vg2WUXo5RTNjR6V8EZZB+0YEsx81ocx6njV/nAM/ap9xTJzSYm6Sb1HBYbWThcUJV4Q/g0z4SPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:1000::53df:5fcc:0; helo=mailout1.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6C234pzvz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 01:43:23 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id DB25835E;
	Fri, 24 Jul 2026 17:43:18 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C811960CF04D; Fri, 24 Jul 2026 17:43:18 +0200 (CEST)
Message-ID: <d983b813043c518d098e2919161e816b91f15862.1784905909.git.lukas@wunner.de>
In-Reply-To: <cover.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 24 Jul 2026 17:24:02 +0200
Subject: [PATCH 2/6] PCI/AER: Log agent & layer for each individual error
To: Bjorn Helgaas <helgaas@kernel.org>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Qingshun Wang <qingshun.wang@linux.intel.com>, Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Terry Bowman <terry.bowman@amd.com>. Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Arjun Govindjee <agovindjee@purestorage.com>, Ashish Karkare <ashishk@purestorage.com>, Jasjeet Rangi <jrangi@purestorage.com>, Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com, sconnor@purestorage.com, an.luo@enflame-tech.com, fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com, xin.wang@enflame-tech.com
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

The AER driver maps detected errors to the corresponding agent and layer
per PCIe r7.0 sec 6.2.7 and logs both.

If multiple errors were detected, their agent and layer may differ.
However the AER driver only logs one agent and one layer for all of them,
which seems nonsensical.

Log the agent and layer for each individual error instead.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/aer.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e07d0e05b5d6..9cdac1c8c52e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -558,11 +558,11 @@ static const char *aer_uncorrectable_error_string[] = {
 };
 
 static const char *aer_agent_string[] = {
-	"Receiver ID",
-	"Requester ID",
-	"Completer ID",
-	"Transmitter ID",
-	"Component ID",
+	"Receiver",
+	"Requester",
+	"Completer",
+	"Transmitter",
+	"Component",
 };
 
 #define aer_stats_dev_attr(name, stats_array, strings_array,		\
@@ -844,8 +844,8 @@ static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	const char **strings;
 	unsigned long status = info->status & ~info->mask;
+	const char *errmsg, *agent, *layer;
 	const char *level = info->level;
-	const char *errmsg;
 	int i;
 
 	if (info->severity == AER_CORRECTABLE)
@@ -855,10 +855,17 @@ static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 	for_each_set_bit(i, &status, 32) {
 		errmsg = strings[i];
-		if (!errmsg)
+		agent = aer_agent_string[AER_GET_AGENT(info->severity, BIT(i))];
+		layer = aer_error_layer[AER_GET_LAYER_ERROR(info->severity,
+								       BIT(i))];
+		if (!errmsg) {
 			errmsg = "Unknown Error Bit";
+			agent = "";
+			layer = "";
+		}
 
-		aer_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
+		aer_printk(level, dev, "  [%2d] %-17s | %-11s | %-17s%s\n",
+			   i, errmsg, agent, layer,
 				info->first_error == i ? " (First)" : "");
 	}
 }
@@ -879,9 +886,9 @@ static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
 void aer_print_error(struct aer_err_info *info, int i)
 {
 	struct pci_dev *dev;
-	int layer, agent, id;
 	const char *level = info->level;
 	const char *bus_type = aer_err_bus(info);
+	int id;
 
 	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
 		return;
@@ -897,17 +904,13 @@ void aer_print_error(struct aer_err_info *info, int i)
 		return;
 
 	if (!info->status) {
-		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
+		pci_err(dev, "%s Bus Error: severity=%s (Inaccessible)\n",
 			bus_type, aer_error_severity_string[info->severity]);
 		goto out;
 	}
 
-	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
-	agent = AER_GET_AGENT(info->severity, info->status);
-
-	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
-		   bus_type, aer_error_severity_string[info->severity],
-		   aer_error_layer[layer], aer_agent_string[agent]);
+	aer_printk(level, dev, "%s Bus Error: severity=%s\n",
+		   bus_type, aer_error_severity_string[info->severity]);
 
 	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
 		   dev->vendor, dev->device, info->status, info->mask);
@@ -940,8 +943,8 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	int tlp_header_valid = 0;
 	const char *bus_type;
-	int layer, agent, tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info = {
 		.severity = aer_severity,
@@ -972,14 +975,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (!aer_ratelimit(dev, info.severity))
 		return;
 
-	layer = AER_GET_LAYER_ERROR(aer_severity, status);
-	agent = AER_GET_AGENT(aer_severity, status);
-
 	aer_printk(info.level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
 		   status, mask);
 	__aer_print_error(dev, &info);
-	aer_printk(info.level, dev, "aer_layer=%s, aer_agent=%s\n",
-		   aer_error_layer[layer], aer_agent_string[agent]);
 
 	if (aer_severity != AER_CORRECTABLE)
 		aer_printk(info.level, dev, "aer_uncor_severity: 0x%08x\n",
-- 
2.53.0


