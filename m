Return-Path: <linuxppc-dev+bounces-29621-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0FACCA463
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 07:50:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6DVm2jjGz2ySC;
	Sat, 17 Oct 2026 18:50:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792223408;
	cv=none; b=g6nPUFv6E3BFKn8WtziEePHIUae4lq54VCrVT3Xwgl5GpG/keePnZXhrOpEQSm1IhKPL6ucNy0PhzS/G7z8XFHoDrxWAkbiaeIEllWwf3Z27ISY1HYa26YFHjXlJ9xmdBYwJvf1va6Rwbr2ehcg4MGaQZAS+RkzFO9l1x/57/haGwC10xoqbA5Oi/OYbA9DVy1xoXjg2+xq73Wh8fjf2ZrtdiGLBU7N6AW1HlNRtMv8J11pCtA9UWGDPXsZyJSpnLYYgV0sdDekW4fSTpUi1HWOPgIyX5+5CibCoVdCHJ4WSDjwGgShU6qBO0dNn1M0P/qgdWNVEcKuXyWlJ/X0iOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792223408; c=relaxed/relaxed;
	bh=DkUsDxyGW9Krva81U9U8FNaYsazFURlWGFCc1iibGeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8lPaB4Ttse7Y9EcT0ZARklnKBL4qBA5UnbupKxRGw49VAPyMFfiuwlCGVg8bSAy+Tye0eykIPq15IkyBKM1u8o7BKv+bpt74XKEO4z1yr4eee8gq3JBCyIO+AXAK/JwzAtM3n8KhxQxfNJ8Xjw4uuGv3x7L98u1h4TRqBAyclQv1lvBpqsn64hE4vHCG+YhtOAPzja1ZUimToaACJ3XtZNqRpyDaDrItg7gTcl7ZVGR7wnRO4RDiqmSxKF+cUnGzSUCDoWqj4C9kyxYJfZYsbj/vX0G5XG6wxr4C3VYsvLDQTa69sEje8p8xy37I9Y7Z/pFyg7ofumYsn3YlYgbiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L1mAu75/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L1mAu75/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6DVl2KN6z2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 18:50:07 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H7ELaE1951835;
	Sat, 17 Oct 2026 07:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DkUsDxyGW9Krva81U
	9U8FNaYsazFURlWGFCc1iibGeM=; b=L1mAu75/J8U6C+KAGRO53r0whcfR4qCS/
	u7o4MHxD8a4sBvMveN821e4AFbhsNOdZ4Id2+W7Uwo6qhUlFIHCv8P4eDC0OnxCV
	TMmlQpaMOYUEd5USKk9ORmoEsMKU8T3VN7wlo/DsHOvTGY1SeveOKmO/S8YkLmBf
	VHOTxuvApFdZtPCgKpvxaXLzwrxAuElVvrtyFVZjxgfprb0uY4Hkvqk3EmPL8W/s
	XvuMT2Fzk6OZP8di9QPb2av/xuXR+EKbeaLciVmRszTFtsTzRbgzH19yBdIzOngR
	cDizasfVLvkZoppbZTve5BkW9gU0sMTv7cDQitL1fTPki0ArNjCPQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0h50sva-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 07:49:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69H6nrwC721725;
	Sat, 17 Oct 2026 07:49:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hawqx06th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 07:49:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69H7nnd028115642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 07:49:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F0DE2004B;
	Sat, 17 Oct 2026 07:49:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B09420040;
	Sat, 17 Oct 2026 07:49:41 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 07:49:41 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v3 4/6] pseries/plpks: add HCALLs for PKWM wrapping key life cycle management
