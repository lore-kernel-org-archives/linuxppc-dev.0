Return-Path: <SRS0=gZAI=7B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD4BC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2020 00:37:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46B42075F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2020 00:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46B42075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Qxmt0jgGzDqpC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2020 10:37:50 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49QxgS5zKGzDqJf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2020 10:33:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49QxgS3GjYz9sSt;
 Tue, 19 May 2020 10:33:08 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/7] powerpc: Add new HWCAP bits
Date: Tue, 19 May 2020 10:31:51 +1000
Message-Id: <20200519003157.31946-2-alistair@popple.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519003157.31946-1-alistair@popple.id.au>
References: <20200519003157.31946-1-alistair@popple.id.au>
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
Cc: mikey@neuling.org, npiggin@gmail.com, aneesh.kumar@linux.ibm.com,
 Alistair Popple <alistair@popple.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

POWER10 introduces two new architectural features - ISAv3.1 and matrix
multiply accumulate (MMA) instructions. Userspace detects the presence
of these features via two HWCAP bits introduced in this patch. These
bits have been agreed to by the compiler and binutils team.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/include/uapi/asm/cputable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
index 540592034740..2692a56bf20b 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -50,6 +50,8 @@
 #define PPC_FEATURE2_DARN		0x00200000 /* darn random number insn */
 #define PPC_FEATURE2_SCV		0x00100000 /* scv syscall */
 #define PPC_FEATURE2_HTM_NO_SUSPEND	0x00080000 /* TM w/out suspended state */
+#define PPC_FEATURE2_ARCH_3_1		0x00040000 /* ISA 3.1 */
+#define PPC_FEATURE2_MMA		0x00020000 /* Matrix Multiply Accumulate */
 
 /*
  * IMPORTANT!
-- 
2.20.1

