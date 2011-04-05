Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0E2FB6FFA
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:21 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p356E9nU024971
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:09 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356ELDl2134262
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356ELJl004174
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/15] powerpc: Properly handshake CPUs going out of boot spin
	loop
Date: Tue,  5 Apr 2011 16:14:08 +1000
Message-Id: <1301984051-18413-13-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to wait a bit for them to have done their CPU setup
or we might end up with translation and EE on with different
LPCR values between threads

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/smp.h |    1 +
 arch/powerpc/kernel/head_64.S  |   18 +++++++++++++-----
 arch/powerpc/kernel/prom.c     |   27 ++++++++++-----------------
 arch/powerpc/kernel/setup_32.c |    1 +
 arch/powerpc/kernel/setup_64.c |   13 ++++++++++++-
 5 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index a902a0d..bb4c033 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -29,6 +29,7 @@
 #include <asm/percpu.h>
 
 extern int boot_cpuid;
+extern int boot_cpu_count;
 
 extern void cpu_die(void);
 
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 43a3cff..370afd4 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -242,23 +242,31 @@ generic_secondary_common_init:
 	ld	r23,0(r23)
 	ld	r23,CPU_SPEC_RESTORE(r23)
 	cmpdi	0,r23,0
-	beq	4f
+	beq	3f
 	ld	r23,0(r23)
 	mtctr	r23
 	bctrl
 
-3:	HMT_LOW
+3:	LOAD_REG_ADDR(r3, boot_cpu_count) /* Decrement boot_cpu_count */
+	lwarx	r4,0,r3
+	subi	r4,r4,1
+	stwcx.	r4,0,r3
+	bne	3b
+	isync
+
+4:	HMT_LOW
 	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor should */
 					/* start.			 */
 #ifndef CONFIG_SMP
-	b	3b			/* Never go on non-SMP		 */
+	b	4b			/* Never go on non-SMP		 */
 #else
 	cmpwi	0,r23,0
-	beq	3b			/* Loop until told to go	 */
+	beq	4b			/* Loop until told to go	 */
 
 	sync				/* order paca.run and cur_cpu_spec */
+	isync				/* In case code patching happened */
 
-4:	/* Create a temp kernel stack for use before relocation is on.	*/
+	/* Create a temp kernel stack for use before relocation is on.	*/
 	ld	r1,PACAEMERGSP(r13)
 	subi	r1,r1,STACK_FRAME_OVERHEAD
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 05b7139..236246f 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -268,13 +268,12 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 					  const char *uname, int depth,
 					  void *data)
 {
-	static int logical_cpuid = 0;
 	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
 	const u32 *prop;
 	const u32 *intserv;
 	int i, nthreads;
 	unsigned long len;
-	int found = 0;
+	int found = -1;
 
 	/* We are scanning "cpu" nodes only */
 	if (type == NULL || strcmp(type, "cpu") != 0)
@@ -299,11 +298,8 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 		 * booted proc.
 		 */
 		if (initial_boot_params && initial_boot_params->version >= 2) {
-			if (intserv[i] ==
-					initial_boot_params->boot_cpuid_phys) {
-				found = 1;
-				break;
-			}
+			if (intserv[i] == initial_boot_params->boot_cpuid_phys)
+				found = boot_cpu_count;
 		} else {
 			/*
 			 * Check if it's the boot-cpu, set it's hw index now,
@@ -311,23 +307,20 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 			 * off secondary threads.
 			 */
 			if (of_get_flat_dt_prop(node,
-					"linux,boot-cpu", NULL) != NULL) {
-				found = 1;
-				break;
-			}
+					"linux,boot-cpu", NULL) != NULL)
+				found = boot_cpu_count;
 		}
-
 #ifdef CONFIG_SMP
 		/* logical cpu id is always 0 on UP kernels */
-		logical_cpuid++;
+		boot_cpu_count++;
 #endif
 	}
 
-	if (found) {
-		DBG("boot cpu: logical %d physical %d\n", logical_cpuid,
+	if (found >= 0) {
+		DBG("boot cpu: logical %d physical %d\n", found,
 			intserv[i]);
-		boot_cpuid = logical_cpuid;
-		set_hard_smp_processor_id(boot_cpuid, intserv[i]);
+		boot_cpuid = found;
+		set_hard_smp_processor_id(found, intserv[i]);
 
 		/*
 		 * PAPR defines "logical" PVR values for cpus that
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 1d2fbc9..620d792 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -48,6 +48,7 @@ extern void bootx_init(unsigned long r4, unsigned long phys);
 
 int boot_cpuid = -1;
 EXPORT_SYMBOL_GPL(boot_cpuid);
+int __initdata boot_cpu_count;
 int boot_cpuid_phys;
 
 int smp_hw_index[NR_CPUS];
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 5a0401f..91a5cc5 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -72,6 +72,7 @@
 #endif
 
 int boot_cpuid = 0;
+int __initdata boot_cpu_count;
 u64 ppc64_pft_size;
 
 /* Pick defaults since we might want to patch instructions
@@ -233,6 +234,7 @@ void early_setup_secondary(void)
 void smp_release_cpus(void)
 {
 	unsigned long *ptr;
+	int i;
 
 	DBG(" -> smp_release_cpus()\n");
 
@@ -245,7 +247,16 @@ void smp_release_cpus(void)
 	ptr  = (unsigned long *)((unsigned long)&__secondary_hold_spinloop
 			- PHYSICAL_START);
 	*ptr = __pa(generic_secondary_smp_init);
-	mb();
+
+	/* And wait a bit for them to catch up */
+	for (i = 0; i < 100000; i++) {
+		mb();
+		HMT_low();
+		if (boot_cpu_count == 0)
+			break;
+		udelay(1);
+	}
+	DBG("boot_cpu_count = %d\n", boot_cpu_count);
 
 	DBG(" <- smp_release_cpus()\n");
 }
-- 
1.7.1
