Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62EC4DDEC6
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 23:58:52 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6BDwm32000500
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 09:58:48 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6BDwmr8250788
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:58:48 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6BDwleo007603
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:58:47 -0600
Subject: [RFC][PATCH 5/8] Fix 4xx build
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 11 Jul 2007 08:58:46 -0500
Message-Id: <1184162326.32199.63.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove inclusion of __res on 40x.  We don't need it in arch/powerpc

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/kernel/head_4xx.S  |    1 -
 arch/powerpc/kernel/ppc_ksyms.c |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.orig/arch/powerpc/kernel/ppc_ksyms.c
+++ linux-2.6/arch/powerpc/kernel/ppc_ksyms.c
@@ -180,7 +180,7 @@ EXPORT_SYMBOL(cacheable_memcpy);
 EXPORT_SYMBOL(cpm_install_handler);
 EXPORT_SYMBOL(cpm_free_handler);
 #endif /* CONFIG_8xx */
-#if defined(CONFIG_8xx) || defined(CONFIG_40x)
+#if defined(CONFIG_8xx)
 EXPORT_SYMBOL(__res);
 #endif
 
--- linux-2.6.orig/arch/powerpc/kernel/head_4xx.S
+++ linux-2.6/arch/powerpc/kernel/head_4xx.S
@@ -35,7 +35,6 @@
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
-#include <asm/ibm4xx.h>
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
