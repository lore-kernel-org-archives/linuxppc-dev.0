Return-Path: <jimix@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58F0067A42
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jun 2006 18:56:41 +1000 (EST)
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com
	[129.34.20.41])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k5Q8vEU9013552
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jun 2006 04:57:14 -0400
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k5Q8uah475216
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jun 2006 04:56:36 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k5Q8uZK179342
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jun 2006 04:56:35 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k5Q9n5tE006621
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jun 2006 05:49:05 -0400
Received: from kmac.watson.ibm.com (kmac.watson.ibm.com [9.2.208.86])
	by kitch0.watson.ibm.com (AIX5.3/8.11.6p2/8.11.0/03-06-2002) with ESMTP
	id k5Q8uYW552988
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jun 2006 04:56:34 -0400
Received: from jimix by kmac.watson.ibm.com with local (Exim 4.62)
	(envelope-from <jimix@kmac.watson.ibm.com>) id 1Fumtu-0005ax-Je
	for linuxppc-dev@ozlabs.org; Mon, 26 Jun 2006 04:56:58 -0400
From: Jimi Xenidis <jimix@watson.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Skip the "copy down" of the kernel if it is already at zero.
Message-Id: <E1Fumtu-0005ax-Je@kmac.watson.ibm.com>
Date: Mon, 26 Jun 2006 04:56:58 -0400
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch allows the kernel to recognized that it was loaded at zero
and the copy down of the image is unnecessary.  This is useful for
Simulators and kexec models.
On a typical 3.8 MiB vmlinux.strip this saves about 2.3 million instructions.

---

 arch/powerpc/kernel/head_64.S |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

88f9d7e234b31d5b06decf266414ba2e920ede3e
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index b7d1404..cd57a6b 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -1654,6 +1654,9 @@ _STATIC(__after_prom_start)
 					/*   i.e. where we are running	 */
 					/*	the source addr		 */
 
+	cmpdi	r4,0			/* In some cases the loader may  */
+	beq	.start_here_multiplatform /* have already put us at zero */
+					/* so we can skip the copy.      */
 	LOAD_REG_IMMEDIATE(r5,copy_to_here) /* # bytes of memory to copy */
 	sub	r5,r5,r27
 
-- 
1.3.3
