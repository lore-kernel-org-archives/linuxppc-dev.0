Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CF6C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:52:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBD2218D0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="lzI7Amhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBD2218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W78N20B3zDqNs
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 03:52:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="lzI7Amhs"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W6qt0yJkzDqNs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 03:38:34 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44W6qn1qx4z9tyQZ;
 Fri, 29 Mar 2019 17:38:29 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=lzI7Amhs; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id nHak3OelUdlX; Fri, 29 Mar 2019 17:38:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44W6qn0dfQz9tyQP;
 Fri, 29 Mar 2019 17:38:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553877509; bh=a109k03KMwPFAs5u10vLKdRLKmIcCJ2dwFi67fYh9/s=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=lzI7AmhsSd0gZOIGS2ZGFrDlQha6wGXVP6EwVy4f95xfsFakuf9i5uCGUx2PWoTvQ
 3tXL+c8GU6eoH3JdBEUtvRJ/g/NYp5bK1H9jOIMxRdS0JnDt8c9EFR5PzWVk4BfWVI
 91dz+dacXu8pHd7BYeJfPGz4kKhAG92CAG95GD70=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AB90F8B93D;
 Fri, 29 Mar 2019 17:38:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id nmleAuXyxHgz; Fri, 29 Mar 2019 17:38:30 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 91A0D8B938;
 Fri, 29 Mar 2019 17:38:30 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 7E41B6FC56; Fri, 29 Mar 2019 16:38:30 +0000 (UTC)
Message-Id: <b88a6913cf1660c6aa2135ef7e900a6e0e0eb332.1553877076.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553877076.git.christophe.leroy@c-s.fr>
References: <cover.1553877076.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 08/17] powerpc/fsl_booke: ensure
 SPEFloatingPointException() reenables interrupts
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 29 Mar 2019 16:38:30 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SPEFloatingPointException() is the only exception handler which 'forgets' to
re-enable interrupts. This patch makes sure it does.

Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/traps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1fd45a8650e1..665f294725cb 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -2088,6 +2088,10 @@ void SPEFloatingPointException(struct pt_regs *regs)
 	int code = FPE_FLTUNK;
 	int err;
 
+	/* We restore the interrupt state now */
+	if (!arch_irq_disabled_regs(regs))
+		local_irq_enable();
+
 	flush_spe_to_thread(current);
 
 	spefscr = current->thread.spefscr;
@@ -2133,6 +2137,10 @@ void SPEFloatingPointRoundException(struct pt_regs *regs)
 	extern int speround_handler(struct pt_regs *regs);
 	int err;
 
+	/* We restore the interrupt state now */
+	if (!arch_irq_disabled_regs(regs))
+		local_irq_enable();
+
 	preempt_disable();
 	if (regs->msr & MSR_SPE)
 		giveup_spe(current);
-- 
2.13.3

