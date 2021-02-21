Return-Path: <SRS0=YiAJ=HX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49858C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Feb 2021 01:25:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01F9600CD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Feb 2021 01:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01F9600CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codefail.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DjngT37psz3d3R
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Feb 2021 12:25:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=codefail.de (client-ip=68.65.122.27;
 helo=mta-07-4.privateemail.com; envelope-from=cmr@codefail.de;
 receiver=<UNKNOWN>)
Received: from MTA-07-4.privateemail.com (mta-07-4.privateemail.com
 [68.65.122.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Djnf40q7lz30Pl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2021 12:24:09 +1100 (AEDT)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
 by MTA-07.privateemail.com (Postfix) with ESMTP id B7A1060047;
 Sat, 20 Feb 2021 20:24:06 -0500 (EST)
Received: from oc8246131445.ibm.com (unknown [10.20.151.213])
 by MTA-07.privateemail.com (Postfix) with ESMTPA id 8163760049;
 Sun, 21 Feb 2021 01:24:06 +0000 (UTC)
From: "Christopher M. Riedl" <cmr@codefail.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 02/10] powerpc/signal: Add unsafe_copy_{vsx,
 fpr}_from_user()
Date: Sat, 20 Feb 2021 19:23:53 -0600
Message-Id: <20210221012401.22328-3-cmr@codefail.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210221012401.22328-1-cmr@codefail.de>
References: <20210221012401.22328-1-cmr@codefail.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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
Cc: Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Reuse the "safe" implementation from signal.c but call unsafe_get_user()
directly in a loop to avoid the intermediate copy into a local buffer.

Signed-off-by: Christopher M. Riedl <cmr@codefail.de>
Reviewed-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/signal.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index 2559a681536e..d8dd76b1dc94 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -53,6 +53,26 @@ unsigned long copy_ckfpr_from_user(struct task_struct *task, void __user *from);
 				&buf[i], label);\
 } while (0)
 
+#define unsafe_copy_fpr_from_user(task, from, label)	do {		\
+	struct task_struct *__t = task;					\
+	u64 __user *buf = (u64 __user *)from;				\
+	int i;								\
+									\
+	for (i = 0; i < ELF_NFPREG - 1; i++)				\
+		unsafe_get_user(__t->thread.TS_FPR(i), &buf[i], label); \
+	unsafe_get_user(__t->thread.fp_state.fpscr, &buf[i], label);	\
+} while (0)
+
+#define unsafe_copy_vsx_from_user(task, from, label)	do {		\
+	struct task_struct *__t = task;					\
+	u64 __user *buf = (u64 __user *)from;				\
+	int i;								\
+									\
+	for (i = 0; i < ELF_NVSRHALFREG ; i++)				\
+		unsafe_get_user(__t->thread.fp_state.fpr[i][TS_VSRLOWOFFSET], \
+				&buf[i], label);			\
+} while (0)
+
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 #define unsafe_copy_ckfpr_to_user(to, task, label)	do {		\
 	struct task_struct *__t = task;					\
@@ -80,6 +100,10 @@ unsigned long copy_ckfpr_from_user(struct task_struct *task, void __user *from);
 	unsafe_copy_to_user(to, (task)->thread.fp_state.fpr,	\
 			    ELF_NFPREG * sizeof(double), label)
 
+#define unsafe_copy_fpr_from_user(task, from, label)			\
+	unsafe_copy_from_user((task)->thread.fp_state.fpr, from,	\
+			    ELF_NFPREG * sizeof(double), label)
+
 static inline unsigned long
 copy_fpr_to_user(void __user *to, struct task_struct *task)
 {
@@ -115,6 +139,8 @@ copy_ckfpr_from_user(struct task_struct *task, void __user *from)
 #else
 #define unsafe_copy_fpr_to_user(to, task, label) do { } while (0)
 
+#define unsafe_copy_fpr_from_user(task, from, label) do { } while (0)
+
 static inline unsigned long
 copy_fpr_to_user(void __user *to, struct task_struct *task)
 {
-- 
2.26.1

