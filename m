Return-Path: <linuxppc-dev+bounces-24798-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E80C531C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 16:06:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6CYF1Jdrz2yLY;
	Sat, 25 Jul 2026 02:06:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784909217;
	cv=none; b=nCPOQKCV7xcdxl+fwIfSHi30GOqWqfWakm4rBaAM8CM46wuMXPq1XEq83o2pa8Fx1JKwQSlBg83XGEEJwhwQ/02g7qsx6c/dTETlgnqqPiEDS3X7Uqv3ikCk5OuCmvwNfgITw/zWVEYwl7zxi6weWkX2OzSTQSWa3s1bLktyOC9E6PWH2ylAjPSd06wNHDbjZV8eVp/v43Nf0a3rZZSWzOSrUpnDpsKWqgkt9dZs2wIS1iMiDdRIj5wdpKQlqlKYzLzdAzWp+Wz+EDifKaJrHDumpzY3coNHgt3OtZZwy9e194BTU5iyuE6H1BIOrdZXkdUSzJIvadSlDUmiCq41GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784909217; c=relaxed/relaxed;
	bh=SnUYPt6IrrnHJ0CSauKKNEpL7+9LCOp4HzUSRo1bXE0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=CzswdxyPDgwPbYtQLYossXD7YHKDHcm99FsQwVplkV1uCrueYEosiN3ctVb53PnQekt05UNYIVQx7xx/mhy+PH79R8YZ+tb6GVt3S3og3y5wSpk0In+OJeTF/Hm8Ih0gLSsvsOKYZLLrdkYXAp5nfjTafDYPKc9i+KEdHSxcaRfHv78mO7cUrLXfGfG+OThh3swLQfct3wAPKjQJ9g3NB4JJxczKsjyjDGKC4BntSd3yAO71Lx59sHXHsiY6rquehzV4eaDWqucr388kkf55mu2y5RIyZxSBqM/WWb08ohgdEloBrR33jUY5eDFO/o4BzD552pv7EOy1udXebVd5aA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 820 seconds by postgrey-1.37 at boromir; Sat, 25 Jul 2026 02:06:56 AEST
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6CYD0WrBz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 02:06:56 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 220B610DCC;
	Fri, 24 Jul 2026 18:06:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 10FE460CF04D; Fri, 24 Jul 2026 18:06:53 +0200 (CEST)
Message-ID: <1b62915ffe06ee5b08e846531c42392e5f244337.1784905909.git.lukas@wunner.de>
In-Reply-To: <cover.1784905909.git.lukas@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 24 Jul 2026 17:24:06 +0200
Subject: [PATCH 6/6] PCI/AER: Support Advisory Non-Fatal Errors
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

Per PCIe r7.0 sec 6.2.4.3, certain Non-Fatal Errors may be signaled using
ERR_COR instead of ERR_NONFATAL.  These "Advisory Non-Fatal Errors" are
listed in sec 6.2.7 and explained in detail in sec 6.2.3.2.4.

Advisory Non-Fatal Errors set bits in the Uncorrectable Error Status
Register as well as one bit in the Correctable Error Status Register
(Advisory Non-Fatal Error Status, bit 13).  The latter is masked by
default, hence these errors are currently not signaled at all (except on
non-compliant products which choose to unmask the bit).

Unmask Advisory Non-Fatal Errors on device enumeration.

Some Non-Fatal Errors are always Advisory, others may be Advisory at the
discretion of the detecting agent.  If multiple errors occur, the agent
may qualify a portion as non-Advisory and signal ERR_NONFATAL in addition
to ERR_COR.  In this case, there's no way to determine which Non-Fatal
Error was Advisory.  Assume none is to ensure that the Uncorrectable Error
code path is taken to recover from the errors.

Introduce aer_compute_anfe_status() to compute Advisory Non-Fatal Error
bits from AER registers, based on this policy.  Use it for Firmware First
error handling in pci_print_aer(), which receives an AER register dump
from the platform (UEFI r2.11 sec N.2.7).

Introduce aer_get_anfe_status() to read AER registers from a device and
feed them to aer_compute_anfe_status().  Use it for native error handling
in aer_get_device_error_info(), which gathers registers from the device
and caches the computed Advisory Non-Fatal Error bits in a new anfe_status
field in struct aer_err_info.

