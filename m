Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ECB606D813
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fSFtT+jP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL4pV1jmTz2yGT;
	Fri, 06 Nov 2026 01:44:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793889890;
	cv=none; b=ebNYcYs6wN/AFD0zG+RVFGY9cpIADtPIjlLcixHukyH1f3plojpkFtidVUcVuX4dP+Lb5OKnTe+UUolFCXw51i4QKL8sjFuxfz3LzFqYvIP+z3M8ijEahOHM9utCN21hgbzBmNjqcwrHKnk6aqxChwTewr4GjxNVE6v+YqKLUGlnstqzOCfzKuDlSDCTqJbNreqIzhMsytc+Hfe8ocKIz1+/z5Q71kjx/irhWzN4zcW3rxzu/zrWF9MKa6yrUnr+TdnOkHBNctz97Awn2RWFpjp0HeXYJjKOnOIYgz0Ccm+bnG2DgcgbWDbxjPSYEINqiuD0/ODWoAFF300XuGAxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793889890; c=relaxed/relaxed;
	bh=b3PZxN+t5NXyBIRpvFunQzhczkCyr6AWuwaW+bi7cdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjFYTUvP+9nooBr+o49RO7spPIfepMHtWmqCo/rhwFc1XfBv4DKmk2PjdqQ3jDMjGX3QBrffvCYbTJczN9E4iTIEA78V1Ky01SoS8THosZH+9nhiSe/CmgfrqoCscWUnGSThCbqjCpbg0YHYld8L8K0opnsIgnJsdOc/HL67K2YhhBPNgyoY/1Hd8vqXI78orkMLLdpiAO41cw3V3nM7hoFmx7ZDbVnHHdcJO5kNW/klUfrwx7Ho1ea7iaq6q8XgMKTKC01hsL9YjiqHtmUPIN9NBQccsMdpCYe/wPrGM1MF+XPNqw+dD9LULDUtATXQUvOAy8PT+gSL/nD9r6n8eQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fSFtT+jP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fSFtT+jP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL4pS74Mwz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 01:44:48 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EiEmM4018413;
	Thu, 5 Nov 2026 14:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=b3PZxN+t5NXyBIRpv
	FunQzhczkCyr6AWuwaW+bi7cdY=; b=fSFtT+jPjALSHXtHp6OBdKTIr1tsEX38n
	5E9eUBEtoAqrJqTGps7U7kOLcwUXuxOhZ6LcB2abnFXQTFkFNHAJCr/BLZIYva1F
	xDNL54x2soTF+xj1N5NweeXwIl2CEfjrS/hPlwEZqdQrHoDsHTOcdkmQS7mvOehX
	LZiNhnmDw4EkGvlPciUkWNDEV9nxKGhac9DlNusoNbRnZSsM/G9kn0Dn7xsXQleu
	Ym2HhZhnkKYVcouYyaL3TTpEX4PPAVS5Mcdny1yGekdJzvyhSsWGhRVbf4PP2v0C
	vhU14mUdkeuWYQZS0sP8dHbitLoX1dN9e/uNWdawl8gUMtu6W5DFA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3txmt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:44:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EZ0GI1829838;
	Thu, 5 Nov 2026 14:44:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7kxfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:44:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5EiUnr48890206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 14:44:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B07112005A;
	Thu,  5 Nov 2026 14:44:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C4852004B;
	Thu,  5 Nov 2026 14:44:22 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.70.234])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 14:44:22 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v6 7/9] pseries/plpks: add HCALLs for PKWM wrapping key life cycle management
Date: Thu,  5 Nov 2026 20:13:18 +0530
Message-ID: <20261105144320.357260-8-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105144320.357260-1-ssrish@linux.ibm.com>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6aec9654 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=_NBI02lyZyL55jlE1CsA:9
 a=nI5ohH7EWcweQLtP:21
X-Proofpoint-ORIG-GUID: c1NTjhRD77E2wLm7BSKLES-cgFA6ArfC
X-Proofpoint-GUID: 3FWuM7_vKsI_HE3GYXpkvNlxmYFe4FLR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfX8UqnaYoEAOG9
 lI/7e754aJ0GAArBXLhz6GjtN5jH9KORBxUwluYGD0nCqhBHxbJcEEVV+P5mTYdZI1pZCjH2gin
 vbo59Km/7U6lR99p3KaQIcU+/l4ubnL8MQMeKo77vXzsK80UmP37/4wGmfkGyhkSipbAbAEhmah
 pnF9gT45z1a38skioI+VH1QHJVLtUMMhB6tfVmH/XUI1YW6xovLlbYk51ebCQgUlKu5gBVf4/pR
 Gkxi3KN18NgxgI2GmCd6/MjI7YUBm2Q6BNvmvMxLIEtMw70IpHB0pTrNmVmShaFgp4jYuUJUzV5
 /3ftN1KjC28O0pTLE9XFmDQF2OXZ2WXA2aNde4/Htg/Kg/yvnqVh5it/SKRAmExvhpGIBlSD1qA
 8nB7hIf3GADQG7cms4mjNjN1FwKrP7CaxyIyzBph85f7PNIM3Xky5Q6sg4IjsH8rsBhAqsrZwZJ
 SY8SJmWISzePyVb2I1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfX+HC/VAYlyqfC
 BSJdRdFyLJpTRzbUYisqCFwQGxYBVNaAid+9NhScv7r62FhF8429D1VrFmPnmQohqQYpd8XOjZv
 9EgatG++niZtd/JxiWWRILYKWMEKdpA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050058
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
 Documentation/arch/powerpc/papr_hcalls.rst |  33 ++
 arch/powerpc/include/asm/hvcall.h          |   5 +-
 arch/powerpc/include/asm/plpks.h           |  15 +
 arch/powerpc/platforms/pseries/plpks.c     | 489 ++++++++++++++++++++-
 4 files changed, 538 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/powerpc/papr_hcalls.rst b/Documentation/arch/powerpc/papr_hcalls.rst
