Return-Path: <linuxppc-dev+bounces-26285-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C8CC61DE2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 11:19:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYRLz4ntMz2yDr;
	Mon, 31 Aug 2026 21:18:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788175115;
	cv=none; b=jovFJtBkf0sXXvP6M7RcdXkiv6cFwB28cUkZRljWjj/qKAsF72mez4P7p7AHn2sGDwAQq/7k2Lai6piHIRF5yGmKDkKlL/a02YmTHQ5gFibKk6yM+T5yUyVMRm9ROue83OYseKpQyMgcbIowxyie2Voz0LKvvD/myXZNjbAZ6tPmE/5NukPMJ74zLAPqC4tR/J8F3N5aKMBoBCcq87eqCOYZVeOlw5txflD5GjrsDLCAP6XppgIyMf4VfYc/exH9Eilr5UptpI3v6ojYHD8SESOpJilGb6cC14SjQyfELwgSlS+Thp9g9SqzL4RIGo1qQKsx5omNvzRdm33KRb6Xsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788175115; c=relaxed/relaxed;
	bh=dp9R1MwSjzkvuulJXdXK/0FQPBdPepaEEBgz4Bmw4VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SADo5cZU0LTs7nYTtA0wsNKRe2yDCGovoPIQDpUI5yzLKxEpBD4LdvIzEf2MRkyvHOvNcnKhaxSYrdkPywBOrCaMUwMufTaPpRKTcXyUnu7+vkCdZEZOAAP6DIjbWFke8TJaWpOIP431aWVZ8PY736yTNw8QfOfNUCuX+heiiOGHZ4farVJHFeDZan1RO/XS393Xeuz1uBtx+FiNbAEM68viE6ZcoWj//nKS3Go8UFQrD8b/WOAXPAifYSCKq3dTRIW/0BiDePMH6h79KtK76FSUmpzanxD1hsWwhAf+rii5JKdex03u03TEJemZg4WcxpBVamvRpmJWCshYpHsI8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K5ATn6yK; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K5ATn6yK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYRLy5PNWz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 21:18:34 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82jxX512812;
	Mon, 31 Aug 2026 11:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dp9R1MwSjzkvuulJX
	dXK/0FQPBdPepaEEBgz4Bmw4VA=; b=K5ATn6yKoJzHFMis38OKW9u6bhUG+lb6N
	spCfrvWmCjQEF6I7JQ+oVAmP5M8ifdzCwnMdTv6qSlrch7DS3hAYOTl4PVFk9AUD
	4pB89CKX4VPaKPFe4K1Pj8/A0Kgeo4UR9wF5YdZ41bIhAcgsSSbdTw3VEZaLgAJA
	0LZdGaAh8B7XcXvfT1Qvj8bUB77wwh72NyzbZEjGMcpjyrdi7Fy0ZY9Y/sxa/nas
	L/GHEtaumHtqg55RzPtWWxpv9peIt40AQBH7kqBC9sY37ElyJvsAtgSmAyCv6UKJ
	12xGO2GEkOM8WvuYVTQepQqshHJzSs3b5EVCh3+xnroelGbUHfFhA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudgvdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:18:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VBDJ55008540;
	Mon, 31 Aug 2026 11:18:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h5f6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:18:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VBIGgB33227204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 11:18:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC6412004B;
	Mon, 31 Aug 2026 11:18:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FEAA20040;
	Mon, 31 Aug 2026 11:18:13 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 11:18:13 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v2 09/10] keys/trusted_keys: enable PKWM wrapping key selection by label
