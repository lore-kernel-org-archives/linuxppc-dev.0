Return-Path: <SRS0=RfJf=5E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC5C4332D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 07:05:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0751A20714
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 07:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tli73Npw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0751A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48jdFl6QQ5zDrBl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 18:04:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::544;
 helo=mail-pg1-x544.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Tli73Npw; dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48jd9t4vVczDr5R
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2020 18:01:37 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id u12so744066pgb.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2020 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p7RU8iP2/BJyBARlUg58yvEyysSwoyVzs2GzWwZXEZI=;
 b=Tli73NpwpNhjGI6zJEJ/udrN/oZXm30lXeGbwkRbK4wf3JFqHWhQhI20mLQOQCvsqg
 sL4s7/3B0BRzI0CcTIJc1846xhBsWuu9YqbvqgsCLla27hFUeId17NfGZlSLGZW35zE4
 ImCTafYfIOcF+nTmlFEHGHn5lPSA97DZHKawKn9p/UGbfWAsbR13lZ5dBxYIj2lpctcv
 wSymUKQneYV8WGWTz6p2FtsKy8FZO8xCPOVCdfirMtnUY/l7f8187jnPSA5CTL8F3GNW
 zMzn0knuMMDBDd8mcC+mz45cCNjwQLbHLSVfM7olFbWsPZPWMOysFgW6TcgKCMQ/J3NI
 PWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p7RU8iP2/BJyBARlUg58yvEyysSwoyVzs2GzWwZXEZI=;
 b=X7dyseLZBvYdipuuefaRp9S51plXXMZbq8TQlWRmleiwL2n9FcjskEmvTsi9LD427w
 7bgTGTU8TSNZ+UoR7B5MIDIKK19vexSgkUS0dYs5B8ornxFeTxg6T+SZWzV5GoSi7dqV
 E5U8akZkYhtlaOEFcoPZ9s8L2EDds56utbhva1muO8gxkfGe3GCGgI9ykXczMN6oujGp
 yJmWGaAftORvVpvm/ZXdr54RQYaQJ60kkPLIdibI2IoX7pYkAO1tOMHokJZfR1w9OeOj
 XQRIq7WLTN2QJBUAU1r3NpqlN3ZJZWYiXq9VNnIAJ1UlmYfe/U5Glikj+DA7GPuMEjgi
 JM6Q==
X-Gm-Message-State: ANhLgQ0A0fWSMTeG8oeGz40MZIvT5mwl4yR+d51hMWCsH+N5Hk1KFeAO
 qJ7xNKh9UXW2JKwAn9KdBTbZFHk2
X-Google-Smtp-Source: ADFU+vsz9OG60vU+AXCirAERcwzl4GtZNgrQU5B3oFi3iAljb/ZpXZ56IuHNw3hoBdo+tLULGkPLfA==
X-Received: by 2002:aa7:84c9:: with SMTP id x9mr2458201pfn.191.1584601294894; 
 Thu, 19 Mar 2020 00:01:34 -0700 (PDT)
Received: from bobo.ibm.com (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id g11sm1140417pfm.4.2020.03.19.00.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 00:01:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Fix "[v3,
 28/32] powerpc/64s: interrupt implement exit logic in C"
Date: Thu, 19 Mar 2020 16:59:34 +1000
Message-Id: <20200319065934.1021079-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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

Accessing thread_info flags can cause an SLB fault, so it must not
be done with MSR[RI]=0, which leads to SLB unrecoverable fault error.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/syscall_64.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall_64.c
index 87d95b455b83..a56ae78f2d1d 100644
--- a/arch/powerpc/kernel/syscall_64.c
+++ b/arch/powerpc/kernel/syscall_64.c
@@ -313,12 +313,18 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 {
 	unsigned long *ti_flagsp = &current_thread_info()->flags;
 	unsigned long flags;
+	unsigned long ret = 0;
 
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S) && unlikely(!(regs->msr & MSR_RI)))
 		unrecoverable_exception(regs);
 	BUG_ON(regs->msr & MSR_PR);
 	BUG_ON(!FULL_REGS(regs));
 
+	if (unlikely(*ti_flagsp & _TIF_EMULATE_STACK_STORE)) {
+		clear_bits(_TIF_EMULATE_STACK_STORE, ti_flagsp);
+		ret = 1;
+	}
+
 	local_irq_save(flags);
 
 	if (regs->softe == IRQS_ENABLED) {
@@ -370,10 +376,6 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 	 */
 	kuap_restore_amr(regs);
 
-	if (unlikely(*ti_flagsp & _TIF_EMULATE_STACK_STORE)) {
-		clear_bits(_TIF_EMULATE_STACK_STORE, ti_flagsp);
-		return 1;
-	}
-	return 0;
+	return ret;
 }
 #endif
-- 
2.23.0

