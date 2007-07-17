Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F092EDDEF6
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 04:32:59 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6HIWusx019980
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 14:32:56 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6HIWrUi247302
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:53 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6HIWnM2013726
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:49 -0600
Received: from [9.10.86.36] (weaponx.rchland.ibm.com [9.10.86.36])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l6HIWnPl013699
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 12:32:49 -0600
Message-Id: <20070717182621.722340000@linux.vnet.ibm.com>>
References: <20070717181547.310201000@linux.vnet.ibm.com>>
Date: Tue, 17 Jul 2007 13:15:54 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 07/14] Fix 40x build
In-Reply-To: <20070717181547.310201000@linux.vnet.ibm.com>>
Content-Type: text/plain
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
