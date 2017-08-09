Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS9rJ0LYRzDqvc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 22:41:52 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id 83so5798831pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Aug 2017 05:41:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/6] powerpc: NMI IPI improve lock primitive
Date: Wed,  9 Aug 2017 22:41:21 +1000
Message-Id: <20170809124126.28907-2-npiggin@gmail.com>
In-Reply-To: <20170809124126.28907-1-npiggin@gmail.com>
References: <20170809124126.28907-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the NMI IPI lock is contended, spin at low SMT priority, using
loads only, and with interrupts enabled (where possible). This
improves behaviour under high contention (e.g., a system crash when
a number of CPUs are trying to enter the debugger).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index cf0e1245b8cc..8d3320562c70 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -351,7 +351,7 @@ static void nmi_ipi_lock_start(unsigned long *flags)
 	hard_irq_disable();
 	while (atomic_cmpxchg(&__nmi_ipi_lock, 0, 1) == 1) {
 		raw_local_irq_restore(*flags);
-		cpu_relax();
+		spin_until_cond(atomic_read(&__nmi_ipi_lock) == 0);
 		raw_local_irq_save(*flags);
 		hard_irq_disable();
 	}
@@ -360,7 +360,7 @@ static void nmi_ipi_lock_start(unsigned long *flags)
 static void nmi_ipi_lock(void)
 {
 	while (atomic_cmpxchg(&__nmi_ipi_lock, 0, 1) == 1)
-		cpu_relax();
+		spin_until_cond(atomic_read(&__nmi_ipi_lock) == 0);
 }
 
 static void nmi_ipi_unlock(void)
@@ -475,7 +475,7 @@ int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us)
 	nmi_ipi_lock_start(&flags);
 	while (nmi_ipi_busy_count) {
 		nmi_ipi_unlock_end(&flags);
-		cpu_relax();
+		spin_until_cond(nmi_ipi_busy_count == 0);
 		nmi_ipi_lock_start(&flags);
 	}
 
-- 
2.13.3