Date: Sat, 17 Oct 2026 13:18:48 +0530
Message-ID: <20261017074850.164031-5-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017074850.164031-1-ssrish@linux.ibm.com>
References: <20261017074850.164031-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfX1+4jbH6Ez9m0
 TZH8BYXaOINI3vpVAfcndP87SMUPio6VQy6vqZGh9nB2neXETv0Cc8M42lYakx4CTH7FNMSpCcA
 d5Z4vXdiL0z63r5gOUnvNdTx7BfSWJI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfX4a80DdM2mXSX
 Wk3F9XHo6jAnJ6FSGUBwkvO58MRVu3RRLbWrheYQEuLljq19WVil6VI6fp+dAiqeI9vmluuDEwO
 zxPqtWhRxL7T0ri4sCeodj8rGEbP1Bjkmhq0QexcU4TBPUTxNucJsOKEyfE74QFtGviAnp9Zkhq
 ryQPJ6yWOgm9yYVS/fXOZeoGKTrR3yosmSl4zot58yf6QupteveXTvaz4KqkM4/v2JdTOOZeFUD
 m8hGjwtIHexC7GNyW1pLsVmoUqcI5zD7HUkIGjbR0rzPSPywYgdP/oogru8g/Anw/eomExAznkn
 mskJLNnOqVB4+vnuTPYRXXgPV1h02LqIzRF4Y2tEhqmXaNDuyb9YpDBJS930eVI7wPyY7JPVZuD
 32hho5vPZ/ZA2Bn7lqP/JnOpGszVKONygCTbHuT9/S7zDSKnZwm1sgVxAe24u2+CMJhGKtF3h6m
 uyLWxUu2ubYk5F4tclQ==
X-Proofpoint-ORIG-GUID: _wsR8WSjfVEwVKarQSZr5wliHLodTls_
X-Proofpoint-GUID: B6ISDTwF6As5e-ODg-1i4G7XPB0fqQjg
X-Authority-Analysis: v=2.4 cv=KujYSmWN c=1 sm=1 tr=0 ts=6ad328a3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=r-sPpvoc-vibC3ztEN0A:9
 a=sXdDUctjTlFAKk6J:21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170030

The PKWM trusted source uses a single wrapping key per LPAR, created only
once during trust source initialization. All the wrap and unwrap requests
are bound to this default wrapping key.

Implement H_PKS_REVOKE_OBJECT, H_PKS_UNREVOKE_OBJECT, and
H_PKS_GET_OBJECTLABELS HCALLs to enable support for revoking and unrevoking
PKWM wrapping keys, and for retrieving wrapping key labels. The label
retrieval operation (H_PKS_GET_OBJECTLABELS) applies to all wrapping keys
including the default one, while the life cycle operations
(H_PKS_REVOKE_OBJECT/H_PKS_UNREVOKE_OBJECT) apply only to user-created
wrapping keys.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 Documentation/arch/powerpc/papr_hcalls.rst |  33 ++
 arch/powerpc/include/asm/hvcall.h          |   5 +-
 arch/powerpc/include/asm/plpks.h           |  15 +
 arch/powerpc/platforms/pseries/plpks.c     | 448 ++++++++++++++++++++-
 4 files changed, 497 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/powerpc/papr_hcalls.rst b/Documentation/arch/powerpc/papr_hcalls.rst
index 44c9c8b32ae3..3455b403a048 100644
--- a/Documentation/arch/powerpc/papr_hcalls.rst
+++ b/Documentation/arch/powerpc/papr_hcalls.rst
@@ -343,6 +343,39 @@ is returned to the caller.
 H_PKS_UNWRAP_OBJECT is used to unwrap an object that was previously wrapped with
 H_PKS_WRAP_OBJECT.
 
+**H_PKS_REVOKE_OBJECT**
+
+| Input: authorization, objectlabel, objectlabellen, flags
+| Out: *object policy*
+| Return Value: *H_Success, H_Function, H_State, H_Parameter, H_P2, H_P3, H_P4,
+                H_Authority, H_Not_Found, H_Busy, H_Aborted*
+
+H_PKS_REVOKE_OBJECT is used to revoke an object in Platform Keystore.
+
+
+**H_PKS_UNREVOKE_OBJECT**
+
+| Input: authorization, objectlabel, objectlabellen, flags
+| Out: *object policy*
+| Return Value: *H_Success, H_Function, H_State, H_Parameter, H_P2, H_P3, H_P4,
+                H_Authority, H_Not_Found, H_Busy, H_Aborted*
+
+H_PKS_UNREVOKE_OBJECT is used to unrevoke an object that was previously revoked
+with H_PKS_REVOKE_OBJECT in Platform Keystore.
+
+
+**H_PKS_GET_OBJECTLABELS**
+
+| Input: authorization, continueToken, out, outlen
+| Out: *continue-token, number of object labels in the returned list, object
+        label list*
+| Return Value: *H_Success, H_Function, H_State, H_Parameter, H_P2, H_P3, H_P4,
+                H_Authority, H_Busy, H_Aborted, H_Continue*
+
+H_PKS_GET_OBJECTLABELS is used to retrieve a list of object labels owned by the
+specified consumer.
+
+
 References
 ==========
 .. [1] "Power Architecture Platform Reference"
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index dff90a7d7f70..4d4c2ce1dd87 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -340,6 +340,7 @@
 #define H_PKS_GET_CONFIG	0x41C
 #define H_PKS_SET_PASSWORD	0x420
 #define H_PKS_GEN_PASSWORD	0x424
