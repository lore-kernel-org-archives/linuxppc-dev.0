Return-Path: <aidan@nicta.com.au>
Received: from mail01.syd.optusnet.com.au (mail01.syd.optusnet.com.au
	[211.29.132.182])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B50B567A70
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Apr 2006 08:42:19 +1000 (EST)
Received: from [192.168.1.11] (c220-237-11-187.randw1.nsw.optusnet.com.au
	[220.237.11.187])
	by mail01.syd.optusnet.com.au (8.12.11/8.12.11) with ESMTP id
	k37MgHOf015438
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Sat, 8 Apr 2006 08:42:18 +1000
Message-ID: <4436EAC9.9000904@nicta.com.au>
Date: Sat, 08 Apr 2006 08:42:17 +1000
From: Aidan Williams <aidan@nicta.com.au>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Virtex-4 FX12 Mini-Module support
References: <4417CEB8.40004@nicta.com.au> <4417FBA9.1030101@petalogix.com>
	<4418896E.4040007@nicta.com.au> <44189045.3010905@petalogix.com>
	<4418BA71.7040208@nicta.com.au> <4418EA57.6060308@petalogix.com>
In-Reply-To: <4418EA57.6060308@petalogix.com>
Content-Type: multipart/mixed; boundary="------------030300060300060800080703"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030300060300060800080703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I'm using the UQ powerpc uclinux code on the
Memec Virtex-4 FX12 Mini-Module Development Kit.

I have attached a patch with our modifications:

   - switch to set cache policy (OFF, WriteThru, WriteBack)
   - switch to enable PPC405 CPU_213 errata workaround
   - cosmetic update to cputable
   - view ccr0 register in /proc/cpu

The patch is against:
http://www.itee.uq.edu.au/~pml/uclinux_powerpc/linuxppc-2.4-20051021.tgz


The specific modules/chips we're using have a silicon bug,
See the euphemistically named "Solution 13:"
http://www.xilinx.com/xlnx/xil_ans_display.jsp?iLanguageID=1&iCountryID=1&getPagePath=20658

The board boots and runs reliably with the caches OFF.
WriteThru and WriteBack caching cause memory corruption and
this is why we implemented the cache policy switch.


regards
	aidan
____
:wq!


--------------030300060300060800080703
Content-Type: plain/text; x-mac-type="0"; x-mac-creator="0";
 name="virtex-4-fx12-minimodule.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="virtex-4-fx12-minimodule.txt"

Index: arch/ppc/config.in
===================================================================
RCS file: /cvs/linuxppc-2.4/arch/ppc/config.in,v
retrieving revision 1.1.1.1
retrieving revision 1.3
diff -u -r1.1.1.1 -r1.3
--- arch/ppc/config.in	17 Mar 2006 05:19:36 -0000	1.1.1.1
+++ arch/ppc/config.in	20 Mar 2006 05:20:38 -0000	1.3
@@ -41,6 +41,13 @@
   define_bool CONFIG_4xx y
 fi
 
+if [ "$CONFIG_40x" = "y" ]; then
+  choice 'Cache Mode'				\
+  	"OFF		CONFIG_CACHE_OFF	\
+	 WriteThru	CONFIG_CACHE_WRITETHRU	\
+	 WriteBack	CONFIG_CACHE_WRITEBACK"	OFF
+fi
+
 if [ "$CONFIG_6xx" = "y" ]; then
   bool 'MPC8260 CPM Support' CONFIG_8260
 fi
@@ -365,6 +372,10 @@
     define_bool CONFIG_405 y
   fi
 
+  if [ "$CONFIG_XILINX_AUTO" = "y" ]; then
+    bool 'Virtex-4 cache bug (CPU_213)' CONFIG_VIRTEX4_CPU_213_BUG
+  fi
+
   if [ "$CONFIG_VIRTEX_II_PRO" = "y" ]; then
     define_bool CONFIG_XILINX_OCP y
     define_bool CONFIG_PPC_OCP y
Index: arch/ppc/boot/simple/embed_config.c
===================================================================
RCS file: /cvs/linuxppc-2.4/arch/ppc/boot/simple/embed_config.c,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- arch/ppc/boot/simple/embed_config.c	17 Mar 2006 05:19:36 -0000	1.1.1.1
+++ arch/ppc/boot/simple/embed_config.c	17 Mar 2006 06:01:25 -0000	1.2
@@ -895,7 +895,7 @@
                bd->bi_enetaddr[2] = 0x35;
                bd->bi_enetaddr[3] = 0x00;
                bd->bi_enetaddr[4] = 0x22;
-               bd->bi_enetaddr[5] = 0x00;
+               bd->bi_enetaddr[5] = 0x01;
        }
        timebase_period_ns = 1000000000 / bd->bi_tbfreq;
 }
Index: arch/ppc/boot/simple/head.S
===================================================================
RCS file: /cvs/linuxppc-2.4/arch/ppc/boot/simple/head.S,v
retrieving revision 1.1.1.1
retrieving revision 1.3
diff -u -r1.1.1.1 -r1.3
--- arch/ppc/boot/simple/head.S	17 Mar 2006 05:19:36 -0000	1.1.1.1
+++ arch/ppc/boot/simple/head.S	20 Mar 2006 05:20:40 -0000	1.3
@@ -64,6 +64,13 @@
 			 */
 #endif
 
