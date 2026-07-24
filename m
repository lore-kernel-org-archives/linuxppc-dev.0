Return-Path: <linuxppc-dev+bounces-24791-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030BCC531FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 15:39:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6BxX39Gxz2yFg;
	Sat, 25 Jul 2026 01:39:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ee9:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784907568;
	cv=none; b=RR7EUSs/itYhd8zqYpqLrB9vgl0pNaBlRzyr1btq3Fd3DUw8W1I1ODFgWJKVDdxEg9YFMkKr7Css83rbSn+DPShBG7Qh3H6mlqn1lF0j3r8C0THu25mAGTPpfD0Jp6t+ArRfwDBOU5nvG+LzuUoT0df1GXdgnFfMi2t/DQZpZjKxVUY6bUTF6+LR/fsU/49RUpG21LCJK2crnvSPyAmCfCukZoeCUwubwho0dtQbgcoov1+QUYghA+SPI2vbjYw5kJall/dJK7GKyh0UKw+1x4cbhP9Jr5OXf6c6XmJDC8r/GQcRHUW4mYFOGPNFilMcerGW7kyzj9hwP40SAPEZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784907568; c=relaxed/relaxed;
	bh=QvhlEouBaXTDxnkeS6sMdflRreTBgCv7RcEvXPPUhCM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=CxWvJiuCUiLLUIygvWQtSj+VYRiqAYcNnHOtreswZ4S1jjxE7L0xVqJippe4vYtmLR/8oW/Mx12e13woxWa2pjuG457ZwzO1joK5Aca2g1zumonOGGiSiRIoKraNEzOYH9f++BQShBTCZMH8wxm4zmmVc6xLQ9lDNpq5+5LBk1zEmg5Ps0El/npnCBT4GvvUicQOvPaoGR2lis5zt4WvqYGWXoTju0LmdUODEqlAdEirVbdkGgZ+e4K5Eh3Q+GDwpQHvYjRg1fOpw8TSAaaupqrm84uNXuh4dUVlTOWLw68vNbu05SEvhXL5gfLJ2jRpSBtESLA7VNmAAi5xpya41Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6BxW33Rvz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 01:39:27 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 7F38410624;
	Fri, 24 Jul 2026 17:39:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6949060CF04D; Fri, 24 Jul 2026 17:39:24 +0200 (CEST)
Message-ID: <aec4820a75e949b332585a08cb1808fda7f40ea4.1784905909.git.lukas@wunner.de>
In-Reply-To: <cover.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 24 Jul 2026 17:24:01 +0200
Subject: [PATCH 1/6] PCI/AER: Fix mapping of errors to agent & layer
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

PCIe r7.0 sec 6.2.7 documents the agent and layer of each Correctable and
Uncorrectable Error.  Based on this spec section, the AER driver maps
detected errors to an agent and layer using a set of macros and logs them.

Most errors listed in sec 6.2.7 map to the "Receiver" agent and
"Transaction Layer", so the macros use these as defaults unless an error
maps to something else.

However the macros have not been amended since their introduction in 2006
with commit 6c2b374d7485 ("PCI-Express AER implemetation: AER core and
aerdriver").  They are still based on PCIe r1.0 sec 7.2.5 (renumbered to
6.2.7 in PCIe r1.1 and newer).

Amend the macros to map errors introduced since then to the appropriate
agent and layer.

PCIe r2.1 introduced a new "Component" agent and "General" layer for
Internal Errors and Header Log Overflow.  Add them to the macros.

Unsupported Request is currently mapped to the "Requester" agent, even
though it is reported by the "Receiver".  Fix the incorrect mapping.

Sec 6.2.7 neglects to list an agent for Data Link Protocol Error and
Surprise Down Error.  Map the latter to "Component" because PCIe r7.0 sec
3.2.1 states that the error is "associated with the detecting Port".  Map
the former to "Receiver" because every occurrence of Data Link Protocol
Error in the spec refers to it being logged in the Receiving Port.  I have
had these errata reported to the PCI-SIG Protocol Working Group.  (There's
also a layout erratum in the REPLAY_NUM Rollover row wherein columns are
shifted to the left, but that's already corrected in the PCIe r7.1 draft
as of 2026-04-07.)

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org
---
 drivers/pci/pcie/aer.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c4fd9c0b2a54..e07d0e05b5d6 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -428,23 +428,32 @@ void pci_aer_exit(struct pci_dev *dev)
 #define AER_AGENT_REQUESTER		1
 #define AER_AGENT_COMPLETER		2
 #define AER_AGENT_TRANSMITTER		3
