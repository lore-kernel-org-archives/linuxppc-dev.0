Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D64C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 12:03:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7E1217F4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 12:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7E1217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44g06N3d6CzDqQb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 22:03:24 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fzl92YR1zDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 21:46:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44fzl90d8Fz9sDn; Thu, 11 Apr 2019 21:46:45 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44fzl84R74z9sMQ; Thu, 11 Apr 2019 21:46:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.9 08/35] powerpc/64: Use barrier_nospec in syscall
 entry
Date: Thu, 11 Apr 2019 21:46:03 +1000
Message-Id: <20190411114630.4042-9-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411114630.4042-1-mpe@ellerman.id.au>
References: <20190411114630.4042-1-mpe@ellerman.id.au>
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
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

commit 51973a815c6b46d7b23b68d6af371ad1c9d503ca upstream.

Our syscall entry is done in assembly so patch in an explicit
barrier_nospec.

Based on a patch by Michal Suchanek.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/entry_64.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index e24ae0fa80ed..11e390662384 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -38,6 +38,7 @@
 #include <asm/context_tracking.h>
 #include <asm/tm.h>
 #include <asm/ppc-opcode.h>
+#include <asm/barrier.h>
 #include <asm/export.h>
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/exception-64s.h>
@@ -180,6 +181,15 @@ system_call:			/* label this so stack traces look sane */
 	clrldi	r8,r8,32
 15:
 	slwi	r0,r0,4
+
+	barrier_nospec_asm
+	/*
+	 * Prevent the load of the handler below (based on the user-passed
+	 * system call number) being speculatively executed until the test
+	 * against NR_syscalls and branch to .Lsyscall_enosys above has
+	 * committed.
+	 */
+
 	ldx	r12,r11,r0	/* Fetch system call handler [ptr] */
 	mtctr   r12
 	bctrl			/* Call handler */
-- 
2.20.1

