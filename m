Return-Path: <jimix@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF888679FB
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 09:16:00 +1000 (EST)
Received: from sp1n294en1.watson.ibm.com (sp1n294en1.watson.ibm.com
	[129.34.20.40])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k5LNGTRl000374
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2006 19:16:33 -0400
Received: from sp1n294en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k5LNFqT118138
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2006 19:15:52 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k5LNFqu104706
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2006 19:15:52 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k5M08YqP014753
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2006 20:08:34 -0400
Received: from kmac.watson.ibm.com (kmac.watson.ibm.com [9.2.208.86])
	by kitch0.watson.ibm.com (AIX5.3/8.11.6p2/8.11.0/03-06-2002) with ESMTP
	id k5LNFpW544840
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2006 19:15:51 -0400
Received: from jimix by kmac.watson.ibm.com with local (Exim 4.62)
	(envelope-from <jimix@kmac.watson.ibm.com>) id 1FtBvP-00026H-TC
	for linuxppc-dev@ozlabs.org; Wed, 21 Jun 2006 19:15:55 -0400
From: Jimi Xenidis <jimix@watson.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Don't access HID registers if running on a Hypervisor.
Message-Id: <E1FtBvP-00026H-TC@kmac.watson.ibm.com>
Date: Wed, 21 Jun 2006 19:15:55 -0400
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The following patch avoids accessing Hypervisor privilege HID
registers when running on a Hypervisor (MSR[HV]=0).

Signed-off-by: Jimi Xenidis <jimix@watson.ibm.com>


diff -r 87d019e8edc2 arch/powerpc/kernel/cpu_setup_power4.S
--- a/arch/powerpc/kernel/cpu_setup_power4.S	Tue Jun 20 13:50:49 2006 -0400
+++ b/arch/powerpc/kernel/cpu_setup_power4.S	Wed Jun 21 19:10:22 2006 -0400
@@ -149,7 +149,12 @@ _GLOBAL(__save_cpu_setup)
 	cmpwi	r0,0x44
 	bne	2f
 
-1:	/* Save HID0,1,4 and 5 */
+1:	/* skip if not running in HV mode */
+	mfmsr	r0
+	rldicl.	r0,r0,4,63
+	beq	2f
+
+	/* Save HID0,1,4 and 5 */
 	mfspr	r3,SPRN_HID0
 	std	r3,CS_HID0(r5)
 	mfspr	r3,SPRN_HID1
@@ -183,7 +188,12 @@ _GLOBAL(__restore_cpu_setup)
 	cmpwi	r0,0x44
 	bnelr
 
-1:	/* Before accessing memory, we make sure rm_ci is clear */
+1:	/* skip if not running in HV mode */
+	mfmsr	r0
+	rldicl.	r0,r0,4,63
+	beqlr
+
+	/* Before accessing memory, we make sure rm_ci is clear */
 	li	r0,0
 	mfspr	r3,SPRN_HID4
 	rldimi	r3,r0,40,23	/* clear bit 23 (rm_ci) */
