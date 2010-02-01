Return-Path: <markn@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9232CB7DCB
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Feb 2010 17:09:24 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id o11662Zm021279
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2010 17:06:02 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1164OAf1306862
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2010 17:04:24 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1169NDo005830
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2010 17:09:23 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o1169N6W005825
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2010 17:09:23 +1100
Received: from ubrain.localnet (haven.au.ibm.com [9.190.164.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTP id 63CEC73728
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Feb 2010 17:09:23 +1100 (EST)
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: Pass CPPR value to H_XIRR hcall
Date: Mon, 1 Feb 2010 17:12:58 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201002011712.58684.markn@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we properly keep track of the CPPR value (since
49bd3647134ea47420067aea8d1401e722bf2aac, "powerpc/pseries: Track previous
CPPR values to correctly EOI interrupts") we can pass it to the
H_XIRR hcall.

This is needed because the Partition Adjunct Option of new versions of
pHyp extend the H_XIRR hcall to include the CPPR as an input parameter.
Earlier versions not supporting this option just disregard the extra
input parameter, so this doesn't cause any problems for existing systems.

The Partition Adjunct Option is required for future systems that will
support SR-IOV capable devices.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/platforms/pseries/plpar_wrappers.h |    4 ++--
 arch/powerpc/platforms/pseries/xics.c           |    7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

Index: upstream/arch/powerpc/platforms/pseries/plpar_wrappers.h
===================================================================
--- upstream.orig/arch/powerpc/platforms/pseries/plpar_wrappers.h
+++ upstream/arch/powerpc/platforms/pseries/plpar_wrappers.h
@@ -259,12 +259,12 @@ static inline long plpar_ipi(unsigned lo
 	return plpar_hcall_norets(H_IPI, servernum, mfrr);
 }
 
-static inline long plpar_xirr(unsigned long *xirr_ret)
+static inline long plpar_xirr(unsigned long *xirr_ret, unsigned char cppr)
 {
 	long rc;
 	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 
-	rc = plpar_hcall(H_XIRR, retbuf);
+	rc = plpar_hcall(H_XIRR, retbuf, cppr);
 
 	*xirr_ret = retbuf[0];
 
Index: upstream/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/pseries/xics.c
+++ upstream/arch/powerpc/platforms/pseries/xics.c
@@ -120,12 +120,12 @@ static inline void direct_qirr_info(int 
 
 /* LPAR low level accessors */
 
-static inline unsigned int lpar_xirr_info_get(void)
+static inline unsigned int lpar_xirr_info_get(unsigned char cppr)
 {
 	unsigned long lpar_rc;
 	unsigned long return_value;
 
-	lpar_rc = plpar_xirr(&return_value);
+	lpar_rc = plpar_xirr(&return_value, cppr);
 	if (lpar_rc != H_SUCCESS)
 		panic(" bad return code xirr - rc = %lx \n", lpar_rc);
 	return (unsigned int)return_value;
@@ -335,7 +335,8 @@ static unsigned int xics_get_irq_direct(
 
 static unsigned int xics_get_irq_lpar(void)
 {
-	unsigned int xirr = lpar_xirr_info_get();
+	struct xics_cppr *os_cppr = &__get_cpu_var(xics_cppr);
+	unsigned int xirr = lpar_xirr_info_get(os_cppr->stack[os_cppr->index]);
 	unsigned int vec = xics_xirr_vector(xirr);
 	unsigned int irq;
 