Regardless whether error handling is native or Firmware First, the AER
driver needs to increment error counters, signal a trace event and log
each error.  When Advisory Non-Fatal Errors occur, these steps must be
performed for Correctable Errors and for Uncorrectable Errors.  Achieve
this through a recursive invocation of aer_print_error() (for native error
handling) and pci_print_aer() (for Firmware First error handling).  The
recursive invocation reports the (Advisory) Uncorrectable Errors after
reporting the Correctable Errors.

Note that the First Error Pointer and TLP Prefix Log is only meaningful
for Uncorrectable Errors, but when Advisory Non-Fatal Errors occur,
aer_get_device_error_info() has to populate the first_error and
tlp_header_valid fields in struct aer_err_info for a Correctable Error.
Avoid incorrectly logging those fields for Correctable Errors by amending
__aer_print_error() and aer_print_error() with conditionals.

Sample log output for an Advisory Unsupported Request Error:

pcieport 0001:00:00.4: AER: Multiple Correctable Error messages received, first one from 0001:0e:00.0
idxd 0001:0e:00.0: PCIe Bus Error: severity=Correctable
idxd 0001:0e:00.0:   device [8086:1216] error status/mask=00002000/00000000
idxd 0001:0e:00.0:   [13] NonFatalErr       |             |
idxd 0001:0e:00.0: PCIe Bus Error: severity=Uncorrectable (Non-Fatal)
idxd 0001:0e:00.0:   device [8086:1216] error status/mask=00100000/00000000
idxd 0001:0e:00.0:   [20] UnsupReq          | Receiver    | Transaction Layer (First)
idxd 0001:0e:00.0: AER:   TLP Header (Flit): 0x01000104 0x00000000 0x0000080e 0x0f800001

This commit takes inspiration (but differs significantly) from an earlier
submission by Zhenzhong Duan, which in turn was based on a submission by
Qingshun Wang:

https://lore.kernel.org/r/20240620025857.206647-1-zhenzhong.duan@intel.com/

Prior attempts at supporting Advisory Non-Fatal Errors were submitted by
Yicong Yang and Dio Sun:

https://lore.kernel.org/r/1614689994-10925-1-git-send-email-yangyicong@hisilicon.com/
https://lore.kernel.org/r/BJXPR01MB0614C01A9523786117B1F1CBCEC8A@BJXPR01MB0614.CHNPR01.prod.partner.outlook.cn/

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci.h      |   4 ++
 drivers/pci/pcie/aer.c | 141 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 137 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..02ee26ee9206 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -828,6 +828,9 @@ static inline bool pci_dev_binding_disallowed(struct pci_dev *dev)
  * @tlp_header_valid: Indicates if TLP field contains error information
  * @status: COR/UNCOR error status
  * @mask: COR/UNCOR mask
+ * @anfe_status: Advisory Non-Fatal Errors, i.e. Uncorrectable Errors signaled
+ *	as Correctable Errors (PCIe r7.0 sec 6.2.4.3).  Only used if @severity
+ *	is AER_CORRECTABLE and @status has Advisory Non-Fatal Error Status set.
  * @tlp: Transaction packet information
  */
 struct aer_err_info {
@@ -850,6 +853,7 @@ struct aer_err_info {
 
 	unsigned int status;
 	unsigned int mask;
+	u32 anfe_status;
 	struct pcie_tlp_log tlp;
 };
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c196c94f43d7..ff6ff7abc286 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -96,6 +96,20 @@ struct aer_info {
 	struct ratelimit_state nonfatal_ratelimit;
 };
 
+#define AER_ANFE			(PCI_ERR_UNC_UNX_COMP |		\
+					PCI_ERR_UNC_ATOMEG |		\
+					PCI_ERR_UNC_DMWR_BLK)
+
+#define AER_POSSIBLE_ANFE		(PCI_ERR_UNC_POISON_TLP |	\
+					PCI_ERR_UNC_POISON_BLK |	\
+					PCI_ERR_UNC_ECRC |		\
+					PCI_ERR_UNC_UNSUP |		\
+					PCI_ERR_UNC_COMP_TIME |		\
+					PCI_ERR_UNC_COMP_ABORT |	\
+					PCI_ERR_UNC_ACSV |		\
+					PCI_ERR_UNC_TLPPRE |		\
+					PCI_ERR_UNC_PCRC_CHECK)
+
 #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
 					PCI_ERR_UNC_POISON_BLK |	\
 					PCI_ERR_UNC_ECRC|		\
