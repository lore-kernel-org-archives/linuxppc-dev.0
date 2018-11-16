Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9947BC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 20:13:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7A22086B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 20:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7A22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xTvF1wGRzF3fW
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Nov 2018 07:13:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bauerman@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xTnM082TzF3lR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Nov 2018 07:08:22 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAGK4HJa125084
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 15:08:20 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nt2nemr4p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 15:08:20 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Fri, 16 Nov 2018 20:08:19 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 16 Nov 2018 20:08:15 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAGK8EsL46006524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 16 Nov 2018 20:08:14 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FF02AC060;
 Fri, 16 Nov 2018 20:08:14 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C91D8AC05B;
 Fri, 16 Nov 2018 20:08:09 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.80.224.199])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 16 Nov 2018 20:08:09 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Subject: [PATCH v8 01/14] MODSIGN: Export module signature definitions
Date: Fri, 16 Nov 2018 18:06:59 -0200
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181116200712.14154-1-bauerman@linux.ibm.com>
References: <20181116200712.14154-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111620-0064-0000-0000-0000037563FE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010063; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01118417; UDB=6.00577118; IPR=6.00898525; 
 MB=3.00024196; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-16 20:08:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111620-0065-0000-0000-00003B5B7D0E
Message-Id: <20181116200712.14154-2-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-16_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160178
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

IMA will use the module_signature format for append signatures, so export
the relevant definitions and factor out the code which verifies that the
appended signature trailer is valid.

Also, create a CONFIG_MODULE_SIG_FORMAT option so that IMA can select it
and be able to use validate_module_sig() without having to depend on
CONFIG_MODULE_SIG.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>
---
 include/linux/module.h           |  3 --
 include/linux/module_signature.h | 47 ++++++++++++++++++
 init/Kconfig                     |  6 ++-
 kernel/Makefile                  |  2 +-
 kernel/module.c                  |  1 +
 kernel/module_signing.c          | 82 ++++++++++++++------------------
 6 files changed, 91 insertions(+), 50 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index fce6b4335e36..e49bbc5c66ef 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -25,9 +25,6 @@
 #include <linux/percpu.h>
 #include <asm/module.h>
 
-/* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
-#define MODULE_SIG_STRING "~Module signature appended~\n"
-
 /* Not Yet Implemented */
 #define MODULE_SUPPORTED_DEVICE(name)
 
diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
new file mode 100644
index 000000000000..862ddc25dbd1
--- /dev/null
+++ b/include/linux/module_signature.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Module signature handling.
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#ifndef _LINUX_MODULE_SIGNATURE_H
+#define _LINUX_MODULE_SIGNATURE_H
+
+/* In stripped ARM and x86-64 modules, ~ is surprisingly rare. */
+#define MODULE_SIG_STRING "~Module signature appended~\n"
+
+enum pkey_id_type {
+	PKEY_ID_PGP,		/* OpenPGP generated key ID */
+	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
+	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
+};
+
+/*
+ * Module signature information block.
+ *
+ * The constituents of the signature section are, in order:
+ *
+ *	- Signer's name
+ *	- Key identifier
+ *	- Signature data
+ *	- Information block
+ */
+struct module_signature {
+	u8	algo;		/* Public-key crypto algorithm [0] */
+	u8	hash;		/* Digest algorithm [0] */
+	u8	id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
+	u8	signer_len;	/* Length of signer's name [0] */
+	u8	key_id_len;	/* Length of key identifier [0] */
+	u8	__pad[3];
+	__be32	sig_len;	/* Length of signature data */
+};
+
+struct load_info;
+
+int validate_module_sig(const struct module_signature *ms, size_t file_len,
+			const char *name);
+int mod_verify_sig(const void *mod, struct load_info *info);
+
+#endif /* _LINUX_MODULE_SIGNATURE_H */
diff --git a/init/Kconfig b/init/Kconfig
index a4112e95724a..cd31593525ee 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1864,7 +1864,7 @@ config MODULE_SRCVERSION_ALL
 config MODULE_SIG
 	bool "Module signature verification"
 	depends on MODULES
-	select SYSTEM_DATA_VERIFICATION
+	select MODULE_SIG_FORMAT
 	help
 	  Check modules for valid signatures upon load: the signature
 	  is simply appended to the module. For more information see
@@ -1879,6 +1879,10 @@ config MODULE_SIG
 	  debuginfo strip done by some packagers (such as rpmbuild) and
 	  inclusion into an initramfs that wants the module size reduced.
 
