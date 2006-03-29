Return-Path: <schihei@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 53684679FD
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 01:14:49 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.12.10/8.12.10) with ESMTP id k2TAolHm193174
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 10:50:47 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2TApNYS211034
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 12:51:23 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2TAoiHI007601
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 12:50:44 +0200
Message-ID: <442AA34B.7050801@de.ibm.com>
Date: Wed, 29 Mar 2006 17:10:03 +0200
From: Heiko J Schick <schihei@de.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, paulus@samba.org
Subject: [PATCH] powerpc: Extends HCALL interface for InfiniBand usage
Content-Type: multipart/mixed; boundary="------------040403080003080808000004"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040403080003080808000004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

below (and attached) you will find my ib_hcall patch, which extends
the HCALL interface for InfiniBand usage. I've made the patch
agains the lates Linux kernel snapshot (linux-2.6.16-git14) from
kernel.org. We moved this into the common powerpc code based on
comments we got after posting the first eHCA InfiniBand device
driver patch.

Any comments or proposals for my patch?

Regards,
      Heiko

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>


   arch/powerpc/platforms/pseries/hvCall.S      |  101 ++++++++++++++++++++-
   arch/powerpc/platforms/pseries/lpar.c        |    3
   include/asm-powerpc/hvcall.h                 |  100 ++++++++++++++++++++
   4 files changed, 202 insertions(+), 2 deletions(-)


diff -Nurpw linux-2.6.16-git14/arch/powerpc/platforms/pseries/hvCall.S linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/hvCall.S
--- linux-2.6.16-git14/arch/powerpc/platforms/pseries/hvCall.S    2006-03-28 14:18:52.389031144 +0200
+++ linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/hvCall.S    2006-03-28 14:20:47.800056224 +0200
@@ -91,7 +91,6 @@ _GLOBAL(plpar_hcall_8arg_2ret)
       mtcrf    0xff,r0
       blr                /* return r3 = status */

-
   /* long plpar_hcall_4out(unsigned long opcode,        R3
                unsigned long arg1,        R4
                unsigned long arg2,        R5
@@ -127,3 +126,103 @@ _GLOBAL(plpar_hcall_4out)

       mtcrf    0xff,r0
       blr                /* return r3 = status */
+
+/* plpar_hcall_7arg_7ret(unsigned long opcode,        R3
+             unsigned long arg1,        R4
+             unsigned long arg2,        R5
+             unsigned long arg3,        R6
+             unsigned long arg4,        R7
+             unsigned long arg5,        R8
+             unsigned long arg6,        R9
+             unsigned long arg7,        R10
+             unsigned long *out1,        112(R1)
+             unsigned long *out2,        110(R1)
+             unsigned long *out3,        108(R1)
+             unsigned long *out4,        106(R1)
+             unsigned long *out5,        104(R1)
+             unsigned long *out6,        102(R1)
+             unsigned long *out7);        100(R1)
+*/
+_GLOBAL(plpar_hcall_7arg_7ret)
+    HMT_MEDIUM
+
+    mfcr    r0
+    stw    r0,8(r1)
+
+    HVSC                /* invoke the hypervisor */
+
+    lwz    r0,8(r1)
+
+    ld    r11,STK_PARM(r11)(r1)    /* Fetch r4 ret arg */
+    std    r4,0(r11)
+    ld    r11,STK_PARM(r12)(r1)    /* Fetch r5 ret arg */
+    std    r5,0(r11)
+    ld    r11,STK_PARM(r13)(r1)    /* Fetch r6 ret arg */
+    std    r6,0(r11)
+    ld    r11,STK_PARM(r14)(r1)    /* Fetch r7 ret arg */
+    std    r7,0(r11)
+    ld    r11,STK_PARM(r15)(r1)    /* Fetch r8 ret arg */
+    std    r8,0(r11)
+    ld    r11,STK_PARM(r16)(r1)    /* Fetch r9 ret arg */
+    std    r9,0(r11)
+    ld    r11,STK_PARM(r17)(r1)    /* Fetch r10 ret arg */
+    std    r10,0(r11)
+
+    mtcrf    0xff,r0
+
+    blr                /* return r3 = status */
+
+/* plpar_hcall_9arg_9ret(unsigned long opcode,        R3
+             unsigned long arg1,        R4
+             unsigned long arg2,        R5
+             unsigned long arg3,        R6
+             unsigned long arg4,        R7
+             unsigned long arg5,        R8
+             unsigned long arg6,        R9
+             unsigned long arg7,        R10
+             unsigned long arg8,        112(R1)
+             unsigned long arg9,        110(R1)
+             unsigned long *out1,        108(R1)
+             unsigned long *out2,        106(R1)
+             unsigned long *out3,        104(R1)
+             unsigned long *out4,        102(R1)
+             unsigned long *out5,        100(R1)
+             unsigned long *out6,         98(R1)
+             unsigned long *out7);         96(R1)
+             unsigned long *out8,         94(R1)
+                 unsigned long *out9,            92(R1)
+*/
+_GLOBAL(plpar_hcall_9arg_9ret)
+    HMT_MEDIUM
+
+    mfcr    r0
+    stw    r0,8(r1)
+
+    ld    r11,STK_PARM(r11)(r1)     /* put arg8 in R11 */
+    ld    r12,STK_PARM(r12)(r1)    /* put arg9 in R12 */
+
+    HVSC                /* invoke the hypervisor */
+
+    ld    r0,STK_PARM(r13)(r1)    /* Fetch r4 ret arg */
+    stdx    r4,r0,r0
+    ld    r0,STK_PARM(r14)(r1)    /* Fetch r5 ret arg */
+    stdx    r5,r0,r0
+    ld    r0,STK_PARM(r15)(r1)    /* Fetch r6 ret arg */
+    stdx    r6,r0,r0
+    ld    r0,STK_PARM(r16)(r1)    /* Fetch r7 ret arg */
+    stdx    r7,r0,r0
+    ld    r0,STK_PARM(r17)(r1)    /* Fetch r8 ret arg */
+    stdx    r8,r0,r0
+    ld    r0,STK_PARM(r18)(r1)    /* Fetch r9 ret arg */
+    stdx    r9,r0,r0
+    ld    r0,STK_PARM(r19)(r1)    /* Fetch r10 ret arg */
+    stdx    r10,r0,r0
+    ld    r0,STK_PARM(r20)(r1)    /* Fetch r11 ret arg */
+    stdx    r11,r0,r0
+    ld    r0,STK_PARM(r21)(r1)    /* Fetch r12 ret arg */
+    stdx    r12,r0,r0
+
+    lwz    r0,8(r1)
+    mtcrf    0xff,r0
+
+    blr                /* return r3 = status */
diff -Nurpw linux-2.6.16-git14/arch/powerpc/platforms/pseries/lpar.c linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/lpar.c
--- linux-2.6.16-git14/arch/powerpc/platforms/pseries/lpar.c    2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/lpar.c    2006-03-28 14:20:47.801056072 +0200
@@ -54,7 +54,8 @@ EXPORT_SYMBOL(plpar_hcall);
   EXPORT_SYMBOL(plpar_hcall_4out);
   EXPORT_SYMBOL(plpar_hcall_norets);
   EXPORT_SYMBOL(plpar_hcall_8arg_2ret);
