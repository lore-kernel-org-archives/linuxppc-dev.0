Return-Path: <SRS0=kIvJ=ER=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9776C388F9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 10:24:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79B820756
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 10:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s57UBg2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79B820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CWLRw71llzDqyB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2020 21:23:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=s57UBg2U; dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CWKZc5z9KzDqML
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2020 20:44:40 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id j5so696771plk.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2020 01:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D7WAeaguotZYLz1Bm4ohm/HOX3EeMRpx6Mt1mCtP4ag=;
 b=s57UBg2UpDTAog/m7yAy1ZLmbQHB2Sf1YXdwKCy8kTVS+n8KFfvne8SgVnoaeT2g9V
 1R1CHvK85vPefbc/EFAFt7lDWcCgMr2vEYOy9YkJoAJEWizlg4/ywoBSz+kX59a+IHVm
 FdybElqnTInhHkw9LIBToUm4Z51tWMuIfEwwEI7yT2JnxVyRJKo18XFdSRC0WhYdH2tw
 n0vDULUn+7f5E5rjgLz7NhFwrOce0/qUCDHIm99CuQYU0i5+u5JyPg02t8ReJskNMfk1
 dqVhX4NtpCqpEMyZ6frGtUYzaC9RbK8a78zMPcfPailcGMXygeRlN48MN8TwBZGXgI8n
 S25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D7WAeaguotZYLz1Bm4ohm/HOX3EeMRpx6Mt1mCtP4ag=;
 b=edINlClIzg3lpqbT5zgQ8rjX+PZxXsX9TOROihNlWauFPstrn1o3scOFHOxV2fZxzh
 lIQkyrFo3kWk3uV5/rvWHLpWEDPWtQToqrF2z45MtOi5t7ZfV2KWHQNVAVDe32bVdwjp
 Jx6gP6IhnOZP3BU+ZWQAAiSqWfU4J3HDGLqrHvd3TrKZlBLqajU28ThtqNtnmTqQ/+Er
 MlyrJpJe6KZZ4WUkaV+ZeWcTvsMDZD4qwPKz55J+jPAWiwbU23gDMx4zeSZKLWoIAtL9
 nwA3dbrSwZSdyCw+3amnwpSbtek6T6ETcEEJ8SlsD5xOPnb4VJjEiJJJjQEoV4eH5lRi
 EbiA==
X-Gm-Message-State: AOAM533BQwkprqWjRyucRQeJdm6Hdcg2OCaMzueE4CVEGgqg2yrthcH1
 PqBf9+dhk5uQumMUHWpXHGuZJpHYzUE=
X-Google-Smtp-Source: ABdhPJx/Q1JzbFmPrAnUiualpzK0/iGB1EPa5VsimnfKVLfqkkUecbyxpEYWHxrOZQa8HNO/MIoaXQ==
X-Received: by 2002:a17:902:c016:b029:d7:1a0:7cf0 with SMTP id
 v22-20020a170902c016b02900d701a07cf0mr20155624plx.64.1605087877998; 
 Wed, 11 Nov 2020 01:44:37 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (27-32-36-31.tpgi.com.au. [27.32.36.31])
 by smtp.gmail.com with ESMTPSA id a3sm2046129pfd.58.2020.11.11.01.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 01:44:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 10/19] powerpc/64: add context tracking to asynchronous
 interrupts
Date: Wed, 11 Nov 2020 19:44:01 +1000
Message-Id: <20201111094410.3038123-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201111094410.3038123-1-npiggin@gmail.com>
References: <20201111094410.3038123-1-npiggin@gmail.com>
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

Previously context tracking was not done for asynchronous interrupts,
(those that run in interrupt context), and if those would cause a
reschedule when they exit, then scheduling functions (schedule_user,
preempt_schedule_irq) call exception_enter/exit to fix this up and
exit user context.

This is a hack we would like to get away from, so do context tracking
for asynchronous interrupts too.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/interrupt.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index e1724d4387b9..ef1f6b595ffd 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -42,10 +42,12 @@ static inline void interrupt_exit_prepare(struct pt_regs *regs, struct interrupt
 
 static inline void interrupt_async_enter_prepare(struct pt_regs *regs, struct interrupt_state *state)
 {
+	interrupt_enter_prepare(regs, state);
 }
 
 static inline void interrupt_async_exit_prepare(struct pt_regs *regs, struct interrupt_state *state)
 {
+	interrupt_exit_prepare(regs, state);
 }
 
 struct interrupt_nmi_state {
-- 
2.23.0

