Return-Path: <SRS0=ePRe=5K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC348C1975A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 04:07:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D379206F6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 04:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="hdpKfmv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D379206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nF214f8YzDqvT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 15:07:21 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48nF0F6fk3zDqPv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2020 15:05:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.a=rsa-sha256
 header.s=201811 header.b=hdpKfmv4; dkim-atps=neutral
Received: from neuling.org (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 48nF0D4wJBz9sP7;
 Wed, 25 Mar 2020 15:05:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1585109148;
 bh=YzJoELGp/3jb+/tl4np6wJBKoxQQ64bLswZwIjF6zCo=;
 h=From:To:Cc:Subject:Date:From;
 b=hdpKfmv4i0MfMx3A1dqExnD/s9FXZ3PjmUeXz51I0DtpkgiQ/iOtFdBBtqWbGT8f3
 bhjWImLCYvgoDCiSaAZD5wv4V5f8VP1vUJKeTjSRdd1cHNHGEOBN6+YqL1QsXrT1Q2
 dEP7X9yHQ+NT/GHSR6DdPcVxzz/zkDJd0d981L/zJfg0Pc/Bv6q9IY5cqSz3D0PD1B
 SCobH9hM0TJRF7EekKCfq0j+5UcnoHYFCwsexrHxODbJmgl6oowv9wmnau2vpqn/5A
 5MrsyZv7GJWFFhY9zTOwDSV7lV0xKsLk+WLv14+jbzobNumjue0XNRfy0tdEBPo/qt
 /5HJYNFM41h/g==
Received: by neuling.org (Postfix, from userid 1000)
 id 8734C2C0240; Wed, 25 Mar 2020 15:05:48 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Subject: [PATCH] powerpc/tm: Document h/rfid and mtmsrd quirk
Date: Wed, 25 Mar 2020 15:05:46 +1100
Message-Id: <20200325040546.3091563-1-mikey@neuling.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com, Gustavo Romero <gromero@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The ISA has a quirk that's useful for the Linux implementation.
Document it here so others are less likely to trip over it.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../powerpc/transactional_memory.rst          | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/powerpc/transactional_memory.rst b/Documentation/powerpc/transactional_memory.rst
index 09955103ac..74ae71001a 100644
--- a/Documentation/powerpc/transactional_memory.rst
+++ b/Documentation/powerpc/transactional_memory.rst
@@ -245,3 +245,30 @@ POWER9N DD2.2.
 Guest migration from POWER8 to POWER9 will work with POWER9N DD2.2 and
 POWER9C DD1.2. Since earlier POWER9 processors don't support TM
 emulation, migration from POWER8 to POWER9 is not supported there.
+
+Kernel implementation
+=====================
+
+h/rfid mtmsrd quirk
+===================
+
+As defined in the ISA, rfid has a quirk which is useful in early
+exception handling. When in a userspace transaction and we enter the
+kernel via some exception, MSR will end up as TM=0 and TS=01 (ie. TM
+off but TM suspended). Regularly the kernel will want change bits in
+the MSR and will perform an rfid to do this. In this case rfid can
+have SRR0 TM = 0 and TS = 00 (ie. TM off and non transaction) and the
+resulting MSR will retain TM = 0 and TS=01 from before (ie. stay in
+suspend). This is a quirk in the architecture as this would normally
+be a transition from TS=01 to TS=00 (ie. suspend -> non transactional)
+which is an illegal transition.
+
+This quirk is described the architecture in the definition of rfid
+with these lines:
+
+  if (MSR 29:31 ¬ = 0b010 | SRR1 29:31 ¬ = 0b000) then
+     MSR 29:31 <- SRR1 29:31
+
+hrfid and mtmsrd have the same quirk.
+
+The Linux kernel uses this quirk in it's early exception handling.
-- 
2.25.1

