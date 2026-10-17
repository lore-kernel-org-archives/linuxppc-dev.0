Return-Path: <linuxppc-dev+bounces-29622-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB2ACCA463
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 07:50:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6DVx3thwz2yDs;
	Sat, 17 Oct 2026 18:50:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792223417;
	cv=none; b=mhWC0/5ZIgoAOtZIiFcPXcetnoqSHQJAUbhg/zrN8/qdR9UirNrKdenEH9gpDA7GHEOKGrh1NUxLvFt3z5lAnTyIE++1VQJi+6emo/EGPQ8ApCN20NHBVIH0oiEAwk6w2BoTAlJlowXIbwv5xt0vf+zz43XKPFhZipAXz2IAptV8iz1Z0a62JIwBHFZXFkvY5NtTePTGU6QQi4pA7HYYUlaalt5+GsxdW9IVjJsVf7YDvheAt7PUGFyPp2LdgjSpgbj+Xr/BxX/jodZJSorFB1KBZmHPI4AHDwqSrzbSmRAN5BY8s0TLo2+GsSPllVatYdw/VOoF42FfeXCyZsGoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792223417; c=relaxed/relaxed;
	bh=1qz1xKnpz9fWpWuzEeNGUTu6S0AqtpwpN0zDxjgZHzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWAKBlodHzdz+67kGsz3h+hpx1GB9b4m0isCndj18T0igPwV1PR2w8Xt2ySLgVeAGioxJYDjhBCRTW5/qVqhf1bQaffI7iOxLGqRqoXVV9qqNpc8PjNLGCo+AQacF+B5iuJghZDQYE1YTerywH9cRjMyoJleDLzIlInyX9Q+BztFF6ahalvtBBEc4WCVNFEOv7OcAd+bRVORwmJMcIGeJCJocYQF5Lj9MTvGt67wknJu5e1hoFaG4n1OiA7Rw2V4qOHMrOzw92650T1R0zK6j4b4fwbNQVuIaNhid0M8ZlEL7iGSE3xyromjGGC+bMiwCOEc+qUdOTADjSh5h7KEog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y27WlleV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y27WlleV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6DVv5j9Pz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 18:50:15 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H7E4Xd095484;
	Sat, 17 Oct 2026 07:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1qz1xKnpz9fWpWuzE
	eNGUTu6S0AqtpwpN0zDxjgZHzQ=; b=Y27WlleVvxb08E0YrpdtThqGA+rWkakKs
	LT7+aE1uknQtZNPMUtjgP5sXzeYMN1VXQ6SLW1hSpyswgC09gOmJJBYVvmWvESQM
	NXJPbg+clhYDietbMVp2001lgrbP0k1SwsFdyemNHkmd0csPjOWvy7SCpADSpo9u
	KnykJQooLjmtnspTCo/EZyDv3Fofl95qlusdv+bbM6wRaVy9Qjso07brJWz0hJ/8
	2IOe86aR0pEPhlW9vW0BbiJd/oABieqADt+DKmpi5asZSOQrrIoCADwLLcxhx961
	IHzVgFE7Ne8ZM8CcEpbneG8PFZkbvhQUGRLjf+LflTHMFJOKPu/Ug==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0pt8s77-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 07:50:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69H6ntS2680483;
	Sat, 17 Oct 2026 07:50:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hb23974hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 07:50:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69H7nwKB45220264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 07:49:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8943620043;
	Sat, 17 Oct 2026 07:49:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A2C220040;
	Sat, 17 Oct 2026 07:49:51 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 07:49:50 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v3 5/6] keys/trusted_keys: enable PKWM wrapping key selection by label
Date: Sat, 17 Oct 2026 13:18:49 +0530
Message-ID: <20261017074850.164031-6-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfXzxP8xUVcFO+6
 GdHmejNptTfyxAL23W0B4/9hN+oF9vx/VrrUHlLx2BKOpoAD+c5nbKA1bdY6Aei9dcv6RI2r4Sr
 IrOyDJjQ6g+x/n3ufRDuMq/WtAPbk6H6Dy7LHVaakYc/zzsuXcEv1G4IzrS2b5cSnGRtnK1cir8
 IzaKIF0e1iZ1CAuTVI9JgK1CXmZENa1KEc/C80W51flsRFrUh474xXISsggh5psjSeK8qS1URxO
 r6W6Oz+RM0a2WYgt7Cx6f68CMuVc23opsYIykXVnPJt58Y5L6E8nn1Kv8hAbPXf3Z4GDB6QqO1g
 vtvQCMaqa55JQ5Xmgbr5fOZ4ITD62kpMjcBQmJ3cmb7PIujvCEg6AwT56rd+j0Ex6rcMJJNRLGG
 +RauzGdGvt3vG235roDxPOOVpmdqPO5n+jksC82c13+OAzqqMARkxwvY/7x4/N8gkThTeMbaegf
 +NJXo+LdEtKqmZ/qHiw==
