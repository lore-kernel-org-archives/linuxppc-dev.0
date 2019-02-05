Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6981CC282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 12:03:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E972080F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 12:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E972080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v3Bz46kjzDqBb
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 23:03:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v2W73KM4zDqHn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 22:32:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43v2W70QZ8z9sN9; Tue,  5 Feb 2019 22:32:51 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43v2W61bFDz9sNN; Tue,  5 Feb 2019 22:32:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v16 14/21] powerpc: Use task_stack_page() in current_pt_regs()
Date: Tue,  5 Feb 2019 22:32:12 +1100
Message-Id: <20190205113219.17903-15-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205113219.17903-1-mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

Change current_pt_regs() to use task_stack_page() rather than
current_thread_info() so that it keeps working once we enable
THREAD_INFO_IN_TASK.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
[mpe: Split out of large patch]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/ptrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 0b8a735b6d85..64271e562fed 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -157,7 +157,7 @@ extern int ptrace_put_reg(struct task_struct *task, int regno,
 			  unsigned long data);
 
 #define current_pt_regs() \
-	((struct pt_regs *)((unsigned long)current_thread_info() + THREAD_SIZE) - 1)
+	((struct pt_regs *)((unsigned long)task_stack_page(current) + THREAD_SIZE) - 1)
 /*
  * We use the least-significant bit of the trap field to indicate
  * whether we have saved the full set of registers, or only a
-- 
2.20.1

