Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A35CC10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 11:53:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0372133D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 11:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0372133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fztw1xk1zDqQl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 21:53:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fzkz2cZBzDqQw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 21:46:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44fzky4mLLz9s9y; Thu, 11 Apr 2019 21:46:34 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44fzky2rYHz9s70; Thu, 11 Apr 2019 21:46:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.9 02/35] powerpc/64s: Add barrier_nospec
Date: Thu, 11 Apr 2019 21:45:57 +1000
Message-Id: <20190411114630.4042-3-mpe@ellerman.id.au>
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

From: Michal Suchanek <msuchanek@suse.de>

commit a6b3964ad71a61bb7c61d80a60bea7d42187b2eb upstream.

A no-op form of ori (or immediate of 0 into r31 and the result stored
in r31) has been re-tasked as a speculation barrier. The instruction
only acts as a barrier on newer machines with appropriate firmware
support. On older CPUs it remains a harmless no-op.

Implement barrier_nospec using this instruction.

mpe: The semantics of the instruction are believed to be that it
prevents execution of subsequent instructions until preceding branches
have been fully resolved and are no longer executing speculatively.
There is no further documentation available at this time.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/barrier.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 798ab37c9930..352ea3e3cc05 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -77,6 +77,21 @@ do {									\
 
 #define smp_mb__before_spinlock()   smp_mb()
 
+#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * Prevent execution of subsequent instructions until preceding branches have
+ * been fully resolved and are no longer executing speculatively.
+ */
+#define barrier_nospec_asm ori 31,31,0
+
+// This also acts as a compiler barrier due to the memory clobber.
+#define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
+
+#else /* !CONFIG_PPC_BOOK3S_64 */
+#define barrier_nospec_asm
+#define barrier_nospec()
+#endif
+
 #include <asm-generic/barrier.h>
 
 #endif /* _ASM_POWERPC_BARRIER_H */
-- 
2.20.1

