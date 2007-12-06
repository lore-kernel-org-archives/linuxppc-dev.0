Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Dec 2007 19:00:04 +1100
Subject: [PATCH 5/25] powerpc: Add xmon function to dump 44x TLB
In-Reply-To: <1196927999.714593.205329520306.qpush@grosgo>
Message-Id: <20071206080115.76E5FDDEC8@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a function to xmon to dump the content of the 44x processor
TLB with a little bit of decoding (but not much).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Did that to track down some machine checks I was having while working
on PCI support due to 32/64 bits resource screwage.
Useful to see where a given MMIO virtual address really maps to.

 arch/powerpc/xmon/xmon.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

Index: linux-work/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-work.orig/arch/powerpc/xmon/xmon.c	2007-12-03 11:48:03.000000000 +1100
+++ linux-work/arch/powerpc/xmon/xmon.c	2007-12-03 12:07:14.000000000 +1100
@@ -153,6 +153,10 @@ static const char *getvecname(unsigned l
 
 static int do_spu_cmd(void);
 
+#ifdef CONFIG_44x
+static void dump_tlb_44x(void);
+#endif
+
 int xmon_no_auto_backtrace;
 
 extern void xmon_enter(void);
@@ -231,6 +235,9 @@ Commands:\n\
 #ifdef CONFIG_PPC_STD_MMU_32
 "  u	dump segment registers\n"
 #endif
+#ifdef CONFIG_44x
+"  u	dump TLB\n"
+#endif
 "  ?	help\n"
 "  zr	reboot\n\
   zh	halt\n"
@@ -856,6 +863,11 @@ cmds(struct pt_regs *excp)
 			dump_segments();
 			break;
 #endif
+#ifdef CONFIG_44x
+		case 'u':
+			dump_tlb_44x();
+			break;
+#endif
 		default:
 			printf("Unrecognized command: ");
 		        do {
@@ -2581,6 +2593,32 @@ void dump_segments(void)
 }
 #endif
 
+#ifdef CONFIG_44x
+static void dump_tlb_44x(void)
+{
+	int i;
+
+	for (i = 0; i < PPC44x_TLB_SIZE; i++) {
+		unsigned long w0, w1, w2;
+		asm volatile("tlbre  %0,%1,0" : "=r" (w0) : "r" (i));
+		asm volatile("tlbre  %0,%1,1" : "=r" (w1) : "r" (i));
+		asm volatile("tlbre  %0,%1,2" : "=r" (w2) : "r" (i));
+		printf("[%02x] %08x %08x %08x ", i, w0, w1, w2);
+		if (w0 & PPC44x_TLB_VALID) {
+			printf("V %08x -> %01x%08x %c%c%c%c%c",
+			       w0 & PPC44x_TLB_EPN_MASK,
+			       w1 & PPC44x_TLB_ERPN_MASK,
+			       w1 & PPC44x_TLB_RPN_MASK,
+			       (w2 & PPC44x_TLB_W) ? 'W' : 'w',
+			       (w2 & PPC44x_TLB_I) ? 'I' : 'i',
+			       (w2 & PPC44x_TLB_M) ? 'M' : 'm',
+			       (w2 & PPC44x_TLB_G) ? 'G' : 'g',
+			       (w2 & PPC44x_TLB_E) ? 'E' : 'e');
+		}
+		printf("\n");
+	}
+}
+#endif /* CONFIG_44x */
 void xmon_init(int enable)
 {
 #ifdef CONFIG_PPC_ISERIES