+config MODULE_SIG_FORMAT
+	def_bool n
+	select SYSTEM_DATA_VERIFICATION
+
 config MODULE_SIG_FORCE
 	bool "Require modules to be validly signed"
 	depends on MODULE_SIG
diff --git a/kernel/Makefile b/kernel/Makefile
index 7343b3a9bff0..e56842571348 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -59,7 +59,7 @@ obj-y += up.o
 endif
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
-obj-$(CONFIG_MODULE_SIG) += module_signing.o
+obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signing.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_CRASH_CORE) += crash_core.o
diff --git a/kernel/module.c b/kernel/module.c
index 49a405891587..205c9eefd08d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -19,6 +19,7 @@
 #include <linux/export.h>
 #include <linux/extable.h>
 #include <linux/moduleloader.h>
+#include <linux/module_signature.h>
 #include <linux/trace_events.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
diff --git a/kernel/module_signing.c b/kernel/module_signing.c
index f2075ce8e4b3..2912b7b1e814 100644
--- a/kernel/module_signing.c
+++ b/kernel/module_signing.c
@@ -11,36 +11,44 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/module_signature.h>
 #include <linux/string.h>
 #include <linux/verification.h>
 #include <crypto/public_key.h>
 #include "module-internal.h"
 
-enum pkey_id_type {
-	PKEY_ID_PGP,		/* OpenPGP generated key ID */
-	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
-	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
-};
-
-/*
- * Module signature information block.
+/**
+ * validate_module_sig - validate that the given signature is sane
  *
- * The constituents of the signature section are, in order:
- *
- *	- Signer's name
- *	- Key identifier
- *	- Signature data
- *	- Information block
+ * @ms:		Signature to validate.
+ * @file_len:	Size of the file to which @ms is appended.
  */
-struct module_signature {
-	u8	algo;		/* Public-key crypto algorithm [0] */
-	u8	hash;		/* Digest algorithm [0] */
-	u8	id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
-	u8	signer_len;	/* Length of signer's name [0] */
-	u8	key_id_len;	/* Length of key identifier [0] */
-	u8	__pad[3];
-	__be32	sig_len;	/* Length of signature data */
-};
+int validate_module_sig(const struct module_signature *ms, size_t file_len,
+			const char *name)
+{
+	if (be32_to_cpu(ms->sig_len) >= file_len - sizeof(*ms))
+		return -EBADMSG;
+
+	if (ms->id_type != PKEY_ID_PKCS7) {
+		pr_err("%s: Module is not signed with expected PKCS#7 message\n",
+		       name);
+		return -ENOPKG;
+	}
+
+	if (ms->algo != 0 ||
+	    ms->hash != 0 ||
+	    ms->signer_len != 0 ||
+	    ms->key_id_len != 0 ||
+	    ms->__pad[0] != 0 ||
+	    ms->__pad[1] != 0 ||
+	    ms->__pad[2] != 0) {
+		pr_err("%s: PKCS#7 signature info has unexpected non-zero params\n",
+		       name);
+		return -EBADMSG;
+	}
+
+	return 0;
+}
 
 /*
  * Verify the signature on a module.
@@ -49,6 +57,7 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 {
 	struct module_signature ms;
 	size_t sig_len, modlen = info->len;
+	int ret;
 
 	pr_devel("==>%s(,%zu)\n", __func__, modlen);
 
@@ -56,32 +65,15 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 		return -EBADMSG;
 
 	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
-	modlen -= sizeof(ms);
+
+	ret = validate_module_sig(&ms, modlen, info->name);
+	if (ret)
+		return ret;
 
 	sig_len = be32_to_cpu(ms.sig_len);
-	if (sig_len >= modlen)
-		return -EBADMSG;
-	modlen -= sig_len;
+	modlen -= sig_len + sizeof(ms);
 	info->len = modlen;
 
-	if (ms.id_type != PKEY_ID_PKCS7) {
-		pr_err("%s: Module is not signed with expected PKCS#7 message\n",
-		       info->name);
-		return -ENOPKG;
-	}
-
-	if (ms.algo != 0 ||
-	    ms.hash != 0 ||
-	    ms.signer_len != 0 ||
-	    ms.key_id_len != 0 ||
-	    ms.__pad[0] != 0 ||
-	    ms.__pad[1] != 0 ||
-	    ms.__pad[2] != 0) {
-		pr_err("%s: PKCS#7 signature info has unexpected non-zero params\n",
-		       info->name);
-		return -EBADMSG;
-	}
-
 	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
 				      NULL, VERIFYING_MODULE_SIGNATURE,
 				      NULL, NULL);