@@ -410,6 +424,15 @@ void pci_aer_init(struct pci_dev *dev)
 	n = pcie_cap_has_rtctl(dev) ? 5 : 4;
 	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
 
+	/*
+	 * Advisory Non-Fatal Errors are masked by default (PCIe r7.0, sec
+	 * 7.8.4.6).
+	 */
+	if (dev->devcap & PCI_EXP_DEVCAP_RBER)
+		pci_clear_and_set_config_dword(dev,
+					       dev->aer_cap + PCI_ERR_COR_MASK,
+					       PCI_ERR_COR_ADV_NFAT, 0);
+
 	pci_aer_clear_status(dev);
 
 	if (pci_aer_available())
@@ -429,6 +452,7 @@ void pci_aer_exit(struct pci_dev *dev)
 #define AER_AGENT_COMPLETER		2
 #define AER_AGENT_TRANSMITTER		3
 #define AER_AGENT_COMPONENT		4
+#define AER_AGENT_UNDEF			5
 
 #define AER_AGENT_REQUESTER_MASK(t)	((t == AER_CORRECTABLE) ?	\
 	0 : PCI_ERR_UNC_COMP_TIME)
@@ -442,18 +466,23 @@ void pci_aer_exit(struct pci_dev *dev)
 #define AER_AGENT_COMPONENT_MASK(t)	((t == AER_CORRECTABLE) ?	\
 	(PCI_ERR_COR_INTERNAL|PCI_ERR_COR_LOG_OVER) :			\
 	(PCI_ERR_UNC_INTN|PCI_ERR_UNC_SURPDN))
+#define AER_AGENT_UNDEF_MASK(t)		((t == AER_CORRECTABLE) ?	\
+	PCI_ERR_COR_ADV_NFAT : 0)
+
 
 #define AER_GET_AGENT(t, e)						\
 	((e & AER_AGENT_COMPLETER_MASK(t)) ? AER_AGENT_COMPLETER :	\
 	(e & AER_AGENT_REQUESTER_MASK(t)) ? AER_AGENT_REQUESTER :	\
 	(e & AER_AGENT_TRANSMITTER_MASK(t)) ? AER_AGENT_TRANSMITTER :	\
 	(e & AER_AGENT_COMPONENT_MASK(t)) ? AER_AGENT_COMPONENT :	\
+	(e & AER_AGENT_UNDEF_MASK(t)) ? AER_AGENT_UNDEF :		\
 	AER_AGENT_RECEIVER)
 
 #define AER_PHYSICAL_LAYER_ERROR	0
 #define AER_DATA_LINK_LAYER_ERROR	1
 #define AER_TRANSACTION_LAYER_ERROR	2
 #define AER_GENERAL_ERROR		3
+#define AER_UNDEF_ERROR			4
 
 #define AER_PHYSICAL_LAYER_ERROR_MASK(t) ((t == AER_CORRECTABLE) ?	\
 	PCI_ERR_COR_RCVR : 0)
@@ -464,11 +493,14 @@ void pci_aer_exit(struct pci_dev *dev)
 	PCI_ERR_COR_REP_TIMER) : (PCI_ERR_UNC_DLP|PCI_ERR_UNC_SURPDN))
 #define AER_GENERAL_ERROR_MASK(t)  ((t == AER_CORRECTABLE) ?		\
 	(PCI_ERR_COR_INTERNAL|PCI_ERR_COR_LOG_OVER) : PCI_ERR_UNC_INTN)
