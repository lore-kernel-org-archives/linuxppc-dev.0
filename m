Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 15348679E6
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 06:42:10 +1000 (EST)
Received: from sp1n294en1.watson.ibm.com (sp1n294en1.watson.ibm.com
	[129.34.20.40])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k4TKgdns014920
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:39 -0400
Received: from sp1n294en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k4TKg7H327230
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:07 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k4TKg73232710
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:42:07 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k4TLZqpD002567
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 17:35:52 -0400
Subject: [PATCH 1/8] Formalize virtual-IRQ remapping configuration.
In-Reply-To: <1148935262.25048.31.camel@brick>
Date: Mon, 29 May 2006 16:42:05 -0400
Message-Id: <11489353253225-git-send-email-mostrows@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linuxppc-dev@ozlabs.org
From: mostrows@watson.ibm.com
Reply-To: mostrows@watson.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Instead of setting various global various to configure the behavior of
virtual-IRQ remapping, each platform has the option of calling
virt_irq_config() in "init_early" to specify:

- the offset to be used (i.e. NUM_ISA_INTERRUPTS)
- the number of interrupt vectors which are to be mapped 1-1
- the number of interrupt vectors that may be arbitrarily remapped

If virt_irq_config() is not called, the default configuration will be
used (512 identity-mapped interrupts with no offset).

--
Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 arch/powerpc/kernel/irq.c              |   62 ++++++++++++++++----------------
 arch/powerpc/kernel/prom.c             |    4 --
 arch/powerpc/kernel/setup_64.c         |    6 +++
 arch/powerpc/platforms/iseries/setup.c |    3 +-
 arch/powerpc/platforms/pseries/setup.c |   10 +++++
 include/asm-powerpc/irq.h              |   30 +++++++++++----
 6 files changed, 70 insertions(+), 45 deletions(-)

2f99449cbcacf67694e38698ec9860f86ba052e2
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 57d560c..efcb859 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -268,32 +268,35 @@ void __init init_IRQ(void)
 #define UNDEFINED_IRQ 0xffffffff
 unsigned int virt_irq_to_real_map[NR_IRQS];
 
-/*
- * Don't use virtual irqs 0, 1, 2 for devices.
- * The pcnet32 driver considers interrupt numbers < 2 to be invalid,
- * and 2 is the XICS IPI interrupt.
- * We limit virtual irqs to __irq_offet_value less than virt_irq_max so
- * that when we offset them we don't end up with an interrupt
- * number >= virt_irq_max.
- */
-#define MIN_VIRT_IRQ	3
-
-unsigned int virt_irq_max;
+static unsigned int min_virt_irq;
 static unsigned int max_virt_irq;
 static unsigned int nr_virt_irqs;
 
 void
-virt_irq_init(void)
+virt_irq_config(unsigned int offset, 
+		unsigned int num_shifted, unsigned int num_remapped)
 {
-	int i;
+	__irq_offset_value = offset;
+	min_virt_irq = num_shifted;
+	max_virt_irq = num_shifted + num_remapped - 1;
+	nr_virt_irqs = num_remapped;
 
-	if ((virt_irq_max == 0) || (virt_irq_max > (NR_IRQS - 1)))
-		virt_irq_max = NR_IRQS - 1;
-	max_virt_irq = virt_irq_max - __irq_offset_value;
-	nr_virt_irqs = max_virt_irq - MIN_VIRT_IRQ + 1;
+	BUG_ON(max_virt_irq + __irq_offset_value > (NR_IRQS-1));
+}
 
