Return-Path: <SRS0=nAOP=6W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5299DC38A2A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 05:06:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E74208D6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 05:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQvcOTAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E74208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49JJG80RbfzDrBH
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 15:06:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::444;
 helo=mail-pf1-x444.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=nQvcOTAF; dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49JHYY3HHbzDqwf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2020 14:34:57 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id w65so285623pfc.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2020 21:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N2warjY66Fmc76yXtaTxuHeaZ8gOJLKc/b6aC26FXDw=;
 b=nQvcOTAFh/34CAYvJzcfDkJblby1k9giqUUGnMPHoMVnk7pzY7JushFbNkz20vHVx0
 Osj2bsrEk1CqRP0XCBUB/6wMZbqSfIWRzYBxQi+Wmekx5qLq5wrKfGm+3Juuz8c/rZgr
 YMb5PVXH9+WOz2ym1TKR3XtfA4daDnlTDIuVpe2IxShVOJxZEwkCymp2KkWKv9Gwzzys
 0Mg3qsakYYnPLzV0qEjNHmgu5oG0HOC3dK453cWOAN9BZIVyo+NovdrlZWhWKlVMeAVh
 g3pRAgx7vunxl/mlK05UdSezOEcuKsh+qv8VF+4vkmzvABq6J2wbvbpKQ7iGitsRMpF+
 optw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N2warjY66Fmc76yXtaTxuHeaZ8gOJLKc/b6aC26FXDw=;
 b=IbtQJm/E4/9ejRrr3keEdQFydXUnaEBDBJGUKE/MnOKkE5aUEPloeOCRMY2EsicyGH
 1x7yi0m2XQ2HohqkWaeZKsdPW/ba9afQz6toxDJ5lzvyESXRlUZFQ2VbyO5sRfxXEfD3
 4Mm6KsAu3apM3AGlAqokX8Zr6wDTVJFTs5RhsaPWR222hKxz/IUA88Spihe5/2OqZ1Jt
 y2COALEnCP00fepBnT+NhA6hAr3I6MC5N1030ejqMV7dMguHRD5QSga6VjiMngN3wMpn
 u3U5LYMdFWmUVCttRV7yFlwiBdy0x0d2TRJ+zaEgHYGnL+9/N1chVKEYRXacU0uAYvzc
 t7WQ==
X-Gm-Message-State: AGi0PuYzX1JYG8iQ6Se0F3AuWwBG5aXGPDiucHcz1I4nSm9Hykizj6w4
 /VFfzWZpwlH1YzIG+ooNNZ0669c+
X-Google-Smtp-Source: APiQypLg1NhndXhnfy9O+JMt6U8us5elbDXl4t+8U8ybatrNG+2iUhfVZnKhwuvPBtvHGgNFatAOUA==
X-Received: by 2002:a63:c80e:: with SMTP id z14mr595638pgg.170.1588912493569; 
 Thu, 07 May 2020 21:34:53 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-214-199.tpgi.com.au. [61.68.214.199])
 by smtp.gmail.com with ESMTPSA id i9sm358813pfk.199.2020.05.07.21.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 21:34:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 15/16] powerpc/traps: make unrecoverable NMIs die instead
 of panic
Date: Fri,  8 May 2020 14:34:07 +1000
Message-Id: <20200508043408.886394-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200508043408.886394-1-npiggin@gmail.com>
References: <20200508043408.886394-1-npiggin@gmail.com>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

System Reset and Machine Check interrupts that are not recoverable due
to being nested or interrupting when RI=0 currently panic. This is
not necessary, and can often just kill the current context and recover.

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/traps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index ee209c5a1ad7..477befcda8d3 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -513,11 +513,11 @@ void system_reset_exception(struct pt_regs *regs)
 #ifdef CONFIG_PPC_BOOK3S_64
 	BUG_ON(get_paca()->in_nmi == 0);
 	if (get_paca()->in_nmi > 1)
-		nmi_panic(regs, "Unrecoverable nested System Reset");
+		die("Unrecoverable nested System Reset", regs, SIGABRT);
 #endif
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
-		nmi_panic(regs, "Unrecoverable System Reset");
+		die("Unrecoverable System Reset", regs, SIGABRT);
 
 	if (saved_hsrrs) {
 		mtspr(SPRN_HSRR0, hsrr0);
@@ -875,7 +875,7 @@ void machine_check_exception(struct pt_regs *regs)
 
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
-		nmi_panic(regs, "Unrecoverable Machine check");
+		die("Unrecoverable Machine check", regs, SIGBUS);
 
 	return;
 
-- 
2.23.0

