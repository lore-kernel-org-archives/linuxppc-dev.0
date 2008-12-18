Return-Path: <brking@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 93455DDF26
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 08:14:54 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBILDwY1029633
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 16:13:58 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBILEoIT193648
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 16:14:50 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBILEnhw017025
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 16:14:50 -0500
Message-Id: <200812182114.mBILEmQY016988@d01av01.pok.ibm.com>
Subject: [PATCH 1/2] powerpc: Disable Collaborative Memory Manager for kdump
To: paulus@samba.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 18 Dec 2008 15:13:46 -0600
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


When running Active Memory Sharing, the Collaborative Memory
Manager (CMM) may mark some pages as "loaned" with the hypervisor.
Periodically, the CMM will query the hypervisor for a loan request,
which is a single signed value. When kexec'ing into a kdump kernel,
the CMM driver in the kdump kernel is not aware of the pages the
previous kernel had marked as "loaned", so the hypervisor and the
CMM driver are out of sync. This results in the CMM driver getting
a negative loan request, which can then get treated as a large unsigned
value and can cause kdump to hang due to the CMM driver inflating too
large. Since there really is no clean way for the CMM driver in the kdump
kernel to clean this up, simply disable CMM in the kdump kernel. This
fixes hangs we were seeing doing kdump with AMS.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/pseries/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/powerpc/platforms/pseries/Kconfig~powerpc_cmm_no_kdump arch/powerpc/platforms/pseries/Kconfig
--- linux-2.6/arch/powerpc/platforms/pseries/Kconfig~powerpc_cmm_no_kdump	2008-12-17 09:52:54.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/Kconfig	2008-12-17 09:52:54.000000000 -0600
@@ -54,7 +54,7 @@ config PPC_SMLPAR
 
 config CMM
 	tristate "Collaborative memory management"
-	depends on PPC_SMLPAR
+	depends on PPC_SMLPAR && !CRASH_DUMP
 	default y
 	help
 	  Select this option, if you want to enable the kernel interface
_