+#define AER_UNDEF_ERROR_MASK(t)  ((t == AER_CORRECTABLE) ?		\
+	PCI_ERR_COR_ADV_NFAT : 0)
 
 #define AER_GET_LAYER_ERROR(t, e)					\
 	((e & AER_PHYSICAL_LAYER_ERROR_MASK(t)) ? AER_PHYSICAL_LAYER_ERROR : \
 	(e & AER_DATA_LINK_LAYER_ERROR_MASK(t)) ? AER_DATA_LINK_LAYER_ERROR : \
 	(e & AER_GENERAL_ERROR_MASK(t)) ? AER_GENERAL_ERROR :		\
+	(e & AER_UNDEF_ERROR_MASK(t)) ? AER_UNDEF_ERROR :		\
 	AER_TRANSACTION_LAYER_ERROR)
 
 /*
@@ -485,6 +517,7 @@ static const char *aer_error_layer[] = {
 	"Data Link Layer",
 	"Transaction Layer",
 	"General",
+	"",
 };
 
 static const char *aer_correctable_error_string[] = {
@@ -563,6 +596,7 @@ static const char *aer_agent_string[] = {
 	"Completer",
 	"Transmitter",
 	"Component",
+	"",
 };
 
 #define aer_stats_dev_attr(name, stats_array, strings_array,		\
@@ -826,6 +860,46 @@ static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
 	}
 }
 
+static u32 aer_compute_anfe_status(u16 devsta, u32 uncor_status,
+				   u32 uncor_mask, u32 uncor_severity)
+{
+	u32 anfe_status;
+
+	/*
+	 * Uncorrectable Errors must be unmasked and have Non-Fatal severity
+	 * to qualify as Advisory Non-Fatal Errors (PCIe r7.0 sec 6.2.4.3).
+	 */
+	uncor_status &= ~uncor_mask & ~uncor_severity;
+
+	/* Some Non-Fatal Errors are always Advisory (PCIe r7.0 sec 6.2.7). */
+	anfe_status = uncor_status & AER_ANFE;
+
+	/*
+	 * Others may be Advisory at the discretion of the detecting agent.
+	 * That's impossible to discern if the agent signaled ERR_NONFATAL
+	 * in addition to ERR_COR.  Assume none are Advisory in that case
+	 * to ensure that the Uncorrectable Error code path is taken.
+	 */
+	if (!(devsta & PCI_EXP_DEVSTA_NFED))
+		anfe_status |= uncor_status & AER_POSSIBLE_ANFE;
+
+	return anfe_status;
+}
+
+static u32 aer_get_anfe_status(struct pci_dev *dev)
+{
+	u32 uncor_status, uncor_mask, uncor_severity;
+	u16 devsta, aer = dev->aer_cap;
+
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &uncor_status);
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &uncor_mask);
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_SEVER, &uncor_severity);
+	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
+
+	return aer_compute_anfe_status(devsta, uncor_status, uncor_mask,
+				       uncor_severity);
+}
+
 static bool tlp_header_logged(u32 status, u32 capctl)
 {
 	/* Errors for which a header is always logged (PCIe r7.0 sec 6.2.7) */
@@ -866,6 +940,7 @@ static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 		aer_printk(level, dev, "  [%2d] %-17s | %-11s | %-17s%s\n",
 			   i, errmsg, agent, layer,
+			   info->severity != AER_CORRECTABLE &&
 				info->first_error == i ? " (First)" : "");
 	}
 }
@@ -897,10 +972,16 @@ void aer_print_error(struct aer_err_info *info, int i)
 
 	pci_dev_aer_stats_incr(dev, info);
 	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
-			info->severity, info->tlp_header_valid, &info->tlp, bus_type);
+			info->severity, info->tlp_header_valid &&
+			info->severity != AER_CORRECTABLE, &info->tlp,
+			bus_type);
 
+	/*
+	 * For Advisory Non-Fatal Errors, record statistics and tracing
+	 * even if ratelimited
+	 */
 	if (!info->ratelimit_print[i])
