Message-ID: <32779.194.247.50.215.1017133252.squirrel@lbbrown.homeip.net>
Date: Tue, 26 Mar 2002 09:00:52 -0000 (GMT)
Subject: [rfc][patch] make open_pic.c cope with booting from cpu# >= 1
From: "Leigh Brown" <leigh@solinno.co.uk>
To: <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

For some strange reason the 7043-240 running in PReP mode boots up using
a random CPU.  The behaviour seems to change depending on firmware
revision, but is not reliable.  This patch tweaks the open_pic code to
allow the boot cpu to be specified.

NOTE: The boot cpu is not actually specified by this code, the platform
specific code must set the variable OpenPIC_BootCPU (Default 0) before
calling openpic_init.

This has been tested successfully running UP on a 7043-140 and a 7043-240.
I don't have SMP working on the 7043-240 yet.

Please let me know if there is a better way to do this.

The patch is pasted below, but is also available on my website in case
it gets corrupted:

http://www.solinno.co.uk/leigh/openpic_cpu.diff

Cheers,

Leigh.

--- MASTER/linuxppc_2_4_devel/arch/ppc/kernel/open_pic.c	Thu Mar 21
06:37:30 2002+++ linuxppc_2_4_devel-140/arch/ppc/kernel/open_pic.c	Tue Mar 26 08:32:17
2002@@ -33,6 +33,7 @@
 #endif

 void* OpenPIC_Addr;
+u_int OpenPIC_BootCPU;
 static volatile struct OpenPIC *OpenPIC = NULL;
 u_int OpenPIC_NumInitSenses __initdata = 0;
 u_char *OpenPIC_InitSenses __initdata = NULL;
@@ -125,7 +126,7 @@
 #define DECL_THIS_CPU		int cpu = smp_hw_index[smp_processor_id()]
 #define CHECK_THIS_CPU		check_arg_cpu(cpu)
 #else
-#define THIS_CPU		Processor[0]
+#define THIS_CPU		Processor[OpenPIC_BootCPU]
 #define DECL_THIS_CPU
 #define CHECK_THIS_CPU
 #endif /* CONFIG_SMP */
@@ -362,9 +363,17 @@
 	/* SIOint (8259 cascade) is special */
 	if (offset) {

	openpic_initirq(0, 8, offset, 1, 1);
-
	openpic_mapirq(0, 1<<0, 0);
+
	openpic_mapirq(0, 1<<OpenPIC_BootCPU, 0);
 	}

+#ifndef CONFIG_SMP
+
/* Deliver interrupts to boot processor only */
+
for (i = 0; i < NumProcessors; i++)
+
	openpic_writefield(&OpenPIC->Processor[i].Current_Task_Priority,
+
			   OPENPIC_CURRENT_TASK_PRIORITY_MASK,
+
			   (i == OpenPIC_BootCPU) ? 0x0 : 0xf);
+#endif
+
 	/* Init all external sources */
 	for (i = 1; i < NumSources; i++) {

	int pri, sense;
@@ -383,7 +392,7 @@

	/* Enabled, Priority 8 or 9 */

	openpic_initirq(i, pri, i+offset, !sense, sense);

	/* Processor 0 */
-
	openpic_mapirq(i, 1<<0, 0);
+
	openpic_mapirq(i, 1<<OpenPIC_BootCPU, 0);
 	}

 	/* Init descriptors */
@@ -913,3 +922,4 @@
 	spin_unlock_irqrestore(&openpic_setup_lock, flags);
 }
 #endif /* CONFIG_PMAC_PBOOK */
+


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
