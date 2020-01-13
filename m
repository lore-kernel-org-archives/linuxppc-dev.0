Return-Path: <SRS0=2lRn=3C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ACFC33CA9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jan 2020 17:29:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13533206DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jan 2020 17:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UjWNw3Qp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13533206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47xLDp72VMzDqLL
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 04:29:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.a=rsa-sha256
 header.s=mail header.b=UjWNw3Qp; dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47xKmz4kLQzDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2020 04:08:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 47xKmq18QMz9v0DP;
 Mon, 13 Jan 2020 18:08:43 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=UjWNw3Qp; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id B9T6ObAEkSau; Mon, 13 Jan 2020 18:08:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 47xKmp6WlNz9tyXf;
 Mon, 13 Jan 2020 18:08:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1578935322; bh=8NMCNHuubcE6t4e17wk7DBu9YLriy2ZDehAsOAuF4AM=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=UjWNw3QpjSpsFOvUaUM8OtpncTUsaDVW9fyOtxPvIgOjuPt21K4VGlFLKAZvHGAtg
 DX/ABsxBaXP3v+YseN/kLMMmCMS6KlqlBycosWAZM50e9rJLMJtj+tUVoQ8kLmhZf0
 0+1xi5QWHkWEUZO1UnR9hyZyBn2sJlPTBiymcRl4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CA3A8B7C9;
 Mon, 13 Jan 2020 18:08:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id MOJBmvXIlLvR; Mon, 13 Jan 2020 18:08:48 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 05B648B7BE;
 Mon, 13 Jan 2020 18:08:48 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id CF0AD64A1D; Mon, 13 Jan 2020 17:08:47 +0000 (UTC)
Message-Id: <ecb0105333f0b95f233565e12282c451d99b2915.1578934751.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1578934751.git.christophe.leroy@c-s.fr>
References: <cover.1578934751.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v3 09/12] powerpc/vdso: provide inline alternative to
 __get_datapage()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
 luto@kernel.org
Date: Mon, 13 Jan 2020 17:08:47 +0000 (UTC)
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
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

__get_datapage() is only a few instructions to retrieve the
address of the page where the kernel stores data to the VDSO.

By inlining this function into its users, a bl/blr pair and
a mflr/mtlr pair is avoided, plus a few reg moves.

The improvement is noticeable (about 55 nsec/call on an 8xx)

With current __get_datapage() function:
gettimeofday:    vdso: 731 nsec/call
clock-gettime-realtime-coarse:    vdso: 668 nsec/call
clock-gettime-monotonic-coarse:    vdso: 745 nsec/call

Using the __get_datapage macro provided by this patch:
gettimeofday:    vdso: 677 nsec/call
clock-gettime-realtime-coarse:    vdso: 613 nsec/call
clock-gettime-monotonic-coarse:    vdso: 690 nsec/call

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/vdso_datapage.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index 4d7965bf369e..7342cc0c1ae4 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -105,6 +105,17 @@ struct vdso_arch_data {
 
 extern struct vdso_arch_data *vdso_data;
 
+#else /* __ASSEMBLY__ */
+
+.macro get_datapage ptr, offset=0
+	bcl	20, 31, .+4
+	mflr	\ptr
+#if CONFIG_PPC_PAGE_SHIFT > 14
+	addis	\ptr, \ptr, (_vdso_datapage + \offset - (.-4))@ha
+#endif
+	addi	\ptr, \ptr, (_vdso_datapage + \offset - (.-4))@l
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
-- 
2.13.3