-
+EXPORT_SYMBOL(plpar_hcall_7arg_7ret);
+EXPORT_SYMBOL(plpar_hcall_9arg_9ret);
   extern void pSeries_find_serial_port(void);


diff -Nurpw linux-2.6.16-git14/include/asm-powerpc/hvcall.h linux-2.6.16-git14-ib/include/asm-powerpc/hvcall.h
--- linux-2.6.16-git14/include/asm-powerpc/hvcall.h    2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-git14-ib/include/asm-powerpc/hvcall.h    2006-03-28 14:20:47.799056376 +0200
@@ -7,8 +7,12 @@
   #define H_Success    0
   #define H_Busy        1    /* Hardware busy -- retry later */
   #define H_Closed    2    /* Resource closed */
+#define H_NOT_AVAILABLE    3
   #define H_Constrained    4    /* Resource request constrained to max allowed */
+#define H_PARTIAL          5
   #define H_InProgress   14    /* Kind of like busy */
+#define H_PARTIAL_STORE   16
+#define H_PAGE_REGISTERED 15
   #define H_Continue     18    /* Returned from H_Join on success */
   #define H_LongBusyStartRange   9900  /* Start of long busy range */
   #define H_LongBusyOrder1msec   9900  /* Long busy, hint that 1msec is a good time to retry */
@@ -34,6 +38,36 @@
   #define H_DestParm             -14
   #define H_RemoteParm           -15
   #define H_Resource             -16
+#define H_ADAPTER_PARM         -17
+#define H_RH_PARM              -18
+#define H_RCQ_PARM             -19
+#define H_SCQ_PARM             -20
+#define H_EQ_PARM              -21
+#define H_RT_PARM              -22
+#define H_ST_PARM              -23
+#define H_SIGT_PARM            -24
+#define H_TOKEN_PARM           -25
+#define H_MLENGTH_PARM         -27
+#define H_MEM_PARM             -28
+#define H_MEM_ACCESS_PARM      -29
+#define H_ATTR_PARM            -30
+#define H_PORT_PARM            -31
+#define H_MCG_PARM             -32
+#define H_VL_PARM              -33
+#define H_TSIZE_PARM           -34
+#define H_TRACE_PARM           -35
+
+#define H_MASK_PARM            -37
+#define H_MCG_FULL             -38
+#define H_ALIAS_EXIST          -39
+#define H_P_COUNTER            -40
+#define H_TABLE_FULL           -41
+#define H_ALT_TABLE            -42
+#define H_MR_CONDITION         -43
+#define H_NOT_ENOUGH_RESOURCES -44
+#define H_R_STATE              -45
+#define H_RESCINDEND           -46
+

   /* Long Busy is a condition that can be returned by the firmware
    * when a call cannot be completed now, but the identical call
@@ -65,6 +99,9 @@
   #define H_DABRX_KERNEL        (1UL<<(63-62))
   #define H_DABRX_USER        (1UL<<(63-63))

+/* Each control block has to be on a 4K bondary */
+#define H_CB_ALIGNMENT          4096
+
   /* pSeries hypervisor opcodes */
   #define H_REMOVE        0x04
   #define H_ENTER            0x08
@@ -116,6 +153,33 @@
   #define H_VTERM_PARTNER_INFO    0x150
   #define H_REGISTER_VTERM    0x154
   #define H_FREE_VTERM        0x158
