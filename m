Return-Path: <SRS0=iuvT=5L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D973C43331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 19:14:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1DD2070A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 19:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvF1POmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1DD2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48pF642YbdzDqyp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2020 06:14:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=GvF1POmZ; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48pF3T04w6zDqdk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2020 06:12:03 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id b9so2516488pls.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2020 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oBe6cdzee5hNjgTO2u9aN47l/InyNYMSPSGVC/YCCl8=;
 b=GvF1POmZ+AG2fqB2BgiVbRA1CqYdCVwhxLHWvg4j+8YSeFCF8TqX7+QFME3K/dDXtS
 mNMeTWq5btscIjV+HMr2TOR8qJnVU8pklASeor69LPph5Gk3QcVLjvI6KFqEXXnCklc3
 /KHRCCI8X+ZSf6uKrJHuLknk96awhJc7GaIfGR5Hs2/F+FGXBBscNHDjGAkRnxizm7Jq
 /vtvD5EEtI3vx7ROe8AwHApNp6poeDPswh9N/1cxgC944a7dhqAg7rnZEPgEMZiFMx5Q
 a2oi61fXrO2JvfNhWS1r0umqychk5ZrJ3S1HTPkttYGFBdNYHqfFozULg1yMAK6+XFMk
 RPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oBe6cdzee5hNjgTO2u9aN47l/InyNYMSPSGVC/YCCl8=;
 b=OoHw5DwtbSVwBqEYiBsS0W+QJqzr/F64k5wbusrdAPJ1v+wiwJT7ORfs/PDZ0XiQK4
 OfvZHvH5B/jlVibIS9EMNdljrpGUx3AYJ2GzWV13XrIieUk6qL1tMxbBulqOmrRXgbrs
 JXp6lQ0RorU3FC9RXVdu+o+kfeG9c6HLAODCDm2g/kJJXC5ipd2uDwodgN4NcW4OmaBk
 bj2ZAve1Rtu7VCelf2I49qWKkEguz0PzEPtjLN8vgvy5ToaVzR+yOty2kfe269lDqJPf
 thI6NxPyGkzHkVT8CcA8IuFMndVY4F4Ciwy0J8WQh6AKSgY7Yqk1oMXNE3uLt15eDRZN
 Jj/Q==
X-Gm-Message-State: ANhLgQ10xzmrOha1l5RLqHraBqWROZBmdWo7Tv1WUFK4mY7C2w+2hbPh
 jQclHn1Jqi7p0iFTGRQsXRRTQaeM
X-Google-Smtp-Source: ADFU+vsbjZKoZuboj1+VUcJa7cVtZ6BdJgFTT9Zf50RRoHOGLSoCv5j0FhdM31d1NE11KrZDBrHKbw==
X-Received: by 2002:a17:90b:3556:: with SMTP id
 lt22mr1618332pjb.138.1585249919990; 
 Thu, 26 Mar 2020 12:11:59 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (14-202-190-183.tpgi.com.au.
 [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id l1sm2184517pje.9.2020.03.26.12.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:11:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Fix 4 "[v3,
 28/32] powerpc/64s: interrupt implement exit logic in C"
Date: Fri, 27 Mar 2020 05:10:33 +1000
Message-Id: <20200326191033.297798-1-npiggin@gmail.com>
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

The return-to-kernel path has to replay any soft-pending interrupts if it is
returning to a context that had interrupts soft-enabled. It has to do this
carefully and avoid plain enabling interrupts if this is an irq context,
which can cause multiple nesting of interrupts on the stack, and other
unexpected issues.

The code which avoided this case got the soft-mask state wrong, and
marked interrupts as enabled before going around again to retry. This
seems to be mostly harmless except when PREEMPT=y, this calls
preempt_schedule_irq with irqs apparently enabled and runs into a BUG
in kernel/sched/core.c

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/syscall_64.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall_64.c
index 049608d811c7..cf06eb443a80 100644
--- a/arch/powerpc/kernel/syscall_64.c
+++ b/arch/powerpc/kernel/syscall_64.c
@@ -342,11 +342,15 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 			trace_hardirqs_off();
 			local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
 			/*
-			 * Can't local_irq_enable in case we are in interrupt
-			 * context. Must replay directly.
+			 * Can't local_irq_restore to replay if we were in
+			 * interrupt context. Must replay directly.
 			 */
-			replay_soft_interrupts();
-			irq_soft_mask_set(flags);
+			if (irqs_disabled_flags(flags)) {
+				replay_soft_interrupts();
+			} else {
+				local_irq_restore(flags);
+				local_irq_save(flags);
+			}
 			/* Took an interrupt, may have more exit work to do. */
 			goto again;
 		}
-- 
2.23.0

