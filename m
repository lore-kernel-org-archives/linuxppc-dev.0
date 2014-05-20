Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews05.kpnxchange.com (cpsmtpb-ews05.kpnxchange.com
 [213.75.39.8])
 by lists.ozlabs.org (Postfix) with ESMTP id 1F23E1A04BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 06:25:02 +1000 (EST)
Message-ID: <1400617498.4912.66.camel@x220>
Subject: [PATCH] powerpc: fix typo 'CONFIG_PMAC'
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Tue, 20 May 2014 22:24:58 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit b0d278b7d3ae ("powerpc/perf_event: Reduce latency of calling
perf_event_do_pending") added a check for CONFIG_PMAC were a check for
CONFIG_PPC_PMAC was clearly intended.

Fixes: b0d278b7d3ae ("powerpc/perf_event: Reduce latency of calling perf_event_do_pending")
Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested. Needs testing on 32 bit powermac, I guess.

This typo was introduced in v2.6.36. No one noticed because very few
people still use 32 bit powermacs?

 arch/powerpc/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 122a580f7322..bb3cfa10a4ea 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -551,7 +551,7 @@ void timer_interrupt(struct pt_regs * regs)
 	may_hard_irq_enable();
 

-#if defined(CONFIG_PPC32) && defined(CONFIG_PMAC)
+#if defined(CONFIG_PPC32) && defined(CONFIG_PPC_PMAC)
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
 		do_IRQ(regs);
 #endif
-- 
1.9.0
