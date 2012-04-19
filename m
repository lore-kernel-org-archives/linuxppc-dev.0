Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C73D3B7071
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 19:04:54 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Thu, 19 Apr 2012 08:18:58 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3J8DBOr1740808
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:13:11 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3J8JmM6008291
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:19:49 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/15] powerpc/pmac: Don't add_timer() twice
Date: Thu, 19 Apr 2012 18:16:48 +1000
Message-Id: <1334823416-9138-8-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
Cc: khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the interrupt and the timeout happen roughly at the same
time, we can get into a situation where the timer function
is run while the interrupt has already been processed. In
this case, the timer function might end up doing an add_timer
on an already pending timer, causing a BUG_ON() to trigger.

Instead, just skip the whole timeout operation if we see that
the timer is pending. The spinlock ensures that the only way
that happens is if we already started a new operation and thus
the timeout can be ignored.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powermac/low_i2c.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index f991dbb..fc536f2 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -366,11 +366,20 @@ static void kw_i2c_timeout(unsigned long data)
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
+
+	/*
+	 * If the timer is pending, that means we raced with the
+	 * irq, in which case we just return
+	 */
+	if (timer_pending(&host->timeout_timer))
+		goto skip;
+
 	kw_i2c_handle_interrupt(host, kw_read_reg(reg_isr));
 	if (host->state != state_idle) {
 		host->timeout_timer.expires = jiffies + KW_POLL_TIMEOUT;
 		add_timer(&host->timeout_timer);
 	}
+ skip:
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-- 
1.7.9.5
