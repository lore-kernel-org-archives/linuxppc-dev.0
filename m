Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD81606A32F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=l050pwTf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL5Vs6fJVz2xN4;
	Fri, 06 Nov 2026 02:16:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793891781;
	cv=none; b=YW9vJWQ71z9Dhw2l2nhi69tdvb9PqJDSSyXiqiFbK+jf/u4CanZ4a1KXkASQe0nhPr4hS1ZfXUEEfgKV4fpp6rI17iRgREsYvP3QY9+G1XZajdneKfe7Wj0zXYxHqHExF7eKBxeO4iRsxvr2f8/1vZPeEKK3cwHTG8NA8U7cqB3DZnK7BZ2GhR+wqcGO4vmd1zcGSGDBNx+nUhLuVlcf4mWILPSrNdAPCk6IAhPW+5uGTwQVzFaopNJPZz/uphzh/nikgNlrcdJlWMpXCQVyff+y6clfE+rnC0CJ/JUG9g1+rJJu0Rj/ndpS0eGbUrQ1PM5b7MNgwTodzErRbK7r9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793891781; c=relaxed/relaxed;
	bh=AMM6MlFhYKn7QV3i6pktOBApqzUfs2lmVsymazaqEt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKqzt/4nedMmlmecZQil5mwj0pJzsT4YspXo1j/BzR7JllBY/z3X8mIShW86TcniimYHUkVFqmQXNPPQkJ/Kh5Ggp2WxPpoOk2qCEK0agfSsdxYA5CJFpPHZXUd4CMBEXTmOZvFEkaJwPT2wtNkfSw5k2wbcVR7BfJX82o605R5voYJHmN3H3cNLiUp4AzcDoSC/xXVxWzRYLR4hq1G/AF5j29FRz6M8zygN/seG/FDz+B0eWRrFiop3mNxHAJfzZvDSIkQj1RJaWb6gDkm65xxcXk8SH26diLMzPnNB11gy9y/couMwLdZlH7E/PDwV7e7BbF7wzO4lBbzmYokI+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=l050pwTf; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=l050pwTf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL5Vq28Fjz2x9c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 02:16:18 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EiN7x3734858;
	Thu, 5 Nov 2026 14:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AMM6MlFhYKn7QV3i6
	pktOBApqzUfs2lmVsymazaqEt8=; b=l050pwTfuYV68o+RoEdprmg8cgjjzEjmh
	/JZWY7+Z2nCH2pBlLgGxx6BOqwlU1s8Uc3G3IuN6dBLVELejs12Qq46fB6kFMtDQ
	ZCR0vfbTssnZ59IK4/6ucFrMdf1emZu52WHy/rlkytKHRVBCZ44+4OWmFpJAgIS5
	ecaZ4MyK38zcPx4VVNpLoJOua4MPKhaF8/Ysnjc0x3kyQ4+0G+b4iHUIhMIwkxWK
	10KdkXl4wmb9gKMoRFiOfSYWTbxdApjp5+mBHqj60qxGY3BM76pu/SMlu4KW2GGh
	IEXmOJCEe2LYS2H2Nl1C4uy+GJbMpb+BEdNwWRM2DpH7RCN5vIfVA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rj2mu2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:44:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EYuFB1746150;
	Thu, 5 Nov 2026 14:44:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9mjfc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:44:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5Eicpp30540102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 14:44:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94D3E2004B;
	Thu,  5 Nov 2026 14:44:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56D1A2005A;
	Thu,  5 Nov 2026 14:44:32 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.70.234])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 14:44:31 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v6 8/9] keys/trusted_keys: enable PKWM wrapping key selection by label