+#ifdef	CONFIG_VIRTEX4_CPU_213_BUG
+	/* PPC errata 213: only for Virtex-4 FX */
+	mfccr0  r0
+	oris    r0,r0,0x50000000@h
+	mtccr0  r0
+#endif
+
 	mflr	r3	/* Save our actual starting address. */
 
 	/* The following functions we call must not modify r3 or r4.....
Index: arch/ppc/kernel/cputable.c
===================================================================
RCS file: /cvs/linuxppc-2.4/arch/ppc/kernel/cputable.c,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- arch/ppc/kernel/cputable.c	17 Mar 2006 05:19:36 -0000	1.1.1.1
+++ arch/ppc/kernel/cputable.c	17 Mar 2006 06:01:27 -0000	1.2
@@ -508,7 +508,14 @@
 	0, /*__setup_cpu_405 */
     },
      {	/* Xilinx Virtex-II Pro  */
-	0xffff0000, 0x20010000, "Virtex-II Pro",
+	0xfffff000, 0x20010000, "Virtex-II Pro",
+	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_DOZE,
+	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+	32, 32,
+	0, /*__setup_cpu_405 */
+     },
+     {	/* Xilinx Virtex-4 FX  */
+	0xfffff000, 0x20011000, "Virtex-4 FX",
 	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_DOZE,
 	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 	32, 32,
Index: arch/ppc/kernel/head_4xx.S
===================================================================
RCS file: /cvs/linuxppc-2.4/arch/ppc/kernel/head_4xx.S,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- arch/ppc/kernel/head_4xx.S	17 Mar 2006 05:19:36 -0000	1.1.1.1
+++ arch/ppc/kernel/head_4xx.S	17 Mar 2006 06:01:27 -0000	1.2
@@ -46,6 +46,19 @@
 #define	STND_EXC	0
 #define	CRIT_EXC	1
 
+#if	defined(CONFIG_CACHE_OFF)
+#define	_PAGE_CACHE	_PAGE_NO_CACHE	/* TLB_I */
+#warning CONFIG_CACHE_CACHE_OFF is defined
+#elif	defined(CONFIG_CACHE_WRITETHRU)
+#define	_PAGE_CACHE	_PAGE_WRITETHRU	/* TLB_W */
+#warning CONFIG_CACHE_WRITETHRU is defined
+#elif	defined(CONFIG_CACHE_WRITEBACK)
+#define	_PAGE_CACHE	0x0
+#warning CONFIG_CACHE_WRITEBACK is defined
+#else
+#error	CONFIG_CACHE_XXX is not defined!
+#endif
+
 /* As with the other PowerPC ports, it is expected that when code
  * execution begins here, the following registers contain valid, yet
  * optional, information:
@@ -304,7 +317,7 @@
 	 */
 	li	r22, 0x0ce2
 	andc	r21, r21, r22		/* Make sure 20, 21 are zero */
-	ori	r21, r21, _PAGE_HWEXEC	/* make it executable */
+	ori	r21, r21, _PAGE_HWEXEC|_PAGE_CACHE
 
 	/* find the TLB index that caused the fault.  It has to be here.
 	*/
@@ -791,7 +804,7 @@
 	stw	r23, tlb_4xx_index@l(0)
 
 6:
-	ori	r21, r21, _PAGE_HWEXEC		/* make it executable */
+	ori	r21, r21, _PAGE_HWEXEC|_PAGE_CACHE
 	tlbwe	r21, r23, TLB_DATA		/* Load TLB LO */
 
 	/* Create EPN.  This is the faulting address plus a static
@@ -1043,7 +1056,7 @@
 	 * matter where they are loaded.
 	 */
 	clrrwi	r4,r4,10		/* Mask off the real page number */
-	ori	r4,r4,(TLB_WR | TLB_EX)	/* Set the write and execute bits */
+	ori	r4,r4,(TLB_WR | TLB_EX | _PAGE_CACHE)	/* Set the write and execute bits */
 
 	clrrwi	r3,r3,10		/* Mask off the effective page number */
 	ori	r3,r3,(TLB_VALID | TLB_PAGESZ(PAGESZ_16M))
Index: arch/ppc/kernel/ppc4xx_setup.c
===================================================================
RCS file: /cvs/linuxppc-2.4/arch/ppc/kernel/ppc4xx_setup.c,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- arch/ppc/kernel/ppc4xx_setup.c	17 Mar 2006 05:19:36 -0000	1.1.1.1
+++ arch/ppc/kernel/ppc4xx_setup.c	17 Mar 2006 06:01:27 -0000	1.2
@@ -129,6 +129,7 @@
 	bd_t *bip = (bd_t *) __res;
 
 	seq_printf(m, "clock\t\t: %ldMHz\n", (long) bip->bi_intfreq / 1000000);
+	seq_printf(m, "ccr0\t\t: 0x%08x\n", mfspr(SPRN_CCR0));
 
 	return 0;
 }
