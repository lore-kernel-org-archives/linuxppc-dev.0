Return-Path: <haren@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 425942C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 17:51:17 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Wed, 31 Oct 2012 00:51:14 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7A34319D803E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 00:51:12 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9V6pC7m256724
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 00:51:12 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9V6pB4r006443
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2012 00:51:12 -0600
Subject: [PATCH 1/6] powerpc: Move branch instruction from
 ACCOUNT_CPU_USER_ENTRY to caller
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, anton@au1.ibm.com,
 mikey@neuling.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Oct 2012 23:51:09 -0700
Message-ID: <1351666269.32304.12.camel@hbabu-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 1/6] powerpc: Move branch instruction from ACCOUNT_CPU_USER_ENTRY to caller

The first instruction in ACCOUNT_CPU_USER_ENTRY is 'beq' which checks for
exceptions coming from kernel mode. PPR value will be saved immediately after
ACCOUNT_CPU_USER_ENTRY and is also for user level exceptions. So moved this
branch instruction in the caller code.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |    3 ++-
 arch/powerpc/include/asm/ppc_asm.h       |    2 --
 arch/powerpc/kernel/entry_64.S           |    3 ++-
 arch/powerpc/kernel/exceptions-64e.S     |    3 ++-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index a43c147..45702e0 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -176,8 +176,9 @@ do_kvm_##n:								\
 	std	r10,0(r1);		/* make stack chain pointer	*/ \
 	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
 	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
+	beq	4f;			/* if from kernel mode		*/ \
 	ACCOUNT_CPU_USER_ENTRY(r9, r10);				   \
-	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
+4:	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
 	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe	*/ \
 	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
 	ld	r9,area+EX_R9(r13);	/* move r9, r10 to stackframe	*/ \
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index ea2a86e..376e36d 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -30,7 +30,6 @@
 #define ACCOUNT_STOLEN_TIME
 #else
 #define ACCOUNT_CPU_USER_ENTRY(ra, rb)					\
-	beq	2f;			/* if from kernel mode */	\
 	MFTB(ra);			/* get timebase */		\
 	ld	rb,PACA_STARTTIME_USER(r13);				\
 	std	ra,PACA_STARTTIME(r13);					\
@@ -38,7 +37,6 @@
 	ld	ra,PACA_USER_TIME(r13);					\
 	add	ra,ra,rb;		/* add on to user time */	\
 	std	ra,PACA_USER_TIME(r13);					\
-2:
 
 #define ACCOUNT_CPU_USER_EXIT(ra, rb)					\
 	MFTB(ra);			/* get timebase */		\
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 56e0ff0..72c40dd 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -62,8 +62,9 @@ system_call_common:
 	std	r12,_MSR(r1)
 	std	r0,GPR0(r1)
 	std	r10,GPR1(r1)
+	beq	2f			/* if from kernel mode */
 	ACCOUNT_CPU_USER_ENTRY(r10, r11)
-	std	r2,GPR2(r1)
+2:	std	r2,GPR2(r1)
 	std	r3,GPR3(r1)
 	mfcr	r2
 	std	r4,GPR4(r1)
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 4684e33..709c06b 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -159,8 +159,9 @@ exc_##n##_common:							    \
 	std	r9,GPR9(r1);		/* save r9 in stackframe */	    \
 	std	r10,_NIP(r1);		/* save SRR0 to stackframe */	    \
 	std	r11,_MSR(r1);		/* save SRR1 to stackframe */	    \
+	beq	1f			/* if from kernel mode */
 	ACCOUNT_CPU_USER_ENTRY(r10,r11);/* accounting (uses cr0+eq) */	    \
-	ld	r3,excf+EX_R10(r13);	/* get back r10 */		    \
+1:	ld	r3,excf+EX_R10(r13);	/* get back r10 */		    \
 	ld	r4,excf+EX_R11(r13);	/* get back r11 */		    \
 	mfspr	r5,SPRN_SPRG_GEN_SCRATCH;/* get back r13 */		    \
 	std	r12,GPR12(r1);		/* save r12 in stackframe */	    \
-- 
1.7.1
