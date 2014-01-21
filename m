Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B533E2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 09:24:19 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Neuling <mikey@neuling.org>
Subject: [PATCH] powerpc: fix hw breakpoints on !HAVE_HW_BREAKPOINT
 configurations
References: <1356048405-20560-1-git-send-email-mikey@neuling.org>
 <1356048405-20560-7-git-send-email-mikey@neuling.org>
 <12813.1357794092__45363.9676016339$1357794149$gmane$org@ale.ozlabs.ibm.com>
Date: Tue, 21 Jan 2014 23:24:02 +0100
In-Reply-To: <12813.1357794092__45363.9676016339$1357794149$gmane$org@ale.ozlabs.ibm.com>
 (Michael Neuling's message of "Thu, 10 Jan 2013 16:01:32 +1100")
Message-ID: <8761pdht31.fsf_-_@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a logic error that caused a failure to update the hw breakpoint
registers when not using the hw-breakpoint interface.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 4a96556..7714950 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -690,7 +690,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
  * schedule DABR
  */
 #ifndef CONFIG_HAVE_HW_BREAKPOINT
-	if (unlikely(hw_brk_match(&__get_cpu_var(current_brk), &new->thread.hw_brk)))
+	if (unlikely(!hw_brk_match(&__get_cpu_var(current_brk), &new->thread.hw_brk)))
 		set_breakpoint(&new->thread.hw_brk);
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif
-- 
1.8.5.3


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
