Return-Path: <vbarshak@ru.mvista.com>
Received: from localhost.localdomain (unknown [93.100.122.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7E5CB6F0C
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 09:22:30 +1100 (EST)
Date: Thu, 26 Nov 2009 00:48:52 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: stop_this_cpu: remove the cpu from the online map.
Message-ID: <20091125214852.GA7912@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the CPU from the online map to prevent smp_call_function
from sending messages to a stopped CPU.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/kernel/smp.c |    3 +++
 1 file changed, 3 insertions(+)

diff -pruN linux-2.6.orig/arch/powerpc/kernel/smp.c linux-2.6/arch/powerpc/kernel/smp.c
--- linux-2.6.orig/arch/powerpc/kernel/smp.c	2009-11-26 00:22:15.000000000 +0300
+++ linux-2.6/arch/powerpc/kernel/smp.c	2009-11-26 00:26:48.000000000 +0300
@@ -218,6 +218,9 @@ void crash_send_ipi(void (*crash_ipi_cal
 
 static void stop_this_cpu(void *dummy)
 {
+	/* Remove this CPU */
+	set_cpu_online(smp_processor_id(), false);
+
 	local_irq_disable();
 	while (1)
 		;
