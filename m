Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7147AB702E
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jul 2011 12:36:30 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v2 PATCH 2/2] booke/kprobe: remove unnecessary
	preempt_enable_no_resched
Date: Mon, 11 Jul 2011 10:39:35 +0800
Message-ID: <1310351976-24078-2-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1310351976-24078-1-git-send-email-tiejun.chen@windriver.com>
References: <1310351976-24078-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When enable CONFIG_PREEMPT we will trigger the following call trace:

BUG: scheduling while atomic: swapper/1/0x10000000
...

krpobe always goes through the following path:

program_check_exception()
        |
        + notify_die(DIE_BPT, "breakpoint",...)
                |
                + kprobe_handler()
                        |
                        + preempt_disable();
                        + break_handler() <- preempt_enable_no_resched()
                        + emulate_step()
                        + preempt_enable_no_resched()
                        ...
        exit

We should remove unnecessary preempt_enable_no_resched() inside of break_handler()
since looks longjmp_break_handler() always go the above path.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/kprobes.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index bc47352..a8a2a4d 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -552,7 +552,6 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 	 * saved regs...
 	 */
 	memcpy(regs, &kcb->jprobe_saved_regs, sizeof(struct pt_regs));
-	preempt_enable_no_resched();
 	return 1;
 }
 
-- 
1.5.6