Index: arch/ppc/mm/4xx_mmu.c
===================================================================
RCS file: /cvs/linuxppc-2.4/arch/ppc/mm/4xx_mmu.c,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- arch/ppc/mm/4xx_mmu.c	17 Mar 2006 05:19:36 -0000	1.1.1.1
+++ arch/ppc/mm/4xx_mmu.c	17 Mar 2006 06:01:33 -0000	1.2
@@ -78,7 +78,12 @@
 	 * handlers (which are run in real-mode).
 	 */
 
+#ifdef	CONFIG_CACHE_WRITEBACK
         mtspr(SPRN_DCWR, 0x00000000);	/* All caching is write-back */
+#endif
+#ifdef	CONFIG_CACHE_WRITETHRU
+        mtspr(SPRN_DCWR, 0xffffffff);	/* All caching is write-thru */
+#endif
 
         /*
 	 * Cache instruction and data space where the exception
@@ -92,6 +97,12 @@
 	 * without flushing. -- Tom
 	 */
 
+#if defined(CONFIG_CACHE_OFF)
+        mtspr(SPRN_DCCR, 0x00000000);
+        mtspr(SPRN_ICCR, 0x00000000);
+#endif
+#if defined(CONFIG_CACHE_WRITETHRU) || defined(CONFIG_CACHE_WRITEBACK)
         mtspr(SPRN_DCCR, 0xF0000000);	/* 512 MB of data space at 0x0. */
         mtspr(SPRN_ICCR, 0xF0000000);	/* 512 MB of instr. space at 0x0. */
+#endif
 }
Index: arch/ppc/platforms/xilinx_auto/auto-config.in
===================================================================
RCS file: /cvs/linuxppc-2.4/arch/ppc/platforms/xilinx_auto/auto-config.in,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- arch/ppc/platforms/xilinx_auto/auto-config.in	17 Mar 2006 05:19:36 -0000	1.1.1.1
+++ arch/ppc/platforms/xilinx_auto/auto-config.in	17 Mar 2006 06:01:33 -0000	1.2
@@ -1,7 +1,7 @@
 ############################################################
 # 
 # CAUTION: This file is automatically generated by libgen.
-# Version: Xilinx EDK 7.1.2 EDK_H.12.5.1 
+# Version: Xilinx EDK 8.1.01 EDK_I.19.5 
 # Description: uClinux Configuration File
 # 
 ############################################################
@@ -10,26 +10,72 @@
 
 # MAIN_MEMORY Settings
 define_hex CONFIG_XILINX_ERAM_START 0x00000000
-define_hex CONFIG_XILINX_ERAM_SIZE 0x10000000
+define_hex CONFIG_XILINX_ERAM_SIZE 0x04000000
 
 # System Clock Frequency
 define_int CONFIG_XILINX_CPU_CLOCK_FREQ 100000000
 
 # Definitions for PPC405_0
 define_string CONFIG_XILINX_PPC405_0_INSTANCE ppc405_0
-define_hex CONFIG_XILINX_PPC405_0_ISOCM_DCR_BASEADDR 0x00000010
-define_hex CONFIG_XILINX_PPC405_0_ISOCM_DCR_HIGHADDR 0x00000013
-define_hex CONFIG_XILINX_PPC405_0_DSOCM_DCR_BASEADDR 0x00000020
-define_hex CONFIG_XILINX_PPC405_0_DSOCM_DCR_HIGHADDR 0x00000023
+define_hex CONFIG_XILINX_PPC405_0_IDCR_BASEADDR 0x00000100
+define_hex CONFIG_XILINX_PPC405_0_IDCR_HIGHADDR 0x0000010F
 define_int CONFIG_XILINX_PPC405_0_DISABLE_OPERAND_FORWARDING 1
-define_int CONFIG_XILINX_PPC405_0_DETERMINISTIMULT 0
 define_int CONFIG_XILINX_PPC405_0_MMU_ENABLE 1
-define_int CONFIG_XILINX_PPC405_0_DCR_RESYNC 0
+define_int CONFIG_XILINX_PPC405_0_DETERMINISTIMULT 0
+define_int CONFIG_XILINX_PPC405_0_PLBSYNCBYPASS 1
+define_hex CONFIG_XILINX_PPC405_0_APU_CONTROL 0x0000DE00
+define_hex CONFIG_XILINX_PPC405_0_APU_UDI_1 0x00A18983
+define_hex CONFIG_XILINX_PPC405_0_APU_UDI_2 0x00A38983
+define_hex CONFIG_XILINX_PPC405_0_APU_UDI_3 0x00A589C3
+define_hex CONFIG_XILINX_PPC405_0_APU_UDI_4 0x00A789C3
+define_hex CONFIG_XILINX_PPC405_0_APU_UDI_5 0x00A98C03
+define_hex CONFIG_XILINX_PPC405_0_APU_UDI_6 0x00AB8C03
+define_hex CONFIG_XILINX_PPC405_0_APU_UDI_7 0x00AD8C43
+define_hex CONFIG_XILINX_PPC405_0_APU_UDI_8 0x00AF8C43
+define_hex CONFIG_XILINX_PPC405_0_PVR_HIGH 0x00000000
+define_hex CONFIG_XILINX_PPC405_0_PVR_LOW 0x00000000
 define_string CONFIG_XILINX_PPC405_0_INSTANCE ppc405_0