X-Authority-Analysis: v=2.4 cv=WNvqzXsR c=1 sm=1 tr=0 ts=6ad328ab cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=_1a9KapSLEuvdD3BKzMA:9
 a=mGxJDu7xY38OflIk:21
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfX8Zq5fhNFnZpJ
 FPXThm6KB+D1+cAT9vlNbU+DSAVkO/nbPttAKtTrqINDZHfZqXSp5opOWWfWRBlSw/aUYE//5TE
 r0lkUKP92+/wJ5fe8DxxllLOpZqm2Qc=
X-Proofpoint-GUID: _gQZu7ofnBhNivyWMuNIW8-qkpztEMcf
X-Proofpoint-ORIG-GUID: lDYu4SQxTEc73L-vDZC3UsDzT2rXbW8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170030

The PKWM trusted source currently uses the default wrapping key for all
seal and unseal operations. However, PKWM supports multiple wrapping keys,
enabling better isolation between trusted keys.

Allow users to provide an active wrapping key of their choice created
through sysfs when sealing trusted keys through a new wrapping_key=<label>
option. If no label is specified, the default wrapping key is used for
sealing.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 .../security/keys/trusted-encrypted.rst       |  4 +-
 arch/powerpc/include/asm/plpks.h              | 10 +++-
 arch/powerpc/platforms/pseries/plpks.c        | 49 ++++++++-----------
 include/keys/trusted_pkwm.h                   |  3 ++
 security/keys/trusted-keys/trusted_pkwm.c     | 38 ++++++++++++--
 5 files changed, 68 insertions(+), 36 deletions(-)

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
index edd189cfcc85..a4fb5dbac406 100644
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
@@ -960,25 +958,22 @@ EXPORT_SYMBOL_GPL(plpks_revoke_is_supported);
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
@@ -986,7 +981,7 @@ int plpks_gen_wrapping_key(void)
 
 	rc = plpar_hcall(H_PKS_GEN_KEY, retbuf,
 			 virt_to_phys(auth), virt_to_phys(label),
-			 label->size, var.policy,
+			 label->size, var->policy,
 			 NULL, PLPKS_WRAPPING_KEY_LENGTH);
 
 	if (!rc)
@@ -995,12 +990,9 @@ int plpks_gen_wrapping_key(void)
 	pseries_status = rc;
 	rc = pseries_status_to_err(rc);
 
-	if (rc && rc != -EEXIST) {
-		pr_err("H_PKS_GEN_KEY failed. pseries_status=%d, rc=%d",
+	if (rc && rc != -EEXIST)
+		pr_err("H_PKS_GEN_KEY failed. pseries_status=%d, rc=%d\n",
 		       pseries_status, rc);
-	} else {
-		rc = 0;
-	}
 
 	kfree(label);
 out:
@@ -1010,13 +1002,14 @@ int plpks_gen_wrapping_key(void)
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
@@ -1051,7 +1044,7 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
  * Returns: On success 0 is returned, a negative errno if not.
  */
 int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
-		      u8 **output_buf, u64 *output_len)
+		      u8 **output_buf, u64 *output_len, struct plpks_var *var)
 {
 	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
 	struct plpks_auth *auth;
@@ -1061,18 +1054,16 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
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
 
 	auth = construct_auth(PLPKS_OS_OWNER);
 	if (IS_ERR(auth))
 		return PTR_ERR(auth);
 
-	label = construct_label(var.component, var.os, var.name, var.namelen);
+	label = construct_label(var->component, var->os, var->name,
+				var->namelen);
 	if (IS_ERR(label)) {
 		rc = PTR_ERR(label);
 		goto out;
@@ -1135,7 +1126,7 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
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
index 6774557f818a..ba7717b474b2 100644
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
+	struct plpks_var var = {0};
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


