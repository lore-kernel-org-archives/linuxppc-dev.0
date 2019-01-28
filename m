Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB266C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 11:21:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356EA214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 11:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="m8QWAqim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356EA214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43p6dN1q3LzDqCH
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 22:21:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="m8QWAqim"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43p6Q23JD7zDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 22:11:22 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43p6Pr6CgWz9v1qB;
 Mon, 28 Jan 2019 12:11:12 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=m8QWAqim; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id vnNPX1_sIHPf; Mon, 28 Jan 2019 12:11:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43p6Pr5617z9v1q3;
 Mon, 28 Jan 2019 12:11:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548673872; bh=NlqFJ1s5i4VAlel5PS716pJ3Faba940iLFOUBMdSEdI=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=m8QWAqim+080I1LEXa78u6e4zbQyF5C6IyS25Z+w4QX7v+EdB1Tj/CcVuzegYrb8/
 UPRAA6hS4w6MzQOGEcr4AjfN6I6VbbBNgy0JL87wS4H4TkFa4+DFZH61hAmE3pXcCA
 ZtYIUXFOaHHygvbJ7x3H6cxCHCo4mKZUeQXDDgFs=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E01E8B79D;
 Mon, 28 Jan 2019 12:11:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id j_ia7CnyPgZ8; Mon, 28 Jan 2019 12:11:19 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E8658B796;
 Mon, 28 Jan 2019 12:11:19 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 0C8B572DE6; Mon, 28 Jan 2019 11:11:19 +0000 (UTC)
Message-Id: <261649c2a789e3321c886f1e6f8741f8a8cdad86.1548673552.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548673552.git.christophe.leroy@c-s.fr>
References: <cover.1548673552.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 04/11] powerpc/32: add CLR_MSR_WE() in EXCEPTION_PROLOG in
 head_32.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 28 Jan 2019 11:11:19 +0000 (UTC)
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

Add CLR_MSR_WE() macro to allow 40x to clear
that bit from the register containing msr value.

This is the only difference between common EXCEPTION_PROLOG
and 40x one. This patch will allow 40x to use the common one.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 9e6fb9d468f0..643dd8d34aac 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -8,6 +8,10 @@
 #define SET_AND_STORE_MSR_RI(reg)
 #endif
 
+#ifndef CLR_MSR_WE
+#define CLR_MSR_WE(reg)
+#endif
+
 /*
  * Exception entry code.  This code runs with address translation
  * turned off, i.e. using physical addresses.
@@ -49,6 +53,7 @@
 	stw	r1,0(r11);	\
 	tovirt(r1,r11);			/* set new kernel sp */	\
 	SET_AND_STORE_MSR_RI(r10);	/* can take exceptions */ \
+	CLR_MSR_WE(r9);		\
 	stw	r0,GPR0(r11);	\
 	lis	r10,STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */ \
 	addi	r10,r10,STACK_FRAME_REGS_MARKER@l; \
-- 
2.13.3

