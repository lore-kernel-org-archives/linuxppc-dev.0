Return-Path: <SRS0=yiwx=H3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D89C433E6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 22:06:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD9F64EBA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 22:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD9F64EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dmn240cJZz3dCh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Feb 2021 09:06:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=bqphPTJ9;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PCci/Pr0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256
 header.s=2020 header.b=bqphPTJ9; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=PCci/Pr0; 
 dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dmn1b4GqSz3ckd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2021 09:06:27 +1100 (AEDT)
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1614290784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=y1kOxZAz1PS35rSHX1Q1Ehy2Rvgctil+MlY8VvUpVeM=;
 b=bqphPTJ9Qo1TuGLHrUjO6wVHCBNeSADaPV0XwqTE0Bpab+6ikJi7H4vu4atASKb6IH3Qw1
 opUOyrZLWDCrk5wexObxu0agdUNkZ0/0wa/UGytDwneezeO6dVSiD25bE5Y7KtDUxTW8qQ
 S4C9fBAX+mqy+1kifk9Ayc7eWMfuOTmcz/AnROBaLFpDgfVd17tHR9gkGVJJW1orOI3fq4
 U1EY2Q1x165411WMmukJXegwyAb1nSg8TU5+v0ybpPkriAJH2IG1+kZEzlMpmCa4kV/t26
 H5xt62luD8p0t77Zqc05I+AKPCMnKCzHOyLFHdj+A/Jx6rn5ESxRi1CUUE2nnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1614290784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=y1kOxZAz1PS35rSHX1Q1Ehy2Rvgctil+MlY8VvUpVeM=;
 b=PCci/Pr0JkVNcGiz0S5XvXVc3KWN8mW8tJ2wd55lhAvIGql3p7Ek93TByeCcpMB3zO1eEO
 tMScaHc5VP7yBiAQ==
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH v1] powerpc: low_i2c: change @lock to raw_spinlock_t
Date: Thu, 25 Feb 2021 23:06:23 +0100
Message-Id: <20210225220623.30543-1-john.ogness@linutronix.de>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Qinglang Miao <miaoqinglang@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

i2c transfers are occurring with local interrupts disabled:

smp_core99_give_timebase()
  local_irq_save();
  smp_core99_cypress_tb_freeze()
    pmac_i2c_xfer()
      kw_i2c_xfer()
        spin_lock_irqsave(&host->lock, flags)

This is a problem because with PREEMPT_RT a spinlock_t can sleep,
causing the system to hang. Convert the spinlock_t to the
non-sleeping raw_spinlock_t.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index f77a59b5c2e1..ba89c95ef290 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -116,7 +116,7 @@ struct pmac_i2c_host_kw
 	int			polled;
 	int			result;
 	struct completion	complete;
-	spinlock_t		lock;
+	raw_spinlock_t		lock;
 	struct timer_list	timeout_timer;
 };
 
@@ -346,14 +346,14 @@ static irqreturn_t kw_i2c_irq(int irq, void *dev_id)
 	struct pmac_i2c_host_kw *host = dev_id;
 	unsigned long flags;
 
-	spin_lock_irqsave(&host->lock, flags);
+	raw_spin_lock_irqsave(&host->lock, flags);
 	del_timer(&host->timeout_timer);
 	kw_i2c_handle_interrupt(host, kw_read_reg(reg_isr));
 	if (host->state != state_idle) {
 		host->timeout_timer.expires = jiffies + KW_POLL_TIMEOUT;
 		add_timer(&host->timeout_timer);
 	}
-	spin_unlock_irqrestore(&host->lock, flags);
+	raw_spin_unlock_irqrestore(&host->lock, flags);
 	return IRQ_HANDLED;
 }
 
@@ -362,7 +362,7 @@ static void kw_i2c_timeout(struct timer_list *t)
 	struct pmac_i2c_host_kw *host = from_timer(host, t, timeout_timer);
 	unsigned long flags;
 
-	spin_lock_irqsave(&host->lock, flags);
+	raw_spin_lock_irqsave(&host->lock, flags);
 
 	/*
 	 * If the timer is pending, that means we raced with the
@@ -377,7 +377,7 @@ static void kw_i2c_timeout(struct timer_list *t)
 		add_timer(&host->timeout_timer);
 	}
  skip:
-	spin_unlock_irqrestore(&host->lock, flags);
+	raw_spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static int kw_i2c_open(struct pmac_i2c_bus *bus)
@@ -470,9 +470,9 @@ static int kw_i2c_xfer(struct pmac_i2c_bus *bus, u8 addrdir, int subsize,
 			unsigned long flags;
 
 			u8 isr = kw_i2c_wait_interrupt(host);
-			spin_lock_irqsave(&host->lock, flags);
+			raw_spin_lock_irqsave(&host->lock, flags);
 			kw_i2c_handle_interrupt(host, isr);
-			spin_unlock_irqrestore(&host->lock, flags);
+			raw_spin_unlock_irqrestore(&host->lock, flags);
 		}
 	}
 
@@ -508,7 +508,7 @@ static struct pmac_i2c_host_kw *__init kw_i2c_host_init(struct device_node *np)
 	}
 	mutex_init(&host->mutex);
 	init_completion(&host->complete);
-	spin_lock_init(&host->lock);
+	raw_spin_lock_init(&host->lock);
 	timer_setup(&host->timeout_timer, kw_i2c_timeout, 0);
 
 	psteps = of_get_property(np, "AAPL,address-step", NULL);
-- 
2.20.1