index 44c9c8b32ae3..776ceb8cc54e 100644
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
+| Out: *number of object labels in the returned list, continue-token, object
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
index 8b2ffb27db5a..707c9ce14365 100644
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
+int plpks_is_wrapping_key_revoked(const struct plpks_var *var);
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
index d5adc563f71f..6e10bd6a9a48 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -26,8 +26,20 @@
 #define PLPKS_MAX_WRAPPED_OBJECT_SIZE	\
 	(PLPKS_MAX_WRAPPING_INPUT_SIZE + PLPKS_WRAPPING_BUF_DIFF)
 
+/*
+ * Base buffer size for ten maximum-sized object labels.
+ * The allocation size is rounded up to a power of two.
+ */
+#define PLPKS_OBJLABEL_BUF_BASE_SIZE	2570
+#define PLPKS_OBJLABEL_BUF_SIZE	\
+	roundup_pow_of_two(PLPKS_OBJLABEL_BUF_BASE_SIZE)
+
+#define PLPKS_OBJLABEL_LEN_FIELD_SIZE	2
+#define PLPKS_OBJLABEL_PREFIX_LEN	8
+
 #define PLPKS_WRAP_INTERFACE_BIT	3
 #define PLPKS_WRAPPING_KEY_LENGTH	32
+#define PLPKS_REVOKE_INTERFACE_BIT	4
 
 #define WRAPFLAG_BE_BIT_SET(be_bit) \
 	BIT_ULL(63 - (be_bit))
@@ -49,6 +61,7 @@
 #include <linux/libfdt.h>
 #include <linux/memblock.h>
 #include <linux/bitfield.h>
+#include <linux/unaligned.h>
 #include <asm/hvcall.h>
 #include <asm/machdep.h>
 #include <asm/plpks.h>
@@ -70,6 +83,7 @@ static u32 maxlargeobjectsize;
 static u64 signedupdatealgorithms;
 static u64 wrappingfeatures;
 static bool wrapsupport;
+static bool revokesupport;
 
 struct plpks_auth {
 	u8 version;
@@ -149,6 +163,9 @@ static int pseries_status_to_err(int rc)
 	case H_ABORTED:
 		err = -EIO;
 		break;
+	case H_CONTINUE:
+		err = -EAGAIN;
+		break;
 	default:
 		err = -EINVAL;
 	}
@@ -315,6 +332,7 @@ static int _plpks_get_config(void)
 	signedupdatealgorithms = be64_to_cpu(config->signedupdatealgorithms);
 	wrappingfeatures = be64_to_cpu(config->wrappingfeatures);
 	wrapsupport = config->flags & PPC_BIT8(PLPKS_WRAP_INTERFACE_BIT);
