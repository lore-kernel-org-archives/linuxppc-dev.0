Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4233AC10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:21:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2EF20859
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2EF20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nD2D71ymzDqD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:21:24 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBhs0xBMzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:21:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBhr0rD0z9sMQ; Mon, 22 Apr 2019 00:21:16 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBhn5xW4z9sLt; Mon, 22 Apr 2019 00:21:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 08/52] powerpc/rfi-flush: Differentiate enabled
 and patched flush types
Date: Mon, 22 Apr 2019 00:19:53 +1000
Message-Id: <20190421142037.21881-9-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190421142037.21881-1-mpe@ellerman.id.au>
References: <20190421142037.21881-1-mpe@ellerman.id.au>
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
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de,
 npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

commit 0063d61ccfc011f379a31acaeba6de7c926fed2c upstream.

Currently the rfi-flush messages print 'Using <type> flush' for all
enabled_flush_types, but that is not necessarily true -- as now the
fallback flush is always enabled on pseries, but the fixup function
overwrites its nop/branch slot with other flush types, if available.

So, replace the 'Using <type> flush' messages with '<type> flush is
available'.

Also, print the patched flush types in the fixup function, so users
can know what is (not) being used (e.g., the slower, fallback flush,
or no flush type at all if flush is disabled via the debugfs switch).

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c    | 6 +++---
 arch/powerpc/lib/feature-fixups.c | 9 ++++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6e9a4c1e8a4d..e975f2533767 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -911,15 +911,15 @@ static void init_fallback_flush(void)
 void setup_rfi_flush(enum l1d_flush_type types, bool enable)
 {
 	if (types & L1D_FLUSH_FALLBACK) {
-		pr_info("rfi-flush: Using fallback displacement flush\n");
+		pr_info("rfi-flush: fallback displacement flush available\n");
 		init_fallback_flush();
 	}
 
 	if (types & L1D_FLUSH_ORI)
-		pr_info("rfi-flush: Using ori type flush\n");
+		pr_info("rfi-flush: ori type flush available\n");
 
 	if (types & L1D_FLUSH_MTTRIG)
-		pr_info("rfi-flush: Using mttrig type flush\n");
+		pr_info("rfi-flush: mttrig type flush available\n");
 
 	enabled_flush_types = types;
 
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 3af014684872..b76b9b6b3a85 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -151,7 +151,14 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 		patch_instruction(dest + 2, instrs[2]);
 	}
 
-	printk(KERN_DEBUG "rfi-flush: patched %d locations\n", i);
+	printk(KERN_DEBUG "rfi-flush: patched %d locations (%s flush)\n", i,
+		(types == L1D_FLUSH_NONE)       ? "no" :
+		(types == L1D_FLUSH_FALLBACK)   ? "fallback displacement" :
+		(types &  L1D_FLUSH_ORI)        ? (types & L1D_FLUSH_MTTRIG)
+							? "ori+mttrig type"
+							: "ori type" :
+		(types &  L1D_FLUSH_MTTRIG)     ? "mttrig type"
+						: "unknown");
 }
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
-- 
2.20.1

