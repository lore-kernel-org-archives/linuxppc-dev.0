Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5589679E6
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 06:11:35 +1100 (EST)
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com
	[129.34.20.41])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k2UJBocN026093
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 14:11:50 -0500
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k2UJBWh108440
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 14:11:32 -0500
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k2UJBVB112950
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 14:11:31 -0500
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k2UK80TW011121
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 15:08:00 -0500
Received: from heater.watson.ibm.com (heater.watson.ibm.com [9.2.222.55])
	by kitch0.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP
	id k2UJBUm35754
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 14:11:30 -0500
Received: from mostrows by heater.watson.ibm.com with local (Exim 4.60)
	(envelope-from <mostrows@watson.ibm.com>) id 1FP2aD-00050y-IO
	for linuxppc-dev@ozlabs.org; Thu, 30 Mar 2006 14:13:25 -0500
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Extends HCALL interface for Infiniband usage
Message-Id: <E1FP2aD-00050y-IO@heater.watson.ibm.com>
From: Michal Ostrowski <mostrows@watson.ibm.com>
Date: Thu, 30 Mar 2006 14:13:25 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


For the sake of discussion...

A generic hcall wrapper through which any hcall may be made; an
alternative to having to wwrite-out each possible combination of
numbers of input and output arguments.

Needs the obvious fix to meek Heiko's requirements (9-in, 9-out).

Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>


 arch/powerpc/platforms/pseries/hvCall.S |   45 ++++++++++++++++++++++++++++++++
 include/asm-powerpc/hvcall.h            |   10 +++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/hvCall.S b/arch/powerpc/platforms/pseries/hvCall.S
index 176e8da..7bb29b5 100644
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -129,3 +129,48 @@ _GLOBAL(plpar_hcall_4out)
 
 	mtcrf	0xff,r0
 	blr				/* return r3 = status */
+
+/* long plpar_hcall_generic(unsigned long opcode,	R3
+			    unsigned long in_args[8],	R4
+			    unsigned long out_args[8])	R5
+*/
+_GLOBAL(plpar_hcall_generic)
+	mfcr	r0
+	std	r0,-8(r1)
+	stdu	r1,-48(r1)
+
+	std	r4,16(r1)
+	std	r5,8(r1)
+
+	mr	r12, r4			/* Load HCALL args into r4...r11. */
+	ld	r4, 0(r12)
+	ld	r5, 8(r12)
+	ld	r6, 16(r12)
+	ld	r7, 24(r12)
+	ld	r8, 32(r12)
+	ld	r9, 40(r12)
+	ld	r10, 48(r12)
+	ld	r11, 56(r12)
+
+	HVSC				/* Invoke the hypervisor. */
+
+	ld	r12, 8(r1)		/* Check if return args need	*/
+	cmpi	0, r12, 0		/* to be saved.			*/
+	beq	1f
+
+	std	r4, 0(r12)
+	std	r5, 8(r12)
+	std	r6, 16(r12)
+	std	r7, 24(r12)
+	std	r8, 32(r12)
+	std	r9, 40(r12)
+	std	r10, 48(r12)
+	std	r11, 56(r12)
+1:
+	ld	r1,0(r1) 
+	ld	r0,-8(r1)
+
+	mtcrf	0xff,r0
+	blr				/* return r3 = status */
+
+
diff --git a/include/asm-powerpc/hvcall.h b/include/asm-powerpc/hvcall.h
index 38ca9ad..3bf6425 100644
--- a/include/asm-powerpc/hvcall.h
+++ b/include/asm-powerpc/hvcall.h
@@ -175,6 +175,16 @@ long plpar_hcall_4out(unsigned long opco
 		      unsigned long *out3,
 		      unsigned long *out4);
 
+/* plpar_hcall_generic()
+ * 
+ * generic hcall pass-thru mechanism
+ *
+ */
+long plpar_hcall_generic(unsigned long opcode, 
+			 unsigned long in_args[8],	
+			 unsigned long out_args[8]);
+
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_HVCALL_H */