Date: Mon, 31 Aug 2026 16:47:37 +0530
Message-ID: <20260831111738.334857-10-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831111738.334857-1-ssrish@linux.ibm.com>
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
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
X-Proofpoint-GUID: UfNs0flxgXOoGiTLtIGM4PmlZsiL2tlK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX9fM+Z9mlnQfs
 4EqpBkUSa2tVHE3dEFhSmv4JjWoDc96qHS83o/O1Klur03oF/8pt0vYF/rZB29VGKokgkoyAyA/
 p+REr8OcjCmDG+TeW9A52wtCDnIZ9ke0tuygRXW0eux/ulLYTIlsXSmIRf/qhHI5LZMdeHznMPC
 PQYUgWpW+q09e+ZhvCX2Hg6EfLpqrUMv/EGdyx4oTGl8TRecVZGZI1XRwPQtWb1dZUiNLh2bZqI
 x9wpsvExTwzpHtMX65VMyOHKBpnowRJYsHVhrD1TYyUw7iaSk+nOamRxcSF5Pgs9dUg8xUjxOmG
 KbM3IyoXfzRuBCCQH329SGUnMoVNChCezvJatr5zM4iU+JNGxrxQzgGZkcW87xA9lhXnFkoUWFn
 C3WOQjHRsDo80HoIKBzRCjPUiZ5cJQF8GuqdHOHmAHj3Dn1zK/TLRJYze9OYnjzA+qbRZZYzcbP
 zIf4t1QJrglyomAXhiw==
X-Proofpoint-ORIG-GUID: lD1WbmnAU2vGoZ-vJmJuDbEMnf7P2Oy_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX5T22KJ0V6JEB
 YWq8XuaLE2azgYWeOm0IHgFBPeCl8gadzYYcZ9uVTsiTEDD854LZaiZ1jyG2WjK134lFTQ8QdCL
 FI/AAlg6DUgPCvwn2CwCwMYLYJBYJaM=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9562fe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=_1a9KapSLEuvdD3BKzMA:9
 a=OmX4KOSJZv6Tv-4Y:21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310095

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
 arch/powerpc/include/asm/plpks.h              | 10 ++-
 arch/powerpc/platforms/pseries/plpks.c        | 64 ++++++++++---------
 include/keys/trusted_pkwm.h                   |  3 +
 security/keys/trusted-keys/trusted_pkwm.c     | 34 +++++++++-
 5 files changed, 80 insertions(+), 35 deletions(-)

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
index c39d1f07017e..badb07afe749 100644
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
index 3b1e6f00b4ae..5cdaabe9de06 100644
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
@@ -935,6 +932,7 @@ EXPORT_SYMBOL_GPL(plpks_revoke_is_supported);
 /**
  * plpks_gen_wrapping_key() - Generate a new random key with the 'wrapping key'
  * policy set.
+ * @var: variable representing the wrapping key to be created
  *
  * The H_PKS_GEN_KEY HCALL makes the hypervisor generate a new random key and
  * store the key in a PLPKS object with the provided object label. With the
@@ -960,25 +958,27 @@ EXPORT_SYMBOL_GPL(plpks_revoke_is_supported);
  *
  * Returns: On success 0 is returned, a negative errno if not.
  */
