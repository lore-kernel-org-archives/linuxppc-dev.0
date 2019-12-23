Return-Path: <SRS0=KcrN=2N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A446C2D0C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Dec 2019 07:56:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B171206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Dec 2019 07:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="vB7eCzA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B171206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47hBWB72JSzDqQ5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Dec 2019 18:56:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="vB7eCzA7"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47hBT254vfzDqDs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2019 18:54:28 +1100 (AEDT)
Received: from localhost (mailhub1-ext [192.168.12.233])
 by localhost (Postfix) with ESMTP id 47hBSp6LlPz9tyVy;
 Mon, 23 Dec 2019 08:54:18 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=vB7eCzA7; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id yYpcIDcCzsSE; Mon, 23 Dec 2019 08:54:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 47hBSp58wpz9tyVf;
 Mon, 23 Dec 2019 08:54:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1577087658; bh=hkKxahRiPSAEMe/USu//uOwiIXNh/xpJtVcNhRacSz4=;
 h=From:Subject:To:Cc:Date:From;
 b=vB7eCzA7rGplvY2F2ekFh/WjZgrGdfiyQUwmzn6VPp+zHfrTrENwh62td5tKITqea
 P82kgK0m3HOm56zXeiuQCNym3YmttLCru35zjuGurMcR0QC2/1Ora1qkWflqe1DsLk
 FRIh6ve/rg3bpkHHs3BYlzfCXqTgnAUR7s74921M=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 552018B798;
 Mon, 23 Dec 2019 08:54:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id XCcVzaFsk9zN; Mon, 23 Dec 2019 08:54:23 +0100 (CET)
Received: from po16098vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.230.100])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 38C3C8B752;
 Mon, 23 Dec 2019 08:54:23 +0100 (CET)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 0D547637C8; Mon, 23 Dec 2019 07:54:22 +0000 (UTC)
Message-Id: <0728849e826ba16f1fbd6fa7f5c6cc87bd64e097.1577087627.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/mm: don't log user reads to 0xffffffff
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 23 Dec 2019 07:54:22 +0000 (UTC)
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

Running vdsotest leaves many times the following log:

[   79.629901] vdsotest[396]: User access of kernel address (ffffffff) - exploit attempt? (uid: 0)

A pointer set to (-1) is likely a programming error similar to
a NULL pointer and is not worth logging as an exploit attempt.

Don't log user accesses to 0xffffffff.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index b5047f9b5dec..d3b4d444bf3c 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -354,6 +354,9 @@ static void sanity_check_fault(bool is_write, bool is_user,
 	 * Userspace trying to access kernel address, we get PROTFAULT for that.
 	 */
 	if (is_user && address >= TASK_SIZE) {
+		if ((long)address == -1)
+			return;
+
 		pr_crit_ratelimited("%s[%d]: User access of kernel address (%lx) - exploit attempt? (uid: %d)\n",
 				   current->comm, current->pid, address,
 				   from_kuid(&init_user_ns, current_uid()));
-- 
2.13.3

