Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65D4C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 20:36:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4F22086A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 20:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4F22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xVPY2mh0zF3cd
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 07:36:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bauerman@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xTpW6Wx5zF3nL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 07:09:23 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAGK8wJn023387
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 15:09:21 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nt4930xk7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 15:09:21 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Fri, 16 Nov 2018 20:09:20 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 16 Nov 2018 20:09:16 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAGK9Fh327263082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 16 Nov 2018 20:09:15 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30821AC05B;
 Fri, 16 Nov 2018 20:09:15 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D12F8AC05E;
 Fri, 16 Nov 2018 20:09:10 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.80.224.199])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 16 Nov 2018 20:09:10 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Subject: [PATCH v8 12/14] ima: Add new "d-sig" template field
Date: Fri, 16 Nov 2018 18:07:10 -0200
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181116200712.14154-1-bauerman@linux.ibm.com>
References: <20181116200712.14154-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111620-0060-0000-0000-000002D42FBB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010063; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01118417; UDB=6.00580177; IPR=6.00898526; 
 MB=3.00024196; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-16 20:09:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111620-0061-0000-0000-00004738464B
Message-Id: <20181116200712.14154-13-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-16_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160179
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-doc@vger.kernel.org,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, "AKASHI,
 Takahiro" <takahiro.akashi@linaro.org>, linux-security-module@vger.kernel.org,
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
 Jessica Yu <jeyu@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 David Woodhouse <dwmw2@infradead.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Define new "d-sig" template field which holds the digest that is expected
to match the one contained in the modsig.

Suggested-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 Documentation/security/IMA-templates.rst  |  5 ++++
 security/integrity/ima/ima.h              |  9 +++++++
 security/integrity/ima/ima_modsig.c       | 23 ++++++++++++++++
 security/integrity/ima/ima_template.c     |  4 ++-
 security/integrity/ima/ima_template_lib.c | 32 ++++++++++++++++++++++-
 security/integrity/ima/ima_template_lib.h |  2 ++
 6 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 2cd0e273cc9a..f2a0f4225857 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -68,6 +68,11 @@ descriptors by adding their identifier to the format string
  - 'd-ng': the digest of the event, calculated with an arbitrary hash
    algorithm (field format: [<hash algo>:]digest, where the digest
    prefix is shown only if the hash algorithm is not SHA1 or MD5);
+ - 'd-sig': the digest of the event for files that have an appended modsig. This
+   field is calculated without including the modsig and thus will differ from
+   the total digest of the file, but it is what should match the digest
+   contained in the modsig (if it doesn't, the signature is invalid). It is
+   shown in the same format as 'd-ng';
  - 'n-ng': the name of the event, without size limitations;
  - 'sig': the file signature.
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 312d60cee702..7f88e4b86156 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -313,6 +313,8 @@ bool ima_hook_supports_modsig(enum ima_hooks func);
 int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    struct evm_ima_xattr_data **xattr_value,
 		    int *xattr_len);
+int ima_get_modsig_hash(struct evm_ima_xattr_data *hdr, enum hash_algo *algo,
+			const u8 **hash, u8 *len);
 int ima_modsig_verify(const unsigned int keyring_id,
 		      struct evm_ima_xattr_data *hdr);
 void ima_free_xattr_data(struct evm_ima_xattr_data *hdr);
@@ -330,6 +332,13 @@ static inline int ima_read_modsig(enum ima_hooks func, const void *buf,
 	return -EOPNOTSUPP;
 }
 
+static inline int ima_get_modsig_hash(struct evm_ima_xattr_data *hdr,
+				      enum hash_algo *algo, const u8 **hash,
+				      u8 *len)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int ima_modsig_verify(const unsigned int keyring_id,
 				    struct evm_ima_xattr_data *hdr)
 {
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index e095d35d804d..584d9d77b2c4 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -144,6 +144,29 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 	return rc;
 }
 
+int ima_get_modsig_hash(struct evm_ima_xattr_data *hdr, enum hash_algo *algo,
+			const u8 **hash, u8 *len)
+{
+	struct modsig_hdr *modsig = (typeof(modsig)) hdr;
+	const struct public_key_signature *pks;
+	int i;
+
+	if (!hdr || hdr->type != IMA_MODSIG)
+		return -EINVAL;
+
+	pks = pkcs7_get_message_sig(modsig->pkcs7_msg);
+	if (!pks)
+		return -EBADMSG;
+
+	for (i = 0; i < HASH_ALGO__LAST; i++)
+		if (!strcmp(hash_algo_name[i], pks->hash_algo))
+			break;
+
+	*algo = i;
+
+	return pkcs7_get_digest(modsig->pkcs7_msg, hash, len);
+}
+
 int ima_modsig_verify(const unsigned int keyring_id,
 		      struct evm_ima_xattr_data *hdr)
 {
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index b631b8bc7624..045ad508cbb8 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -43,8 +43,10 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_string},
 	{.field_id = "sig", .field_init = ima_eventsig_init,
 	 .field_show = ima_show_template_sig},
+	{.field_id = "d-sig", .field_init = ima_eventdigest_sig_init,
+	 .field_show = ima_show_template_digest_ng},
 };
-#define MAX_TEMPLATE_NAME_LEN 15
+#define MAX_TEMPLATE_NAME_LEN 24
 
 static struct ima_template_desc *ima_template;
 static struct ima_template_desc *lookup_template_desc(const char *name);
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 300912914b17..36d175816894 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -222,7 +222,8 @@ int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
 	return 0;
 }
 
-static int ima_eventdigest_init_common(u8 *digest, u32 digestsize, u8 hash_algo,
+static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
+				       u8 hash_algo,
 				       struct ima_field_data *field_data)
 {
 	/*
@@ -325,6 +326,35 @@ int ima_eventdigest_ng_init(struct ima_event_data *event_data,
 					   hash_algo, field_data);
 }
 
+/*
+ * This function writes the digest of the file which is expected to match the
+ * digest contained in the file's embedded signature.
+ */
+int ima_eventdigest_sig_init(struct ima_event_data *event_data,
+			     struct ima_field_data *field_data)
+{
+	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
+	enum hash_algo hash_algo = HASH_ALGO_SHA1;
+	const u8 *cur_digest = NULL;
+	u8 cur_digestsize = 0;
+	int ret;
+
+	if (!xattr_value || xattr_value->type != IMA_MODSIG)
+		return 0;
+
+	if (event_data->violation)	/* recording a violation. */
+		goto out;
+
+	ret = ima_get_modsig_hash(xattr_value, &hash_algo, &cur_digest,
+				  &cur_digestsize);
+	if (ret)
+		return ret;
+
+ out:
+	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
+					   hash_algo, field_data);
+}
+
 static int ima_eventname_init_common(struct ima_event_data *event_data,
 				     struct ima_field_data *field_data,
 				     bool size_limit)
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 6a3d8b831deb..3cd353e83f73 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -38,6 +38,8 @@ int ima_eventname_init(struct ima_event_data *event_data,
 		       struct ima_field_data *field_data);
 int ima_eventdigest_ng_init(struct ima_event_data *event_data,
 			    struct ima_field_data *field_data);
+int ima_eventdigest_sig_init(struct ima_event_data *event_data,
+			     struct ima_field_data *field_data);
 int ima_eventname_ng_init(struct ima_event_data *event_data,
 			  struct ima_field_data *field_data);
 int ima_eventsig_init(struct ima_event_data *event_data,

