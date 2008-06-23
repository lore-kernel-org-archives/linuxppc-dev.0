Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Mon, 23 Jun 2008 15:31:29 +1000
Subject: [PATCH 7/9] powerpc: Add VSX assembler code macros
In-Reply-To: <1214199088.328454.246197670684.qpush@coopers>
Message-Id: <20080623053129.8EEE27029B@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the macros for the VSX load/store instruction as most
binutils are not going to support this for a while.

Also add VSX register save/restore macros and vsr[0-63] register definitions.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 include/asm-powerpc/ppc_asm.h |  127 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

Index: linux-2.6-ozlabs/include/asm-powerpc/ppc_asm.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/ppc_asm.h
+++ linux-2.6-ozlabs/include/asm-powerpc/ppc_asm.h
@@ -74,6 +74,15 @@ END_FTR_SECTION_IFCLR(CPU_FTR_PURR);				
 				REST_10GPRS(22, base)
 #endif
 
+/*
+ * Define what the VSX XX1 form instructions will look like, then add
+ * the 128 bit load store instructions based on that.
+ */
+#define VSX_XX1(xs, ra, rb)	(((xs) & 0x1f) << 21 | ((ra) << 16) |  \
+				 ((rb) << 11) | (((xs) >> 5)))
+
+#define STXVD2X(xs, ra, rb)	.long (0x7c000798 | VSX_XX1((xs), (ra), (rb)))
+#define LXVD2X(xs, ra, rb)	.long (0x7c000698 | VSX_XX1((xs), (ra), (rb)))
 
 #define SAVE_2GPRS(n, base)	SAVE_GPR(n, base); SAVE_GPR(n+1, base)
 #define SAVE_4GPRS(n, base)	SAVE_2GPRS(n, base); SAVE_2GPRS(n+2, base)
@@ -110,6 +119,57 @@ END_FTR_SECTION_IFCLR(CPU_FTR_PURR);				
 #define REST_16VRS(n,b,base)	REST_8VRS(n,b,base); REST_8VRS(n+8,b,base)
 #define REST_32VRS(n,b,base)	REST_16VRS(n,b,base); REST_16VRS(n+16,b,base)
 
