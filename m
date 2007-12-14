Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 850A3DE03E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 15:52:16 +1100 (EST)
Date: Thu, 13 Dec 2007 22:52:10 -0600 (CST)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/6] init_decrementer_clockevent can be static __init
In-Reply-To: <mm-cpu-0@bga.com>
Message-Id: <mm-cpu-2@bga.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

as its only called from time_init, which is __init.

Also remove unneeded forward declaration.

Signed-off-by: Milton Miller <miltonm@bga.com>
---

Index: kernel/arch/powerpc/kernel/time.c
===================================================================
--- kernel.orig/arch/powerpc/kernel/time.c	2007-12-13 17:46:59.000000000 -0600
+++ kernel/arch/powerpc/kernel/time.c	2007-12-13 17:56:37.000000000 -0600
@@ -117,7 +117,6 @@ static struct clock_event_device decreme
 };
 
 static DEFINE_PER_CPU(struct clock_event_device, decrementers);
-void init_decrementer_clockevent(void);
 static DEFINE_PER_CPU(u64, decrementer_next_tb);
 
 #ifdef CONFIG_PPC_ISERIES
@@ -836,7 +835,7 @@ static void register_decrementer_clockev
 	clockevents_register_device(dec);
 }
 
-void init_decrementer_clockevent(void)
+static void __init init_decrementer_clockevent(void)
 {
 	int cpu = smp_processor_id();
 
