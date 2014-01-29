Return-Path: <nicolas.pitre@linaro.org>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
 by ozlabs.org (Postfix) with ESMTP id 297272C02FB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 04:45:26 +1100 (EST)
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N0600IRCBZJOTG0@VL-VM-MR006.ip.videotron.ca> for
 linuxppc-dev@lists.ozlabs.org; Wed, 29 Jan 2014 12:45:19 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Russell King <linux@arm.linux.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, Paul Mundt <lethal@linux-sh.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2 5/6] X86: remove redundant cpuidle_idle_call()
Date: Wed, 29 Jan 2014 12:45:12 -0500
Message-id: <1391017513-12995-6-git-send-email-nicolas.pitre@linaro.org>
In-reply-to: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The core idle loop now takes care of it.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/x86/kernel/process.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 3fb8d95ab8..4505e2a950 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -298,10 +298,7 @@ void arch_cpu_idle_dead(void)
  */
 void arch_cpu_idle(void)
 {
-	if (cpuidle_idle_call())
-		x86_idle();
-	else
-		local_irq_enable();
+	x86_idle();
 }
 
 /*
-- 
1.8.4.108.g55ea5f6
