Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 470472C00A2
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:32 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 27 Aug 2013 05:17:52 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B12A3357804E
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:27 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7QJFEXv5898634
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:15:14 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7QJVQdg029172
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Aug 2013 05:31:27 +1000
Subject: [RFC PATCH v3 01/12] powerpc/book3s: Split the common exception
 prolog logic into two section.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Tue, 27 Aug 2013 01:01:24 +0530
Message-ID: <20130826193124.2855.96419.stgit@mars>
In-Reply-To: <20130826192616.2855.18749.stgit@mars>
References: <20130826192616.2855.18749.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

This patch splits the common exception prolog logic into two parts to
facilitate reuse of existing code in the next patch. The second part will
be reused in the machine check exception routine in the next patch.

Please note that this patch does not introduce or change existing code
logic. Instead it is just a code movement.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |   67 ++++++++++++++++--------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 07ca627..2386d40 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -248,6 +248,40 @@ do_kvm_##n:								\
 
 #define NOTEST(n)
 
+#define EXCEPTION_PROLOG_COMMON_2(n, area)				   \
+	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
+	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe	*/ \
+	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
+	ld	r9,area+EX_R9(r13);	/* move r9, r10 to stackframe	*/ \
+	ld	r10,area+EX_R10(r13);					   \
+	std	r9,GPR9(r1);						   \
+	std	r10,GPR10(r1);						   \
+	ld	r9,area+EX_R11(r13);	/* move r11 - r13 to stackframe	*/ \
+	ld	r10,area+EX_R12(r13);					   \
+	ld	r11,area+EX_R13(r13);					   \
+	std	r9,GPR11(r1);						   \
+	std	r10,GPR12(r1);						   \
+	std	r11,GPR13(r1);						   \
+	BEGIN_FTR_SECTION_NESTED(66);					   \
+	ld	r10,area+EX_CFAR(r13);					   \
+	std	r10,ORIG_GPR3(r1);					   \
+	END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);		   \
+	GET_LR(r9,area);		/* Get LR, later save to stack	*/ \
+	ld	r2,PACATOC(r13);	/* get kernel TOC into r2	*/ \
+	std	r9,_LINK(r1);						   \
+	mfctr	r10;			/* save CTR in stackframe	*/ \
+	std	r10,_CTR(r1);						   \
+	lbz	r10,PACASOFTIRQEN(r13);				   \
+	mfspr	r11,SPRN_XER;		/* save XER in stackframe	*/ \
+	std	r10,SOFTE(r1);						   \
+	std	r11,_XER(r1);						   \
+	li	r9,(n)+1;						   \
+	std	r9,_TRAP(r1);		/* set trap number		*/ \
+	li	r10,0;							   \
+	ld	r11,exception_marker@toc(r2);				   \
+	std	r10,RESULT(r1);		/* clear regs->result		*/ \
+	std	r11,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame	*/
+
 /*
  * The common exception prolog is used for all except a few exceptions
  * such as a segment miss on a kernel address.  We have to be prepared
@@ -281,38 +315,7 @@ do_kvm_##n:								\
 	beq	4f;			/* if from kernel mode		*/ \
 	ACCOUNT_CPU_USER_ENTRY(r9, r10);				   \
 	SAVE_PPR(area, r9, r10);					   \
-4:	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
-	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe	*/ \
-	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
-	ld	r9,area+EX_R9(r13);	/* move r9, r10 to stackframe	*/ \
-	ld	r10,area+EX_R10(r13);					   \
-	std	r9,GPR9(r1);						   \
-	std	r10,GPR10(r1);						   \
-	ld	r9,area+EX_R11(r13);	/* move r11 - r13 to stackframe	*/ \
-	ld	r10,area+EX_R12(r13);					   \
-	ld	r11,area+EX_R13(r13);					   \
-	std	r9,GPR11(r1);						   \
-	std	r10,GPR12(r1);						   \
-	std	r11,GPR13(r1);						   \
-	BEGIN_FTR_SECTION_NESTED(66);					   \
-	ld	r10,area+EX_CFAR(r13);					   \
-	std	r10,ORIG_GPR3(r1);					   \
-	END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);		   \
-	GET_LR(r9,area);		/* Get LR, later save to stack	*/ \
-	ld	r2,PACATOC(r13);	/* get kernel TOC into r2	*/ \
-	std	r9,_LINK(r1);						   \
-	mfctr	r10;			/* save CTR in stackframe	*/ \
-	std	r10,_CTR(r1);						   \
-	lbz	r10,PACASOFTIRQEN(r13);				   \
-	mfspr	r11,SPRN_XER;		/* save XER in stackframe	*/ \
-	std	r10,SOFTE(r1);						   \
-	std	r11,_XER(r1);						   \
-	li	r9,(n)+1;						   \
-	std	r9,_TRAP(r1);		/* set trap number		*/ \
-	li	r10,0;							   \
-	ld	r11,exception_marker@toc(r2);				   \
-	std	r10,RESULT(r1);		/* clear regs->result		*/ \
-	std	r11,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame	*/ \
+4:	EXCEPTION_PROLOG_COMMON_2(n, area)				   \
 	ACCOUNT_STOLEN_TIME
 
 /*
