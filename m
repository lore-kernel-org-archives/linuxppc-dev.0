Return-Path: <linuxppc-dev+bounces-29667-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C66CCA490
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 17:10:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j74vB1MTlz2yql;
	Mon, 19 Oct 2026 04:10:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792343446;
	cv=none; b=V4e0JLK3g5+VWGN6Wix6pK2+ZwUgB1eNNB/WFSHgWuXqzHHRTucLn5cmHdbL6XVfJqVDDHyA/v4TiIjx7QOh/Svp1It8ia7FPxZOv3CaRd5SB7JvYqe17m9tQG8zFqM/y7MteIICoLg+OVGlInuWGJFHdihOghoG3/uyzXzlvc1NK2X7CxZ9dspUpgx5gc3r3zf93U90X+3X4DeYCncceXqzkKRg/ZuRcV50ZH/BoDV8pMbn2SQS1nv9LBWiDzcuNYf6QUu05kvTY5yp+GzRFsbRqQxPjNuqa9DpqMWG76FuuVbPsxcO7iMl7m0LKG7xDwo6PRXIeVjr8NkbKH1bvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792343446; c=relaxed/relaxed;
	bh=m02Yr+9N1QpAgfZYWq5+IlhDDBi0u15BcC72v3r8GnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjNC0FMdfJjAW4qP3J3l3Dq1NZfc5FM7FLr0/J4l7BQIg9E7ywHfmNKKH2wE+x2i8zB0ot4r7H5HHBww1SQ5sXtnsKZMgRDNixFr+iKkIY3/O0yBdyEX+hY0WnjODXlHSwqiEpmlaLsjZciC5Vg80xjPr4XyLxk/60j6/pXScamAQypAX2OaRGApCeCCERMJhPzQ14nqU0SvtPK4l1JcQs7o223rSQ1NASSp8gCdUigB4Rf2xMLaP4ePgOT13SiWJoYghI1TrGYHkae6XebeJtYqK2/FJvwueg1K+mFi03MymcIF084MDdEeuRa/j74psj2Y8KJmk4G4LQrEsY18ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qJi7zZ4L; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qJi7zZ4L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j74v920rCz2xg9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 04:10:45 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFFYqk1296187;
	Sun, 18 Oct 2026 17:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=m02Yr+9N1QpAgfZYW
	q5+IlhDDBi0u15BcC72v3r8GnM=; b=qJi7zZ4LWYpGA/Qj6s3oDWbB6fqgkxmLR
	kTcaR4i0wXM+FLhkfXpyDZ8VXW3L0OYs4/umeSOfWK5qUaYVlRr+eQgBPVtM/Mly
	nIPSQxvVM98SLK+b1ARphcFhQ2vYUqjcrabOVtLk1WivFAnRKF3uzp+I8vjwewEG
	TkmK0CrVaU06SHvTyATVTRVWtXdwSYdkR4CcsyHlQuIuizvffc4lGhIu9zGjntHz
	Qu/qYNdY9Chij+vFzp6l/F19vp5ZJXiVMRTkzEJGH4PHcb4EaGYcJoxQJ2ypEJOi
	jIIg9YjlNxikVmurzUEKoNjovCD8hujo8ShKochBPwKQC2jDEmA6g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0r7ep4m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:10:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFK3P82729546;
	Sun, 18 Oct 2026 17:10:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hckbq2c8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:10:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69IHAPms47317282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Oct 2026 17:10:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 899CC20040;
	Sun, 18 Oct 2026 17:10:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D16220043;
	Sun, 18 Oct 2026 17:10:15 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.125.165])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 Oct 2026 17:10:14 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v5 8/9] keys/trusted_keys: enable PKWM wrapping key selection by label
Date: Sun, 18 Oct 2026 22:38:43 +0530
Message-ID: <20261018170844.491252-9-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018170844.491252-1-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfXzVpSwmC7L+25
 SHzJd1SBoTbUqeCqV2wUdTOjAlRb/gdpYhLhPe7a9pKhsvTftDOKLU0aB/imPJBrRxsUFvYqOAc
 F1LLrX5IbUpUgGLggrGiQNpV8m5Pw+s=