Date: Thu,  5 Nov 2026 20:13:19 +0530
Message-ID: <20261105144320.357260-9-ssrish@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: iXe32G4pIyVtxR4o59QcOjiDu3LxbrOX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfXzJyNEzB2t/TB
 2wHq8JsimPZRZ2nLh6fpOMAr+6kDbplkJ5RQSiEU3Mti7nc/9cVkgeUbyfjIg7/9NFLtMwyWRLh
 CSAg/nYLBvj30HQhtw/Lc+xNfbP3ZuI=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6aec965b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=_1a9KapSLEuvdD3BKzMA:9
 a=mGxJDu7xY38OflIk:21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfXwOLVdnMSrqJw
 YWndOqc/XkNRXt+41V93h7zeBzhuElBXl1D3oD/J7iCoT/6YxaP2eH9oDkYq3cpV7dxNXAIhiS2
 o416Z+c68Siogl0FvWgvBDYdgNkDf5Fpi8Z+NSTIR4w8cz/zCof2TlPi4ysPsWd6fymcny81wPz
 2q5CVE9U9oGAhiVOmFh1/eT10bGkaUuhl2jALMszKMQWqmNXaoeuapMzC0RFsZ+ZzkcBbvPHXjR
 s6JX9WD1QDEUJPAa5DRAL0N/yml2LgF2VnPg5GnDo7SK0xjIzedhStcnVJI83FaQPUMQZRS5JAD
 BLh+xoCfYpg2dKGEIg8Ud61Ccc81D5h8t8EM+iyQBSP0mZtdvEASpsngFIJaQrkb9/mHm11LCeA
 3sVNSoJmqXq41+ysFVe8vy1B/5x3jNhy5dAAHs7m1hNhTMwfKP4jlVZ2LXAO3okR94etijJ9gHy
 9ZoLqkQFGFAb0Gujz2w==
X-Proofpoint-GUID: 0SFdVe1DRhnRmSaAtQn7uZItkRO8-E6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050058
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PKWM trusted source currently uses the default wrapping key for all
seal and unseal operations. However, PKWM supports multiple wrapping keys,
enabling better isolation between trusted keys.

Allow users to provide an active wrapping key of their choice created
through sysfs when sealing trusted keys through a new wrapping_key=<label>
option. If no label is specified, the default wrapping key is used for
sealing.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 .../security/keys/trusted-encrypted.rst       |  4 +-
 arch/powerpc/include/asm/plpks.h              | 10 ++++-
 arch/powerpc/platforms/pseries/plpks.c        | 42 ++++++++-----------
 include/keys/trusted_pkwm.h                   |  3 ++
 security/keys/trusted-keys/trusted_pkwm.c     | 38 +++++++++++++++--
 5 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index ddff7c7c2582..76fda28fddb1 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -83,7 +83,7 @@ safe.
 
      (5) PKWM (PowerVM Key Wrapping Module: IBM PowerVM + Platform KeyStore)
 
-         Rooted to a unique, per-LPAR key, which is derived from a system-wide,
+         Rooted to unique, per-LPAR keys, which are derived from a system-wide,
          randomly generated LPAR root key. Both the per-LPAR keys and the LPAR
          root key are stored in hypervisor-owned secure memory at runtime,
          and the LPAR root key is additionally persisted in secure locations
@@ -366,6 +366,8 @@ Usage::
                        0x01: require secure boot to be in either audit or
                              enforced mode
                        0x02: require secure boot to be in enforced mode
+       wrapping_key= optional wrapping key label as a string. The default
+                     wrapping key is used when no label is provided.
 
 "keyctl print" returns an ASCII hex copy of the sealed key, which is in format
 specific to PKWM key-blob implementation.  The key length for new keys is
diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
index 707c9ce14365..abf8a71cf3f2 100644
--- a/arch/powerpc/include/asm/plpks.h
+++ b/arch/powerpc/include/asm/plpks.h
@@ -50,6 +50,12 @@
 #define PLPKS_MAX_TIMEOUT		(5 * USEC_PER_SEC)
 #define PLPKS_FLUSH_SLEEP		10000 // usec
 
+// Label for the PKWM default wrapping key
+#define PLPKS_DEFAULT_WRAPKEY_LABEL	"default-wrapping-key"
+
+// Component for a PKWM wrapping key
+#define PLPKS_WRAPKEY_COMPONENT	"PLPKSWR"
+
 struct plpks_var {
 	char *component;
 	u8 *name;
@@ -117,10 +123,10 @@ int plpks_config_create_softlink(struct kobject *from);
 
 bool plpks_wrapping_is_supported(void);
 
-int plpks_gen_wrapping_key(void);
+int plpks_gen_wrapping_key(struct plpks_var *var);
 
 int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
-		      u8 **output_buf, u64 *output_len);
+		      u8 **output_buf, u64 *output_len, struct plpks_var *var);
 
 int plpks_unwrap_object(u8 **input_buf, u64 input_len,
 			u8 **output_buf, u64 *output_len);
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 6e10bd6a9a48..df144accd223 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -9,9 +9,6 @@
 
 #define pr_fmt(fmt) "plpks: " fmt
 