+void
+virt_irq_init(void)
+{
+	int i;
 	for (i = 0; i < NR_IRQS; i++)
 		virt_irq_to_real_map[i] = UNDEFINED_IRQ;
+
+	/* Configure the default mappings; don't remap interrupts, 
+	 * use 1-1 virt <-> real mappings. Subsequently platforms may
+	 * choose to call virt_irq_config with their own custom settings.
+	 */
+	virt_irq_config(0, NR_IRQS, 0);
+	
 }
 
 /* Create a mapping for a real_irq if it doesn't already exist.
@@ -304,30 +307,25 @@ int virt_irq_create_mapping(unsigned int
 	unsigned int virq, first_virq;
 	static int warned;
 
-	if (ppc64_interrupt_controller == IC_OPEN_PIC)
-		return real_irq;	/* no mapping for openpic (for now) */
-
-	if (ppc64_interrupt_controller == IC_CELL_PIC)
-		return real_irq;	/* no mapping for iic either */
-
-	/* don't map interrupts < MIN_VIRT_IRQ */
-	if (real_irq < MIN_VIRT_IRQ) {
+	/* don't map interrupts < min_virt_irq */
+	if (real_irq < min_virt_irq) {
 		virt_irq_to_real_map[real_irq] = real_irq;
 		return real_irq;
 	}
 
-	/* map to a number between MIN_VIRT_IRQ and max_virt_irq */
+	/* map to a number between min_virt_irq and max_virt_irq */
 	virq = real_irq;
 	if (virq > max_virt_irq)
-		virq = (virq % nr_virt_irqs) + MIN_VIRT_IRQ;
+		virq = (virq % nr_virt_irqs) + min_virt_irq;
 
 	/* search for this number or a free slot */
 	first_virq = virq;
 	while (virt_irq_to_real_map[virq] != UNDEFINED_IRQ) {
 		if (virt_irq_to_real_map[virq] == real_irq)
 			return virq;
+		
 		if (++virq > max_virt_irq)
-			virq = MIN_VIRT_IRQ;
+			virq = min_virt_irq;
 		if (virq == first_virq)
 			goto nospace;	/* oops, no free slots */
 	}
@@ -338,8 +336,10 @@ int virt_irq_create_mapping(unsigned int
  nospace:
 	if (!warned) {
 		printk(KERN_CRIT "Interrupt table is full\n");
-		printk(KERN_CRIT "Increase virt_irq_max (currently %d) "
-		       "in your kernel sources and rebuild.\n", virt_irq_max);
+		printk(KERN_CRIT "Modify kernel sources to call "
+		       "virt_irq_config() with a larger value "
+		       "of \"num_remapped\" (currently %d)  and rebuild.\n",
+		       nr_virt_irqs);
 		warned = 1;
 	}
 	return NO_IRQ;
@@ -358,7 +358,7 @@ unsigned int real_irq_to_virt_slowpath(u
 	virq = real_irq;
 
 	if (virq > max_virt_irq)
-		virq = (virq % nr_virt_irqs) + MIN_VIRT_IRQ;
+		virq = (virq % nr_virt_irqs) + min_virt_irq;
 
 	first_virq = virq;
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9a07f97..bfbe6a7 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -472,10 +472,6 @@ void __init finish_device_tree(void)
 
 	DBG(" -> finish_device_tree\n");
 
-#ifdef CONFIG_PPC64
-	/* Initialize virtual IRQ map */
-	virt_irq_init();
-#endif
 	scan_interrupt_controllers();
 
 	/*
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4467c49..4669179 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -389,6 +389,12 @@ void __init setup_system(void)
 	 */
 	check_for_initrd();
 
+
+	/* Configure default setting for virtual IRQ remapping.
+	 * ppc_md.init_early() may reconfigure this with virt_irq_config()
+	 */
+	virt_irq_init();
+
 	/*
 	 * Do some platform specific early initializations, that includes
 	 * setting up the hash table pointers. It also sets up some interrupt-mapping
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index a6fd9be..6a7d04b 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -688,8 +688,9 @@ static int __init iseries_probe(void)
 	/*
 	 * The Hypervisor only allows us up to 256 interrupt
 	 * sources (the irq number is passed in a u8).
+	 * This call provides us with vectors 0 .. 255 without remapping.
 	 */
-	virt_irq_max = 255;
+	virt_irq_config(0, 256, 0);
 
 	return 1;
 }
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 5f79f01..9d22265 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -270,7 +270,6 @@ static  void __init pSeries_discover_pic
 	 * Setup interrupt mapping options that are needed for finish_device_tree
 	 * to properly parse the OF interrupt tree & do the virtual irq mapping
 	 */
-	__irq_offset_value = NUM_ISA_INTERRUPTS;
 	ppc64_interrupt_controller = IC_INVALID;
 	for (np = NULL; (np = of_find_node_by_name(np, "interrupt-controller"));) {
 		typep = (char *)get_property(np, "compatible", NULL);
@@ -286,6 +285,15 @@ static  void __init pSeries_discover_pic
 		printk("pSeries_discover_pic: failed to recognize"
 			" interrupt-controller\n");
 
+	/*
+	 * Don't use virtual irqs 0, 1, 2 for devices.
+	 * The pcnet32 driver considers interrupt numbers < 2 to be invalid,
+	 * and 2 is the XICS IPI interrupt.
+	 */
+	
+	virt_irq_config(NUM_ISA_INTERRUPTS, 3,  
+			NR_IRQS - (3 + NUM_ISA_INTERRUPTS));
+
 }
 
 static void pSeries_mach_cpu_die(void)
diff --git a/include/asm-powerpc/irq.h b/include/asm-powerpc/irq.h
index 7bc6d73..f2adbc0 100644
--- a/include/asm-powerpc/irq.h
+++ b/include/asm-powerpc/irq.h
@@ -54,18 +54,32 @@
  */
 extern unsigned int virt_irq_to_real_map[NR_IRQS];
 
-/* The maximum virtual IRQ number that we support.  This
- * can be set by the platform and will be reduced by the
- * value of __irq_offset_value.  It defaults to and is
- * capped by (NR_IRQS - 1).
- */
-extern unsigned int virt_irq_max;
-
 /* Create a mapping for a real_irq if it doesn't already exist.
  * Return the virtual irq as a convenience.
  */
 int virt_irq_create_mapping(unsigned int real_irq);
-void virt_irq_init(void);
+
+/* Initializes the virtual IRQ re-mapping, before ppc_md.init_early() */
+extern void virt_irq_init(void);
+
+/* virt_irq_config - Configure the division of the virtual IRQ space.
+ *		     Each platform may call this to set it's own specific 
+ *		     IRQ remapping parameters.
+ * @offset:	  offset of remapped space (i.e. NUM_ISA_INTERRUPTS).
+ * @num_shifted:  number of vectors to be simply shifted to account for
+ *		  the offset with no other remapping.
+ * @num_remapper: number of vectors that may be arbitrarily remapped.
+ *
+ * Virtual IRQ vectors will have the following mappings to the IRQ vectors
+ * as seen by the approrpiate interrupt controller:
+ * 0 .. offset-1		 -> 0 .. offset-1   (1-1 mapping)
+ * offset .. offset+num_shifted-1 -> 0 .. num_shifted-1 (shift by offset)
+ * offset+num_shifted .. offset+num_shifted+num_remapped-1 ->
+ *		arbitrary mappings to real irq as required.
+ */
+extern void virt_irq_config(unsigned int offset,
+			    unsigned int num_linear,
+			    unsigned int num_remapped);
 
 static inline unsigned int virt_irq_to_real(unsigned int virt_irq)
 {
-- 
1.1.4.g0b63-dirty
