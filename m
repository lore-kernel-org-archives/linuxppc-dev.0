Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/perf: Fix deadlock caused by calling printk() in PMU
 exception
Date: Thu,  6 Jun 2013 13:58:20 +1000
Message-Id: <1370491100-781-1-git-send-email-michael@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, sukadev@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit bc09c21 "Fix finding overflowed PMC in interrupt" we added
a printk() to the PMU exception handler. Unfortunately that is not safe.

The problem is that the PMU exception may run even when interrupts are
soft disabled, aka NMI context. We do this so that we can profile parts
of the kernel that have interrupts soft-disabled.

But by calling printk() from the exception handler, we can potentially
deadlock in the printk code on logbuf_lock, eg:

  [c00000038ba575c0] c000000000081928 .vprintk_emit+0xa8/0x540
  [c00000038ba576a0] c0000000007bcde8 .printk+0x48/0x58
  [c00000038ba57710] c000000000076504 .perf_event_interrupt+0x2d4/0x490
  [c00000038ba57810] c00000000001f6f8 .performance_monitor_exception+0x48/0x60
  [c00000038ba57880] c0000000000032cc performance_monitor_common+0x14c/0x180
  --- Exception: f01 (Performance Monitor) at c0000000007b25d4 ._raw_spin_lock_irq
  +0x64/0xc0
  [c00000038ba57bf0] c00000000007ed90 .devkmsg_read+0xd0/0x5a0
  [c00000038ba57d00] c0000000001c2934 .vfs_read+0xc4/0x1e0
  [c00000038ba57d90] c0000000001c2cd8 .SyS_read+0x58/0xd0
  [c00000038ba57e30] c000000000009d54 syscall_exit+0x0/0x98
  --- Exception: c01 (System Call) at 00001fffffbf6f7c
  SP (3ffff6d4de10) is in userspace

Fix it by making sure we only call printk() when we are not in NMI
context.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Cc: <stable@vger.kernel.org> # 3.9
---
 arch/powerpc/perf/core-book3s.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 845c867..29c6482 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1758,7 +1758,7 @@ static void perf_event_interrupt(struct pt_regs *regs)
 			}
 		}
 	}
-	if ((!found) && printk_ratelimit())
+	if (!found && !nmi && printk_ratelimit())
 		printk(KERN_WARNING "Can't find PMC that caused IRQ\n");
 
 	/*
-- 
1.7.10.4