-define_string CONFIG_XILINX_PPC405_0_HW_VER 2.00.c
+define_string CONFIG_XILINX_PPC405_0_HW_VER 1.01.a
+
+# Definitions for V34_0
+define_string CONFIG_XILINX_V34_0_INSTANCE plb
+define_int CONFIG_XILINX_V34_0_PLB_NUM_MASTERS 2
+define_int CONFIG_XILINX_V34_0_PLB_NUM_SLAVES 2
+define_int CONFIG_XILINX_V34_0_PLB_MID_WIDTH 1
+define_int CONFIG_XILINX_V34_0_PLB_AWIDTH 32
+define_int CONFIG_XILINX_V34_0_PLB_DWIDTH 64
+define_int CONFIG_XILINX_V34_0_DCR_INTFCE 0
+define_hex CONFIG_XILINX_V34_0_BASEADDR 0x000003FF
+define_hex CONFIG_XILINX_V34_0_HIGHADDR 0x00000000
+define_int CONFIG_XILINX_V34_0_DCR_AWIDTH 10
+define_int CONFIG_XILINX_V34_0_DCR_DWIDTH 32
+define_int CONFIG_XILINX_V34_0_EXT_RESET_HIGH 1
+define_int CONFIG_XILINX_V34_0_IRQ_ACTIVE 1
+define_int CONFIG_XILINX_V34_0_NUM_OPBCLK_PLB2OPB_REARB 5
+define_string CONFIG_XILINX_V34_0_INSTANCE plb
+define_string CONFIG_XILINX_V34_0_HW_VER 1.02.a
+
+# Definitions for V20_0
+define_string CONFIG_XILINX_V20_0_INSTANCE opb
+define_hex CONFIG_XILINX_V20_0_BASEADDR 0xFFFFFFFF
+define_hex CONFIG_XILINX_V20_0_HIGHADDR 0x00000000
+define_int CONFIG_XILINX_V20_0_OPB_AWIDTH 32
+define_int CONFIG_XILINX_V20_0_OPB_DWIDTH 32
+define_int CONFIG_XILINX_V20_0_NUM_MASTERS 1
+define_int CONFIG_XILINX_V20_0_NUM_SLAVES 4
+define_int CONFIG_XILINX_V20_0_USE_LUT_OR 1
+define_int CONFIG_XILINX_V20_0_EXT_RESET_HIGH 1
+define_int CONFIG_XILINX_V20_0_DYNAM_PRIORITY 0
+define_int CONFIG_XILINX_V20_0_PARK 0
+define_int CONFIG_XILINX_V20_0_PROINTRFCE 0
+define_int CONFIG_XILINX_V20_0_REG_GRANTS 1
+define_int CONFIG_XILINX_V20_0_DEV_BLK_ID 0
+define_int CONFIG_XILINX_V20_0_DEV_MIR_ENABLE 0
+define_string CONFIG_XILINX_V20_0_INSTANCE opb
+define_string CONFIG_XILINX_V20_0_HW_VER 1.10.c
 
 # Definitions for UARTLITE_0
-define_string CONFIG_XILINX_UARTLITE_0_INSTANCE RS232_Uart_1
+define_string CONFIG_XILINX_UARTLITE_0_INSTANCE RS232
 define_hex CONFIG_XILINX_UARTLITE_0_BASEADDR 0x40600000
 define_hex CONFIG_XILINX_UARTLITE_0_HIGHADDR 0x4060FFFF
 define_int CONFIG_XILINX_UARTLITE_0_OPB_DWIDTH 32
@@ -39,134 +85,109 @@
 define_int CONFIG_XILINX_UARTLITE_0_BAUDRATE 9600
 define_int CONFIG_XILINX_UARTLITE_0_USE_PARITY 0
 define_int CONFIG_XILINX_UARTLITE_0_ODD_PARITY 0
-define_string CONFIG_XILINX_UARTLITE_0_INSTANCE RS232_Uart_1
+define_string CONFIG_XILINX_UARTLITE_0_INSTANCE RS232
 define_string CONFIG_XILINX_UARTLITE_0_HW_VER 1.00.b
