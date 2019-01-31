Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAFCC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 17:46:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C34220B1F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 17:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="SDoC3Gfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C34220B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43r72h46QTzDqcL
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Feb 2019 04:46:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="SDoC3Gfm"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43r70q1bC6zDqc9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2019 04:44:59 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43r70j4T7wz9vBKq;
 Thu, 31 Jan 2019 18:44:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=SDoC3Gfm; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id eKvne8ryPTPS; Thu, 31 Jan 2019 18:44:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43r70j30tgz9vBKn;
 Thu, 31 Jan 2019 18:44:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548956693; bh=ugoZ4ISKI/Wbc3x+9e2KTETw23VmyIlLo+gOrAR3JkI=;
 h=From:Subject:To:Cc:Date:From;
 b=SDoC3Gfm7FV7wDF3RLUH1e5K9f7/WNELtvyy0QaqUYZ1EZd8/f7JIVcQlrFc20q1U
 0wIB9oyitc7HdE6fwM6VHAq5DX/KVsQDmdilrmt9nF7oDQY3QO05SG50EHfOdFhzjm
 uU/qxhSqh/dnwr9Xq5UxgZy9CRnLQwzs8CECC1XY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 18D5D8B83A;
 Thu, 31 Jan 2019 18:44:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Qx5-lQXDOIpQ; Thu, 31 Jan 2019 18:44:55 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EAEEF8B835;
 Thu, 31 Jan 2019 18:44:54 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id BA05F72E25; Thu, 31 Jan 2019 17:44:54 +0000 (UTC)
Message-Id: <9f9dd859d571e324c7412ed9db9da8cfba678257.1548956511.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH] powerpc/6xx: Don't set back MSR_RI before reenabling MMU
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 31 Jan 2019 17:44:54 +0000 (UTC)
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

By delaying the setting of MSR_RI, a 1% improvment is optained on
null_syscall selftest on an mpc8321.

Without this patch:

root@vgoippro:~# ./null_syscall
   1134.33 ns     378.11 cycles

With this patch:

root@vgoippro:~# ./null_syscall
   1121.85 ns     373.95 cycles

The drawback is that a machine check during that period
would be unrecoverable, but as only main memory is accessed
during that period, it shouldn't be a concern.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 146385b1c2da..ea28a6ab56ec 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -282,8 +282,6 @@ __secondary_hold_acknowledge:
 	stw	r1,GPR1(r11);	\
 	stw	r1,0(r11);	\
 	tovirt(r1,r11);			/* set new kernel sp */	\
-	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR); /* can take exceptions */ \
-	MTMSRD(r10);			/* (except for mach check in rtas) */ \
 	stw	r0,GPR0(r11);	\
 	lis	r10,STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
 	addi	r10,r10,STACK_FRAME_REGS_MARKER@l; \
-- 
2.13.3