+#define H_RESET_EVENTS          0x15C
+#define H_ALLOC_RESOURCE        0x160
+#define H_FREE_RESOURCE         0x164
+#define H_MODIFY_QP             0x168
+#define H_QUERY_QP              0x16C
+#define H_REREGISTER_PMR        0x170
+#define H_REGISTER_SMR          0x174
+#define H_QUERY_MR              0x178
+#define H_QUERY_MW              0x17C
+#define H_QUERY_HCA             0x180
+#define H_QUERY_PORT            0x184
+#define H_MODIFY_PORT           0x188
+#define H_DEFINE_AQP1           0x18C
+#define H_GET_TRACE_BUFFER      0x190
+#define H_DEFINE_AQP0           0x194
+#define H_RESIZE_MR             0x198
+#define H_ATTACH_MCQP           0x19C
+#define H_DETACH_MCQP           0x1A0
+#define H_CREATE_RPT            0x1A4
+#define H_REMOVE_RPT            0x1A8
+#define H_REGISTER_RPAGES       0x1AC
+#define H_DISABLE_AND_GETC      0x1B0
+#define H_ERROR_DATA            0x1B4
+#define H_GET_HCA_INFO          0x1B8
+#define H_GET_PERF_COUNT        0x1BC
+#define H_MANAGE_TRACE          0x1C0
+#define H_QUERY_INT_STATE       0x1E4
   #define H_POLL_PENDING            0x1D8
   #define H_JOIN            0x298
   #define H_ENABLE_CRQ        0x2B0
@@ -175,6 +239,42 @@ long plpar_hcall_4out(unsigned long opco
                 unsigned long *out3,
                 unsigned long *out4);

+long plpar_hcall_7arg_7ret(unsigned long opcode,
+               unsigned long arg1,
+               unsigned long arg2,
+               unsigned long arg3,
+               unsigned long arg4,
+               unsigned long arg5,
+               unsigned long arg6,
+               unsigned long arg7,
+               unsigned long *out1,
+               unsigned long *out2,
+               unsigned long *out3,
+               unsigned long *out4,
+               unsigned long *out5,
+               unsigned long *out6,
+               unsigned long *out7);
+
+long plpar_hcall_9arg_9ret(unsigned long opcode,
+               unsigned long arg1,
+               unsigned long arg2,
+               unsigned long arg3,
+               unsigned long arg4,
+               unsigned long arg5,
+               unsigned long arg6,
+               unsigned long arg7,
+               unsigned long arg8,
+               unsigned long arg9,
+               unsigned long *out1,
+               unsigned long *out2,
+               unsigned long *out3,
+               unsigned long *out4,
+               unsigned long *out5,
+               unsigned long *out6,
+               unsigned long *out7,
+               unsigned long *out8,
+               unsigned long *out9);
+
   #endif /* __ASSEMBLY__ */
   #endif /* __KERNEL__ */
   #endif /* _ASM_POWERPC_HVCALL_H */



diff -Nurpw linux-2.6.16-git14/arch/powerpc/platforms/pseries/hvCall.S linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/hvCall.S
--- linux-2.6.16-git14/arch/powerpc/platforms/pseries/hvCall.S	2006-03-28 14:18:52.389031144 +0200
+++ linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/hvCall.S	2006-03-28 14:20:47.800056224 +0200
@@ -91,7 +91,6 @@ _GLOBAL(plpar_hcall_8arg_2ret)
   	mtcrf	0xff,r0
   	blr				/* return r3 = status */

-
   /* long plpar_hcall_4out(unsigned long opcode,		R3
   		 	unsigned long arg1,		R4
   		 	unsigned long arg2,		R5
@@ -127,3 +126,103 @@ _GLOBAL(plpar_hcall_4out)

   	mtcrf	0xff,r0
   	blr				/* return r3 = status */