-define_int CONFIG_XILINX_UARTLITE_0_IRQ 2
-
-# Definitions for TIMER_0
-define_string CONFIG_XILINX_TIMER_0_INSTANCE opb_timer_1
-define_string CONFIG_XILINX_TIMER_0_FAMILY virtex2p
-define_int CONFIG_XILINX_TIMER_0_COUNT_WIDTH 32
-define_int CONFIG_XILINX_TIMER_0_ONE_TIMER_ONLY 1
-define_int CONFIG_XILINX_TIMER_0_TRIG0_ASSERT 1
-define_int CONFIG_XILINX_TIMER_0_TRIG1_ASSERT 1
-define_int CONFIG_XILINX_TIMER_0_GEN0_ASSERT 1
-define_int CONFIG_XILINX_TIMER_0_GEN1_ASSERT 1
-define_int CONFIG_XILINX_TIMER_0_OPB_AWIDTH 32
-define_int CONFIG_XILINX_TIMER_0_OPB_DWIDTH 32
-define_hex CONFIG_XILINX_TIMER_0_BASEADDR 0x41C00000
-define_hex CONFIG_XILINX_TIMER_0_HIGHADDR 0x41C0FFFF
-define_string CONFIG_XILINX_TIMER_0_INSTANCE opb_timer_1
-define_string CONFIG_XILINX_TIMER_0_HW_VER 1.00.b
-define_int CONFIG_XILINX_TIMER_0_IRQ 0
-
-# Definitions for INTC_0
-define_string CONFIG_XILINX_INTC_0_INSTANCE opb_intc_0
-define_string CONFIG_XILINX_INTC_0_FAMILY virtex2p
-define_int CONFIG_XILINX_INTC_0_Y 0
-define_int CONFIG_XILINX_INTC_0_X 0
-define_string CONFIG_XILINX_INTC_0_U_SET intc
-define_int CONFIG_XILINX_INTC_0_OPB_AWIDTH 32
-define_int CONFIG_XILINX_INTC_0_OPB_DWIDTH 32
-define_hex CONFIG_XILINX_INTC_0_BASEADDR 0x41200000
-define_hex CONFIG_XILINX_INTC_0_HIGHADDR 0x4120FFFF
-define_int CONFIG_XILINX_INTC_0_NUM_INTR_INPUTS 3
-define_hex CONFIG_XILINX_INTC_0_KIND_OF_INTR 0x00000004
-define_hex CONFIG_XILINX_INTC_0_KIND_OF_EDGE 0x00000004
-define_hex CONFIG_XILINX_INTC_0_KIND_OF_LVL 0x00000003
-define_int CONFIG_XILINX_INTC_0_HAS_IPR 1
-define_int CONFIG_XILINX_INTC_0_HAS_SIE 1
-define_int CONFIG_XILINX_INTC_0_HAS_CIE 1
-define_int CONFIG_XILINX_INTC_0_HAS_IVR 1
-define_int CONFIG_XILINX_INTC_0_IRQ_IS_LEVEL 1
-define_int CONFIG_XILINX_INTC_0_IRQ_ACTIVE 1
-define_string CONFIG_XILINX_INTC_0_INSTANCE opb_intc_0
-define_string CONFIG_XILINX_INTC_0_HW_VER 1.00.c
+define_int CONFIG_XILINX_UARTLITE_0_IRQ 1
 
 # Definitions for ETHERNET_0
 define_string CONFIG_XILINX_ETHERNET_0_INSTANCE Ethernet_MAC
-define_int CONFIG_XILINX_ETHERNET_0_DEV_BLK_ID 0
-define_int CONFIG_XILINX_ETHERNET_0_PLB_CLK_PERIOD_PS 10000
-define_string CONFIG_XILINX_ETHERNET_0_FAMILY virtex2p
-define_int CONFIG_XILINX_ETHERNET_0_IPIF_FIFO_DEPTH 32768
-define_hex CONFIG_XILINX_ETHERNET_0_BASEADDR 0x80400000
-define_hex CONFIG_XILINX_ETHERNET_0_HIGHADDR 0x8040FFFF
+define_int CONFIG_XILINX_ETHERNET_0_DEV_BLK_ID 1
 define_int CONFIG_XILINX_ETHERNET_0_DEV_MIR_ENABLE 1
+define_hex CONFIG_XILINX_ETHERNET_0_BASEADDR 0x40C00000
+define_hex CONFIG_XILINX_ETHERNET_0_HIGHADDR 0x40C0FFFF
 define_int CONFIG_XILINX_ETHERNET_0_RESET_PRESENT 1
 define_int CONFIG_XILINX_ETHERNET_0_INCLUDE_DEV_PENCODER 1
 define_int CONFIG_XILINX_ETHERNET_0_DMA_PRESENT 1
 define_int CONFIG_XILINX_ETHERNET_0_DMA_INTR_COALESCE 1
-define_int CONFIG_XILINX_ETHERNET_0_PLB_NUM_MASTERS 2
-define_int CONFIG_XILINX_ETHERNET_0_PLB_MID_WIDTH 1
-define_int CONFIG_XILINX_ETHERNET_0_PLB_AWIDTH 32
-define_int CONFIG_XILINX_ETHERNET_0_PLB_DWIDTH 64
-define_hex CONFIG_XILINX_ETHERNET_0_MIIM_CLKDVD 0x00000013
+define_int CONFIG_XILINX_ETHERNET_0_OPB_AWIDTH 32
+define_int CONFIG_XILINX_ETHERNET_0_OPB_DWIDTH 32
+define_int CONFIG_XILINX_ETHERNET_0_OPB_CLK_PERIOD_PS 10000
+define_string CONFIG_XILINX_ETHERNET_0_FAMILY virtex4
+define_int CONFIG_XILINX_ETHERNET_0_IPIF_RDFIFO_DEPTH 32768
+define_int CONFIG_XILINX_ETHERNET_0_IPIF_WRFIFO_DEPTH 32768
+define_hex CONFIG_XILINX_ETHERNET_0_MIIM_CLKDVD 0x0000001F
 define_int CONFIG_XILINX_ETHERNET_0_SOURCE_ADDR_INSERT_EXIST 1
 define_int CONFIG_XILINX_ETHERNET_0_PAD_INSERT_EXIST 1
 define_int CONFIG_XILINX_ETHERNET_0_FCS_INSERT_EXIST 1
 define_int CONFIG_XILINX_ETHERNET_0_MAFIFO_DEPTH 64