+	revokesupport = config->flags & PPC_BIT8(PLPKS_REVOKE_INTERFACE_BIT);
 
 	// Validate that the numbers we get back match the requirements of the spec
 	if (maxpwsize < 32) {
@@ -838,9 +856,6 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 	if (var->namelen > PLPKS_MAX_NAME_SIZE)
 		return -EINVAL;
 
-	if (var->policy & PLPKS_WRAPPINGKEY)
-		return -EPERM;
-
 	auth = construct_auth(consumer);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
@@ -910,6 +925,23 @@ bool plpks_wrapping_is_supported(void)
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
@@ -1205,6 +1237,457 @@ int plpks_unwrap_object(u8 **input_buf, u64 input_len, u8 **output_buf,
 }
 EXPORT_SYMBOL_GPL(plpks_unwrap_object);
 
+static bool plpks_is_default_wrapkey(const struct plpks_var *var)
+{
+	return var->namelen == sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1 &&
+	       !memcmp(var->name, PLPKS_DEFAULT_WRAPKEY_LABEL, var->namelen);
+}
+
+/**
+ * plpks_revoke_wrapping_key() - Revoke a wrapping key stored in the PLPKS.
+ * @var: variable representing the wrapping key to be revoked
+ *
+ * The H_PKS_REVOKE_OBJECT HCALL revokes an object stored in the PLPKS.
+ *
+ * Possible reasons for the returned errno values:
+ *
+ * -ENXIO	if PLPKS is not supported
+ *		if the {un}revoke interfaces are not supported
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
+	if (!var || !var->name || !var->namelen)
+		return -EINVAL;
+
+	if (!plpks_revoke_is_supported())
+		return -ENXIO;
+
+	if (plpks_is_default_wrapkey(var))
+		return -EPERM;
+
+	auth = construct_auth(PLPKS_OS_OWNER);
+	if (IS_ERR(auth))
+		return PTR_ERR(auth);
+
+	label = construct_label(PLPKS_WRAPKEY_COMPONENT, var->os, var->name,
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
+ *		if the {un}revoke interfaces are not supported
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
+	if (!var || !var->name || !var->namelen)
+		return -EINVAL;
+
+	if (!plpks_revoke_is_supported())
+		return -ENXIO;
+
+	if (plpks_is_default_wrapkey(var))
+		return -EINVAL;
+
+	auth = construct_auth(PLPKS_OS_OWNER);
+	if (IS_ERR(auth))
+		return PTR_ERR(auth);
+
+	label = construct_label(PLPKS_WRAPKEY_COMPONENT, var->os, var->name,
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
+int plpks_is_wrapping_key_revoked(const struct plpks_var *var)
+{
+	struct plpks_var read_var = { 0 };
+	int rc;
+
+	if (!var || !var->name || !var->namelen)
+		return -EINVAL;
+
+	read_var.component = PLPKS_WRAPKEY_COMPONENT;
+	read_var.name = var->name;
+	read_var.namelen = var->namelen;
+	read_var.os = var->os;
+
+	rc = plpks_read_var(PLPKS_OS_OWNER, &read_var);
+	if (!rc) {
+		/*
+		 * Reading a wrapping key is expected to fail with
+		 * -EPERM and return its policy.
+		 */
+		rc = -EIO;
+	} else if (rc == -EPERM) {
+		if (read_var.policy & PLPKS_WRAPPINGKEY) {
+			if (read_var.policy & PLPKS_REVOKED)
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
+	if (!var || !var->name || !var->namelen)
+		return -EINVAL;
+
+	if (plpks_is_default_wrapkey(var))
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
+			pr_err("deletion of <%.*s> failed. rc=%d\n",
+			       var->namelen, (char *)var->name, rc);
+	} else if (!rc) {
+		pr_err("revoke <%.*s> before deletion\n", var->namelen,
+		       (char *)var->name);
+		rc = -EPERM;
+	} else {
+		pr_err("revocation status check failed for <%.*s>. rc = %d\n",
+		       var->namelen, (char *)var->name, rc);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(plpks_del_wrapping_key);
+
+/**
+ * plpks_get_object_labels() - retrieve a list of object labels for the objects
+ * stored in the PLPKS
+ * @output_buf: buffer to be allocated to store the retrieved object labels, to
+ * be freed by the caller
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
+	u8 prefix[PLPKS_OBJLABEL_PREFIX_LEN];
+	u16 label_len;
+	u64 labels_count;
+	u64 continuetoken = 0, output_buf_len = 0;
+	int rc, pseries_status;
+	size_t labels_buf_offset = 0, output_buf_offset = 0;
+	size_t obj_label_entry_size, i;
+
+	if (!output_buf || !output_len || !comp_prefix)
+		return -EINVAL;
+
+	*output_buf = NULL;
+	*output_len = 0;
+
+	memset(prefix, 0, sizeof(prefix));
+	memcpy(prefix, comp_prefix, strnlen(comp_prefix, sizeof(prefix)));
+
+	auth = construct_auth(PLPKS_OS_OWNER);
+	if (IS_ERR(auth))
+		return PTR_ERR(auth);
+
+	do {
+		labels_buf =
+			kzalloc(PLPKS_OBJLABEL_BUF_SIZE, GFP_KERNEL);
+
+		if (!labels_buf) {
+			rc = -ENOMEM;
+			goto out_free_output_buf;
+		}
+
+		rc = plpar_hcall(H_PKS_GET_OBJECTLABELS, retbuf,
+				 virt_to_phys(auth), continuetoken,
+				 virt_to_phys(labels_buf),
+				 PLPKS_OBJLABEL_BUF_SIZE);
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
+			output_buf_len += PLPKS_OBJLABEL_BUF_SIZE;
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
+				if (labels_buf_offset +
+				    PLPKS_OBJLABEL_LEN_FIELD_SIZE >
+				    PLPKS_OBJLABEL_BUF_SIZE) {
+					rc = -EIO;
+					goto out_free_labels_buf;
+				}
+
+				label_len =
+					get_unaligned_be16(labels_buf +
+							   labels_buf_offset);
+
+				obj_label_entry_size =
+					PLPKS_OBJLABEL_LEN_FIELD_SIZE +
+					label_len;
+
+				if (label_len < sizeof(struct label_attr) ||
+				    labels_buf_offset + obj_label_entry_size >
+				    PLPKS_OBJLABEL_BUF_SIZE) {
+					rc = -EIO;
+					goto out_free_labels_buf;
+				}
+
+				metadata =
+					(struct label_attr *)(labels_buf +
+					labels_buf_offset +
+					PLPKS_OBJLABEL_LEN_FIELD_SIZE);
+
+				if (!memcmp(metadata->prefix, prefix,
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


