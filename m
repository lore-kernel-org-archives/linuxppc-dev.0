Return-Path: <SRS0=+9Gk=I2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170CEC433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Mar 2021 21:02:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375776191C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Mar 2021 21:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375776191C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=me.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F7p7T4DFXz30FP
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 08:02:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=me.com header.i=@me.com header.a=rsa-sha256 header.s=1a1hai header.b=uyVCtTQQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=me.com
 (client-ip=17.58.6.47; helo=pv50p00im-zteg10021401.me.com;
 envelope-from=sxwjean@me.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=me.com header.i=@me.com header.a=rsa-sha256
 header.s=1a1hai header.b=uyVCtTQQ; dkim-atps=neutral
X-Greylist: delayed 344 seconds by postgrey-1.36 at boromir;
 Mon, 29 Mar 2021 01:41:41 AEDT
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com
 [17.58.6.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7dh55Vv0z2xYd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Mar 2021 01:41:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1616942155; bh=Ow0/kmASW8C17u8xlB5YZpkDJsBZ6QXmxxYqzlWdjE0=;
 h=From:To:Subject:Date:Message-Id;
 b=uyVCtTQQk6fMjMILnAMKvYGL5WBdz3SaHw7q2bQeA+uTlvI2Z9YIEAttpb7lC+fCL
 dBdSFCbrRQvmM/od9PF5mJfW8WdOv46Cfqyig0BWakJeLneY3Hvi2Xs9iZgO+kTxMS
 lTsl4SuyZMcBuAxSGfDE1bgNOdOQMXRopFOp2YPtCfzQJxIhIZKFe0uGcyRl0VVc5o
 9K+oHSx+MyBRqDpSLaskpeR2KvpmqdL98ou9jqqbpPfHQMczgef0Mz9Zx8OPDlbD58
 AiHJLAjLMYLbGY5JpwDvOD70727ZL8VK289CJcxOGDjbO514wGQNbITuNITEb3kz/T
 b0nWSpEbFJzjQ==
Received: from localhost.localdomain (unknown [120.245.2.89])
 by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id BD265480408;
 Sun, 28 Mar 2021 14:35:51 +0000 (UTC)
From: Xiongwei Song <sxwjean@me.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 npiggin@gmail.com, christophe.leroy@csgroup.eu,
 ravi.bangoria@linux.ibm.com, mikey@neuling.org, aneesh.kumar@linux.ibm.com,
 haren@linux.ibm.com
Subject: [PATCH] powerpc/process: Enhance readability for trap types.
Date: Sun, 28 Mar 2021 22:35:45 +0800
Message-Id: <20210328143545.24324-1-sxwjean@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-28_07:2021-03-26,
 2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=802 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2103280113
X-Mailman-Approved-At: Mon, 29 Mar 2021 08:02:05 +1100
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
Cc: Xiongwei Song <sxwjean@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Xiongwei Song <sxwjean@gmail.com>

Define macros to enhance the code readability on ppc trap types.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/powerpc/kernel/process.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 3231c2df9e26..3bbd3cf353a7 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1451,6 +1451,10 @@ static void print_msr_bits(unsigned long val)
 #define LAST_VOLATILE	12
 #endif
 
+#define TRAP_MC  0x200 /* Machine Check */
+#define TRAP_DSI 0x300 /* DSI exception */
+#define TRAP_AM  0x600 /* Alignment exception */
+
 static void __show_regs(struct pt_regs *regs)
 {
 	int i, trap;
@@ -1465,7 +1469,7 @@ static void __show_regs(struct pt_regs *regs)
 	trap = TRAP(regs);
 	if (!trap_is_syscall(regs) && cpu_has_feature(CPU_FTR_CFAR))
 		pr_cont("CFAR: "REG" ", regs->orig_gpr3);
-	if (trap == 0x200 || trap == 0x300 || trap == 0x600) {
+	if (trap == TRAP_MC || trap == TRAP_DSI || trap == TRAP_AM) {
 		if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
 			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
 		else
-- 
2.17.1

