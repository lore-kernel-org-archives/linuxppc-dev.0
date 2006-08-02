Return-Path: <mkravetz@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7ADE967BB1
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 03:59:33 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k72HxUqG027860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 13:59:30 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k72HxUed272934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 11:59:30 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k72HxUKw004929
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 11:59:30 -0600
Received: from localhost.localdomain (dyn9047021127.beaverton.ibm.com
	[9.47.21.127])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k72HxTo6004883
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 11:59:29 -0600
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.6/8.13.4) with ESMTP id k72HxmQR007761
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 10:59:48 -0700
Received: (from mkravetz@localhost)
	by localhost.localdomain (8.13.6/8.13.6/Submit) id k72Hxmnf007760
	for linuxppc-dev@ozlabs.org; Wed, 2 Aug 2006 10:59:48 -0700
Date: Wed, 2 Aug 2006 10:59:47 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] asm code for Hypervisor Call Instrumentation
Message-ID: <20060802175947.GA7489@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In my last submission of hcall instrumentation patches, I took
Paul's suggestion and added code to get the timebase and PURR
snapshots in the hcall asm routines.  I'm not confident in my
assembly skills, so I would really like some comments on this
approach/code.  The idea(and some code) was taken from hash_low_64.S.
Of course, this all 'appears' to work correctly. :)

This patch is built on top of Anton's hcall cleanup patch.  One
remaining issue is 'where should the statistic data structures
be updated?'.  For simplicity, I have the asm code call the
following C routine to perform the updates.

void update_hcall_stats(unsigned long opcode, unsigned long tb_delta,
                                unsigned long purr_delta)
{
        unsigned long op_index = opcode >> 2;
        struct hcall_stats *hs = &__get_cpu_var(hcall_stats[op_index]);

        hs->tb_total += tb_delta;
        hs->purr_total += purr_delta;
        hs->num_calls++;
}

I honestly do not know if it would be better to do all of this in the
assembly routine.  I believe that 'allocation' of a stack frame is
only necessary because of the callout.  Right?

-- 
Mike

diff -Naupr powerpc/arch/powerpc/platforms/pseries/hvCall.S powerpc.work/arch/powerpc/platforms/pseries/hvCall.S
--- powerpc/arch/powerpc/platforms/pseries/hvCall.S	2006-07-19 18:58:18.000000000 +0000
+++ powerpc.work/arch/powerpc/platforms/pseries/hvCall.S	2006-07-21 07:06:49.000000000 +0000
@@ -11,7 +11,57 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 	
-#define STK_PARM(i)     (48 + ((i)-3)*8)
+#define STK_PARM(i)     (STACKFRAMESIZE + 48 + ((i)-3)*8)
+#define STK_REG(i)      (112 + ((i)-14)*8)
+
+#ifdef CONFIG_HCALL_STATS
+#define STACKFRAMESIZE  256
+#define HCALL_INST_PRECALL					\
+	/* use stack frame to save a few non-volital regs */	\
+	stdu    r1,-STACKFRAMESIZE(r1);				\
+	std     r31,STK_REG(r31)(r1);				\
+	std     r30,STK_REG(r30)(r1);				\
+	std     r29,STK_REG(r29)(r1);				\
+	std     r28,STK_REG(r28)(r1);				\
+								\
+	/* save lr and hcall opcode */				\
+	/* then get time, purr snapshot before hcall */		\
+	mflr	r31;						\
+	mr	r30,r3;						\
+	mftb	r29;						\
+BEGIN_FTR_SECTION;						\
+	mfspr	r28,SPRN_PURR;					\
+END_FTR_SECTION_IFSET(CPU_FTR_PURR);
+
+#define HCALL_INST_POSTCALL					\
+	/* get time, purr snapshot after hcall */		\
+	mftb	r4;						\
+BEGIN_FTR_SECTION;						\
+	mfspr	r5,SPRN_PURR;					\
+END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
+								\
+	/* setup regs to call routine that stuffs stats */	\
+	/* into per-cpu/per-call structure.		*/	\
+	subf	r4,r29,r4;					\
+	subf	r5,r28,r5;					\
+	mr	r29,r3;		/* save hcall rc  */		\
+	mr	r3,r30;						\
+	bl	.update_hcall_stats;				\
+								\
+	/* restore hcall rc, lr and non-volital regs */		\
+	mr	r3,r29;						\
+	mtlr	r31;						\
+	ld      r31,STK_REG(r31)(r1);				\
+	ld      r30,STK_REG(r30)(r1);				\
+	ld      r29,STK_REG(r29)(r1);				\
+	ld      r28,STK_REG(r28)(r1);				\
+	addi    r1,r1,STACKFRAMESIZE
+#else
+
+#define STACKFRAMESIZE	0
+#define HCALL_INST_PRECALL	nop
+#define HCALL_INST_POSTCALL	nop
+#endif
 
 	.text
 
@@ -21,8 +71,12 @@ _GLOBAL(plpar_hcall_norets)
 	mfcr	r0
 	stw	r0,8(r1)
 
+	HCALL_INST_PRECALL
+
 	HVSC				/* invoke the hypervisor */
 
+	HCALL_INST_POSTCALL
+
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
 	blr				/* return r3 = status */
@@ -33,6 +87,8 @@ _GLOBAL(plpar_hcall)
 	mfcr	r0
 	stw	r0,8(r1)
 
+	HCALL_INST_PRECALL
+
 	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
 
 	mr	r4,r5
@@ -50,6 +106,8 @@ _GLOBAL(plpar_hcall)
 	std	r6, 16(r12)
 	std	r7, 24(r12)
 
+	HCALL_INST_POSTCALL
+
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
 
@@ -61,6 +119,8 @@ _GLOBAL(plpar_hcall9)
 	mfcr	r0
 	stw	r0,8(r1)
 
+	HCALL_INST_PRECALL
+
 	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
 
 	mr	r4,r5
@@ -86,6 +146,8 @@ _GLOBAL(plpar_hcall9)
 	std	r11,56(r12)
 	std	r12,64(r12)
 
+	HCALL_INST_POSTCALL
+
 	lwz	r0,8(r1)
 	mtcrf	0xff,r0
 
