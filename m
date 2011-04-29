Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14C62B6F72
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Apr 2011 11:18:48 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p3T1ISfT008369
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Apr 2011 11:18:28 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3T1IlFu1536104
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Apr 2011 11:18:47 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p3T1IkiI000570
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Apr 2011 11:18:47 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC/PATCH 3/4] powerpc/udbg: Register udbg console generically
Date: Fri, 29 Apr 2011 11:18:41 +1000
Message-Id: <1304039922-32262-3-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1304039922-32262-1-git-send-email-benh@kernel.crashing.org>
References: <1304039922-32262-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_PPC_EARLY_DEBUG is set, call register_early_udbg_console()
early from generic code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/udbg.c            |    2 ++
 arch/powerpc/platforms/pseries/lpar.c |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index e39cad8..4aada69 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -66,6 +66,8 @@ void __init udbg_early_init(void)
 
 #ifdef CONFIG_PPC_EARLY_DEBUG
 	console_loglevel = 10;
+
+	register_early_udbg_console();
 #endif
 }
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 6f0ed3a..aabe8d7 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -193,8 +193,6 @@ void __init udbg_init_debug_lpar(void)
 	udbg_putc = udbg_putcLP;
 	udbg_getc = udbg_getcLP;
 	udbg_getc_poll = udbg_getc_pollLP;
-
-	register_early_udbg_console();
 }
 
 /* returns 0 if couldn't find or use /chosen/stdout as console */
-- 
1.7.1
