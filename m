Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E752C3F6B0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Aug 2022 13:35:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MBqxR18lDz3c9p
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Aug 2022 23:35:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=chenzhongjin@huawei.com; receiver=<UNKNOWN>)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MBqwx2Dh3z2xJD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2022 23:35:26 +1000 (AEST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MBqr81mPrzkWSD;
	Tue, 23 Aug 2022 21:31:20 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 21:34:49 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 21:34:35 +0800
From: Chen Zhongjin <chenzhongjin@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] objtool: replace _ASM_PTR with quad in macros
Date: Tue, 23 Aug 2022 21:31:24 +0800
Message-ID: <20220823133124.55914-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
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
Cc: peterz@infradead.org, sv@linux.ibm.com, mhiramat@kernel.org, naveen.n.rao@linux.vnet.ibm.com, bp@suse.de, chenzhongjin@huawei.com, jpoimboe@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Macros STACK_FRAME_NON_STANDARD and ANNOTATE_NOENDBR uses
_ASM_PTR. It switch between .long and .quad based on 32bit
or 64bit. However objtool doesn't work for 32bit, so _ASM_PTR
makes no sense.

Considering that _ASM_PTR comes from asm.h, which is x86
specific head file, while objtool.h is generic. Replace
_ASM_PTR with quad and remove asm.h reference.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 include/linux/objtool.h       | 6 ++----
 tools/include/linux/objtool.h | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 62c54ffbeeaa..d2413cb78037 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -45,8 +45,6 @@ struct unwind_hint {
 
 #ifdef CONFIG_OBJTOOL
 
-#include <asm/asm.h>
-
 #ifndef __ASSEMBLY__
 
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
@@ -87,7 +85,7 @@ struct unwind_hint {
 #define ANNOTATE_NOENDBR					\
 	"986: \n\t"						\
 	".pushsection .discard.noendbr\n\t"			\
-	_ASM_PTR " 986b\n\t"					\
+	".quad 986b\n\t"					\
 	".popsection\n\t"
 
 #define ASM_REACHABLE							\
@@ -144,7 +142,7 @@ struct unwind_hint {
 
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-	_ASM_PTR \func
+	.quad \func
 	.popsection
 .endm
 
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 62c54ffbeeaa..d2413cb78037 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -45,8 +45,6 @@ struct unwind_hint {
 
 #ifdef CONFIG_OBJTOOL
 
-#include <asm/asm.h>
-
 #ifndef __ASSEMBLY__
 
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
@@ -87,7 +85,7 @@ struct unwind_hint {
 #define ANNOTATE_NOENDBR					\
 	"986: \n\t"						\
 	".pushsection .discard.noendbr\n\t"			\
-	_ASM_PTR " 986b\n\t"					\
+	".quad 986b\n\t"					\
 	".popsection\n\t"
 
 #define ASM_REACHABLE							\
@@ -144,7 +142,7 @@ struct unwind_hint {
 
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-	_ASM_PTR \func
+	.quad \func
 	.popsection
 .endm
 
-- 
2.17.1