+
+/* plpar_hcall_7arg_7ret(unsigned long opcode,		R3
+			 unsigned long arg1,		R4
+			 unsigned long arg2,		R5
+			 unsigned long arg3,		R6
+			 unsigned long arg4,		R7
+			 unsigned long arg5,		R8
+			 unsigned long arg6,		R9
+			 unsigned long arg7,		R10
+			 unsigned long *out1,		112(R1)
+			 unsigned long *out2,		110(R1)
+			 unsigned long *out3,		108(R1)
+			 unsigned long *out4,		106(R1)
+			 unsigned long *out5,		104(R1)
+			 unsigned long *out6,		102(R1)
+			 unsigned long *out7);		100(R1)
+*/
+_GLOBAL(plpar_hcall_7arg_7ret)
+	HMT_MEDIUM
+
+	mfcr	r0
+	stw	r0,8(r1)
+
+	HVSC				/* invoke the hypervisor */
+
+	lwz	r0,8(r1)
+
+	ld	r11,STK_PARM(r11)(r1)	/* Fetch r4 ret arg */
+	std	r4,0(r11)
+	ld	r11,STK_PARM(r12)(r1)	/* Fetch r5 ret arg */
+	std	r5,0(r11)
+	ld	r11,STK_PARM(r13)(r1)	/* Fetch r6 ret arg */
+	std	r6,0(r11)
+	ld	r11,STK_PARM(r14)(r1)	/* Fetch r7 ret arg */
+	std	r7,0(r11)
+	ld	r11,STK_PARM(r15)(r1)	/* Fetch r8 ret arg */
+	std	r8,0(r11)
+	ld	r11,STK_PARM(r16)(r1)	/* Fetch r9 ret arg */
+	std	r9,0(r11)
+	ld	r11,STK_PARM(r17)(r1)	/* Fetch r10 ret arg */
+	std	r10,0(r11)
+
+	mtcrf	0xff,r0
+
+	blr				/* return r3 = status */
+
+/* plpar_hcall_9arg_9ret(unsigned long opcode,		R3
+			 unsigned long arg1,		R4
+			 unsigned long arg2,		R5
+			 unsigned long arg3,		R6
+			 unsigned long arg4,		R7
+			 unsigned long arg5,		R8
+			 unsigned long arg6,		R9
+			 unsigned long arg7,		R10
+			 unsigned long arg8,		112(R1)
+			 unsigned long arg9,		110(R1)
+			 unsigned long *out1,		108(R1)
+			 unsigned long *out2,		106(R1)
+			 unsigned long *out3,		104(R1)
+			 unsigned long *out4,		102(R1)
+			 unsigned long *out5,		100(R1)
+			 unsigned long *out6,		 98(R1)
+			 unsigned long *out7);		 96(R1)
+			 unsigned long *out8,		 94(R1)
+		         unsigned long *out9,            92(R1)
+*/
+_GLOBAL(plpar_hcall_9arg_9ret)
+	HMT_MEDIUM
+
+	mfcr	r0
+	stw	r0,8(r1)
+
+	ld	r11,STK_PARM(r11)(r1)	 /* put arg8 in R11 */
+	ld	r12,STK_PARM(r12)(r1)    /* put arg9 in R12 */
+
+	HVSC				/* invoke the hypervisor */
+
+	ld	r0,STK_PARM(r13)(r1)	/* Fetch r4 ret arg */
+	stdx	r4,r0,r0
+	ld	r0,STK_PARM(r14)(r1)	/* Fetch r5 ret arg */
+	stdx	r5,r0,r0
+	ld	r0,STK_PARM(r15)(r1)	/* Fetch r6 ret arg */
+	stdx	r6,r0,r0
+	ld	r0,STK_PARM(r16)(r1)	/* Fetch r7 ret arg */
+	stdx	r7,r0,r0
+	ld	r0,STK_PARM(r17)(r1)	/* Fetch r8 ret arg */
+	stdx	r8,r0,r0
+	ld	r0,STK_PARM(r18)(r1)	/* Fetch r9 ret arg */
+	stdx	r9,r0,r0
+	ld	r0,STK_PARM(r19)(r1)	/* Fetch r10 ret arg */
+	stdx	r10,r0,r0
+	ld	r0,STK_PARM(r20)(r1)	/* Fetch r11 ret arg */
+	stdx	r11,r0,r0
+	ld	r0,STK_PARM(r21)(r1)	/* Fetch r12 ret arg */
+	stdx	r12,r0,r0
+
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+
+	blr				/* return r3 = status */
diff -Nurpw linux-2.6.16-git14/arch/powerpc/platforms/pseries/hvCall.S.orig linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/hvCall.S.orig
--- linux-2.6.16-git14/arch/powerpc/platforms/pseries/hvCall.S.orig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/hvCall.S.orig	2006-03-28 14:19:51.140018464 +0200
@@ -0,0 +1,129 @@
+/*
+ * This file contains the generic code to perform a call to the
+ * pSeries LPAR hypervisor.
+ * NOTE: this file will go away when we move to inline this work.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <asm/hvcall.h>
+#include <asm/processor.h>
+#include <asm/ppc_asm.h>
+	
+#define STK_PARM(i)     (48 + ((i)-3)*8)
+
+	.text
+
+/* long plpar_hcall(unsigned long opcode,		R3
+			unsigned long arg1,		R4
+			unsigned long arg2,		R5
+			unsigned long arg3,		R6
+			unsigned long arg4,		R7
+			unsigned long *out1,		R8
+			unsigned long *out2,		R9
+			unsigned long *out3);		R10
+ */
+_GLOBAL(plpar_hcall)
+	HMT_MEDIUM
+
+	mfcr	r0
+
+	std	r8,STK_PARM(r8)(r1)	/* Save out ptrs */
+	std	r9,STK_PARM(r9)(r1)
+	std	r10,STK_PARM(r10)(r1)
+
+	stw	r0,8(r1)
+
+	HVSC				/* invoke the hypervisor */
+
+	lwz	r0,8(r1)
+
+	ld	r8,STK_PARM(r8)(r1)	/* Fetch r4-r6 ret args */
+	ld	r9,STK_PARM(r9)(r1)
+	ld	r10,STK_PARM(r10)(r1)
+	std	r4,0(r8)
+	std	r5,0(r9)
+	std	r6,0(r10)
+
+	mtcrf	0xff,r0
+	blr				/* return r3 = status */
+
+
+/* Simple interface with no output values (other than status) */
+_GLOBAL(plpar_hcall_norets)
+	HMT_MEDIUM
+
+	mfcr	r0
+	stw	r0,8(r1)
+
+	HVSC				/* invoke the hypervisor */
+
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+	blr				/* return r3 = status */
+
+
+/* long plpar_hcall_8arg_2ret(unsigned long opcode,	R3
+			unsigned long arg1,		R4
+			unsigned long arg2,		R5
+			unsigned long arg3,		R6
+			unsigned long arg4,		R7
+			unsigned long arg5,		R8
+			unsigned long arg6,		R9
+			unsigned long arg7,		R10
+			unsigned long arg8,		112(R1)
+			unsigned long *out1);		120(R1)
+ */
+_GLOBAL(plpar_hcall_8arg_2ret)
+	HMT_MEDIUM
+
+	mfcr	r0
+	ld	r11,STK_PARM(r11)(r1)	/* put arg8 in R11 */
+	stw	r0,8(r1)
+
+	HVSC				/* invoke the hypervisor */
+
+	lwz	r0,8(r1)
+	ld	r10,STK_PARM(r12)(r1)	/* Fetch r4 ret arg */
+	std	r4,0(r10)
+	mtcrf	0xff,r0
+	blr				/* return r3 = status */
+
+
+/* long plpar_hcall_4out(unsigned long opcode,		R3
+		 	unsigned long arg1,		R4
+		 	unsigned long arg2,		R5
+		 	unsigned long arg3,		R6
+		 	unsigned long arg4,		R7
+		 	unsigned long *out1,		R8
+		 	unsigned long *out2,		R9
+		 	unsigned long *out3,		R10
+		 	unsigned long *out4);		112(R1)
+ */
+_GLOBAL(plpar_hcall_4out)
+	HMT_MEDIUM
+
+	mfcr	r0
+	stw	r0,8(r1)
+
+	std	r8,STK_PARM(r8)(r1)	/* Save out ptrs */
+	std	r9,STK_PARM(r9)(r1)
+	std	r10,STK_PARM(r10)(r1)
+
+	HVSC				/* invoke the hypervisor */
+
+	lwz	r0,8(r1)
+
+	ld	r8,STK_PARM(r8)(r1)	/* Fetch r4-r7 ret args */
+	ld	r9,STK_PARM(r9)(r1)
+	ld	r10,STK_PARM(r10)(r1)
+	ld	r11,STK_PARM(r11)(r1)
+	std	r4,0(r8)
+	std	r5,0(r9)
+	std	r6,0(r10)
+	std	r7,0(r11)
+
+	mtcrf	0xff,r0
+	blr				/* return r3 = status */
diff -Nurpw linux-2.6.16-git14/arch/powerpc/platforms/pseries/lpar.c linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/lpar.c
--- linux-2.6.16-git14/arch/powerpc/platforms/pseries/lpar.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/lpar.c	2006-03-28 14:20:47.801056072 +0200
@@ -54,7 +54,8 @@ EXPORT_SYMBOL(plpar_hcall);
   EXPORT_SYMBOL(plpar_hcall_4out);
   EXPORT_SYMBOL(plpar_hcall_norets);
   EXPORT_SYMBOL(plpar_hcall_8arg_2ret);
