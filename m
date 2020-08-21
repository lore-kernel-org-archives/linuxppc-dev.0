Return-Path: <SRS0=lwUg=B7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299C4C433E3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:36:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BF520738
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ZmjgC9SC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BF520738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BXycV53h7zDr8D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 20:36:42 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BXyYb3NKbzDr6Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2020 20:34:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ZmjgC9SC; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BXyYZ4kXlz9sPB; Fri, 21 Aug 2020 20:34:10 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BXyYZ3g1Jz9sTF; Fri, 21 Aug 2020 20:34:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1598006050;
 bh=6IeqeXu1SmWY4L/7HoCdAVC4LYQ5JZ6uDzQLdVBwQJE=;
 h=From:To:Subject:Date:From;
 b=ZmjgC9SCu3LdZY6ddacoKS51YDBExb5EPp5UA3aivmAa+wz1k/BKRM03d5Mbukrce
 E2bKkDezY+AnfAzKgKHlaUfQgsNrxnnswz4PHEUHNT89/NpkiTpFYYgU5eS2seNprI
 FehHhK2fTQi2I/skNfsKtqtxadjMu+wph5gqi0e2EEbjnvhQoiljoAdVreW4iOPvT5
 1PvfnD7xwAhI0+kXk4TDUmYelNs9eDHuth8UWCfhaDB78atRqWOaYMni/GvRh6QX13
 B9HwiX3bk0U0mpoq+GpKPi6yEBJFuJbwzc+TzVHr7vByvhsvmuEctey7Xubwc94lQu
 7Q//HEcinwGbg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/prom_init: Check display props exist before enabling
 btext
Date: Fri, 21 Aug 2020 20:34:07 +1000
Message-Id: <20200821103407.3362149-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

It's possible to enable CONFIG_PPC_EARLY_DEBUG_BOOTX for a pseries
kernel (maybe it shouldn't be), which is then booted with qemu/slof.

But if you do that the kernel crashes in draw_byte(), with a DAR
pointing somewhere near INT_MAX.

Adding some debug to prom_init we see that we're not able to read the
"address" property from OF, so we're just using whatever junk value
was on the stack.

So check the properties can be read properly from OF, if not we bail
out before initialising btext, which avoids the crash.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom_init.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index ae7ec9903191..5090a5ab54e5 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2422,10 +2422,19 @@ static void __init prom_check_displays(void)
 			u32 width, height, pitch, addr;
 
 			prom_printf("Setting btext !\n");
-			prom_getprop(node, "width", &width, 4);
-			prom_getprop(node, "height", &height, 4);
-			prom_getprop(node, "linebytes", &pitch, 4);
-			prom_getprop(node, "address", &addr, 4);
+
+			if (prom_getprop(node, "width", &width, 4) == PROM_ERROR)
+				return;
+
+			if (prom_getprop(node, "height", &height, 4) == PROM_ERROR)
+				return;
+
+			if (prom_getprop(node, "linebytes", &pitch, 4) == PROM_ERROR)
+				return;
+
+			if (prom_getprop(node, "address", &addr, 4) == PROM_ERROR)
+				return;
+
 			prom_printf("W=%d H=%d LB=%d addr=0x%x\n",
 				    width, height, pitch, addr);
 			btext_setup_display(width, height, 8, pitch, addr);
-- 
2.25.1

