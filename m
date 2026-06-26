Return-Path: <linuxppc-dev+bounces-23023-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2AFCDE00E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 12:36:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmwBl3kSCz2yYd;
	Fri, 26 Jun 2026 22:35:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782477359;
	cv=none; b=eGc63FdkuQKene5SW65/maMWtcYMSjqghTO8+Pduy/RN/N8GMEbOGuWyYwcfdjW++qz5Yg+NJV36rQ09l9XPiO601OS8jLXZfF18H2mSKoKUChUKJXiy4ZCJM5ouyNFBuEaTZ/of7Sji7xMqcwtu+vzt8f7i89mm5L1Jw15g7vsVVaTvf32yGbDhjMV0RQ+Kpbh29UIytGdvYV5V1C7z54wOJqsm1yZw89r/u0sYvoUaBqYvsPoJYbhsfAs/2vCeUccKUUEQVftRQbhUFGKhMhHCStikIUZbulpWDXuHHVTNIWKUmznVATn4a3sKaGVM4tC+MWtGLds5VVa1RCIbsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782477359; c=relaxed/relaxed;
	bh=qZusql1MEib1Ora7F9aQYtgBwH0FEhYr2tnwv1gB/D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPr2pyFsTbIr5xAAHcvgo5AnNo46ULm4GJ2xhwaEDE1U0vpY5exaDMkqiUbV6JVGEAFVXaJdQf8VF0HEC+38UG5rimUR5yzqGfXbaQAylhCAgTG2P4t2iqZqoZxYD+143HsvTcN97VRCDT2T6oLg9F5UzT3w8BR/ifPUQkYP0ItweimtHQzKTXP0l9Qo2aVKHXtDZsZUYaA4HQSIfrwKkHv80oHRNH9RUZiqtqm4DRGa/0cNrv4enMw4qPS+2gOqtpYgyPtue1F7lvpiCMsSEXfnPT4x1Nm3eZ/wl4LuocenfccCTS8pFcDAHW2JpvOPaDnI5BINx1QlCfxwdPsfwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NBnwk4Nk; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NBnwk4Nk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmwBk1tw7z2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 22:35:57 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAIhQD2660410;
	Fri, 26 Jun 2026 12:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qZusql1MEib1Ora7F9aQYtgBwH0FEhYr2tnwv1gB/
	D4=; b=NBnwk4NkSkpZqZThv9fVfSEbYAwNiZjHT48Zhy/6sXEZk3trENY1EN8Gu
	mlRhHFeZ4dWNzFyy9bMHXhHEdKA/h8/WkY38HDFNn4UwLirBcqd1HqTYmAok4oGv
	abVA1r00tWdrNveBHeRKojKNG0Ifd0thVHBE4Sbd2Gnf/qNNaiBIuj4vdr4SKSVp
	ENYXuCNbt9wQCIcgN+YD62zMKox7uWdW9wYmEWwAQ5xcVac5EjXSPyklGxocPY53
	x+e6Nu9/+9lntzF8UEkClbUXB3BBj58si+JI/ZypGCPKCAClQKoTdD98oEvZrYOz
	Pxgb6gPjMHjivgVRa8wRJJtM15zWA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gxk1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 12:35:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QCYeTK031766;
	Fri, 26 Jun 2026 12:35:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dgjufu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 12:35:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QCZdig49873318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 12:35:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A6B52004D;
	Fri, 26 Jun 2026 12:35:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC52620043;
	Fri, 26 Jun 2026 12:35:36 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 12:35:36 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: shivangu@linux.ibm.com
Cc: adityag@linux.ibm.com, chleroy@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mahesh@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        sourabhjain@linux.ibm.com, thuth@redhat.com
Subject: [PATCH v2] powerpc/powernv: Cache OPAL check_token() results
Date: Fri, 26 Jun 2026 18:05:34 +0530
Message-ID: <20260626123534.396456-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: -McQ3Gf7Y7AmqoLOU5nRkxoEdRgx8Krk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEwMCBTYWx0ZWRfX9eREewlKgEMw
 nTs8BFCPkKilwOqMtQNLd6WhIkLpgD4hgpHu1k6JL4d3klsoJREXHj26yFBEsI1dQLlTy6Qy6j2
 gKB/fFXNGsI1a4l+Kfwavlv3Z5FwPNg=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3e7220 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_oxaYUcLAtKeAHhaBbsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEwMCBTYWx0ZWRfX+yX5+bvzOF1T
 aMo7tAiv4puaqNPCYXBLLLAXtpK9gQqMToCHeu+GAFj4ZEILCUPvqad17ZYEtZLoiAKRqxo900q
 Govmo0DSG4dr76Ljm3d0wiLRvfsUxEJBNkX73QrSwdoiqEtF46DxFUTWsCexJz9ajz+q+RdIFmP
 6Ba0Gny4npdDl8HWaG8QpXgpAZ4R73oPTFKQkEmkjBrCaxHxbYQWufn+DL18UBGCiwlq/6zAT3i
 rbchA4LIIgamGyVD73HA2NypJm3E/pMBK5iEExoZTpjsHj2RyADS+e5CN576hfFHsR6Vi5uTahC
 kwPBdz5YLIN69UYb/GxWTeDwEa8T1DAC66NtUiLyudK+l/rMpubKZvTZPna88r5U5ihPy3l9jnn
 WbpWm1Yxem9Bxo8habxgnFkw9Pp8fEWCnqihGKclKktOfwURRmmhp4sSxbOZbTnh2DFvdh1nu+8
 XQbbjjPx3cZ43cYgHVg==