-
+EXPORT_SYMBOL(plpar_hcall_7arg_7ret);
+EXPORT_SYMBOL(plpar_hcall_9arg_9ret);
   extern void pSeries_find_serial_port(void);


diff -Nurpw linux-2.6.16-git14/include/asm-powerpc/hvcall.h linux-2.6.16-git14-ib/include/asm-powerpc/hvcall.h
--- linux-2.6.16-git14/include/asm-powerpc/hvcall.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-git14-ib/include/asm-powerpc/hvcall.h	2006-03-28 14:20:47.799056376 +0200
@@ -7,8 +7,12 @@
   #define H_Success	0
   #define H_Busy		1	/* Hardware busy -- retry later */
   #define H_Closed	2	/* Resource closed */
+#define H_NOT_AVAILABLE    3
   #define H_Constrained	4	/* Resource request constrained to max allowed */
+#define H_PARTIAL          5
   #define H_InProgress   14	/* Kind of like busy */
+#define H_PARTIAL_STORE   16
+#define H_PAGE_REGISTERED 15
   #define H_Continue     18	/* Returned from H_Join on success */
   #define H_LongBusyStartRange   9900  /* Start of long busy range */
   #define H_LongBusyOrder1msec   9900  /* Long busy, hint that 1msec is a good time to retry */
@@ -34,6 +38,36 @@
   #define H_DestParm             -14
   #define H_RemoteParm           -15
   #define H_Resource             -16
+#define H_ADAPTER_PARM         -17
+#define H_RH_PARM              -18
+#define H_RCQ_PARM             -19
+#define H_SCQ_PARM             -20
+#define H_EQ_PARM              -21
+#define H_RT_PARM              -22
+#define H_ST_PARM              -23
+#define H_SIGT_PARM            -24
+#define H_TOKEN_PARM           -25
+#define H_MLENGTH_PARM         -27
+#define H_MEM_PARM             -28
+#define H_MEM_ACCESS_PARM      -29
+#define H_ATTR_PARM            -30
+#define H_PORT_PARM            -31
+#define H_MCG_PARM             -32
+#define H_VL_PARM              -33
+#define H_TSIZE_PARM           -34
+#define H_TRACE_PARM           -35
+
+#define H_MASK_PARM            -37
+#define H_MCG_FULL             -38
+#define H_ALIAS_EXIST          -39
+#define H_P_COUNTER            -40
+#define H_TABLE_FULL           -41
+#define H_ALT_TABLE            -42
+#define H_MR_CONDITION         -43
+#define H_NOT_ENOUGH_RESOURCES -44
+#define H_R_STATE              -45
+#define H_RESCINDEND           -46
+

   /* Long Busy is a condition that can be returned by the firmware
    * when a call cannot be completed now, but the identical call
@@ -65,6 +99,9 @@
   #define H_DABRX_KERNEL		(1UL<<(63-62))
   #define H_DABRX_USER		(1UL<<(63-63))

+/* Each control block has to be on a 4K bondary */
+#define H_CB_ALIGNMENT          4096
+
   /* pSeries hypervisor opcodes */
   #define H_REMOVE		0x04
   #define H_ENTER			0x08