+define_int CONFIG_XILINX_ETHERNET_0_MAFIFO_BRAM_1_SRL_0 0
 define_int CONFIG_XILINX_ETHERNET_0_HALF_DUPLEX_EXIST 1
 define_int CONFIG_XILINX_ETHERNET_0_ERR_COUNT_EXIST 1
+define_int CONFIG_XILINX_ETHERNET_0_CAM_EXIST 0
+define_int CONFIG_XILINX_ETHERNET_0_CAM_BRAM_0_SRL_1 1
+define_int CONFIG_XILINX_ETHERNET_0_JUMBO_EXIST 0
 define_int CONFIG_XILINX_ETHERNET_0_MII_EXIST 1
 define_string CONFIG_XILINX_ETHERNET_0_INSTANCE Ethernet_MAC
-define_string CONFIG_XILINX_ETHERNET_0_HW_VER 1.01.a
-define_int CONFIG_XILINX_ETHERNET_0_IRQ 1
+define_string CONFIG_XILINX_ETHERNET_0_HW_VER 1.02.a
+define_int CONFIG_XILINX_ETHERNET_0_IRQ 0
 
 # Definitions for DDR_0
-define_string CONFIG_XILINX_DDR_0_INSTANCE DDR_256MB_32MX64_rank1_row13_col10_cl2_5
-define_int CONFIG_XILINX_DDR_0_INCLUDE_BURST_CACHELN_SUPPORT 1
+define_string CONFIG_XILINX_DDR_0_INSTANCE DDR_SDRAM_32Mx16
+define_int CONFIG_XILINX_DDR_0_DDR_ASYNSUPPORT 0
+define_int CONFIG_XILINX_DDR_0_INCLUDE_BURST_SUPPORT 0
 define_int CONFIG_XILINX_DDR_0_REG_DIMM 0
+define_int CONFIG_XILINX_DDR_0_EXTRA_TSU 0
 define_int CONFIG_XILINX_DDR_0_NUM_BANKS_MEM 1
-define_int CONFIG_XILINX_DDR_0_NUM_CLK_PAIRS 4
-define_string CONFIG_XILINX_DDR_0_FAMILY virtex2p
-define_int CONFIG_XILINX_DDR_0_INCLUDE_ECSUPPORT 0
-define_int CONFIG_XILINX_DDR_0_ENABLE_ECREG 1
-define_int CONFIG_XILINX_DDR_0_ECDEFAULT_ON 1
-define_int CONFIG_XILINX_DDR_0_INCLUDE_ECINTR 0
-define_int CONFIG_XILINX_DDR_0_INCLUDE_ECTEST 0
-define_int CONFIG_XILINX_DDR_0_ECSETHRESHOLD 1
-define_int CONFIG_XILINX_DDR_0_ECDETHRESHOLD 1
-define_int CONFIG_XILINX_DDR_0_ECPETHRESHOLD 1
-define_int CONFIG_XILINX_DDR_0_NUM_ECBITS 7
-define_int CONFIG_XILINX_DDR_0_DDR_TMRD 20000
-define_int CONFIG_XILINX_DDR_0_DDR_TWR 20000
+define_int CONFIG_XILINX_DDR_0_NUM_CLK_PAIRS 1
+define_string CONFIG_XILINX_DDR_0_FAMILY virtex4
+define_int CONFIG_XILINX_DDR_0_DDR_TMRD 15000
+define_int CONFIG_XILINX_DDR_0_DDR_TWR 15000
 define_int CONFIG_XILINX_DDR_0_DDR_TWTR 1
-define_int CONFIG_XILINX_DDR_0_DDR_TRAS 60000
-define_int CONFIG_XILINX_DDR_0_DDR_TRC 90000
-define_int CONFIG_XILINX_DDR_0_DDR_TRFC 100000
-define_int CONFIG_XILINX_DDR_0_DDR_TRCD 30000
-define_int CONFIG_XILINX_DDR_0_DDR_TRRD 20000
-define_int CONFIG_XILINX_DDR_0_DDR_TREFC 70300000
+define_int CONFIG_XILINX_DDR_0_DDR_TRAS 40000
+define_int CONFIG_XILINX_DDR_0_DDR_TRC 65000
+define_int CONFIG_XILINX_DDR_0_DDR_TRFC 75000
+define_int CONFIG_XILINX_DDR_0_DDR_TRCD 20000
+define_int CONFIG_XILINX_DDR_0_DDR_TRRD 15000
+define_int CONFIG_XILINX_DDR_0_DDR_TREFC 70300
 define_int CONFIG_XILINX_DDR_0_DDR_TREFI 7800000
