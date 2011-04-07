Return-Path: <anton@samba.org>
Date: Thu, 7 Apr 2011 21:54:07 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] rtas: Only sleep in rtas_busy_delay if we have useful work
	to do
Message-ID: <20110407215407.4f6ca50f@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: nacc@us.ibm.com, linuxppc-dev@lists.ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


RTAS returns extended error codes as a hint of how long the
OS might want to wait before retrying a call. If we have nothing
else useful to do we may as well call back straight away.

This was found when testing the new dynamic dma window feature.
Firmware split the zeroing of the TCE table into 32k chunks but
returned 9901 (which is a suggested wait of 10ms). All up this took
about 10 minutes to complete since msleep is jiffies based and will
round 10ms up to 20ms.

With the patch below we take 3 seconds to complete the same test.
The hint firmware is returning in the RTAS call should definitely
be decreased, but even if we slept 1ms each iteration this would
take 32s.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/rtas.c	2011-04-05 11:19:35.023234011 +1000
+++ linux-2.6/arch/powerpc/kernel/rtas.c	2011-04-07 21:25:24.646414629 +1000
@@ -494,7 +494,7 @@ unsigned int rtas_busy_delay(int status)
 
 	might_sleep();
 	ms = rtas_busy_delay_time(status);
-	if (ms)
+	if (ms && need_resched())
 		msleep(ms);
 
 	return ms;
