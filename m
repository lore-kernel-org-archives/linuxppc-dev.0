Return-Path: <sonny@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53394B71AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Nov 2010 06:22:19 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAIJ0dsv004259
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 14:00:39 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAIJMF61462670
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 14:22:15 -0500
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAIJMEK6022155
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 12:22:14 -0700
Received: from us.ibm.com (dyn9414181.austin.ibm.com [9.41.41.81])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	oAIJMEAq022079
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 12:22:14 -0700
Resent-Message-ID: <20101118192213.GI32203@us.ibm.com>
From: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] Powerpc: separate CONFIG_RELOCATABLE from CONFIG_CRASHDUMP in
	boot code
Date: Thu, 18 Nov 2010 04:35:07 -0600
Message-Id: <1290076507-3181-1-git-send-email-sonnyrao@linux.vnet.ibm.com>
Cc: Sonny Rao <sonnyrao@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix head_64.S so that we can build a relocatable kernel
that isn't necessarily a crash-dump kernel

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/head_64.S |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index f0dd577..53b098f 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -96,7 +96,7 @@ __secondary_hold_acknowledge:
 	.llong hvReleaseData-KERNELBASE
 #endif /* CONFIG_PPC_ISERIES */

-#ifdef CONFIG_CRASH_DUMP
+#ifdef CONFIG_RELOCATABLE
 	/* This flag is set to 1 by a loader if the kernel should run
 	 * at the loaded address instead of the linked address.  This
 	 * is used by kexec-tools to keep the the kdump kernel in the
@@ -384,12 +384,10 @@ _STATIC(__after_prom_start)
 	/* process relocations for the final address of the kernel */
 	lis	r25,PAGE_OFFSET@highest	/* compute virtual base of kernel */
 	sldi	r25,r25,32
-#ifdef CONFIG_CRASH_DUMP
 	lwz	r7,__run_at_load-_stext(r26)
-	cmplwi	cr0,r7,1	/* kdump kernel ? - stay where we are */
+	cmplwi	cr0,r7,1	/* flagged to stay where we are ? */
 	bne	1f
 	add	r25,r25,r26
-#endif
 1:	mr	r3,r25
 	bl	.relocate
 #endif
-- 
1.5.6.5