-define_int CONFIG_XILINX_DDR_0_DDR_TRP 30000
+define_int CONFIG_XILINX_DDR_0_DDR_TRP 20000
 define_int CONFIG_XILINX_DDR_0_DDR_CAS_LAT 2
-define_int CONFIG_XILINX_DDR_0_DDR_DWIDTH 64
+define_int CONFIG_XILINX_DDR_0_DDR_DWIDTH 16
 define_int CONFIG_XILINX_DDR_0_DDR_AWIDTH 13
 define_int CONFIG_XILINX_DDR_0_DDR_COL_AWIDTH 10
 define_int CONFIG_XILINX_DDR_0_DDR_BANK_AWIDTH 2
 define_hex CONFIG_XILINX_DDR_0_MEM0_BASEADDR 0x00000000
-define_hex CONFIG_XILINX_DDR_0_MEM0_HIGHADDR 0x0FFFFFFF
+define_hex CONFIG_XILINX_DDR_0_MEM0_HIGHADDR 0x03FFFFFF
 define_hex CONFIG_XILINX_DDR_0_MEM1_BASEADDR 0xFFFFFFFF
 define_hex CONFIG_XILINX_DDR_0_MEM1_HIGHADDR 0x00000000
 define_hex CONFIG_XILINX_DDR_0_MEM2_BASEADDR 0xFFFFFFFF
 define_hex CONFIG_XILINX_DDR_0_MEM2_HIGHADDR 0x00000000
 define_hex CONFIG_XILINX_DDR_0_MEM3_BASEADDR 0xFFFFFFFF
 define_hex CONFIG_XILINX_DDR_0_MEM3_HIGHADDR 0x00000000
-define_hex CONFIG_XILINX_DDR_0_ECBASEADDR 0xFFFFFFFF
-define_hex CONFIG_XILINX_DDR_0_ECHIGHADDR 0x00000000
-define_int CONFIG_XILINX_DDR_0_PLB_NUM_MASTERS 2
-define_int CONFIG_XILINX_DDR_0_PLB_MID_WIDTH 1
-define_int CONFIG_XILINX_DDR_0_PLB_AWIDTH 32
-define_int CONFIG_XILINX_DDR_0_PLB_DWIDTH 64
-define_int CONFIG_XILINX_DDR_0_PLB_CLK_PERIOD_PS 10000
+define_int CONFIG_XILINX_DDR_0_OPB_DWIDTH 32
+define_int CONFIG_XILINX_DDR_0_OPB_AWIDTH 32
+define_int CONFIG_XILINX_DDR_0_OPB_CLK_PERIOD_PS 10000
 define_int CONFIG_XILINX_DDR_0_SIM_INIT_TIME_PS 200000000
-define_string CONFIG_XILINX_DDR_0_INSTANCE DDR_256MB_32MX64_rank1_row13_col10_cl2_5
-define_string CONFIG_XILINX_DDR_0_HW_VER 1.11.a
+define_string CONFIG_XILINX_DDR_0_INSTANCE DDR_SDRAM_32Mx16
+define_string CONFIG_XILINX_DDR_0_HW_VER 2.00.b
+
+# Definitions for INTC_0
+define_string CONFIG_XILINX_INTC_0_INSTANCE opb_intc_0
+define_string CONFIG_XILINX_INTC_0_FAMILY virtex4
+define_int CONFIG_XILINX_INTC_0_Y 0
+define_int CONFIG_XILINX_INTC_0_X 0
+define_string CONFIG_XILINX_INTC_0_U_SET intc
+define_int CONFIG_XILINX_INTC_0_OPB_AWIDTH 32
+define_int CONFIG_XILINX_INTC_0_OPB_DWIDTH 32
+define_hex CONFIG_XILINX_INTC_0_BASEADDR 0x41200000
+define_hex CONFIG_XILINX_INTC_0_HIGHADDR 0x4120FFFF
+define_int CONFIG_XILINX_INTC_0_NUM_INTR_INPUTS 2
+define_hex CONFIG_XILINX_INTC_0_KIND_OF_INTR 0x00000002
+define_hex CONFIG_XILINX_INTC_0_KIND_OF_EDGE 0x00000002
+define_hex CONFIG_XILINX_INTC_0_KIND_OF_LVL 0x00000001
+define_int CONFIG_XILINX_INTC_0_HAS_IPR 1
+define_int CONFIG_XILINX_INTC_0_HAS_SIE 1
+define_int CONFIG_XILINX_INTC_0_HAS_CIE 1
+define_int CONFIG_XILINX_INTC_0_HAS_IVR 1
+define_int CONFIG_XILINX_INTC_0_IRQ_IS_LEVEL 1
+define_int CONFIG_XILINX_INTC_0_IRQ_ACTIVE 1
+define_string CONFIG_XILINX_INTC_0_INSTANCE opb_intc_0
+define_string CONFIG_XILINX_INTC_0_HW_VER 1.00.c
 
 # Definitions for BRAM_IF_CNTLR_0
 define_string CONFIG_XILINX_BRAM_IF_CNTLR_0_INSTANCE plb_bram_if_cntlr_1
 define_int CONFIG_XILINX_BRAM_IF_CNTLR_0_NUM_MASTERS 2
