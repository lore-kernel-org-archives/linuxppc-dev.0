Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 470AEDDEDA
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2007 02:33:17 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l73GXD7V017188
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 12:33:13 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l73GXDpR210700
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 10:33:13 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l73GXDeN030775
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Aug 2007 10:33:13 -0600
Message-Id: <20070803161711.059388000@linux.vnet.ibm.com>>
References: <20070803160900.069522000@linux.vnet.ibm.com>>
Date: Fri, 03 Aug 2007 11:09:07 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [patch 07/10] Fix 40x build
In-Reply-To: <20070803160900.069522000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
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
 arch/powerpc/kernel/head_40x.S  |    1 -
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
 
--- linux-2.6.orig/arch/powerpc/kernel/head_40x.S
+++ linux-2.6/arch/powerpc/kernel/head_40x.S
@@ -35,7 +35,6 @@
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
-#include <asm/ibm4xx.h>
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>

-- 
