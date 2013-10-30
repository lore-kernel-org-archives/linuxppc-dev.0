Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 223D32C03F3
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:34:00 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 31 Oct 2013 00:33:58 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 70AE52BB0055
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:33:55 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9UEGOcB8257850
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:16:24 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9UEXsm3008954
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:33:54 +1100
Subject: [RFC PATCH v5 01/12] powerpc/book3s: Split the common exception
 prolog logic into two section.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 30 Oct 2013 20:03:51 +0530
Message-ID: <20131030143351.26643.11898.stgit@mars>
In-Reply-To: <20131030143219.26643.24782.stgit@mars>
References: <20131030143219.26643.24782.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

This patch splits the common exception prolog logic into three parts to
facilitate reuse of existing code in the next patch. This patch also
re-arranges few instructions in such a way that the second part now deals
with saving register values from paca save area to stack frame, and
the third part deals with saving current register values to stack frame.

The second and third part will be reused in the machine check exception
routine in the subsequent patch.

Please note that this patch does not introduce or change existing code
logic. Instead it is just a code movement and instruction re-ordering.

Patch Acked-by Paul. But made some minor modification (explained above) to
address Paul's comment in the later patch(3).

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Acked-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/exception-64s.h |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index cca12f0..306eda9 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -282,9 +282,12 @@ do_kvm_##n:								\
 	beq	4f;			/* if from kernel mode		*/ \
 	ACCOUNT_CPU_USER_ENTRY(r9, r10);				   \
 	SAVE_PPR(area, r9, r10);					   \
-4:	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
-	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe	*/ \
-	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
+4:	EXCEPTION_PROLOG_COMMON_2(area)					   \
+	EXCEPTION_PROLOG_COMMON_3(n)					   \
+	ACCOUNT_STOLEN_TIME
+
+/* Save original regs values from save area to stack frame. */
+#define EXCEPTION_PROLOG_COMMON_2(area)					   \
 	ld	r9,area+EX_R9(r13);	/* move r9, r10 to stackframe	*/ \
 	ld	r10,area+EX_R10(r13);					   \
 	std	r9,GPR9(r1);						   \
@@ -299,11 +302,16 @@ do_kvm_##n:								\
 	ld	r10,area+EX_CFAR(r13);					   \
 	std	r10,ORIG_GPR3(r1);					   \
 	END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);		   \
+	GET_CTR(r10, area);						   \
+	std	r10,_CTR(r1);
+
+#define EXCEPTION_PROLOG_COMMON_3(n)					   \
+	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
+	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe   */ \
+	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
 	mflr	r9;			/* Get LR, later save to stack	*/ \
 	ld	r2,PACATOC(r13);	/* get kernel TOC into r2	*/ \
 	std	r9,_LINK(r1);						   \
-	GET_CTR(r10, area);						   \
-	std	r10,_CTR(r1);						   \
 	lbz	r10,PACASOFTIRQEN(r13);				   \
 	mfspr	r11,SPRN_XER;		/* save XER in stackframe	*/ \
 	std	r10,SOFTE(r1);						   \
@@ -313,8 +321,7 @@ do_kvm_##n:								\
 	li	r10,0;							   \
 	ld	r11,exception_marker@toc(r2);				   \
 	std	r10,RESULT(r1);		/* clear regs->result		*/ \
-	std	r11,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame	*/ \
-	ACCOUNT_STOLEN_TIME
+	std	r11,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame	*/
 
 /*
  * Exception vectors.
