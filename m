Return-Path: <anton@ozlabs.org>
Date: Tue, 9 Jan 2007 02:43:02 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Some hcall stats fixes
Message-ID: <20070108154301.GC7508@krispykreme>
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


There were a few issues with the HCALL_STATS code:

- PURR cpu feature checks were backwards
- We iterated one entry off the end of the hcall_stats array
- Remove dead update_hcall_stats() function prototype

I noticed one thing while debugging, and that is we call H_ENTER (to set
up the MMU hashtable in early init) before we have done the cpu fixups.
This means we will execute the PURR SPR reads even on a CPU that isnt
capable of it. I wonder if we can move the CPU feature fixups earlier.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff -ru linux-2.6.20-rc3-orig/arch/powerpc/platforms/pseries/hvCall.S linux-2.6.20-rc3/arch/powerpc/platforms/pseries/hvCall.S
--- linux-2.6.20-rc3-orig/arch/powerpc/platforms/pseries/hvCall.S	2006-11-29 15:57:37.000000000 -0600
+++ linux-2.6.20-rc3/arch/powerpc/platforms/pseries/hvCall.S	2007-01-08 07:34:45.000000000 -0600
@@ -26,7 +26,7 @@
 BEGIN_FTR_SECTION;						\
 	mfspr	r0,SPRN_PURR;		/* get PURR and */	\
 	std	r0,STK_PARM(r6)(r1);	/* save for later */	\
-END_FTR_SECTION_IFCLR(CPU_FTR_PURR);
+END_FTR_SECTION_IFSET(CPU_FTR_PURR);
 	
 /*
  * postcall is performed immediately before function return which
@@ -43,7 +43,7 @@
 	mfspr	r8,SPRN_PURR;		/* PURR after */	\
 	ld	r6,STK_PARM(r6)(r1);	/* PURR before */	\
 	subf	r6,r6,r8;		/* delta */		\
-END_FTR_SECTION_IFCLR(CPU_FTR_PURR);				\
+END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
 	ld	r5,STK_PARM(r5)(r1);	/* timebase before */	\
 	subf	r5,r5,r7;		/* time delta */	\
 								\
@@ -66,7 +66,7 @@
 	ld	r7,HCALL_STAT_PURR(r4);	/* PURR */		\
 	add	r7,r7,r6;					\
 	std	r7,HCALL_STAT_PURR(r4);				\
-END_FTR_SECTION_IFCLR(CPU_FTR_PURR);				\
+END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
 1:
 #else
 #define HCALL_INST_PRECALL
diff -ru linux-2.6.20-rc3-orig/arch/powerpc/platforms/pseries/hvCall_inst.c linux-2.6.20-rc3/arch/powerpc/platforms/pseries/hvCall_inst.c
--- linux-2.6.20-rc3-orig/arch/powerpc/platforms/pseries/hvCall_inst.c	2007-01-08 06:40:53.000000000 -0600
+++ linux-2.6.20-rc3/arch/powerpc/platforms/pseries/hvCall_inst.c	2007-01-08 07:33:56.000000000 -0600
@@ -34,7 +34,7 @@
  */
 static void *hc_start(struct seq_file *m, loff_t *pos)
 {
-	if ((int)*pos < HCALL_STAT_ARRAY_SIZE)
+	if ((int)*pos < (HCALL_STAT_ARRAY_SIZE-1))
 		return (void *)(unsigned long)(*pos + 1);
 
 	return NULL;
@@ -57,7 +57,7 @@
 	struct hcall_stats *hs = (struct hcall_stats *)m->private;
 
 	if (hs[h_num].num_calls) {
-		if (!cpu_has_feature(CPU_FTR_PURR))
+		if (cpu_has_feature(CPU_FTR_PURR))
 			seq_printf(m, "%lu %lu %lu %lu\n", h_num<<2,
 				   hs[h_num].num_calls,
 				   hs[h_num].tb_total,
diff -ru linux-2.6.20-rc3-orig/include/asm-powerpc/hvcall.h linux-2.6.20-rc3/include/asm-powerpc/hvcall.h
--- linux-2.6.20-rc3-orig/include/asm-powerpc/hvcall.h	2006-11-29 15:57:37.000000000 -0600
+++ linux-2.6.20-rc3/include/asm-powerpc/hvcall.h	2007-01-08 07:35:19.000000000 -0600
@@ -252,8 +252,6 @@
 	unsigned long	tb_total;	/* total wall time (mftb) of calls. */
 	unsigned long	purr_total;	/* total cpu time (PURR) of calls. */
 };
-void update_hcall_stats(unsigned long opcode, unsigned long tb_delta,
-			unsigned long purr_delta);
 #define HCALL_STAT_ARRAY_SIZE	((MAX_HCALL_OPCODE >> 2) + 1)
 
 #endif /* __ASSEMBLY__ */