@@ -116,6 +153,33 @@
   #define H_VTERM_PARTNER_INFO	0x150
   #define H_REGISTER_VTERM	0x154
   #define H_FREE_VTERM		0x158
+#define H_RESET_EVENTS          0x15C
+#define H_ALLOC_RESOURCE        0x160
+#define H_FREE_RESOURCE         0x164
+#define H_MODIFY_QP             0x168
+#define H_QUERY_QP              0x16C
+#define H_REREGISTER_PMR        0x170
+#define H_REGISTER_SMR          0x174
+#define H_QUERY_MR              0x178
+#define H_QUERY_MW              0x17C
+#define H_QUERY_HCA             0x180
+#define H_QUERY_PORT            0x184
+#define H_MODIFY_PORT           0x188
+#define H_DEFINE_AQP1           0x18C
+#define H_GET_TRACE_BUFFER      0x190
+#define H_DEFINE_AQP0           0x194
+#define H_RESIZE_MR             0x198
+#define H_ATTACH_MCQP           0x19C
+#define H_DETACH_MCQP           0x1A0
+#define H_CREATE_RPT            0x1A4
+#define H_REMOVE_RPT            0x1A8
+#define H_REGISTER_RPAGES       0x1AC
+#define H_DISABLE_AND_GETC      0x1B0
+#define H_ERROR_DATA            0x1B4
+#define H_GET_HCA_INFO          0x1B8
+#define H_GET_PERF_COUNT        0x1BC
+#define H_MANAGE_TRACE          0x1C0
+#define H_QUERY_INT_STATE       0x1E4
   #define H_POLL_PENDING	        0x1D8
   #define H_JOIN			0x298
   #define H_ENABLE_CRQ		0x2B0
@@ -175,6 +239,42 @@ long plpar_hcall_4out(unsigned long opco
   		      unsigned long *out3,
   		      unsigned long *out4);

+long plpar_hcall_7arg_7ret(unsigned long opcode,
+			   unsigned long arg1,
+			   unsigned long arg2,
+			   unsigned long arg3,
+			   unsigned long arg4,
+			   unsigned long arg5,
+			   unsigned long arg6,
+			   unsigned long arg7,
+			   unsigned long *out1,
+			   unsigned long *out2,
+			   unsigned long *out3,
+			   unsigned long *out4,
+			   unsigned long *out5,
+			   unsigned long *out6,
+			   unsigned long *out7);
+
+long plpar_hcall_9arg_9ret(unsigned long opcode,
+			   unsigned long arg1,
+			   unsigned long arg2,
+			   unsigned long arg3,
+			   unsigned long arg4,
+			   unsigned long arg5,
+			   unsigned long arg6,
+			   unsigned long arg7,
+			   unsigned long arg8,
+			   unsigned long arg9,
+			   unsigned long *out1,
+			   unsigned long *out2,
+			   unsigned long *out3,
+			   unsigned long *out4,
+			   unsigned long *out5,
+			   unsigned long *out6,
+			   unsigned long *out7,
+			   unsigned long *out8,
+			   unsigned long *out9);
+
   #endif /* __ASSEMBLY__ */
   #endif /* __KERNEL__ */
   #endif /* _ASM_POWERPC_HVCALL_H */


--------------040403080003080808000004
Content-Type: text/x-patch;
 name="ib_hcalls-2616-git14.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ib_hcalls-2616-git14.patch"

diff -Nurpw linux-2.6.16-git14/arch/powerpc/platforms/pseries/hvCall.S linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/hvCall.S
--- linux-2.6.16-git14/arch/powerpc/platforms/pseries/hvCall.S	2006-03-28 14:18:52.389031144 +0200
+++ linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/hvCall.S	2006-03-28 14:20:47.800056224 +0200
@@ -91,7 +91,6 @@ _GLOBAL(plpar_hcall_8arg_2ret)
 	mtcrf	0xff,r0
 	blr				/* return r3 = status */
 
-
 /* long plpar_hcall_4out(unsigned long opcode,		R3
 		 	unsigned long arg1,		R4
 		 	unsigned long arg2,		R5
@@ -127,3 +126,103 @@ _GLOBAL(plpar_hcall_4out)
 
 	mtcrf	0xff,r0
 	blr				/* return r3 = status */
