Return-Path: <anton@ozlabs.org>
Date: Wed, 19 Jul 2006 08:01:28 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] clean up pseries hcall interfaces
Message-ID: <20060718220127.GA1480@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Our pseries hcall interfaces are out of control:

	plpar_hcall_norets
	plpar_hcall
	plpar_hcall_8arg_2ret
	plpar_hcall_4out
	plpar_hcall_7arg_7ret
	plpar_hcall_9arg_9ret

Create 3 interfaces to cover all cases:

	plpar_hcall_norets:	7 arguments no returns
	plpar_hcall:		6 arguments 4 returns
	plpar_hcall9:		9 arguments 9 returns

There are only 2 cases in the kernel that need plpar_hcall9, hopefully
we can keep it that way.

Pass in a buffer to stash return parameters so we avoid the &dummy1,
&dummy2 madness.

Signed-off-by: Anton Blanchard <anton@samba.org>
--

Index: build/arch/powerpc/kernel/lparcfg.c
===================================================================
--- build.orig/arch/powerpc/kernel/lparcfg.c	2006-07-18 04:20:13.000000000 +1000
+++ build/arch/powerpc/kernel/lparcfg.c	2006-07-18 04:24:08.000000000 +1000
@@ -183,8 +183,14 @@ static unsigned int h_get_ppp(unsigned l
 			      unsigned long *resource)
 {
 	unsigned long rc;
-	rc = plpar_hcall_4out(H_GET_PPP, 0, 0, 0, 0, entitled, unallocated,
-			      aggregation, resource);
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall(H_GET_PPP, retbuf);
+
+	*entitled = retbuf[0];
+	*unallocated = retbuf[1];
+	*aggregation = retbuf[2];
+	*resource = retbuf[3];
 
 	log_plpar_hcall_return(rc, "H_GET_PPP");
 
@@ -194,8 +200,12 @@ static unsigned int h_get_ppp(unsigned l
 static void h_pic(unsigned long *pool_idle_time, unsigned long *num_procs)
 {
 	unsigned long rc;
-	unsigned long dummy;
-	rc = plpar_hcall(H_PIC, 0, 0, 0, 0, pool_idle_time, num_procs, &dummy);
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall(H_PIC, retbuf);
+
+	*pool_idle_time = retbuf[0];
+	*num_procs = retbuf[1];
 
 	if (rc != H_AUTHORITY)
 		log_plpar_hcall_return(rc, "H_PIC");
Index: build/arch/powerpc/kernel/rtas.c
===================================================================
--- build.orig/arch/powerpc/kernel/rtas.c	2006-07-18 04:20:13.000000000 +1000
+++ build/arch/powerpc/kernel/rtas.c	2006-07-18 04:24:08.000000000 +1000
@@ -666,15 +666,14 @@ static int rtas_ibm_suspend_me(struct rt
 	int i;
 	long state;
 	long rc;
-	unsigned long dummy;
-
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 	struct rtas_suspend_me_data data;
 
 	/* Make sure the state is valid */
-	rc = plpar_hcall(H_VASI_STATE,
-			 ((u64)args->args[0] << 32) | args->args[1],
-			 0, 0, 0,
-			 &state, &dummy, &dummy);
+	rc = plpar_hcall(H_VASI_STATE, retbuf,
+			 ((u64)args->args[0] << 32) | args->args[1]);
+
+	state = retbuf[0];
 
 	if (rc) {
 		printk(KERN_ERR "rtas_ibm_suspend_me: vasi_state returned %ld\n",rc);
Index: build/arch/powerpc/platforms/pseries/hvCall.S
===================================================================
--- build.orig/arch/powerpc/platforms/pseries/hvCall.S	2006-07-18 04:20:13.000000000 +1000
+++ build/arch/powerpc/platforms/pseries/hvCall.S	2006-07-19 06:59:32.000000000 +1000
@@ -1,7 +1,6 @@
 /*
  * This file contains the generic code to perform a call to the
  * pSeries LPAR hypervisor.
- * NOTE: this file will go away when we move to inline this work.
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -16,42 +15,6 @@
 
 	.text
 
-/* long plpar_hcall(unsigned long opcode,		R3
-			unsigned long arg1,		R4
-			unsigned long arg2,		R5
-			unsigned long arg3,		R6
-			unsigned long arg4,		R7
-			unsigned long *out1,		R8
-			unsigned long *out2,		R9
-			unsigned long *out3);		R10
- */
-_GLOBAL(plpar_hcall)
-	HMT_MEDIUM
-
-	mfcr	r0
-
-	std	r8,STK_PARM(r8)(r1)	/* Save out ptrs */
-	std	r9,STK_PARM(r9)(r1)
-	std	r10,STK_PARM(r10)(r1)
-
-	stw	r0,8(r1)
-
-	HVSC				/* invoke the hypervisor */
-
-	lwz	r0,8(r1)
-
-	ld	r8,STK_PARM(r8)(r1)	/* Fetch r4-r6 ret args */
-	ld	r9,STK_PARM(r9)(r1)
-	ld	r10,STK_PARM(r10)(r1)
-	std	r4,0(r8)
-	std	r5,0(r9)
-	std	r6,0(r10)
-
-	mtcrf	0xff,r0
-	blr				/* return r3 = status */
-
-
-/* Simple interface with no output values (other than status) */
 _GLOBAL(plpar_hcall_norets)
 	HMT_MEDIUM
 
@@ -64,164 +27,64 @@ _GLOBAL(plpar_hcall_norets)
 	mtcrf	0xff,r0
 	blr				/* return r3 = status */
 
-
-/* long plpar_hcall_8arg_2ret(unsigned long opcode,	R3
-			unsigned long arg1,		R4
-			unsigned long arg2,		R5
-			unsigned long arg3,		R6
-			unsigned long arg4,		R7
-			unsigned long arg5,		R8
-			unsigned long arg6,		R9
-			unsigned long arg7,		R10
-			unsigned long arg8,		112(R1)
-			unsigned long *out1);		120(R1)
- */
-_GLOBAL(plpar_hcall_8arg_2ret)
+_GLOBAL(plpar_hcall)
 	HMT_MEDIUM
 
 	mfcr	r0
-	ld	r11,STK_PARM(r11)(r1)	/* put arg8 in R11 */
 	stw	r0,8(r1)
 
-	HVSC				/* invoke the hypervisor */
-
-	lwz	r0,8(r1)
-	ld	r10,STK_PARM(r12)(r1)	/* Fetch r4 ret arg */
-	std	r4,0(r10)
-	mtcrf	0xff,r0
-	blr				/* return r3 = status */
-
-
-/* long plpar_hcall_4out(unsigned long opcode,		R3
-		 	unsigned long arg1,		R4
-		 	unsigned long arg2,		R5
-		 	unsigned long arg3,		R6
-		 	unsigned long arg4,		R7
-		 	unsigned long *out1,		R8
-		 	unsigned long *out2,		R9
-		 	unsigned long *out3,		R10
-		 	unsigned long *out4);		112(R1)
- */
-_GLOBAL(plpar_hcall_4out)
-	HMT_MEDIUM
-
-	mfcr	r0
-	stw	r0,8(r1)
+	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
 
-	std	r8,STK_PARM(r8)(r1)	/* Save out ptrs */
-	std	r9,STK_PARM(r9)(r1)
-	std	r10,STK_PARM(r10)(r1)
+	mr	r4,r5
+	mr	r5,r6
+	mr	r6,r7
+	mr	r7,r8
+	mr	r8,r9
+	mr	r9,r10
 
 	HVSC				/* invoke the hypervisor */
 
-	lwz	r0,8(r1)
-
-	ld	r8,STK_PARM(r8)(r1)	/* Fetch r4-r7 ret args */
-	ld	r9,STK_PARM(r9)(r1)
-	ld	r10,STK_PARM(r10)(r1)
-	ld	r11,STK_PARM(r11)(r1)
-	std	r4,0(r8)
-	std	r5,0(r9)
-	std	r6,0(r10)
-	std	r7,0(r11)
-
-	mtcrf	0xff,r0
-	blr				/* return r3 = status */
-
-/* plpar_hcall_7arg_7ret(unsigned long opcode,		R3
-			 unsigned long arg1,		R4
-			 unsigned long arg2,		R5
-			 unsigned long arg3,		R6
-			 unsigned long arg4,		R7
-			 unsigned long arg5,		R8
-			 unsigned long arg6,		R9
-			 unsigned long arg7,		R10
-			 unsigned long *out1,		112(R1)
-			 unsigned long *out2,		110(R1)
-			 unsigned long *out3,		108(R1)
-			 unsigned long *out4,		106(R1)
-			 unsigned long *out5,		104(R1)
-			 unsigned long *out6,		102(R1)
-			 unsigned long *out7);		100(R1)
-*/
-_GLOBAL(plpar_hcall_7arg_7ret)
-	HMT_MEDIUM
-
-	mfcr	r0
-	stw	r0,8(r1)
-
-	HVSC				/* invoke the hypervisor */
+	ld	r12,STK_PARM(r4)(r1)
+	std	r4,  0(r12)
+	std	r5,  8(r12)
+	std	r6, 16(r12)
+	std	r7, 24(r12)
 
 	lwz	r0,8(r1)
-
-	ld	r11,STK_PARM(r11)(r1)	/* Fetch r4 ret arg */
-	std	r4,0(r11)
-	ld	r11,STK_PARM(r12)(r1)	/* Fetch r5 ret arg */
-	std	r5,0(r11)
-	ld	r11,STK_PARM(r13)(r1)	/* Fetch r6 ret arg */
-	std	r6,0(r11)
-	ld	r11,STK_PARM(r14)(r1)	/* Fetch r7 ret arg */
-	std	r7,0(r11)
-	ld	r11,STK_PARM(r15)(r1)	/* Fetch r8 ret arg */
-	std	r8,0(r11)
-	ld	r11,STK_PARM(r16)(r1)	/* Fetch r9 ret arg */
-	std	r9,0(r11)
-	ld	r11,STK_PARM(r17)(r1)	/* Fetch r10 ret arg */
-	std	r10,0(r11)
-
 	mtcrf	0xff,r0
 
 	blr				/* return r3 = status */
 
-/* plpar_hcall_9arg_9ret(unsigned long opcode,		R3
-			 unsigned long arg1,		R4
-			 unsigned long arg2,		R5
-			 unsigned long arg3,		R6
-			 unsigned long arg4,		R7
-			 unsigned long arg5,		R8
-			 unsigned long arg6,		R9
-			 unsigned long arg7,		R10
-			 unsigned long arg8,		112(R1)
-			 unsigned long arg9,		110(R1)
-			 unsigned long *out1,		108(R1)
-			 unsigned long *out2,		106(R1)
-			 unsigned long *out3,		104(R1)
-			 unsigned long *out4,		102(R1)
-			 unsigned long *out5,		100(R1)
-			 unsigned long *out6,		 98(R1)
-			 unsigned long *out7);		 96(R1)
-			 unsigned long *out8,		 94(R1)
-		         unsigned long *out9,            92(R1)
-*/
-_GLOBAL(plpar_hcall_9arg_9ret)
+_GLOBAL(plpar_hcall9)
 	HMT_MEDIUM
 
 	mfcr	r0
 	stw	r0,8(r1)
 
-	ld	r11,STK_PARM(r11)(r1)	 /* put arg8 in R11 */
-	ld	r12,STK_PARM(r12)(r1)    /* put arg9 in R12 */
+	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
+
+	mr	r4,r5
+	mr	r5,r6
+	mr	r6,r7
+	mr	r7,r8
+	mr	r8,r9
+	mr	r9,r10
+	ld	r10,STK_PARM(r11)(r1)	 /* put arg7 in R10 */
+	ld	r11,STK_PARM(r12)(r1)	 /* put arg8 in R11 */
+	ld	r12,STK_PARM(r13)(r1)    /* put arg9 in R12 */
 
 	HVSC				/* invoke the hypervisor */
 
-	ld	r0,STK_PARM(r13)(r1)	/* Fetch r4 ret arg */
-	stdx	r4,r0,r0
-	ld	r0,STK_PARM(r14)(r1)	/* Fetch r5 ret arg */
-	stdx	r5,r0,r0
-	ld	r0,STK_PARM(r15)(r1)	/* Fetch r6 ret arg */
-	stdx	r6,r0,r0
-	ld	r0,STK_PARM(r16)(r1)	/* Fetch r7 ret arg */
-	stdx	r7,r0,r0
-	ld	r0,STK_PARM(r17)(r1)	/* Fetch r8 ret arg */
-	stdx	r8,r0,r0
-	ld	r0,STK_PARM(r18)(r1)	/* Fetch r9 ret arg */
-	stdx	r9,r0,r0
-	ld	r0,STK_PARM(r19)(r1)	/* Fetch r10 ret arg */
-	stdx	r10,r0,r0
-	ld	r0,STK_PARM(r20)(r1)	/* Fetch r11 ret arg */
-	stdx	r11,r0,r0
-	ld	r0,STK_PARM(r21)(r1)	/* Fetch r12 ret arg */
-	stdx	r12,r0,r0
+	ld	r12,STK_PARM(r4)(r1)
+	std	r4,  0(r12)
+	std	r5,  8(r12)
+	std	r6, 16(r12)
+	std	r7, 24(r12)
+	std	r8, 32(r12)
+	std	r9, 40(r12)
+	std	r10,48(r12)
+	std	r11,56(r12)
+	std	r12,64(r12)
 
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
Index: build/arch/powerpc/platforms/pseries/hvconsole.c
===================================================================
--- build.orig/arch/powerpc/platforms/pseries/hvconsole.c	2006-07-18 04:20:13.000000000 +1000
+++ build/arch/powerpc/platforms/pseries/hvconsole.c	2006-07-18 04:24:08.000000000 +1000
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <asm/hvcall.h>
 #include <asm/hvconsole.h>
+#include "plpar_wrappers.h"
 
 /**
  * hvc_get_chars - retrieve characters from firmware for denoted vterm adatper
@@ -40,9 +41,9 @@ int hvc_get_chars(uint32_t vtermno, char
 {
 	unsigned long got;
 
-	if (plpar_hcall(H_GET_TERM_CHAR, vtermno, 0, 0, 0, &got,
-		(unsigned long *)buf, (unsigned long *)buf+1) == H_SUCCESS)
+	if (plpar_get_term_char(vtermno, &got, buf) == H_SUCCESS)
 		return got;
+
 	return 0;
 }
 
Index: build/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- build.orig/arch/powerpc/platforms/pseries/lpar.c	2006-07-18 04:20:13.000000000 +1000
+++ build/arch/powerpc/platforms/pseries/lpar.c	2006-07-18 04:24:08.000000000 +1000
@@ -48,13 +48,11 @@
 #define DBG_LOW(fmt...) do { } while(0)
 #endif
 
-/* in pSeries_hvCall.S */
+/* in hvCall.S */
 EXPORT_SYMBOL(plpar_hcall);
-EXPORT_SYMBOL(plpar_hcall_4out);
+EXPORT_SYMBOL(plpar_hcall9);
 EXPORT_SYMBOL(plpar_hcall_norets);
-EXPORT_SYMBOL(plpar_hcall_8arg_2ret);
-EXPORT_SYMBOL(plpar_hcall_7arg_7ret);
-EXPORT_SYMBOL(plpar_hcall_9arg_9ret);
+
 extern void pSeries_find_serial_port(void);
 
 
@@ -277,7 +275,6 @@ long pSeries_lpar_hpte_insert(unsigned l
 	unsigned long flags;
 	unsigned long slot;
 	unsigned long hpte_v, hpte_r;
-	unsigned long dummy0, dummy1;
 
 	if (!(vflags & HPTE_V_BOLTED))
 		DBG_LOW("hpte_insert(group=%lx, va=%016lx, pa=%016lx, "
@@ -302,8 +299,7 @@ long pSeries_lpar_hpte_insert(unsigned l
 	if (rflags & (_PAGE_GUARDED|_PAGE_NO_CACHE))
 		hpte_r &= ~_PAGE_COHERENT;
 
-	lpar_rc = plpar_hcall(H_ENTER, flags, hpte_group, hpte_v,
-			      hpte_r, &slot, &dummy0, &dummy1);
+	lpar_rc = plpar_pte_enter(flags, hpte_group, hpte_v, hpte_r, &slot);
 	if (unlikely(lpar_rc == H_PTEG_FULL)) {
 		if (!(vflags & HPTE_V_BOLTED))
 			DBG_LOW(" full\n");
Index: build/arch/powerpc/platforms/pseries/plpar_wrappers.h
===================================================================
--- build.orig/arch/powerpc/platforms/pseries/plpar_wrappers.h	2006-07-18 04:20:13.000000000 +1000
+++ build/arch/powerpc/platforms/pseries/plpar_wrappers.h	2006-07-18 04:27:14.000000000 +1000
@@ -5,20 +5,17 @@
 
 static inline long poll_pending(void)
 {
-	unsigned long dummy;
-	return plpar_hcall(H_POLL_PENDING, 0, 0, 0, 0, &dummy, &dummy, &dummy);
+	return plpar_hcall_norets(H_POLL_PENDING);
 }
 
 static inline long prod_processor(void)
 {
-	plpar_hcall_norets(H_PROD);
-	return 0;
+	return plpar_hcall_norets(H_PROD);
 }
 
 static inline long cede_processor(void)
 {
-	plpar_hcall_norets(H_CEDE);
-	return 0;
+	return plpar_hcall_norets(H_CEDE);
 }
 
 static inline long vpa_call(unsigned long flags, unsigned long cpu,
@@ -42,21 +39,47 @@ static inline long register_vpa(unsigned
 
 extern void vpa_init(int cpu);
 
+static inline long plpar_pte_enter(unsigned long flags,
+		unsigned long hpte_group, unsigned long hpte_v,
+		unsigned long hpte_r, unsigned long *slot)
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall(H_ENTER, retbuf, flags, hpte_group, hpte_v, hpte_r);
+
+	*slot = retbuf[0];
+
+	return rc;
+}
+
 static inline long plpar_pte_remove(unsigned long flags, unsigned long ptex,
 		unsigned long avpn, unsigned long *old_pteh_ret,
 		unsigned long *old_ptel_ret)
 {
-	unsigned long dummy;
-	return plpar_hcall(H_REMOVE, flags, ptex, avpn, 0, old_pteh_ret,
-			old_ptel_ret, &dummy);
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall(H_REMOVE, retbuf, flags, ptex, avpn);
+
+	*old_pteh_ret = retbuf[0];
+	*old_ptel_ret = retbuf[1];
+
+	return rc;
 }
 
 static inline long plpar_pte_read(unsigned long flags, unsigned long ptex,
 		unsigned long *old_pteh_ret, unsigned long *old_ptel_ret)
 {
-	unsigned long dummy;
-	return plpar_hcall(H_READ, flags, ptex, 0, 0, old_pteh_ret,
-			old_ptel_ret, &dummy);
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall(H_READ, retbuf, flags, ptex);
+
+	*old_pteh_ret = retbuf[0];
+	*old_ptel_ret = retbuf[1];
+
+	return rc;
 }
 
 static inline long plpar_pte_protect(unsigned long flags, unsigned long ptex,
@@ -68,9 +91,14 @@ static inline long plpar_pte_protect(uns
 static inline long plpar_tce_get(unsigned long liobn, unsigned long ioba,
 		unsigned long *tce_ret)
 {
-	unsigned long dummy;
-	return plpar_hcall(H_GET_TCE, liobn, ioba, 0, 0, tce_ret, &dummy,
-			&dummy);
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall(H_GET_TCE, retbuf, liobn, ioba);
+
+	*tce_ret = retbuf[0];
+
+	return rc;
 }
 
 static inline long plpar_tce_put(unsigned long liobn, unsigned long ioba,
@@ -94,9 +122,17 @@ static inline long plpar_tce_stuff(unsig
 static inline long plpar_get_term_char(unsigned long termno,
 		unsigned long *len_ret, char *buf_ret)
 {
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 	unsigned long *lbuf = (unsigned long *)buf_ret;	/* TODO: alignment? */
-	return plpar_hcall(H_GET_TERM_CHAR, termno, 0, 0, 0, len_ret,
-			lbuf + 0, lbuf + 1);
+
+	rc = plpar_hcall(H_GET_TERM_CHAR, retbuf, termno);
+
+	*len_ret = retbuf[0];
+	lbuf[0] = retbuf[1];
+	lbuf[1] = retbuf[2];
+
+	return rc;
 }
 
 static inline long plpar_put_term_char(unsigned long termno, unsigned long len,
@@ -107,4 +143,31 @@ static inline long plpar_put_term_char(u
 			lbuf[1]);
 }
 
+static inline long plpar_eoi(unsigned long xirr)
+{
+	return plpar_hcall_norets(H_EOI, xirr);
+}
+
+static inline long plpar_cppr(unsigned long cppr)
+{
+	return plpar_hcall_norets(H_CPPR, cppr);
+}
+
+static inline long plpar_ipi(unsigned long servernum, unsigned long mfrr)
+{
+	return plpar_hcall_norets(H_IPI, servernum, mfrr);
+}
+
+static inline long plpar_xirr(unsigned long *xirr_ret)
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall(H_XIRR, retbuf);
+
+	*xirr_ret = retbuf[0];
+
+	return rc;
+}
+
 #endif /* _PSERIES_PLPAR_WRAPPERS_H */
Index: build/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- build.orig/arch/powerpc/platforms/pseries/xics.c	2006-07-18 04:21:59.000000000 +1000
+++ build/arch/powerpc/platforms/pseries/xics.c	2006-07-18 04:25:58.000000000 +1000
@@ -34,6 +34,7 @@
 #include <asm/i8259.h>
 
 #include "xics.h"
+#include "plpar_wrappers.h"
 
 #define XICS_IPI		2
 #define XICS_IRQ_SPURIOUS	0
@@ -110,27 +111,6 @@ static inline void direct_qirr_info(int 
 /* LPAR low level accessors */
 
 
-static inline long plpar_eoi(unsigned long xirr)
-{
-	return plpar_hcall_norets(H_EOI, xirr);
-}
-
-static inline long plpar_cppr(unsigned long cppr)
-{
-	return plpar_hcall_norets(H_CPPR, cppr);
-}
-
-static inline long plpar_ipi(unsigned long servernum, unsigned long mfrr)
-{
-	return plpar_hcall_norets(H_IPI, servernum, mfrr);
-}
-
-static inline long plpar_xirr(unsigned long *xirr_ret)
-{
-	unsigned long dummy;
-	return plpar_hcall(H_XIRR, 0, 0, 0, 0, xirr_ret, &dummy, &dummy);
-}
-
 static inline unsigned int lpar_xirr_info_get(int n_cpu)
 {
 	unsigned long lpar_rc;
Index: build/drivers/net/ibmveth.c
===================================================================
--- build.orig/drivers/net/ibmveth.c	2006-07-18 04:20:13.000000000 +1000
+++ build/drivers/net/ibmveth.c	2006-07-18 04:24:08.000000000 +1000
@@ -702,7 +702,8 @@ static int ibmveth_start_xmit(struct sk_
 					     desc[3].desc,
 					     desc[4].desc,
 					     desc[5].desc,
-					     correlator);
+					     correlator,
+					     &correlator);
 	} while ((lpar_rc == H_BUSY) && (retry_count--));
 
 	if(lpar_rc != H_SUCCESS && lpar_rc != H_DROPPED) {
Index: build/drivers/net/ibmveth.h
===================================================================
--- build.orig/drivers/net/ibmveth.h	2006-07-18 04:20:13.000000000 +1000
+++ build/drivers/net/ibmveth.h	2006-07-19 06:55:56.000000000 +1000
@@ -61,8 +61,21 @@
 #define h_add_logical_lan_buffer(ua, buf) \
   plpar_hcall_norets(H_ADD_LOGICAL_LAN_BUFFER, ua, buf)
 
-#define h_send_logical_lan(ua, buf1, buf2, buf3, buf4, buf5, buf6, correlator) \
-  plpar_hcall_8arg_2ret(H_SEND_LOGICAL_LAN, ua, buf1, buf2, buf3, buf4, buf5, buf6, correlator, &correlator)
+static inline long h_send_logical_lan(unsigned long unit_address,
+		unsigned long desc1, unsigned long desc2, unsigned long desc3,
+		unsigned long desc4, unsigned long desc5, unsigned long desc6,
+		unsigned long corellator_in, unsigned long *corellator_out)
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+
+	rc = plpar_hcall9(H_SEND_LOGICAL_LAN, retbuf, unit_address, desc1,
+			desc2, desc3, desc4, desc5, desc6, corellator_in);
+
+	*corellator_out = retbuf[0];
+
+	return rc;
+}
 
 #define h_multicast_ctrl(ua, cmd, mac) \
   plpar_hcall_norets(H_MULTICAST_CTRL, ua, cmd, mac)
Index: build/include/asm-powerpc/hvcall.h
===================================================================
--- build.orig/include/asm-powerpc/hvcall.h	2006-07-18 04:20:13.000000000 +1000
+++ build/include/asm-powerpc/hvcall.h	2006-07-19 07:16:14.000000000 +1000
@@ -204,94 +204,39 @@
 
 #ifndef __ASSEMBLY__
 
-/* plpar_hcall() -- Generic call interface using above opcodes
+/**
+ * plpar_hcall_norets: - Make a pseries hypervisor call with no return arguments
+ * @opcode: The hypervisor call to make.
  *
- * The actual call interface is a hypervisor call instruction with
- * the opcode in R3 and input args in R4-R7.
- * Status is returned in R3 with variable output values in R4-R11.
- * Only H_PTE_READ with H_READ_4 uses R6-R11 so we ignore it for now
- * and return only two out args which MUST ALWAYS BE PROVIDED.
- */
-long plpar_hcall(unsigned long opcode,
-		 unsigned long arg1,
-		 unsigned long arg2,
-		 unsigned long arg3,
-		 unsigned long arg4,
-		 unsigned long *out1,
-		 unsigned long *out2,
-		 unsigned long *out3);
-
-/* Same as plpar_hcall but for those opcodes that return no values
- * other than status.  Slightly more efficient.
+ * This call supports up to 7 arguments and only returns the status of
+ * the hcall. Use this version where possible, its slightly faster than
+ * the other plpar_hcalls.
  */
 long plpar_hcall_norets(unsigned long opcode, ...);
 
-/*
- * Special hcall interface for ibmveth support.
- * Takes 8 input parms. Returns a rc and stores the
- * R4 return value in *out1.
- */
-long plpar_hcall_8arg_2ret(unsigned long opcode,
-			   unsigned long arg1,
-			   unsigned long arg2,
-			   unsigned long arg3,
-			   unsigned long arg4,
-			   unsigned long arg5,
-			   unsigned long arg6,
-			   unsigned long arg7,
-			   unsigned long arg8,
-			   unsigned long *out1);
-
-/* plpar_hcall_4out()
+/**
+ * plpar_hcall: - Make a pseries hypervisor call
+ * @opcode: The hypervisor call to make.
+ * @retbuf: Buffer to store up to 4 return arguments in.
  *
- * same as plpar_hcall except with 4 output arguments.
+ * This call supports up to 6 arguments and 4 return arguments. Use
+ * PLPAR_HCALL_BUFSIZE to size the return argument buffer.
  *
+ * Used for all but the craziest of phyp interfaces (see plpar_hcall9)
  */
-long plpar_hcall_4out(unsigned long opcode,
-		      unsigned long arg1,
-		      unsigned long arg2,
-		      unsigned long arg3,
-		      unsigned long arg4,
-		      unsigned long *out1,
-		      unsigned long *out2,
-		      unsigned long *out3,
-		      unsigned long *out4);
+#define PLPAR_HCALL_BUFSIZE 4
+long plpar_hcall(unsigned long opcode, unsigned long *retbuf, ...);
 
-long plpar_hcall_7arg_7ret(unsigned long opcode,
-			   unsigned long arg1,
-			   unsigned long arg2,
-			   unsigned long arg3,
-			   unsigned long arg4,
-			   unsigned long arg5,
-			   unsigned long arg6,
-			   unsigned long arg7,
-			   unsigned long *out1,
-			   unsigned long *out2,
-			   unsigned long *out3,
-			   unsigned long *out4,
-			   unsigned long *out5,
-			   unsigned long *out6,
-			   unsigned long *out7);
-
-long plpar_hcall_9arg_9ret(unsigned long opcode,
-			   unsigned long arg1,
-			   unsigned long arg2,
-			   unsigned long arg3,
-			   unsigned long arg4,
-			   unsigned long arg5,
-			   unsigned long arg6,
-			   unsigned long arg7,
-			   unsigned long arg8,
-			   unsigned long arg9,
-			   unsigned long *out1,
-			   unsigned long *out2,
-			   unsigned long *out3,
-			   unsigned long *out4,
-			   unsigned long *out5,
-			   unsigned long *out6,
-			   unsigned long *out7,
-			   unsigned long *out8,
-			   unsigned long *out9);
+/**
+ * plpar_hcall9: - Make a pseries hypervisor call with up to 9 return arguments
+ * @opcode: The hypervisor call to make.
+ * @retbuf: Buffer to store up to 9 return arguments in.
+ *
+ * This call supports up to 9 arguments and 9 return arguments. Use
+ * PLPAR_HCALL9_BUFSIZE to size the return argument buffer.
+ */
+#define PLPAR_HCALL9_BUFSIZE 9
+long plpar_hcall9(unsigned long opcode, unsigned long *retbuf, ...);
 
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
