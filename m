Message-ID: <1862.80.7.99.14.1086887362.squirrel@www.solinno.co.uk>
Date: Thu, 10 Jun 2004 18:09:22 +0100 (BST)
Subject: [RFC][PATCH 8/9] Support for old IBM PReP boxes
From: "Leigh Brown" <leigh@solinno.co.uk>
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is the code to cope with those machines that seem to be able
to boot from the second CPU (240, F40).  Very weird.  This touches
the generic openpic code so worth sanity checking.


diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c
linux-2.6.6/arch/ppc/platforms/prep_pci.c
--- linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c	2004-06-09
13:59:05.000000000 +0100
+++ linux-2.6.6/arch/ppc/platforms/prep_pci.c	2004-06-09
13:59:42.000000000 +0100
@@ -833,6 +833,27 @@
 	{0x000, 0x00, 0x00, "",					NULL,			NULL, NULL, NULL, 0x00}
 };

+u_int __init
+ibm_prep_boot_cpu(void)
+{
+	/* Scan the residual data for the CPU that the firmware used to
+	 * execute the loader - this is our boot CPU.  This is needed
+	 * because the 7043-240 (at least) will not always use CPU 0
+	 * as the boot CPU */
+	if (have_residual_data()) {
+		int i;
+
+		for (i = 0; i < res->MaxNumCpus; ++i)
+			if (res->Cpus[i].CpuState == CPU_GOOD) {
+				printk(KERN_INFO "PReP boot CPU: %d\n",
+							res->Cpus[i].CpuNumber);
+				return res->Cpus[i].CpuNumber;
+			}
+	}
+
+	return 0;
+}
+
 void __init
 ibm_prep_init(void)
 {
@@ -881,6 +902,7 @@
 			return;
 #undef p
 		OpenPIC_Addr = ioremap(addr, len);
+		OpenPIC_BootCPU = ibm_prep_boot_cpu();
 		ppc_md.get_irq = openpic_get_irq;

 		OpenPIC_InitSenses = prep_openpic_initsenses;
diff -urNX .diffex linux-2.6.6-prev/arch/ppc/syslib/open_pic.c
linux-2.6.6/arch/ppc/syslib/open_pic.c
--- linux-2.6.6-prev/arch/ppc/syslib/open_pic.c	2004-06-07
11:44:43.000000000 +0100
+++ linux-2.6.6/arch/ppc/syslib/open_pic.c	2004-06-09 13:59:42.000000000
+0100
@@ -33,6 +33,7 @@
 #endif

 void* OpenPIC_Addr;
+u_int OpenPIC_BootCPU;
 static volatile struct OpenPIC *OpenPIC = NULL;

 /*
@@ -128,7 +129,7 @@
 #define DECL_THIS_CPU		int cpu = smp_hw_index[smp_processor_id()]
 #define CHECK_THIS_CPU		check_arg_cpu(cpu)
 #else
-#define THIS_CPU		Processor[0]
+#define THIS_CPU		Processor[OpenPIC_BootCPU]
 #define DECL_THIS_CPU
 #define CHECK_THIS_CPU
 #endif /* CONFIG_SMP */
@@ -407,8 +408,8 @@
 		/* Enabled, Priority 8 */
 		openpic_initirq(i, 8, i+offset, (sense & IRQ_POLARITY_MASK),
 				(sense & IRQ_SENSE_MASK));
-		/* Processor 0 */
-		openpic_mapirq(i, 1<<0, 0);
+		/* Boot Processor */
+		openpic_mapirq(i, 1<<OpenPIC_BootCPU, 0);
 	}

 	/* Init descriptors */
diff -urNX .diffex linux-2.6.6-prev/include/asm-ppc/open_pic.h
linux-2.6.6/include/asm-ppc/open_pic.h
--- linux-2.6.6-prev/include/asm-ppc/open_pic.h	2004-06-09
13:59:05.000000000 +0100
+++ linux-2.6.6/include/asm-ppc/open_pic.h	2004-06-09 13:59:42.000000000
+0100
@@ -36,6 +36,7 @@
 extern u_int OpenPIC_NumInitSenses;
 extern u_char *OpenPIC_InitSenses;
 extern void* OpenPIC_Addr;
+extern u_int OpenPIC_BootCPU;

 /* Exported functions */
 extern void openpic_set_sources(int first_irq, int num_irqs, void *isr);


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