+#define H_PKS_GET_OBJECTLABELS	0x428
 #define H_PKS_WRITE_OBJECT	0x42C
 #define H_PKS_GEN_KEY		0x430
 #define H_PKS_READ_OBJECT	0x434
@@ -362,7 +363,9 @@
 #define H_GUEST_DELETE		0x488
 #define H_PKS_WRAP_OBJECT	0x490
 #define H_PKS_UNWRAP_OBJECT	0x494
-#define MAX_HCALL_OPCODE	H_PKS_UNWRAP_OBJECT
+#define H_PKS_REVOKE_OBJECT	0x4AC
+#define H_PKS_UNREVOKE_OBJECT	0x4B0
+#define MAX_HCALL_OPCODE	H_PKS_UNREVOKE_OBJECT
 
 /* Scope args for H_SCM_UNBIND_ALL */
 #define H_UNBIND_SCOPE_ALL (0x1)
diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
index 8b2ffb27db5a..c39d1f07017e 100644
--- a/arch/powerpc/include/asm/plpks.h
+++ b/arch/powerpc/include/asm/plpks.h
@@ -25,6 +25,7 @@
 #define PLPKS_SIGNEDUPDATE	PPC_BIT32(7) // Object can only be modified by signed updates
 #define PLPKS_WRAPPINGKEY	PPC_BIT32(8) // Object contains a wrapping key
 #define PLPKS_HVPROVISIONED	PPC_BIT32(28) // Hypervisor has provisioned this object
+#define PLPKS_REVOKED		PPC_BIT32(30) // Object is revoked
 
 // Signature algorithm flags from signed_update_algorithms
 #define PLPKS_ALG_RSA2048	PPC_BIT(0)
@@ -123,6 +124,20 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
 
 int plpks_unwrap_object(u8 **input_buf, u64 input_len,
 			u8 **output_buf, u64 *output_len);
+
+int plpks_revoke_wrapping_key(struct plpks_var *var);
+
+int plpks_unrevoke_wrapping_key(struct plpks_var *var);
+
+int plpks_del_wrapping_key(struct plpks_var *var);
+
+int plpks_is_wrapping_key_revoked(struct plpks_var *var);
+
+int plpks_get_object_labels(u8 **output_buf, u64 *output_len,
+			    char *comp_prefix);
+
+bool plpks_revoke_is_supported(void);
+
 #else // CONFIG_PSERIES_PLPKS
 static inline bool plpks_is_available(void) { return false; }
 static inline u16 plpks_get_passwordlen(void) { BUILD_BUG(); }
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index a7953db3f23a..edd189cfcc85 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -23,8 +23,17 @@
  */
 #define PLPKS_WRAPPING_BUF_DIFF	1024
 
+/*
+ * Maximum length for the buffer to store the retrieved object labels
+ */
+#define PLPKS_OBJLABEL_BUF_MAX	2550
+
+#define PLPKS_OBJLABEL_LEN_FIELD_SIZE	2
+#define PLPKS_OBJLABEL_PREFIX_LEN	8
+
 #define PLPKS_WRAP_INTERFACE_BIT	3
 #define PLPKS_WRAPPING_KEY_LENGTH	32
+#define PLPKS_REVOKE_INTERFACE_BIT	4
 
 #define WRAPFLAG_BE_BIT_SET(be_bit) \
 	BIT_ULL(63 - (be_bit))
@@ -46,6 +55,7 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/bitfield.h>
+#include <linux/unaligned.h>
 #include <asm/hvcall.h>
 #include <asm/machdep.h>
 #include <asm/plpks.h>
@@ -67,6 +77,7 @@ static u32 maxlargeobjectsize;
 static u64 signedupdatealgorithms;
 static u64 wrappingfeatures;
 static bool wrapsupport;
