Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3C25FDDDF7
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 02:30:30 +1100 (EST)
Date: Wed, 7 Nov 2007 09:39:53 -0600
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] pasemi: Don't enter powersaving states from
	elevated astates
Message-ID: <20071107153953.GA3187@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC] pasemi: Don't enter powersaving states from elevated astates

When the PWRficient cpus are entered into powersavings states, the
astate is automatically dropped down to 0. While we still restore it
when we come out of idle, it can still cause some weird effects with
respect to performance (especially since it takes a while to ramp up to
higher astates).

So, to avoid this, don't enter power savings when the cpufreq driver
(or user) has set higher astates than 0.

The restore is still required, since there's a chance the astate has
been raised from the other cpu while the idling one was asleep.

Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/pasemi/cpufreq.c b/arch/powerpc/platforms/pasemi/cpufreq.c
index 8caa166..c2e0340 100644
--- a/arch/powerpc/platforms/pasemi/cpufreq.c
+++ b/arch/powerpc/platforms/pasemi/cpufreq.c
@@ -124,6 +124,11 @@ static void set_astate(int cpu, unsigned int astate)
 	local_irq_restore(flags);
 }
 
+int check_astate(void)
+{
+	return get_cur_astate(hard_smp_processor_id());
+}
+
 void restore_astate(int cpu)
 {
 	set_astate(cpu, current_astate);
diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
index 516acab..c96127b 100644
--- a/arch/powerpc/platforms/pasemi/pasemi.h
+++ b/arch/powerpc/platforms/pasemi/pasemi.h
@@ -16,8 +16,14 @@ extern void idle_doze(void);
 
 /* Restore astate to last set */
 #ifdef CONFIG_PPC_PASEMI_CPUFREQ
+extern int check_astate(void);
 extern void restore_astate(int cpu);
 #else
+static inline int check_astate(void)
+{
+	/* Always return >0 so we never power save */
+	return 1;
+}
 static inline void restore_astate(int cpu)
 {
 }
diff --git a/arch/powerpc/platforms/pasemi/powersave.S b/arch/powerpc/platforms/pasemi/powersave.S
index 6d0fba6..56f45ad 100644
--- a/arch/powerpc/platforms/pasemi/powersave.S
+++ b/arch/powerpc/platforms/pasemi/powersave.S
@@ -62,7 +62,16 @@ sleep_common:
 	mflr	r0
 	std	r0, 16(r1)
 	stdu	r1,-64(r1)
+#ifdef CONFIG_PPC_PASEMI_CPUFREQ
+	std	r3, 48(r1)
 
+	/* Only do power savings when in astate 0 */
+	bl	.check_astate
+	cmpwi	r3,0
+	bne	1f
+
+	ld	r3, 48(r1)
+#endif
 	LOAD_REG_IMMEDIATE(r6,MSR_DR|MSR_IR|MSR_ME|MSR_EE)
 	mfmsr	r4
 	andc	r5,r4,r6
@@ -73,7 +82,7 @@ sleep_common:
 
 	mtmsrd	r4,0
 
-	addi	r1,r1,64
+1:	addi	r1,r1,64
 	ld	r0,16(r1)
 	mtlr	r0
 	blr
