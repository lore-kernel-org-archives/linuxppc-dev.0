Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3308C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:33:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C0120675
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C0120675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fp7B3Hk7zDqbx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 00:33:10 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fp0Y1VJ4zDqQ0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 00:27:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43fp0V53tZz9sBZ; Thu, 17 Jan 2019 00:27:22 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43fp0V0Ffrz9sD9; Thu, 17 Jan 2019 00:27:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH v2 1/5] powerpc/syscalls: Use the number when building SPU
 syscall table
Date: Thu, 17 Jan 2019 00:27:10 +1100
Message-Id: <20190116132714.20094-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
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
Cc: firoz.khan@linaro.org, arnd@arndb.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently the macro that inserts entries into the SPU syscall table
doesn't actually use the "nr" (syscall number) parameter.

This does work, but it relies on the exact right number of syscall
entries being emitted in order for the syscal numbers to line up with
the array entries. If for example we had two entries with the same
syscall number we wouldn't get an error, it would just cause all
subsequent syscalls to be off by one in the spu_syscall_table.

So instead change the macro to assign to the specific entry of the
array, meaning any numbering overlap will be caught by the compiler.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/spu_callbacks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v2: Add Arnd's ack.

diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
index 2f03671ac8db..8f94acdd6d6d 100644
--- a/arch/powerpc/platforms/cell/spu_callbacks.c
+++ b/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -34,7 +34,7 @@
  */
 
 void *spu_syscall_table[] = {
-#define __SYSCALL(nr, entry, nargs) entry,
+#define __SYSCALL(nr, entry, nargs) [nr] = entry,
 #include <asm/syscall_table_spu.h>
 #undef __SYSCALL
 };
-- 
2.20.1