-int plpks_gen_wrapping_key(void)
+int plpks_gen_wrapping_key(struct plpks_var *var)
 {
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
 	struct label *label;
 	int rc = 0, pseries_status = 0;
-	struct plpks_var var = {
-		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
-		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
-		.policy = PLPKS_WRAPPINGKEY,
-		.os = PLPKS_VAR_LINUX,
-		.component = PLPKS_WRAPKEY_COMPONENT
-	};
+
+	if (!var)
+		return -EINVAL;
+
+	if (!var->name || !*var->name) {
+		pr_err("key label cannot be NULL/empty\n");
+		return -EINVAL;
+	}
 
 	auth = construct_auth(PLPKS_OS_OWNER);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
 
-	label = construct_label(var.component, var.os, var.name, var.namelen);
+	label = construct_label(var->component, var->os, var->name,
+				var->namelen);
 	if (IS_ERR(label)) {
 		rc = PTR_ERR(label);
 		goto out;
@@ -986,7 +986,7 @@ int plpks_gen_wrapping_key(void)
 
 	rc = plpar_hcall(H_PKS_GEN_KEY, retbuf,
 			 virt_to_phys(auth), virt_to_phys(label),
-			 label->size, var.policy,
+			 label->size, var->policy,
 			 NULL, PLPKS_WRAPPING_KEY_LENGTH);
 
 	if (!rc)
@@ -995,11 +995,13 @@ int plpks_gen_wrapping_key(void)
 	pseries_status = rc;
 	rc = pseries_status_to_err(rc);
 
-	if (rc && rc != -EEXIST) {
-		pr_err("H_PKS_GEN_KEY failed. pseries_status=%d, rc=%d",
-		       pseries_status, rc);
-	} else {
-		rc = 0;
+	if (rc) {
+		if (rc == -EEXIST)
+			pr_info("wrapping key <%s> already exists\n",
+				(char *)var->name);
+		else
+			pr_err("H_PKS_GEN_KEY failed. pseries_status=%d, rc=%d\n",
+			       pseries_status, rc);
 	}
 
 	kfree(label);
@@ -1010,13 +1012,14 @@ int plpks_gen_wrapping_key(void)
 EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
 
 /**
- * plpks_wrap_object() - Wrap an object using the default wrapping key stored in
- * the PLPKS.
+ * plpks_wrap_object() - Wrap an object using the specified wrapping key stored
+ * in the PLPKS.
  * @input_buf: buffer containing the data to be wrapped
  * @input_len: length of the input buffer
  * @wrap_flags: object wrapping flags
  * @output_buf: buffer to store the wrapped data
  * @output_len: length of the output buffer
+ * @var: variable representing the wrapping key to be used
  *
  * The H_PKS_WRAP_OBJECT HCALL wraps an object using a wrapping key stored in
  * the PLPKS and returns the wrapped object to the caller. The caller provides a
@@ -1051,7 +1054,7 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
  * Returns: On success 0 is returned, a negative errno if not.
  */
 int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
-		      u8 **output_buf, u64 *output_len)
+		      u8 **output_buf, u64 *output_len, struct plpks_var *var)
 {
 	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
@@ -1061,18 +1064,21 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
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
+	if (!var)
+		return -EINVAL;
+
+	if (!var->name || !*var->name) {
+		pr_err("key label cannot be NULL/empty\n");
+		return -EINVAL;
+	}
 
 	auth = construct_auth(PLPKS_OS_OWNER);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
 
-	label = construct_label(var.component, var.os, var.name, var.namelen);
+	label = construct_label(var->component, var->os, var->name,
+				var->namelen);
 	if (IS_ERR(label)) {
 		rc = PTR_ERR(label);
 		goto out;
@@ -1135,7 +1141,7 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
 EXPORT_SYMBOL_GPL(plpks_wrap_object);
 
 /**
- * plpks_unwrap_object() - Unwrap an object using the default wrapping key
+ * plpks_unwrap_object() - Unwrap an object using its associated wrapping key
  * stored in the PLPKS.
  * @input_buf: buffer containing the data to be unwrapped
  * @input_len: length of the input buffer
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
index 633a7674d065..7bfe98d79cd7 100644
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
@@ -82,6 +90,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 {
 	struct trusted_key_options *options = NULL;
 	struct trusted_pkwm_options *pkwm = NULL;
+	struct plpks_var var;
 	u8 *input_buf, *output_buf;
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
@@ -161,14 +180,23 @@ static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
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
+	var = (struct plpks_var) {
+		.name = (u8 *)PLPKS_DEFAULT_WRAPKEY_LABEL,
+		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
+		.policy = PLPKS_WRAPPINGKEY,
+		.os = PLPKS_VAR_LINUX,
+		.component = PLPKS_WRAPKEY_COMPONENT
+	};
+
+	ret = plpks_gen_wrapping_key(&var);
+	if (ret && ret != -EEXIST) {
 		pr_err("Failed to generate default wrapping key\n");
 		return ret;
 	}
-- 
2.52.0