-#define PLPKS_WRAPKEY_COMPONENT	"PLPKSWR"
-#define PLPKS_DEFAULT_WRAPKEY_LABEL	"default-wrapping-key"
-
 /*
  * To 4K align the {input, output} buffers to the {UN}WRAP H_CALLs
  */
@@ -945,6 +942,7 @@ EXPORT_SYMBOL_GPL(plpks_revoke_is_supported);
 /**
  * plpks_gen_wrapping_key() - Generate a new random key with the 'wrapping key'
  * policy set.
+ * @var: variable representing the wrapping key to be created
  *
  * The H_PKS_GEN_KEY HCALL makes the hypervisor generate a new random key and
  * store the key in a PLPKS object with the provided object label. With the
@@ -971,25 +969,22 @@ EXPORT_SYMBOL_GPL(plpks_revoke_is_supported);
  *
  * Returns: On success 0 is returned, a negative errno if not.
  */
-int plpks_gen_wrapping_key(void)
+int plpks_gen_wrapping_key(struct plpks_var *var)
 {
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
 	struct label *label;
 	int rc, pseries_status;
-	struct plpks_var var = {
-		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
-		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
-		.policy = PLPKS_WRAPPINGKEY,
-		.os = PLPKS_VAR_LINUX,
-		.component = PLPKS_WRAPKEY_COMPONENT
-	};
+
+	if (!var || !var->name || !var->namelen)
+		return -EINVAL;
 
 	auth = construct_auth(PLPKS_OS_OWNER);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
 
-	label = construct_label(var.component, var.os, var.name, var.namelen);
+	label = construct_label(PLPKS_WRAPKEY_COMPONENT, var->os, var->name,
+				var->namelen);
 	if (IS_ERR(label)) {
 		rc = PTR_ERR(label);
 		goto out;
@@ -997,7 +992,7 @@ int plpks_gen_wrapping_key(void)
 
 	rc = plpar_hcall(H_PKS_GEN_KEY, retbuf,
 			 virt_to_phys(auth), virt_to_phys(label),
-			 label->size, var.policy,
+			 label->size, PLPKS_WRAPPINGKEY,
 			 NULL, PLPKS_WRAPPING_KEY_LENGTH);
 
 	if (!rc) {
@@ -1009,8 +1004,6 @@ int plpks_gen_wrapping_key(void)
 		if (rc != -EEXIST)
 			pr_err("H_PKS_GEN_KEY failed. pseries_status=%d, rc=%d",
 			       pseries_status, rc);
-		else
-			rc = 0;
 	}
 
 	kfree(label);
@@ -1021,13 +1014,14 @@ int plpks_gen_wrapping_key(void)
 EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
 
 /**
- * plpks_wrap_object() - Wrap an object using the default wrapping key stored in
+ * plpks_wrap_object() - Wrap an object using the specified wrapping key stored
  * the PLPKS.
  * @input_buf: buffer containing the data to be wrapped
  * @input_len: length of the input buffer (non-zero, at most 32KB)
  * @wrap_flags: object wrapping flags
  * @output_buf: buffer to store the wrapped data
  * @output_len: length of the output buffer
+ * @var: variable representing the wrapping key to be used
  *
  * The H_PKS_WRAP_OBJECT HCALL wraps an object using a wrapping key stored in
  * the PLPKS and returns the wrapped object to the caller. The caller provides a
@@ -1062,7 +1056,7 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
  * Returns: On success 0 is returned, a negative errno if not.
  */
 int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
-		      u8 **output_buf, u64 *output_len)
+		      u8 **output_buf, u64 *output_len, struct plpks_var *var)
 {
 	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
@@ -1072,12 +1066,9 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
 	int rc = 0, pseries_status = 0;
 	bool sb_audit_or_enforce_bit = wrap_flags & BIT(0);
 	bool sb_enforce_bit = wrap_flags & BIT(1);
-	struct plpks_var var = {
-		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
-		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
-		.os = PLPKS_VAR_LINUX,
-		.component = PLPKS_WRAPKEY_COMPONENT
-	};
+
+	if (!var || !var->name || !var->namelen)
+		return -EINVAL;
 
 	if (!input_len || input_len > PLPKS_MAX_WRAPPING_INPUT_SIZE)
 		return -EINVAL;
@@ -1086,7 +1077,8 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
 
-	label = construct_label(var.component, var.os, var.name, var.namelen);
+	label = construct_label(PLPKS_WRAPKEY_COMPONENT, var->os, var->name,
+				var->namelen);
 	if (IS_ERR(label)) {
 		rc = PTR_ERR(label);
 		goto out;
@@ -1149,7 +1141,7 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
 EXPORT_SYMBOL_GPL(plpks_wrap_object);
 
 /**
- * plpks_unwrap_object() - Unwrap an object using the default wrapping key
+ * plpks_unwrap_object() - Unwrap an object using its associated wrapping key
  * stored in the PLPKS.
  * @input_buf: buffer containing the data to be unwrapped
  * @input_len: length of the input buffer (more than 1KB, at most 33KB)
diff --git a/include/keys/trusted_pkwm.h b/include/keys/trusted_pkwm.h
index 4035b9776394..53a5f780edd2 100644
--- a/include/keys/trusted_pkwm.h
+++ b/include/keys/trusted_pkwm.h
@@ -6,10 +6,13 @@
 #include <linux/bitops.h>
 #include <linux/printk.h>
 
+#define WRAPPING_KEY_LABEL_LEN_MAX	239
+
 extern struct trusted_key_ops pkwm_trusted_key_ops;
 
 struct trusted_pkwm_options {
 	u16 wrap_flags;
+	unsigned char wrapping_key_label[WRAPPING_KEY_LABEL_LEN_MAX + 1];
 };
 
 static inline void dump_options(struct trusted_key_options *o)
diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index b5c3d17be475..c44b50d68d4c 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -13,10 +13,12 @@
 enum {
 	Opt_err,
 	Opt_wrap_flags,
+	Opt_wrapping_key_label,
 };
 
 static const match_table_t key_tokens = {
 	{Opt_wrap_flags, "wrap_flags=%s"},
+	{Opt_wrapping_key_label, "wrapping_key=%s"},
 	{Opt_err, NULL}
 };
 
@@ -50,6 +52,12 @@ static int getoptions(char *datablob, struct trusted_key_options *opt)
 				return -EINVAL;
 			pkwm->wrap_flags = wrap_flags;
 			break;
+		case Opt_wrapping_key_label:
+			if (strlen(args[0].from) > WRAPPING_KEY_LABEL_LEN_MAX)
+				return -EINVAL;
+			strscpy(pkwm->wrapping_key_label, args[0].from,
+				sizeof(pkwm->wrapping_key_label));
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -83,6 +91,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 	struct trusted_key_options *options = NULL;
 	struct trusted_pkwm_options *pkwm = NULL;
 	u8 *input_buf, *output_buf = NULL;
+	struct plpks_var var = { 0 };
 	u64 output_len, input_len;
 	int rc;
 
@@ -108,8 +117,18 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 
 	pkwm = options->private;
 
+	if (pkwm->wrapping_key_label[0]) {
+		var.name = (u8 *)pkwm->wrapping_key_label;
+		var.namelen = strlen(pkwm->wrapping_key_label);
+	} else {
+		var.name = (u8 *)PLPKS_DEFAULT_WRAPKEY_LABEL;
+		var.namelen = strlen(PLPKS_DEFAULT_WRAPKEY_LABEL);
+	}
+	var.os = PLPKS_VAR_LINUX;
+	var.component = PLPKS_WRAPKEY_COMPONENT;
+
 	rc = plpks_wrap_object(&input_buf, input_len, pkwm->wrap_flags,
-			       &output_buf, &output_len);
+			       &output_buf, &output_len, &var);
 	if (!rc) {
 		memcpy(p->blob, output_buf, output_len);
 		p->blob_len = output_len;
@@ -161,15 +180,26 @@ static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
 static int trusted_pkwm_init(void)
 {
 	int ret;
+	struct plpks_var var;
 
 	if (!plpks_wrapping_is_supported()) {
 		pr_err("H_PKS_WRAP_OBJECT interface not supported\n");
 		return -ENODEV;
 	}
 
-	ret = plpks_gen_wrapping_key();
-	if (ret) {
-		pr_err("Failed to generate default wrapping key\n");
+	var = (struct plpks_var) {
+		.name = (u8 *)PLPKS_DEFAULT_WRAPKEY_LABEL,
+		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
+		.policy = PLPKS_WRAPPINGKEY,
+		.os = PLPKS_VAR_LINUX,
+		.component = PLPKS_WRAPKEY_COMPONENT
+	};
+
+	ret = plpks_gen_wrapping_key(&var);
+
+	/* An existing default wrapping key is considered success. */
+	if (ret && ret != -EEXIST) {
+		pr_err("Failed to generate default wrapping key: %d\n", ret);
 		return ret;
 	}
 
-- 
2.52.0


