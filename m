Return-Path: <tnt@246tNt.com>
Received: from outmx015.isp.belgacom.be (outmx015.isp.belgacom.be
	[195.238.2.87]) by ozlabs.org (Postfix) with ESMTP id A04022BE83
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Dec 2004 01:26:44 +1100 (EST)
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
	by outmx015.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id iBGEQb8t030724
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2004 15:26:37 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from ayanami.246tNt.com (238.232-200-80.adsl.skynet.be
	[80.200.232.238])
	by outmx015.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id iBGEQZMt030697
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2004 15:26:35 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from [10.0.0.245] (246tNt-laptop.lan.ayanami.246tNt.com [10.0.0.245])
	by ayanami.246tNt.com (Postfix) with ESMTP id E2F9A1649A4
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2004 15:25:32 +0100 (CET)
Message-ID: <41C19B1B.1050202@246tNt.com>
Date: Thu, 16 Dec 2004 15:26:35 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [RFC][PATCH] Adds support for PF_FREEZE on ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

While trying to use the /sys/power interface on a ppc target,
I noticed that the processes didn't freeze. Apparently, since
that interface was never used on ppc beforce, signal.c didn't handle the
signal.

The patch below fixes that for me.


Sylvain


Signed-Off-By: Sylvain Munaut <tnt@246tNt.com>


===== arch/ppc/kernel/signal.c 1.40 vs edited =====
--- 1.40/arch/ppc/kernel/signal.c       2004-10-28 09:39:49 +02:00
+++ edited/arch/ppc/kernel/signal.c     2004-12-01 09:25:55 +01:00
@@ -24,6 +24,7 @@
 #include <linux/wait.h>
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
+#include <linux/suspend.h>
 #include <linux/stddef.h>
 #include <linux/elf.h>
 #include <linux/tty.h>
@@ -616,6 +617,11 @@

        if (!oldset)
                oldset = &current->blocked;
+
+       if (current->flags & PF_FREEZE) {
+               refrigerator(0);
+               return 0;
+       }

        newsp = frame = 0;
