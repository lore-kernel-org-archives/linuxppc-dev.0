Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B33AC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 20:40:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31D02086C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 20:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31D02086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xVTs5ZGRzF3pf
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 07:40:01 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xTpl3gTWzF3my
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 07:09:35 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAGK8wdK041818
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 15:09:33 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nt24t6408-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 15:09:32 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Fri, 16 Nov 2018 20:09:32 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 16 Nov 2018 20:09:27 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAGK9QrP26935494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 16 Nov 2018 20:09:26 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80567AC062;
 Fri, 16 Nov 2018 20:09:26 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3112BAC059;
 Fri, 16 Nov 2018 20:09:22 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.80.224.199])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 16 Nov 2018 20:09:21 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Subject: [PATCH v8 14/14] ima: Store the measurement again when appraising a
 modsig
Date: Fri, 16 Nov 2018 18:07:12 -0200
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181116200712.14154-1-bauerman@linux.ibm.com>
References: <20181116200712.14154-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111620-0072-0000-0000-000003CA292A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010063; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01118417; UDB=6.00577118; IPR=6.00898526; 
 MB=3.00024197; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-16 20:09:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111620-0073-0000-0000-00004A2182C3
Message-Id: <20181116200712.14154-15-bauerman@linux.ibm.com>
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

If the IMA template contains the 'sig' field, then the modsig should be
added to the measurement list when the file is appraised, and that is what
normally happens.

But If a measurement rule caused a file containing a modsig to be measured
before a different rule causes it to be appraised, the resulting
measurement entry will not contain the modsig because it is only fetched
during appraisal. When the appraisal rule triggers, it won't store a new
measurement containing the modsig because the file was already measured.

We need to detect that situation and store an additional measurement with
the modsig. This is done by defining the appraise subaction flag
IMA_READ_MEASURE and testing for it in process_measurement().

Suggested-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/ima/ima.h          |  1 +
 security/integrity/ima/ima_api.c      |  8 +++-
 security/integrity/ima/ima_main.c     | 16 +++++++-
 security/integrity/ima/ima_policy.c   | 59 ++++++++++++++++++++++++---
 security/integrity/ima/ima_template.c | 27 ++++++++++++
 security/integrity/integrity.h        |  9 ++--
 6 files changed, 110 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 8e1b1ddbe14f..c39bed55f6d2 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -147,6 +147,7 @@ int ima_init_crypto(void);
 void ima_putc(struct seq_file *m, void *data, int datalen);
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
 struct ima_template_desc *ima_template_desc_current(void);
+bool ima_current_template_has_sig(void);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 99dd1d53fc35..a7af114bc6b4 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -289,7 +289,13 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 					    xattr_len, NULL};
 	int violation = 0;
 
-	if (iint->measured_pcrs & (0x1 << pcr))
+	/*
+	 * We still need to store the measurement in the case of MODSIG because
+	 * we only have its contents to put in the list at the time of
+	 * appraisal. See comment in store_measurement_again() for more details.
+	 */
+	if (iint->measured_pcrs & (0x1 << pcr) &&
+	    (!xattr_value || xattr_value->type != IMA_MODSIG))
 		return;
 
 	result = ima_alloc_init_template(&event_data, &entry);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d5abd22d502a..807b9b77b813 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -166,6 +166,20 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
+/*
+ * A file measurement might already exist in the measurement list. Based on
+ * policy, include an additional file measurement containing the appended
+ * signature and file hash, without the appended signature (i.e., the 'd-sig'
+ * field).
+ */
+static bool store_measurement_again(struct integrity_iint_cache *iint,
+				    struct evm_ima_xattr_data *xattr_value)
+{
+	return iint->flags & IMA_READ_MEASURE && xattr_value &&
+		xattr_value->type == IMA_MODSIG &&
+		ima_current_template_has_sig();
+}
+
 static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
@@ -299,7 +313,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
-	if (action & IMA_MEASURE)
+	if (action & IMA_MEASURE || store_measurement_again(iint, xattr_value))
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, pcr);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 3e5a64053aa8..c0b39802e988 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -10,6 +10,9 @@
  *	- initialize default measure policy rules
  *
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/list.h>
 #include <linux/fs.h>
@@ -367,7 +370,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
  * In addition to knowing that we need to appraise the file in general,
  * we need to differentiate between calling hooks, for hook specific rules.
  */
-static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
+static int get_appraise_subaction(struct ima_rule_entry *rule,
+				  enum ima_hooks func)
 {
 	if (!(rule->flags & IMA_FUNC))
 		return IMA_FILE_APPRAISE;
@@ -388,6 +392,15 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 	}
 }
 