+
+/* plpar_hcall_7arg_7ret(unsigned long opcode,		R3
+			 unsigned long arg1,		R4
+			 unsigned long arg2,		R5
+			 unsigned long arg3,		R6
+			 unsigned long arg4,		R7
+			 unsigned long arg5,		R8
+			 unsigned long arg6,		R9
+			 unsigned long arg7,		R10
+			 unsigned long *out1,		112(R1)
+			 unsigned long *out2,		110(R1)
+			 unsigned long *out3,		108(R1)
+			 unsigned long *out4,		106(R1)
+			 unsigned long *out5,		104(R1)
+			 unsigned long *out6,		102(R1)
+			 unsigned long *out7);		100(R1)
+*/
+_GLOBAL(plpar_hcall_7arg_7ret)
+	HMT_MEDIUM
+
+	mfcr	r0
+	stw	r0,8(r1)
+
+	HVSC				/* invoke the hypervisor */
+
+	lwz	r0,8(r1)
+
+	ld	r11,STK_PARM(r11)(r1)	/* Fetch r4 ret arg */
+	std	r4,0(r11)
+	ld	r11,STK_PARM(r12)(r1)	/* Fetch r5 ret arg */
+	std	r5,0(r11)
+	ld	r11,STK_PARM(r13)(r1)	/* Fetch r6 ret arg */
+	std	r6,0(r11)
+	ld	r11,STK_PARM(r14)(r1)	/* Fetch r7 ret arg */
+	std	r7,0(r11)
+	ld	r11,STK_PARM(r15)(r1)	/* Fetch r8 ret arg */
+	std	r8,0(r11)
+	ld	r11,STK_PARM(r16)(r1)	/* Fetch r9 ret arg */
+	std	r9,0(r11)
+	ld	r11,STK_PARM(r17)(r1)	/* Fetch r10 ret arg */
+	std	r10,0(r11)
+
+	mtcrf	0xff,r0
+
+	blr				/* return r3 = status */
+
+/* plpar_hcall_9arg_9ret(unsigned long opcode,		R3
+			 unsigned long arg1,		R4
+			 unsigned long arg2,		R5
+			 unsigned long arg3,		R6
+			 unsigned long arg4,		R7
+			 unsigned long arg5,		R8
+			 unsigned long arg6,		R9
+			 unsigned long arg7,		R10
+			 unsigned long arg8,		112(R1)
+			 unsigned long arg9,		110(R1)
+			 unsigned long *out1,		108(R1)
+			 unsigned long *out2,		106(R1)
+			 unsigned long *out3,		104(R1)
+			 unsigned long *out4,		102(R1)
+			 unsigned long *out5,		100(R1)
+			 unsigned long *out6,		 98(R1)
+			 unsigned long *out7);		 96(R1)
+			 unsigned long *out8,		 94(R1)
+		         unsigned long *out9,            92(R1)
+*/
+_GLOBAL(plpar_hcall_9arg_9ret)
+	HMT_MEDIUM
+
+	mfcr	r0
+	stw	r0,8(r1)
+
+	ld	r11,STK_PARM(r11)(r1)	 /* put arg8 in R11 */
+	ld	r12,STK_PARM(r12)(r1)    /* put arg9 in R12 */
+
+	HVSC				/* invoke the hypervisor */
+
+	ld	r0,STK_PARM(r13)(r1)	/* Fetch r4 ret arg */
+	stdx	r4,r0,r0
+	ld	r0,STK_PARM(r14)(r1)	/* Fetch r5 ret arg */
+	stdx	r5,r0,r0
+	ld	r0,STK_PARM(r15)(r1)	/* Fetch r6 ret arg */
+	stdx	r6,r0,r0
+	ld	r0,STK_PARM(r16)(r1)	/* Fetch r7 ret arg */
+	stdx	r7,r0,r0
+	ld	r0,STK_PARM(r17)(r1)	/* Fetch r8 ret arg */
+	stdx	r8,r0,r0
+	ld	r0,STK_PARM(r18)(r1)	/* Fetch r9 ret arg */
+	stdx	r9,r0,r0
+	ld	r0,STK_PARM(r19)(r1)	/* Fetch r10 ret arg */
+	stdx	r10,r0,r0
+	ld	r0,STK_PARM(r20)(r1)	/* Fetch r11 ret arg */
+	stdx	r11,r0,r0
+	ld	r0,STK_PARM(r21)(r1)	/* Fetch r12 ret arg */
+	stdx	r12,r0,r0
+
+	lwz	r0,8(r1)
+	mtcrf	0xff,r0
+
+	blr				/* return r3 = status */
diff -Nurpw linux-2.6.16-git14/arch/powerpc/platforms/pseries/lpar.c linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/lpar.c
--- linux-2.6.16-git14/arch/powerpc/platforms/pseries/lpar.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-git14-ib/arch/powerpc/platforms/pseries/lpar.c	2006-03-28 14:20:47.801056072 +0200
@@ -54,7 +54,8 @@ EXPORT_SYMBOL(plpar_hcall);
 EXPORT_SYMBOL(plpar_hcall_4out);
 EXPORT_SYMBOL(plpar_hcall_norets);
 EXPORT_SYMBOL(plpar_hcall_8arg_2ret);
-
+EXPORT_SYMBOL(plpar_hcall_7arg_7ret);
+EXPORT_SYMBOL(plpar_hcall_9arg_9ret);
 extern void pSeries_find_serial_port(void);
 
 
diff -Nurpw linux-2.6.16-git14/include/asm-powerpc/hvcall.h linux-2.6.16-git14-ib/include/asm-powerpc/hvcall.h
--- linux-2.6.16-git14/include/asm-powerpc/hvcall.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-git14-ib/include/asm-powerpc/hvcall.h	2006-03-28 14:20:47.799056376 +0200
@@ -7,8 +7,12 @@
 #define H_Success	0
 #define H_Busy		1	/* Hardware busy -- retry later */
 #define H_Closed	2	/* Resource closed */
+#define H_NOT_AVAILABLE    3
 #define H_Constrained	4	/* Resource request constrained to max allowed */
