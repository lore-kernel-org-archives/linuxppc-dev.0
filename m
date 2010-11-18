Return-Path: <sonny@us.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9990AB71B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Nov 2010 06:22:35 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oAIJ0mfq030631
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 14:00:48 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAIJMWUZ459666
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 14:22:32 -0500
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAIJMVaG022515
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 12:22:31 -0700
Received: from us.ibm.com (dyn9414181.austin.ibm.com [9.41.41.81])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	oAIJMVa3022504
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 12:22:31 -0700
Resent-Message-ID: <20101118192231.GK32203@us.ibm.com>
From: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: minor cleanups for machdep.h
Date: Thu, 18 Nov 2010 04:39:23 -0600
Message-Id: <1290076764-3280-1-git-send-email-sonnyrao@linux.vnet.ibm.com>
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

remove stale declaration of setup_pci_ptrs, aparently from ppc before 2.4.0

remove #ifdef around struct existance delcaration

fix spelling of linear

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index d045b01..8433d36 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -27,9 +27,7 @@ struct iommu_table;
 struct rtc_time;
 struct file;
 struct pci_controller;
-#ifdef CONFIG_KEXEC
 struct kimage;
-#endif

 #ifdef CONFIG_SMP
 struct smp_ops_t {
@@ -72,7 +70,7 @@ struct machdep_calls {
 					     int psize, int ssize);
 	void		(*flush_hash_range)(unsigned long number, int local);

-	/* special for kexec, to be called in real mode, linar mapping is
+	/* special for kexec, to be called in real mode, linear mapping is
 	 * destroyed as well */
 	void		(*hpte_clear_all)(void);

@@ -324,8 +322,6 @@ extern sys_ctrler_t sys_ctrler;

 #endif /* CONFIG_PPC_PMAC */

-extern void setup_pci_ptrs(void);
-
 #ifdef CONFIG_SMP
 /* Poor default implementations */
 extern void __devinit smp_generic_give_timebase(void);
-- 
1.5.6.5
