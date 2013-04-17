Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1679C2C0162
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2013 19:50:42 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: remove the unneeded trigger of decrementer interrupt
 in decrementer_check_overflow
Date: Wed, 17 Apr 2013 17:50:35 +0800
Message-ID: <1366192235-17480-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously in order to handle the edge sensitive decrementers,
we choose to set the decrementer to 1 to trigger a decrementer
interrupt when re-enabling interrupts. But with the rework of the
lazy EE, we would replay the decrementer interrupt when re-enabling
interrupts if a decrementer interrupt occurs with irq soft-disabled.
So there is no need to trigger a decrementer interrupt in this case
any more.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/kernel/irq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4f97fe3..1af5744 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -116,8 +116,6 @@ static inline notrace int decrementer_check_overflow(void)
  	u64 now = get_tb_or_rtc();
  	u64 *next_tb = &__get_cpu_var(decrementers_next_tb);
  
-	if (now >= *next_tb)
-		set_dec(1);
 	return now >= *next_tb;
 }
 
-- 
1.8.1.4
