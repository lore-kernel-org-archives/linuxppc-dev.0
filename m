Return-Path: <SRS0=bRvR=GM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78572C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Jan 2021 03:40:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C05FB23998
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Jan 2021 03:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05FB23998
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codefail.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DCQjG1GvnzDr0f
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Jan 2021 14:40:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=codefail.de (client-ip=131.153.2.42;
 helo=h1.fbrelay.privateemail.com; envelope-from=cmr@codefail.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=codefail.de
Received: from h1.fbrelay.privateemail.com (h1.fbrelay.privateemail.com
 [131.153.2.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DCQbm65CbzDqwW
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jan 2021 14:35:47 +1100 (AEDT)
Received: from MTA-07-4.privateemail.com (mta-07.privateemail.com
 [198.54.127.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 205CE80009
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2021 22:26:16 -0500 (EST)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
 by MTA-07.privateemail.com (Postfix) with ESMTP id 66943600C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2021 22:26:05 -0500 (EST)
Received: from oc8246131445.ibm.com (unknown [10.20.151.217])
 by MTA-07.privateemail.com (Postfix) with ESMTPA id 380E1600CD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jan 2021 03:26:05 +0000 (UTC)
From: "Christopher M. Riedl" <cmr@codefail.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 2/8] powerpc/signal: Add unsafe_copy_{vsx,fpr}_from_user()
Date: Fri,  8 Jan 2021 21:25:51 -0600
Message-Id: <20210109032557.13831-3-cmr@codefail.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210109032557.13831-1-cmr@codefail.de>
References: <20210109032557.13831-1-cmr@codefail.de>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Reuse the "safe" implementation from signal.c except for calling
unsafe_copy_from_user() to copy into a local buffer.

Signed-off-by: Christopher M. Riedl <cmr@codefail.de>
---
 arch/powerpc/kernel/signal.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index 2559a681536e..c18402d625f1 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -53,6 +53,33 @@ unsigned long copy_ckfpr_from_user(struct task_struct *task, void __user *from);
 				&buf[i], label);\
 } while (0)
 
+#define unsafe_copy_fpr_from_user(task, from, label)	do {		\
+	struct task_struct *__t = task;					\
+	u64 __user *__f = (u64 __user *)from;				\
+	u64 buf[ELF_NFPREG];						\
+	int i;								\
+									\
+	unsafe_copy_from_user(buf, __f, ELF_NFPREG * sizeof(double),	\
+				label);					\
+	for (i = 0; i < ELF_NFPREG - 1; i++)				\
+		__t->thread.TS_FPR(i) = buf[i];				\
+	__t->thread.fp_state.fpscr = buf[i];				\
+} while (0)
+
+#define unsafe_copy_vsx_from_user(task, from, label)	do {		\
+	struct task_struct *__t = task;					\
+	u64 __user *__f = (u64 __user *)from;				\
+	u64 buf[ELF_NVSRHALFREG];					\
+	int i;								\
+									\
+	unsafe_copy_from_user(buf, __f,					\
+				ELF_NVSRHALFREG * sizeof(double),	\
+				label);					\
+	for (i = 0; i < ELF_NVSRHALFREG ; i++)				\
+		__t->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];	\
+} while (0)
+
+
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 #define unsafe_copy_ckfpr_to_user(to, task, label)	do {		\
 	struct task_struct *__t = task;					\
@@ -80,6 +107,10 @@ unsigned long copy_ckfpr_from_user(struct task_struct *task, void __user *from);
 	unsafe_copy_to_user(to, (task)->thread.fp_state.fpr,	\
 			    ELF_NFPREG * sizeof(double), label)
 
+#define unsafe_copy_fpr_from_user(task, from, label)			\
+	unsafe_copy_from_user((task)->thread.fp_state.fpr, from,	\
+			    ELF_NFPREG * sizeof(double), label)
+
 static inline unsigned long
 copy_fpr_to_user(void __user *to, struct task_struct *task)
 {
@@ -115,6 +146,8 @@ copy_ckfpr_from_user(struct task_struct *task, void __user *from)
 #else
 #define unsafe_copy_fpr_to_user(to, task, label) do { } while (0)
 
+#define unsafe_copy_fpr_from_user(task, from, label) do { } while (0)
+
 static inline unsigned long
 copy_fpr_to_user(void __user *to, struct task_struct *task)
 {
-- 
2.26.1