+#define H_PARTIAL          5
 #define H_InProgress   14	/* Kind of like busy */
+#define H_PARTIAL_STORE   16
+#define H_PAGE_REGISTERED 15
 #define H_Continue     18	/* Returned from H_Join on success */
 #define H_LongBusyStartRange   9900  /* Start of long busy range */
 #define H_LongBusyOrder1msec   9900  /* Long busy, hint that 1msec is a good time to retry */
@@ -34,6 +38,36 @@
 #define H_DestParm             -14
 #define H_RemoteParm           -15
 #define H_Resource             -16
+#define H_ADAPTER_PARM         -17
+#define H_RH_PARM              -18
+#define H_RCQ_PARM             -19
+#define H_SCQ_PARM             -20
+#define H_EQ_PARM              -21
+#define H_RT_PARM              -22
+#define H_ST_PARM              -23
+#define H_SIGT_PARM            -24
+#define H_TOKEN_PARM           -25
+#define H_MLENGTH_PARM         -27
+#define H_MEM_PARM             -28
+#define H_MEM_ACCESS_PARM      -29
+#define H_ATTR_PARM            -30
+#define H_PORT_PARM            -31
+#define H_MCG_PARM             -32
+#define H_VL_PARM              -33
+#define H_TSIZE_PARM           -34
+#define H_TRACE_PARM           -35
+
+#define H_MASK_PARM            -37
+#define H_MCG_FULL             -38
+#define H_ALIAS_EXIST          -39
+#define H_P_COUNTER            -40
+#define H_TABLE_FULL           -41
+#define H_ALT_TABLE            -42
+#define H_MR_CONDITION         -43
+#define H_NOT_ENOUGH_RESOURCES -44
+#define H_R_STATE              -45
+#define H_RESCINDEND           -46
+
 
 /* Long Busy is a condition that can be returned by the firmware
  * when a call cannot be completed now, but the identical call
@@ -65,6 +99,9 @@
 #define H_DABRX_KERNEL		(1UL<<(63-62))
 #define H_DABRX_USER		(1UL<<(63-63))
 
+/* Each control block has to be on a 4K bondary */
+#define H_CB_ALIGNMENT          4096
+
 /* pSeries hypervisor opcodes */
 #define H_REMOVE		0x04
 #define H_ENTER			0x08
@@ -116,6 +153,33 @@
 #define H_VTERM_PARTNER_INFO	0x150
 #define H_REGISTER_VTERM	0x154
 #define H_FREE_VTERM		0x158
+#define H_RESET_EVENTS          0x15C
+#define H_ALLOC_RESOURCE        0x160
+#define H_FREE_RESOURCE         0x164
+#define H_MODIFY_QP             0x168
+#define H_QUERY_QP              0x16C
+#define H_REREGISTER_PMR        0x170
+#define H_REGISTER_SMR          0x174
+#define H_QUERY_MR              0x178
+#define H_QUERY_MW              0x17C
+#define H_QUERY_HCA             0x180
+#define H_QUERY_PORT            0x184
+#define H_MODIFY_PORT           0x188
+#define H_DEFINE_AQP1           0x18C
+#define H_GET_TRACE_BUFFER      0x190
+#define H_DEFINE_AQP0           0x194
+#define H_RESIZE_MR             0x198
+#define H_ATTACH_MCQP           0x19C
+#define H_DETACH_MCQP           0x1A0
+#define H_CREATE_RPT            0x1A4
+#define H_REMOVE_RPT            0x1A8
+#define H_REGISTER_RPAGES       0x1AC
+#define H_DISABLE_AND_GETC      0x1B0
+#define H_ERROR_DATA            0x1B4
+#define H_GET_HCA_INFO          0x1B8
+#define H_GET_PERF_COUNT        0x1BC
+#define H_MANAGE_TRACE          0x1C0
+#define H_QUERY_INT_STATE       0x1E4
 #define H_POLL_PENDING	        0x1D8
 #define H_JOIN			0x298
 #define H_ENABLE_CRQ		0x2B0
@@ -175,6 +239,42 @@ long plpar_hcall_4out(unsigned long opco
 		      unsigned long *out3,
 		      unsigned long *out4);
 
+long plpar_hcall_7arg_7ret(unsigned long opcode,
+			   unsigned long arg1,
+			   unsigned long arg2,
+			   unsigned long arg3,
+			   unsigned long arg4,
+			   unsigned long arg5,
+			   unsigned long arg6,
+			   unsigned long arg7,
+			   unsigned long *out1,
+			   unsigned long *out2,
+			   unsigned long *out3,
+			   unsigned long *out4,
+			   unsigned long *out5,
+			   unsigned long *out6,
+			   unsigned long *out7);
+
+long plpar_hcall_9arg_9ret(unsigned long opcode,
+			   unsigned long arg1,
+			   unsigned long arg2,
+			   unsigned long arg3,
+			   unsigned long arg4,
+			   unsigned long arg5,
+			   unsigned long arg6,
+			   unsigned long arg7,
+			   unsigned long arg8,
+			   unsigned long arg9,
+			   unsigned long *out1,
+			   unsigned long *out2,
+			   unsigned long *out3,
+			   unsigned long *out4,
+			   unsigned long *out5,
+			   unsigned long *out6,
+			   unsigned long *out7,
+			   unsigned long *out8,
+			   unsigned long *out9);
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_HVCALL_H */

--------------040403080003080808000004--