+/* Save the lower 32 VSRs in the thread VSR region */
+#define SAVE_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n));  STXVD2X(n,b,base)
+#define SAVE_2VSRS(n,b,base)	SAVE_VSR(n,b,base); SAVE_VSR(n+1,b,base)
+#define SAVE_4VSRS(n,b,base)	SAVE_2VSRS(n,b,base); SAVE_2VSRS(n+2,b,base)
+#define SAVE_8VSRS(n,b,base)	SAVE_4VSRS(n,b,base); SAVE_4VSRS(n+4,b,base)
+#define SAVE_16VSRS(n,b,base)	SAVE_8VSRS(n,b,base); SAVE_8VSRS(n+8,b,base)
+#define SAVE_32VSRS(n,b,base)	SAVE_16VSRS(n,b,base); SAVE_16VSRS(n+16,b,base)
+#define REST_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n)); LXVD2X(n,b,base)
+#define REST_2VSRS(n,b,base)	REST_VSR(n,b,base); REST_VSR(n+1,b,base)
+#define REST_4VSRS(n,b,base)	REST_2VSRS(n,b,base); REST_2VSRS(n+2,b,base)
+#define REST_8VSRS(n,b,base)	REST_4VSRS(n,b,base); REST_4VSRS(n+4,b,base)
+#define REST_16VSRS(n,b,base)	REST_8VSRS(n,b,base); REST_8VSRS(n+8,b,base)
+#define REST_32VSRS(n,b,base)	REST_16VSRS(n,b,base); REST_16VSRS(n+16,b,base)
+/* Save the upper 32 VSRs (32-63) in the thread VSX region (0-31) */
+#define SAVE_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n));  STXVD2X(n+32,b,base)
+#define SAVE_2VSRSU(n,b,base)	SAVE_VSRU(n,b,base); SAVE_VSRU(n+1,b,base)
+#define SAVE_4VSRSU(n,b,base)	SAVE_2VSRSU(n,b,base); SAVE_2VSRSU(n+2,b,base)
+#define SAVE_8VSRSU(n,b,base)	SAVE_4VSRSU(n,b,base); SAVE_4VSRSU(n+4,b,base)
+#define SAVE_16VSRSU(n,b,base)	SAVE_8VSRSU(n,b,base); SAVE_8VSRSU(n+8,b,base)
+#define SAVE_32VSRSU(n,b,base)	SAVE_16VSRSU(n,b,base); SAVE_16VSRSU(n+16,b,base)
+#define REST_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n)); LXVD2X(n+32,b,base)
+#define REST_2VSRSU(n,b,base)	REST_VSRU(n,b,base); REST_VSRU(n+1,b,base)
+#define REST_4VSRSU(n,b,base)	REST_2VSRSU(n,b,base); REST_2VSRSU(n+2,b,base)
+#define REST_8VSRSU(n,b,base)	REST_4VSRSU(n,b,base); REST_4VSRSU(n+4,b,base)
+#define REST_16VSRSU(n,b,base)	REST_8VSRSU(n,b,base); REST_8VSRSU(n+8,b,base)
+#define REST_32VSRSU(n,b,base)	REST_16VSRSU(n,b,base); REST_16VSRSU(n+16,b,base)
+
+#ifdef CONFIG_VSX
+#define REST_32FPVSRS(n,c,base)						\
+BEGIN_FTR_SECTION							\
+	b	2f;							\
+END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
+	REST_32FPRS(n,base);						\
+	b	3f;							\
+2:	REST_32VSRS(n,c,base);						\
+3:
+
+#define SAVE_32FPVSRS(n,c,base)						\
+BEGIN_FTR_SECTION							\
+	b	2f;							\
+END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
+	SAVE_32FPRS(n,base);						\
+	b	3f;							\
+2:	SAVE_32VSRS(n,c,base);						\
+3:
+
+#else
+#define REST_32FPVSRS(n,b,base)	REST_32FPRS(n, base)
+#define SAVE_32FPVSRS(n,b,base)	SAVE_32FPRS(n, base)
+#endif
+
 #define SAVE_EVR(n,s,base)	evmergehi s,s,n; stw s,THREAD_EVR0+4*(n)(base)
 #define SAVE_2EVRS(n,s,base)	SAVE_EVR(n,s,base); SAVE_EVR(n+1,s,base)
 #define SAVE_4EVRS(n,s,base)	SAVE_2EVRS(n,s,base); SAVE_2EVRS(n+2,s,base)
@@ -534,6 +594,73 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define	vr30	30
 #define	vr31	31
 
+/* VSX Registers (VSRs) */
+
+#define	vsr0	0
+#define	vsr1	1
+#define	vsr2	2
+#define	vsr3	3
+#define	vsr4	4
+#define	vsr5	5
+#define	vsr6	6
+#define	vsr7	7
+#define	vsr8	8
+#define	vsr9	9
+#define	vsr10	10
+#define	vsr11	11
+#define	vsr12	12
+#define	vsr13	13
+#define	vsr14	14
+#define	vsr15	15
+#define	vsr16	16
+#define	vsr17	17
+#define	vsr18	18
+#define	vsr19	19
+#define	vsr20	20
+#define	vsr21	21
+#define	vsr22	22
+#define	vsr23	23
+#define	vsr24	24
+#define	vsr25	25
+#define	vsr26	26
+#define	vsr27	27
+#define	vsr28	28
+#define	vsr29	29
+#define	vsr30	30
+#define	vsr31	31
+#define	vsr32	32
+#define	vsr33	33
+#define	vsr34	34
+#define	vsr35	35
+#define	vsr36	36
+#define	vsr37	37
+#define	vsr38	38
+#define	vsr39	39
+#define	vsr40	40
+#define	vsr41	41
+#define	vsr42	42
+#define	vsr43	43
+#define	vsr44	44
+#define	vsr45	45
+#define	vsr46	46
+#define	vsr47	47
+#define	vsr48	48
+#define	vsr49	49
+#define	vsr50	50
+#define	vsr51	51
+#define	vsr52	52
+#define	vsr53	53
+#define	vsr54	54
+#define	vsr55	55
+#define	vsr56	56
+#define	vsr57	57
+#define	vsr58	58
+#define	vsr59	59
+#define	vsr60	60
+#define	vsr61	61
+#define	vsr62	62
+#define	vsr63	63
+
 /* SPE Registers (EVPRs) */
 
 #define	evr0	0