-		return;
+		goto anfe;
 
 	if (!info->status) {
 		pci_err(dev, "%s Bus Error: severity=%s (Inaccessible)\n",
@@ -916,8 +997,20 @@ void aer_print_error(struct aer_err_info *info, int i)
 
 	__aer_print_error(dev, info);
 
-	if (info->tlp_header_valid)
+	if (info->tlp_header_valid && info->severity != AER_CORRECTABLE)
 		pcie_print_tlp_log(dev, &info->tlp, level, dev_fmt("  "));
+
+anfe:
+	/* Recursive invocation for Advisory Non-Fatal Errors */
+	if (info->anfe_status && info->severity == AER_CORRECTABLE) {
+		info->severity = AER_NONFATAL;
+		info->status = info->anfe_status;
+		info->mask = 0;
+
+		aer_print_error(info, i);
+
+		info->severity = AER_CORRECTABLE;
+	}
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -938,8 +1031,8 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		   struct aer_capability_regs *aer)
 {
+	const char *bus_type, *sev;
 	int tlp_header_valid = 0;
-	const char *bus_type;
 	u32 status, mask;
 	struct aer_err_info info = {
 		.severity = aer_severity,
@@ -949,10 +1042,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (aer_severity == AER_CORRECTABLE) {
 		status = aer->cor_status;
 		mask = aer->cor_mask;
+		sev = "cor";
 		info.level = KERN_WARNING;
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
+		sev = "uncor";
 		info.level = KERN_ERR;
 		tlp_header_valid = tlp_header_logged(status & ~mask,
 						     aer->cap_control);
@@ -968,11 +1063,16 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	trace_aer_event(pci_name(dev), (status & ~mask), aer_severity,
 			tlp_header_valid, &aer->header_log, bus_type);
 
+	/*
+	 * For Advisory Non-Fatal Errors, record statistics and tracing
+	 * even if ratelimited
+	 */
 	if (!aer_ratelimit(dev, info.severity))
-		return;
+		goto anfe;
 
-	aer_printk(info.level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n",
-		   status, mask);
+	aer_printk(info.level, dev,
+		   "aer_%s_status: 0x%08x, aer_%s_mask: 0x%08x\n",
+		   sev, status, sev, mask);
 	__aer_print_error(dev, &info);
 
 	if (aer_severity != AER_CORRECTABLE)
@@ -982,6 +1082,21 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	if (tlp_header_valid)
 		pcie_print_tlp_log(dev, &aer->header_log, info.level,
 				   dev_fmt("  "));
+
+anfe:
+	/* Recursive invocation for Advisory Non-Fatal Errors */
+	if (aer_severity == AER_CORRECTABLE &&
+	    info.status & ~info.mask & PCI_ERR_COR_ADV_NFAT) {
+		u32 anfe_status = aer_compute_anfe_status(PCI_EXP_DEVSTA_CED,
+							  aer->uncor_status,
+							  aer->uncor_mask,
+							  aer->uncor_severity);
+		if (anfe_status) {
+			aer->uncor_status = anfe_status;
+			aer->uncor_mask = 0;
+			pci_print_aer(dev, AER_NONFATAL, aer);
+		}
+	}
 }
 EXPORT_SYMBOL_GPL(pci_print_aer);
 
@@ -1184,9 +1299,14 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 		 * Correctable error does not need software intervention.
 		 * No need to go through error recovery process.
 		 */
-		if (aer)
+		if (aer) {
 			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
 					info->status);
+			if (info->anfe_status)
+				pci_write_config_dword(dev,
+					aer + PCI_ERR_UNCOR_STATUS,
+					info->anfe_status);
+		}
 		if (pcie_aer_is_native(dev)) {
 			struct pci_driver *pdrv = dev->driver;
 
@@ -1333,6 +1453,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 
 	/* Must reset in this function */
 	info->status = 0;
+	info->anfe_status = 0;
 	info->tlp_header_valid = 0;
 	info->is_cxl = pcie_is_cxl(dev);
 
@@ -1347,6 +1468,10 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 			&info->mask);
 		if (!(info->status & ~info->mask))
 			return 0;
+		if (info->status & ~info->mask & PCI_ERR_COR_ADV_NFAT) {
+			info->anfe_status = aer_get_anfe_status(dev);
+			aer_get_uncor_info(dev, info, info->anfe_status);
+		}
 	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
 		   type == PCI_EXP_TYPE_RC_EC ||
 		   type == PCI_EXP_TYPE_DOWNSTREAM ||
-- 
2.53.0


