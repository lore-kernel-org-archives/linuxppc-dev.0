Return-Path: <pochini@shiny.it>
Received: from vsmtp2alice.tin.it (vsmtp2alice.tin.it [212.216.176.142])
	by ozlabs.org (Postfix) with ESMTP id BD05F685E6
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2005 08:13:27 +1100 (EST)
Received: from Jay (82.54.120.45) by vsmtp2alice.tin.it (7.2.060.1)
	id 4363086F00056D8D for linuxppc-dev@ozlabs.org;
	Mon, 31 Oct 2005 22:13:21 +0100
Date: Mon, 31 Oct 2005 21:11:48 +0000
From: Giuliano Pochini <pochini@shiny.it>
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Message-Id: <20051031211148.240d0c28.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: enabling/disabling CPUs Kconfig bug
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The option Processor-->Support for enabling/disabling CPUs should require
Platform options-->Power Management support to be enabled, otherwise compile
fails. I'm not sure if this patch is right or if the problem is somewhere else.


Signed-off-by Giuliano Pochini <pochini@shiny.it>

--- arch/ppc/Kconfig__orig	2005-10-30 17:19:17.000000000 +0000
+++ arch/ppc/Kconfig	2005-10-30 17:19:59.000000000 +0000
@@ -263,7 +263,7 @@
 
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
-	depends on SMP && HOTPLUG && EXPERIMENTAL && PPC_PMAC
+	depends on SMP && HOTPLUG && EXPERIMENTAL && PPC_PMAC && PM
 	---help---
 	  Say Y here to be able to disable and re-enable individual
 	  CPUs at runtime on SMP machines.


--
Giuliano.