-define_hex CONFIG_XILINX_BRAM_IF_CNTLR_0_BASEADDR 0xFFFFC000
+define_hex CONFIG_XILINX_BRAM_IF_CNTLR_0_BASEADDR 0xFFFF0000
 define_hex CONFIG_XILINX_BRAM_IF_CNTLR_0_HIGHADDR 0xFFFFFFFF
 define_int CONFIG_XILINX_BRAM_IF_CNTLR_0_INCLUDE_BURST_CACHELN_SUPPORT 0
 define_int CONFIG_XILINX_BRAM_IF_CNTLR_0_PLB_DWIDTH 64
@@ -176,31 +197,12 @@
 define_string CONFIG_XILINX_BRAM_IF_CNTLR_0_INSTANCE plb_bram_if_cntlr_1
 define_string CONFIG_XILINX_BRAM_IF_CNTLR_0_HW_VER 1.00.b
 
-# Definitions for DSBRAM_IF_CNTLR_0
-define_string CONFIG_XILINX_DSBRAM_IF_CNTLR_0_INSTANCE docm_cntlr
-define_hex CONFIG_XILINX_DSBRAM_IF_CNTLR_0_BASEADDR 0x28800000
-define_hex CONFIG_XILINX_DSBRAM_IF_CNTLR_0_HIGHADDR 0x28803FFF
-define_int CONFIG_XILINX_DSBRAM_IF_CNTLR_0_BRAM_EN 0
-define_int CONFIG_XILINX_DSBRAM_IF_CNTLR_0_RANGECHECK 0
-define_string CONFIG_XILINX_DSBRAM_IF_CNTLR_0_INSTANCE docm_cntlr
-define_string CONFIG_XILINX_DSBRAM_IF_CNTLR_0_HW_VER 3.00.a
-
-# Definitions for ISBRAM_IF_CNTLR_0
-define_string CONFIG_XILINX_ISBRAM_IF_CNTLR_0_INSTANCE iocm_cntlr
-define_hex CONFIG_XILINX_ISBRAM_IF_CNTLR_0_BASEADDR 0xE8800000
-define_hex CONFIG_XILINX_ISBRAM_IF_CNTLR_0_HIGHADDR 0xE8801FFF
-define_int CONFIG_XILINX_ISBRAM_IF_CNTLR_0_BRAM_EN 0
-define_int CONFIG_XILINX_ISBRAM_IF_CNTLR_0_RANGECHECK 0
-define_string CONFIG_XILINX_ISBRAM_IF_CNTLR_0_INSTANCE iocm_cntlr
-define_string CONFIG_XILINX_ISBRAM_IF_CNTLR_0_HW_VER 3.00.a
-
 # Peripheral counts
-define_int CONFIG_XILINX_DSBRAM_IF_CNTLR_NUM_INSTANCES 1
-define_int CONFIG_XILINX_TIMER_NUM_INSTANCES 1
-define_int CONFIG_XILINX_ISBRAM_IF_CNTLR_NUM_INSTANCES 1
+define_int CONFIG_XILINX_V20_NUM_INSTANCES 1
+define_int CONFIG_XILINX_V34_NUM_INSTANCES 1
 define_int CONFIG_XILINX_BRAM_IF_CNTLR_NUM_INSTANCES 1
-define_int CONFIG_XILINX_DDR_NUM_INSTANCES 1
 define_int CONFIG_XILINX_INTC_NUM_INSTANCES 1
+define_int CONFIG_XILINX_DDR_NUM_INSTANCES 1
 define_int CONFIG_XILINX_UARTLITE_NUM_INSTANCES 1
 define_int CONFIG_XILINX_ETHERNET_NUM_INSTANCES 1
 
Index: arch/ppc/platforms/xilinx_auto/xilinx_auto.c
===================================================================
RCS file: /cvs/linuxppc-2.4/arch/ppc/platforms/xilinx_auto/xilinx_auto.c,v
retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -r1.1.1.1 -r1.2
--- arch/ppc/platforms/xilinx_auto/xilinx_auto.c	17 Mar 2006 05:19:36 -0000	1.1.1.1
+++ arch/ppc/platforms/xilinx_auto/xilinx_auto.c	17 Mar 2006 06:01:33 -0000	1.2
@@ -224,8 +224,8 @@
 #endif
 
 	/* Identify the system */
-	printk
-	    ("Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc. (source@mvista.com)\n");
+	printk("Xilinx Auto Virtex-II/Virtex-4, based on:\n"
+	       "  Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc. (source@mvista.com)\n");
 }
 
 /* Called after board_setup_irq from ppc4xx_init_IRQ(). */


--------------030300060300060800080703--