X-Authority-Analysis: v=2.4 cv=PrUG/AM3 c=1 sm=1 tr=0 ts=6ad4fd86 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=_1a9KapSLEuvdD3BKzMA:9
 a=mGxJDu7xY38OflIk:21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX9o6KBjGpMNZk
 GF/iba0hlFy7qC9n7Kk7Omqt4pC7JslABqoJlxI/6M/ieIoAP9EuELoECYTU5mg6jWiXCsL/QSb
 1yKfX8iNSUI/xYgA6LDtguqcN1A4AajUNH4cvUVF+3LRuC1fGASUJRwKd36AQj40D5hsv6i8FJm
 QHrPHgswDUzxb6CcQtoT0PJXsUFhU6qsAMyXWi/rLh4MaDXue66GYBP0LylPnIixmMrbCPTR8FV
 Ps9EVsl6Zsg1iBJH/Esz0Vi5abIz6hK0sWB4ATokDuQ0UNQHKfIYgSm3CvexcsKr4C5CA2KfS9k
 xl3E4gUh9S/RTCIYk1VNjvXK/2ttDIvF7A4qZyDBUowFH8/dbgjHZH+KnKKkPhrnJkk5Te9ExQn
 mRRgpKRqqFGonTkTsKEqmO+EsoGa7Q4vTLtuzAL9ZczH+LDKn+leaGBTPBl0AK4iLFDAd9qGtTe
 K0tykc6XoUrkknSBBPw==
X-Proofpoint-GUID: N-bWdt5tYioACQvQRsGn1LJK2i9j5U4_
X-Proofpoint-ORIG-GUID: 1Fcb60SqRqNsvGXbm3nYkCRvC6EOGDDl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180066

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
 arch/powerpc/platforms/pseries/plpks.c        | 44 ++++++++-----------
 include/keys/trusted_pkwm.h                   |  3 ++
 security/keys/trusted-keys/trusted_pkwm.c     | 38 ++++++++++++++--
 5 files changed, 66 insertions(+), 33 deletions(-)

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
index 97797ae6ee6c..2c72ba15aec7 100644
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
@@ -943,6 +940,7 @@ EXPORT_SYMBOL_GPL(plpks_revoke_is_supported);
 /**
  * plpks_gen_wrapping_key() - Generate a new random key with the 'wrapping key'
  * policy set.
+ * @var: variable representing the wrapping key to be created
  *
  * The H_PKS_GEN_KEY HCALL makes the hypervisor generate a new random key and
  * store the key in a PLPKS object with the provided object label. With the
@@ -968,25 +966,22 @@ EXPORT_SYMBOL_GPL(plpks_revoke_is_supported);
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
+	if (!var || !var->name || !*var->name)
+		return -EINVAL;
 
 	auth = construct_auth(PLPKS_OS_OWNER);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
 
-	label = construct_label(var.component, var.os, var.name, var.namelen);
+	label = construct_label(var->component, var->os, var->name,
+				var->namelen);
 	if (IS_ERR(label)) {
 		rc = PTR_ERR(label);
 		goto out;
@@ -994,7 +989,7 @@ int plpks_gen_wrapping_key(void)
 
 	rc = plpar_hcall(H_PKS_GEN_KEY, retbuf,
 			 virt_to_phys(auth), virt_to_phys(label),
-			 label->size, var.policy,
+			 label->size, var->policy,
 			 NULL, PLPKS_WRAPPING_KEY_LENGTH);
 
 	if (!rc) {
@@ -1006,8 +1001,6 @@ int plpks_gen_wrapping_key(void)
 		if (rc != -EEXIST)
 			pr_err("H_PKS_GEN_KEY failed. pseries_status=%d, rc=%d",
 			       pseries_status, rc);
-		else
-			rc = 0;
 	}
 
 	kfree(label);
@@ -1018,13 +1011,14 @@ int plpks_gen_wrapping_key(void)
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
@@ -1059,7 +1053,7 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
  * Returns: On success 0 is returned, a negative errno if not.
  */
 int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
-		      u8 **output_buf, u64 *output_len)
+		      u8 **output_buf, u64 *output_len, struct plpks_var *var)
 {
 	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
@@ -1069,12 +1063,9 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
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
+	if (!var || !var->name || !*var->name)
+		return -EINVAL;
 
 	if (!input_len || input_len > PLPKS_MAX_WRAPPING_INPUT_SIZE)
 		return -EINVAL;
@@ -1083,7 +1074,8 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
 
-	label = construct_label(var.component, var.os, var.name, var.namelen);
+	label = construct_label(var->component, var->os, var->name,
+				var->namelen);
 	if (IS_ERR(label)) {
 		rc = PTR_ERR(label);
 		goto out;
@@ -1146,7 +1138,7 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
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