+#define AER_AGENT_COMPONENT		4
 
 #define AER_AGENT_REQUESTER_MASK(t)	((t == AER_CORRECTABLE) ?	\
-	0 : (PCI_ERR_UNC_COMP_TIME|PCI_ERR_UNC_UNSUP))
+	0 : PCI_ERR_UNC_COMP_TIME)
 #define AER_AGENT_COMPLETER_MASK(t)	((t == AER_CORRECTABLE) ?	\
 	0 : PCI_ERR_UNC_COMP_ABORT)
 #define AER_AGENT_TRANSMITTER_MASK(t)	((t == AER_CORRECTABLE) ?	\
-	(PCI_ERR_COR_REP_ROLL|PCI_ERR_COR_REP_TIMER) : 0)
+	(PCI_ERR_COR_REP_ROLL|PCI_ERR_COR_REP_TIMER) :			\
+	(PCI_ERR_UNC_POISON_BLK|PCI_ERR_UNC_ATOMEG|			\
+	 PCI_ERR_UNC_DMWR_BLK|PCI_ERR_UNC_XLAT_BLK|			\
+	 PCI_ERR_UNC_TLPPRE))
+#define AER_AGENT_COMPONENT_MASK(t)	((t == AER_CORRECTABLE) ?	\
+	(PCI_ERR_COR_INTERNAL|PCI_ERR_COR_LOG_OVER) :			\
+	(PCI_ERR_UNC_INTN|PCI_ERR_UNC_SURPDN))
 
 #define AER_GET_AGENT(t, e)						\
 	((e & AER_AGENT_COMPLETER_MASK(t)) ? AER_AGENT_COMPLETER :	\
 	(e & AER_AGENT_REQUESTER_MASK(t)) ? AER_AGENT_REQUESTER :	\
 	(e & AER_AGENT_TRANSMITTER_MASK(t)) ? AER_AGENT_TRANSMITTER :	\
+	(e & AER_AGENT_COMPONENT_MASK(t)) ? AER_AGENT_COMPONENT :	\
 	AER_AGENT_RECEIVER)
 
 #define AER_PHYSICAL_LAYER_ERROR	0
 #define AER_DATA_LINK_LAYER_ERROR	1
 #define AER_TRANSACTION_LAYER_ERROR	2
+#define AER_GENERAL_ERROR		3
 
 #define AER_PHYSICAL_LAYER_ERROR_MASK(t) ((t == AER_CORRECTABLE) ?	\
 	PCI_ERR_COR_RCVR : 0)
@@ -452,11 +461,14 @@ void pci_aer_exit(struct pci_dev *dev)
 	(PCI_ERR_COR_BAD_TLP|						\
 	PCI_ERR_COR_BAD_DLLP|						\
 	PCI_ERR_COR_REP_ROLL|						\
-	PCI_ERR_COR_REP_TIMER) : PCI_ERR_UNC_DLP)
+	PCI_ERR_COR_REP_TIMER) : (PCI_ERR_UNC_DLP|PCI_ERR_UNC_SURPDN))
+#define AER_GENERAL_ERROR_MASK(t)  ((t == AER_CORRECTABLE) ?		\
+	(PCI_ERR_COR_INTERNAL|PCI_ERR_COR_LOG_OVER) : PCI_ERR_UNC_INTN)
 
 #define AER_GET_LAYER_ERROR(t, e)					\
 	((e & AER_PHYSICAL_LAYER_ERROR_MASK(t)) ? AER_PHYSICAL_LAYER_ERROR : \
 	(e & AER_DATA_LINK_LAYER_ERROR_MASK(t)) ? AER_DATA_LINK_LAYER_ERROR : \
+	(e & AER_GENERAL_ERROR_MASK(t)) ? AER_GENERAL_ERROR :		\
 	AER_TRANSACTION_LAYER_ERROR)
 
 /*
@@ -471,7 +483,8 @@ static const char * const aer_error_severity_string[] = {
 static const char *aer_error_layer[] = {
 	"Physical Layer",
 	"Data Link Layer",
-	"Transaction Layer"
+	"Transaction Layer",
+	"General",
 };
 
 static const char *aer_correctable_error_string[] = {
@@ -548,7 +561,8 @@ static const char *aer_agent_string[] = {
 	"Receiver ID",
 	"Requester ID",
 	"Completer ID",
-	"Transmitter ID"
+	"Transmitter ID",
+	"Component ID",
 };
 
 #define aer_stats_dev_attr(name, stats_array, strings_array,		\
-- 
2.53.0


