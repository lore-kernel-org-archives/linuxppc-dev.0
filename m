Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9337B7D75
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:31:49 +1100 (EST)
Message-Id: <20100218122000.228868034@linutronix.de>
Date: Thu, 18 Feb 2010 12:22:31 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 03/15] powerpc: Convert die.lock to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

die.lock needs to be a real spinlock in RT. Convert it to
raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/kernel/traps.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6-tip/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/kernel/traps.c
+++ linux-2.6-tip/arch/powerpc/kernel/traps.c
@@ -102,11 +102,11 @@ static inline void pmac_backlight_unblan
 int die(const char *str, struct pt_regs *regs, long err)
 {
 	static struct {
-		spinlock_t lock;
+		raw_spinlock_t lock;
 		u32 lock_owner;
 		int lock_owner_depth;
 	} die = {
-		.lock =			__SPIN_LOCK_UNLOCKED(die.lock),
+		.lock =			__RAW_SPIN_LOCK_UNLOCKED(die.lock),
 		.lock_owner =		-1,
 		.lock_owner_depth =	0
 	};
@@ -120,7 +120,7 @@ int die(const char *str, struct pt_regs 
 
 	if (die.lock_owner != raw_smp_processor_id()) {
 		console_verbose();
-		spin_lock_irqsave(&die.lock, flags);
+		raw_spin_lock_irqsave(&die.lock, flags);
 		die.lock_owner = smp_processor_id();
 		die.lock_owner_depth = 0;
 		bust_spinlocks(1);
@@ -155,7 +155,7 @@ int die(const char *str, struct pt_regs 
 	bust_spinlocks(0);
 	die.lock_owner = -1;
 	add_taint(TAINT_DIE);
-	spin_unlock_irqrestore(&die.lock, flags);
+	raw_spin_unlock_irqrestore(&die.lock, flags);
 
 	if (kexec_should_crash(current) ||
 		kexec_sr_activated(smp_processor_id()))
