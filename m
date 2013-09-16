Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6A7742C0102
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:41:12 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 16 Sep 2013 22:37:42 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1A0FC2CE8053
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:41:06 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8GCOaJT9306478
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:24:37 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8GCf5GT001651
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:41:05 +1000
Subject: [RFC PATCH v4 01/12] powerpc/book3s: Split the common exception
 prolog logic into two section.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 16 Sep 2013 18:11:02 +0530
Message-ID: <20130916124102.16111.8260.stgit@mars.in.ibm.com>
In-Reply-To: <20130916123908.16111.4657.stgit@mars.in.ibm.com>
References: <20130916123908.16111.4657.stgit@mars.in.ibm.com>
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
index 07ca627..94ab2d2 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -281,9 +281,12 @@ do_kvm_##n:								\
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
@@ -298,9 +301,14 @@ do_kvm_##n:								\
 	ld	r10,area+EX_CFAR(r13);					   \
 	std	r10,ORIG_GPR3(r1);					   \
 	END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);		   \
-	GET_LR(r9,area);		/* Get LR, later save to stack	*/ \
+	GET_LR(r9,area);		/* Save LR to stack	*/ \
+	std	r9,_LINK(r1);
+
+#define EXCEPTION_PROLOG_COMMON_3(n)					   \
+	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
+	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe	*/ \
+	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
 	ld	r2,PACATOC(r13);	/* get kernel TOC into r2	*/ \
-	std	r9,_LINK(r1);						   \
 	mfctr	r10;			/* save CTR in stackframe	*/ \
 	std	r10,_CTR(r1);						   \
 	lbz	r10,PACASOFTIRQEN(r13);				   \
@@ -312,8 +320,7 @@ do_kvm_##n:								\
 	li	r10,0;							   \
 	ld	r11,exception_marker@toc(r2);				   \
 	std	r10,RESULT(r1);		/* clear regs->result		*/ \
-	std	r11,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame	*/ \
-	ACCOUNT_STOLEN_TIME
+	std	r11,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame	*/
 
 /*
  * Exception vectors.