+static bool revokesupport;
 
 struct plpks_auth {
 	u8 version;
@@ -146,6 +157,9 @@ static int pseries_status_to_err(int rc)
 	case H_ABORTED:
 		err = -EIO;
 		break;
+	case H_CONTINUE:
+		err = -EAGAIN;
+		break;
 	default:
 		err = -EINVAL;
 	}
@@ -312,6 +326,7 @@ static int _plpks_get_config(void)
 	signedupdatealgorithms = be64_to_cpu(config->signedupdatealgorithms);
 	wrappingfeatures = be64_to_cpu(config->wrappingfeatures);
 	wrapsupport = config->flags & PPC_BIT8(PLPKS_WRAP_INTERFACE_BIT);
+	revokesupport = config->flags & PPC_BIT8(PLPKS_REVOKE_INTERFACE_BIT);
 
 	// Validate that the numbers we get back match the requirements of the spec
 	if (maxpwsize < 32) {
@@ -831,9 +846,6 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 	if (var->namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
-	if (var->policy & PLPKS_WRAPPINGKEY)
-		return -EPERM;
-
 	auth = construct_auth(consumer);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
@@ -903,6 +915,23 @@ bool plpks_wrapping_is_supported(void)
 }
 EXPORT_SYMBOL_GPL(plpks_wrapping_is_supported);
 
+/**
+ * plpks_revoke_is_supported() - Get the H_PKS_REVOKE_OBJECT and
+ * H_PKS_UNREVOKE_OBJECT interfaces availability status for the LPAR.
+ *
+ * Successful execution of the H_PKS_GET_CONFIG HCALL during initialization
+ * sets bit 4 of the flags variable in the PLPKS config structure if the
+ * H_PKS_REVOKE_OBJECT and H_PKS_UNREVOKE_OBJECT interfaces are supported.
+ *
+ * Returns: true if the H_PKS_REVOKE_OBJECT and H_PKS_UNREVOKE_OBJECT interfaces
+ * are supported, false if not.
+ */
+bool plpks_revoke_is_supported(void)
+{
+	return revokesupport;
+}
+EXPORT_SYMBOL_GPL(plpks_revoke_is_supported);
+
 /**
  * plpks_gen_wrapping_key() - Generate a new random key with the 'wrapping key'
  * policy set.
@@ -1189,6 +1218,419 @@ int plpks_unwrap_object(u8 **input_buf, u64 input_len, u8 **output_buf,
 }
 EXPORT_SYMBOL_GPL(plpks_unwrap_object);
 
+/**
+ * plpks_revoke_wrapping_key() - Revoke a wrapping key stored in the PLPKS.
+ * @var: variable representing the wrapping key to be revoked
+ *
+ * The H_PKS_REVOKE_OBJECT HCALL revokes an object stored in the PLPKS.
+ *
+ * Possible reasons for the returned errno values:
+ *
+ * -ENXIO	if PLPKS is not supported
+ * -EIO		if PLPKS access is blocked due to the LPAR's state
+ *		if PLPKS modification is blocked due to the LPAR's state
+ *		if an error occurred while processing the request
+ * -EINVAL	if invalid authorization parameter
+ *		if invalid wrapping key label parameter
+ *		if invalid wrapping key label length parameter
+ *		if invalid or unsupported wrapping key revoking flags
+ * -EPERM	if access is denied
+ *		if the specified wrapping key is the default wrapping key
+ * -ENOENT	if the requested wrapping key was not found
+ * -EBUSY	if unable to handle the request or long running operation
+ *		initiated, retry later.
+ *
+ * Returns: On success 0 is returned, a negative errno if not.
+ */
+int plpks_revoke_wrapping_key(struct plpks_var *var)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
+	struct plpks_auth *auth;
+	struct label *label;
+	u64 objrevokeflags = 0;
+	int rc, pseries_status;
+
+	if (!var || !var->name || !*var->name)
+		return -EINVAL;
+
+	if (!strcmp((char *)var->name, PLPKS_DEFAULT_WRAPKEY_LABEL))
+		return -EPERM;
+
+	auth = construct_auth(PLPKS_OS_OWNER);
+	if (IS_ERR(auth))
+		return PTR_ERR(auth);
+
+	label = construct_label(var->component, var->os, var->name,
+				var->namelen);
+	if (IS_ERR(label)) {
+		rc = PTR_ERR(label);
+		goto out;
+	}
+
+	rc = plpar_hcall(H_PKS_REVOKE_OBJECT, retbuf, virt_to_phys(auth),
+			 virt_to_phys(label), label->size, objrevokeflags);
+
+	pseries_status = rc;
+	rc = pseries_status_to_err(rc);
+
+	if (rc) {
+		pr_err("H_PKS_REVOKE_OBJECT failed. pseries_status=%d, rc=%d\n",
+		       pseries_status, rc);
+	}
+
+	if (!rc || (rc == -EPERM && retbuf[0]))
+		var->policy = (u32)retbuf[0];
+
+	kfree(label);
+out:
+	kfree_sensitive(auth);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(plpks_revoke_wrapping_key);
+
+/**
+ * plpks_unrevoke_wrapping_key() - Unrevoke a revoked wrapping key in the PLPKS.
+ * @var: variable representing the revoked wrapping key to be unrevoked
+ *
+ * The H_PKS_UNREVOKE_OBJECT HCALL unrevokes a revoked object stored in the
+ * PLPKS.
+ *
+ * Possible reasons for the returned errno values:
+ *
+ * -ENXIO	if PLPKS is not supported
+ * -EIO		if PLPKS access is blocked due to the LPAR's state
+ *		if PLPKS modification is blocked due to the LPAR's state
+ *		if an error occurred while processing the request
+ * -EINVAL	if invalid authorization parameter
+ *		if invalid object label parameter
+ *		if invalid object label length parameter
+ *		if invalid or unsupported object revoking flags
+ *		if the specified wrapping key is the default wrapping key
+ * -EPERM	if access is denied
+ * -ENOENT	if the requested object was not found
+ * -EBUSY	if unable to handle the request or long running operation
+ *		initiated, retry later.
+ *
+ * Returns: On success 0 is returned, a negative errno if not.
+ */
+int plpks_unrevoke_wrapping_key(struct plpks_var *var)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
+	struct plpks_auth *auth;
+	struct label *label;
+	u64 objrevokeflags = 0;
+	int rc, pseries_status;
+
+	if (!var || !var->name || !*var->name)
+		return -EINVAL;
+
+	if (!strcmp((char *)var->name, PLPKS_DEFAULT_WRAPKEY_LABEL))
+		return -EINVAL;
+
+	auth = construct_auth(PLPKS_OS_OWNER);
+	if (IS_ERR(auth))
+		return PTR_ERR(auth);
+
+	label = construct_label(var->component, var->os, var->name,
+				var->namelen);
+	if (IS_ERR(label)) {
+		rc = PTR_ERR(label);
+		goto out;
+	}
+
+	rc = plpar_hcall(H_PKS_UNREVOKE_OBJECT, retbuf,
+			 virt_to_phys(auth), virt_to_phys(label),
+			 label->size, objrevokeflags);
+
+	pseries_status = rc;
+	rc = pseries_status_to_err(rc);
+
+	if (rc)
+		pr_err("H_PKS_UNREVOKE_OBJECT failed. pseries_status=%d, rc=%d\n",
+		       pseries_status, rc);
+
+	if (!rc || (rc == -EPERM && retbuf[0]))
+		var->policy = (u32)retbuf[0];
+
+	kfree(label);
+out:
+	kfree_sensitive(auth);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(plpks_unrevoke_wrapping_key);
+
+/**
+ * plpks_is_wrapping_key_revoked() - Check if a given wrapping key has been
+ * revoked.
+ * @var: variable representing the wrapping key to be checked
+ *
+ * When the H_PKS_READ_OBJECT HCALL tries reads an object that exists but when
+ * the policy is not met, it returns H_AUTHORITY along with the 4-byte object
+ * policy. This policy is inspected to determine if the object has been revoked.
+ *
+ * Possible reasons for the returned errno values:
+ *
+ * -ENXIO	if PLPKS is not supported
+ * -EIO		if PLPKS access is blocked due to the LPAR's state
+ *		if reading a wrapping key unexpectedly succeeds
+ *		if an error occurred while processing the request
+ * -EINVAL	if invalid authorization parameter
+ *		if invalid object label parameter
+ *		if invalid object label len parameter
+ *		if invalid output data parameter
+ *		if invalid output data len parameter
+ * -EPERM	if access is denied
+ * -ENOENT	if the requested object was not found
+ * -EFBIG	if the requested object couldn't be
+ *		stored in the buffer provided
+ * -EBUSY	if unable to handle the request
+ *
+ * Returns: 1 is returned if the wrapping key has been revoked. 0 is returned if
+ *	    the wrapping key has not been revoked. Otherwise, a negative errno
+ *	    is returned.
+ */
+int plpks_is_wrapping_key_revoked(struct plpks_var *var)
+{
+	int rc;
+
+	if (!var || !var->name || !*var->name)
+		return -EINVAL;
+
+	rc = plpks_read_var(PLPKS_OS_OWNER, var);
+	if (!rc) {
+		/*
+		 * Reading a wrapping key is expected to fail with
+		 * -EPERM and return its policy.
+		 */
+		rc = -EIO;
+	} else if (rc == -EPERM) {
+		if (var->policy & PLPKS_WRAPPINGKEY) {
+			if (var->policy & PLPKS_REVOKED)
+				rc = 1;
+			else
+				rc = 0;
+		}
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(plpks_is_wrapping_key_revoked);
+
+/**
+ * plpks_del_wrapping_key() - Delete a wrapping key from the PLPKS.
+ * @var: variable representing the revoked wrapping key to be deleted
+ *
+ * The plpks_remove_var function removes the specified variable and its data
+ * from the PLPKS by invoking the H_PKS_REMOVE_OBJECT HCALL.
+ *
+ * Possible reasons for the returned errno values:
+ *
+ * -ENXIO	if PLPKS is not supported
+ * -EIO		if PLPKS access is blocked due to the LPAR's state
+ *		if PLPKS modification is blocked due to the LPAR's state
+ *		if an error occurred while processing the request
+ * -EINVAL	if invalid authorization parameter
+ *		if invalid object label parameter
+ *		if invalid object label len parameter
+ * -EPERM	if access is denied
+ *		if the specified wrapping key is the default wrapping key
+ *		if the specified wrapping key has not been revoked
+ * -ENOENT	if the requested object was not found
+ * -EBUSY	if unable to handle the request
+ *
+ * Returns: On success 0 is returned, a negative errno if not.
+ */
+int plpks_del_wrapping_key(struct plpks_var *var)
+{
+	int rc;
+	struct plpks_var_name vname;
+
+	if (!var || !var->name || !*var->name)
+		return -EINVAL;
+
+	if (!strcmp((char *)var->name, PLPKS_DEFAULT_WRAPKEY_LABEL))
+		return -EPERM;
+
+	rc = plpks_is_wrapping_key_revoked(var);
+	if (rc == 1) {
+		vname = (struct plpks_var_name) {
+			.name = var->name,
+			.namelen = var->namelen
+		};
+
+		rc = plpks_remove_var(PLPKS_WRAPKEY_COMPONENT, var->os,
+				      vname);
+		if (rc)
+			pr_err("deletion of <%s> failed. rc=%d\n",
+			       (char *)var->name, rc);
+	} else if (!rc) {
+		pr_err("revoke <%s> before deletion\n", (char *)var->name);
+		rc = -EPERM;
+	} else {
+		pr_err("revocation status check failed for <%s>. rc = %d\n",
+		       (char *)var->name, rc);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(plpks_del_wrapping_key);
+
+/**
+ * plpks_get_object_labels() - retrieve a list of object labels for the objects
+ * stored in the PLPKS
+ * @output_buf: buffer to store the retrieved object labels
+ * @output_len: number of object labels retrieved
+ * @comp_prefix: component prefix string
+ *
+ * The H_PKS_GET_OBJECTLABELS HCALL retrieves a list of object labels for the
+ * objects with the given component prefix stored in the PLPKS.
+ *
+ * Possible reasons for the returned errno values:
+ *
+ * -ENXIO	if PLPKS is not supported
+ * -EIO		if PLPKS access is blocked due to the LPAR's state
+ *		if PLPKS modification is blocked due to the LPAR's state
+ *		if an error occurred while processing the request
+ * -EINVAL	if invalid authorization parameter
+ *		if invalid output buffer parameter
+ *		if invalid output buffer length parameter
+ *		if invalid continue token parameter
+ *		if the provided component prefix is NULL
+ * -EPERM	if access is denied
+ * -EBUSY	if unable to handle the request or long running operation
+ *		initiated, retry later.
+ *
+ * Returns: On success 0 is returned, a negative errno if not.
+ */
+int plpks_get_object_labels(u8 **output_buf, u64 *output_len,
+			    char *comp_prefix)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
+	u8 *labels_buf = NULL;
+	u8 *tmp_buf = NULL;
+	struct plpks_auth *auth;
+	struct label_attr *metadata = NULL;
+	u16 label_len;
+	u64 labels_count;
+	u64 continuetoken = 0, output_buf_len = 0;
+	int rc, pseries_status;
+	size_t labels_buf_offset = 0, output_buf_offset = 0;
+	size_t obj_label_entry_size, i;
+
+	*output_buf = NULL;
+	*output_len = 0;
+
+	if (!comp_prefix)
+		return -EINVAL;
+
+	auth = construct_auth(PLPKS_OS_OWNER);
+	if (IS_ERR(auth))
+		return PTR_ERR(auth);
+
+	do {
+		labels_buf =
+			kzalloc(roundup_pow_of_two(PLPKS_OBJLABEL_BUF_MAX),
+				GFP_KERNEL);
+
+		if (!labels_buf) {
+			rc = -ENOMEM;
+			goto out_free_output_buf;
+		}
+
+		rc = plpar_hcall(H_PKS_GET_OBJECTLABELS, retbuf,
+				 virt_to_phys(auth), continuetoken,
+				 virt_to_phys(labels_buf),
+				 roundup_pow_of_two(PLPKS_OBJLABEL_BUF_MAX));
+
+		pseries_status = rc;
+		rc = pseries_status_to_err(rc);
+
+		if (rc && rc != -EAGAIN) {
+			pr_err("H_PKS_GET_OBJECTLABELS failed. pseries_status=%d rc=%d\n",
+			       pseries_status, rc);
+			goto out_free_labels_buf;
+		} else {
+			/*
+			 * Setting an incorrect countinuetoken upon
+			 * receiving H_CONTINUE would result in H_P2. Since
+			 * the continuetoken is being set to the expected
+			 * value from the previous call, H_P2 must not be
+			 * returned.
+			 */
+			continuetoken = retbuf[1];
+
+			labels_count = retbuf[0];
+			if (!labels_count) {
+				kfree(labels_buf);
+				labels_buf = NULL;
+				goto out;
+			}
+
+			/*
+			 * Filter out object labels that don't have the provided
+			 * component prefix.
+			 */
+
+			output_buf_len +=
+				roundup_pow_of_two(PLPKS_OBJLABEL_BUF_MAX);
+
+			tmp_buf = krealloc(*output_buf, output_buf_len,
+					   GFP_KERNEL);
+
+			if (!tmp_buf) {
+				rc = -ENOMEM;
+				goto out_free_labels_buf;
+			}
+
+			*output_buf = tmp_buf;
+
+			for (i = 0; i < labels_count; ++i) {
+				label_len =
+					get_unaligned_be16(labels_buf +
+							   labels_buf_offset);
+
+				obj_label_entry_size =
+					PLPKS_OBJLABEL_LEN_FIELD_SIZE +
+					label_len;
+
+				metadata =
+					(struct label_attr *)(labels_buf +
+					labels_buf_offset +
+					PLPKS_OBJLABEL_LEN_FIELD_SIZE);
+
+				if (!memcmp(metadata->prefix, comp_prefix,
+					    PLPKS_OBJLABEL_PREFIX_LEN)) {
+					memcpy(*output_buf + output_buf_offset,
+					       labels_buf + labels_buf_offset,
+					       obj_label_entry_size);
+
+					output_buf_offset +=
+						obj_label_entry_size;
+					(*output_len) += 1;
+				}
+				labels_buf_offset += obj_label_entry_size;
+			}
+			kfree(labels_buf);
+			labels_buf = NULL;
+			labels_buf_offset = 0;
+		}
+	} while (rc == -EAGAIN);
+
+	goto out;
+
+out_free_labels_buf:
+	kfree(labels_buf);
+	labels_buf = NULL;
+out_free_output_buf:
+	kfree(*output_buf);
+	*output_buf = NULL;
+	*output_len = 0;
+out:
+	kfree_sensitive(auth);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(plpks_get_object_labels);
+
 /**
  * plpks_read_os_var() - Fetch the data for the specified variable that is owned
  * by the OS consumer.
-- 
2.52.0