+static int get_measure_subaction(struct ima_rule_entry *rule,
+				 enum ima_hooks func)
+{
+	if (rule->flags & IMA_FUNC && ima_hook_supports_modsig(func))
+		return IMA_READ_MEASURE;
+	else
+		return 0;
+}
+
 /**
  * ima_match_policy - decision based on LSM and other conditions
  * @inode: pointer to an inode for which the policy decision is being made
@@ -424,11 +437,12 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 
 		action |= entry->action & IMA_DO_MASK;
 		if (entry->action & IMA_APPRAISE) {
-			action |= get_subaction(entry, func);
+			action |= get_appraise_subaction(entry, func);
 			action &= ~IMA_HASH;
 			if (ima_fail_unverifiable_sigs)
 				action |= IMA_FAIL_UNVERIFIABLE_SIGS;
-		}
+		} else if (entry->action & IMA_MEASURE)
+			action |= get_measure_subaction(entry, func);
 
 		if (entry->action & IMA_DO_MASK)
 			actmask &= ~(entry->action | entry->action << 1);
@@ -756,6 +770,40 @@ static void ima_log_string(struct audit_buffer *ab, char *key, char *value)
 	ima_log_string_op(ab, key, value, NULL);
 }
 
+/*
+ * To validate the appended signature included in the measurement list requires
+ * the file hash, without the appended signature (i.e., the 'd-sig' field).
+ * Therefore, notify the user if they have the 'sig' field but not the 'd-sig'
+ * field in the template.
+ */
+static void check_current_template_modsig(void)
+{
+#define MSG "template with 'sig' field also needs 'd-sig' field when modsig is allowed\n"
+	struct ima_template_desc *template;
+	bool has_sig, has_dsig;
+	static bool checked;
+	int i;
+
+	/* We only need to notify the user once. */
+	if (checked)
+		return;
+
+	has_sig = has_dsig = false;
+	template = ima_template_desc_current();
+	for (i = 0; i < template->num_fields; i++) {
+		if (!strcmp(template->fields[i]->field_id, "sig"))
+			has_sig = true;
+		else if (!strcmp(template->fields[i]->field_id, "d-sig"))
+			has_dsig = true;
+	}
+
+	if (has_sig && !has_dsig)
+		pr_notice(MSG);
+
+	checked = true;
+#undef MSG
+}
+
 static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 {
 	struct audit_buffer *ab;
@@ -1035,10 +1083,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			if ((strcmp(args[0].from, "imasig")) == 0)
 				entry->flags |= IMA_DIGSIG_REQUIRED;
 			else if (ima_hook_supports_modsig(entry->func) &&
-				 strcmp(args[0].from, "imasig|modsig") == 0)
+				 strcmp(args[0].from, "imasig|modsig") == 0) {
 				entry->flags |= IMA_DIGSIG_REQUIRED
 						| IMA_MODSIG_ALLOWED;
-			else
+				check_current_template_modsig();
+			} else
 				result = -EINVAL;
 			break;
 		case Opt_permit_directio:
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 045ad508cbb8..a58b55e7c1c6 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -231,6 +231,33 @@ struct ima_template_desc *ima_template_desc_current(void)
 	return ima_template;
 }
 
+/*
+ * Tells whether the current template has fields which reference a file's
+ * signature.
+ */
+bool ima_current_template_has_sig(void)
+{
+	static int ima_template_has_sig = -1;
+
+	if (ima_template_has_sig < 0) {
+		struct ima_template_desc *template;
+		int i;
+
+		template = ima_template_desc_current();
+		for (i = 0; i < template->num_fields; i++)
+			if (!strcmp(template->fields[i]->field_id, "sig") ||
+			    !strcmp(template->fields[i]->field_id, "d-sig")) {
+				ima_template_has_sig = 1;
+				break;
+			}
+
+		if (ima_template_has_sig < 0)
+			ima_template_has_sig = 0;
+	}
+
+	return ima_template_has_sig;
+}
+
 int __init ima_init_template(void)
 {
 	struct ima_template_desc *template = ima_template_desc_current();
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index e8c379211a96..9d7cefa5c999 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -39,12 +39,13 @@
 #define IMA_MODSIG_ALLOWED	0x20000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
-				 IMA_HASH | IMA_APPRAISE_SUBMASK)
+				 IMA_HASH | IMA_APPRAISE_SUBMASK | \
+				 IMA_READ_MEASURE)
 #define IMA_DONE_MASK		(IMA_MEASURED | IMA_APPRAISED | IMA_AUDITED | \
 				 IMA_HASHED | IMA_COLLECTED | \
-				 IMA_APPRAISED_SUBMASK)
+				 IMA_APPRAISED_SUBMASK | IMA_READ_MEASURED)
 
-/* iint subaction appraise cache flags */
+/* iint subaction appraise and measure cache flags */
 #define IMA_FILE_APPRAISE	0x00001000
 #define IMA_FILE_APPRAISED	0x00002000
 #define IMA_MMAP_APPRAISE	0x00004000
@@ -55,6 +56,8 @@
 #define IMA_READ_APPRAISED	0x00080000
 #define IMA_CREDS_APPRAISE	0x00100000
 #define IMA_CREDS_APPRAISED	0x00200000
+#define IMA_READ_MEASURE	0x00400000
+#define IMA_READ_MEASURED	0x00800000
 #define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
 				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE | \
 				 IMA_CREDS_APPRAISE)