X-Proofpoint-ORIG-GUID: 9HYbuIUslBhT0YAa_tMzS9YkQiukJR3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260100

`opal_check_token()` function is used to determine if a specific
OPAL firmware call is supported on the current platform. This check
is performed frequently during boot and runtime, resulting in
unnecessary firmware calls for the same token values.

Add a caching layer for the opal_check_token() OPAL call to avoid
repeated firmware calls for token availability checks. This reduces
firmware call overhead during boot.

Testing with buildroot images shows OPAL calls reduced from
35578 to 28983, before console bring-up.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
Changelog:
* v1: https://lore.kernel.org/all/20260601112520.161605-1-shivangu@linux.ibm.com/
   - implemented tri-state check as suggestd by Sourabh.
   - made the implementation more clear.

---
 arch/powerpc/include/asm/opal.h            |  1 +
 arch/powerpc/platforms/powernv/opal-call.c |  2 +-
 arch/powerpc/platforms/powernv/opal.c      | 30 ++++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 0a398265ba04..e7e11479122b 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -156,6 +156,7 @@ int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
 int64_t opal_pci_poll(uint64_t id);
 int64_t opal_return_cpu(void);
 int64_t opal_check_token(uint64_t token);
+int64_t opal_check_token_call(uint64_t token);
 int64_t opal_reinit_cpus(uint64_t flags);
 
 int64_t opal_xscom_read(uint32_t gcid, uint64_t pcb_addr, __be64 *val);
diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
index 021b0ec29e24..00325c189e69 100644
--- a/arch/powerpc/platforms/powernv/opal-call.c
+++ b/arch/powerpc/platforms/powernv/opal-call.c
@@ -207,7 +207,7 @@ OPAL_CALL(opal_validate_flash,			OPAL_FLASH_VALIDATE);
 OPAL_CALL(opal_manage_flash,			OPAL_FLASH_MANAGE);
 OPAL_CALL(opal_update_flash,			OPAL_FLASH_UPDATE);
 OPAL_CALL(opal_resync_timebase,			OPAL_RESYNC_TIMEBASE);
-OPAL_CALL(opal_check_token,			OPAL_CHECK_TOKEN);
+OPAL_CALL(opal_check_token_call,		OPAL_CHECK_TOKEN);
 OPAL_CALL(opal_dump_init,			OPAL_DUMP_INIT);
 OPAL_CALL(opal_dump_info,			OPAL_DUMP_INFO);
 OPAL_CALL(opal_dump_info2,			OPAL_DUMP_INFO2);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 1946dbdc9fa1..1e9cb5271ee7 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -1125,6 +1125,36 @@ EXPORT_SYMBOL_GPL(opal_flash_read);
 EXPORT_SYMBOL_GPL(opal_flash_write);
 EXPORT_SYMBOL_GPL(opal_flash_erase);
 EXPORT_SYMBOL_GPL(opal_prd_msg);
+
+/**
+ * opal_check_token - Check if an OPAL call token is supported
+ * @token: OPAL token number to check
+ *
+ * Returns 1 if supported, 0 if not.
+ */
+int64_t opal_check_token(uint64_t token)
+{
+	static u8 token_cache[OPAL_LAST];
+	enum {
+		SUPP_UNKNOWN = 0,
+		PRESENT,
+		ABSENT
+	};
+
+	if (token > OPAL_LAST)
+		return 0;
+
+	if (token_cache[token] == SUPP_UNKNOWN) {
+		/* Do the actual opal_call here */
+		if (opal_check_token_call(token)) {
+			token_cache[token] = PRESENT;
+		} else {
+			token_cache[token] = ABSENT;
+		}
+	}
+
+	return (token_cache[token] == PRESENT);
+}
 EXPORT_SYMBOL_GPL(opal_check_token);
 
 /* Convert a region of vmalloc memory to an opal sg list */
-- 
2.54.0


