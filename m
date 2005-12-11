Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (sipsolutions.net [66.160.135.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96EB9688D6
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Dec 2005 11:01:10 +1100 (EST)
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1134258468.6989.36.camel@gaston>
References: <1134256279.3810.8.camel@localhost>
	<1134258468.6989.36.camel@gaston>
Content-Type: text/plain
Date: Sun, 11 Dec 2005 01:00:49 +0100
Message-Id: <1134259249.4387.3.camel@localhost>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
Subject: Re: [patch] ppc32: set smp_tb_synchronized on UP with SMP kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ppc32 kernel, when built with CONFIG_SMP and booted on a single CPU
machine, will not properly set smp_tb_synchronized, thus causing
gettimeofday() to not use the HW timebase and to be limited to jiffy
resolution. This, among others, causes unacceptable pauses when
launching X.org.

Signed-Off-By: Johannes Berg <johannes@sipsolutions.net>

--- 

With this patch, X.org startup time goes down from ~30 seconds to normal
(just a second or so). The know-how really comes from BenH who I
discussed with on IRC.

--- linux-2.6.15-rc5.orig/arch/ppc/kernel/smp.c	2005-12-10 23:56:23.026328000 +0100
+++ linux-2.6.15-rc5/arch/ppc/kernel/smp.c	2005-12-11 00:56:53.756328000 +0100
@@ -301,6 +301,10 @@
 
 	/* Probe platform for CPUs: always linear. */
 	num_cpus = smp_ops->probe();
+	
+	if (num_cpus < 2)
+		smp_tb_synchronized = 1;
+	
 	for (i = 0; i < num_cpus; ++i)
 		cpu_set(i, cpu_possible_map);
 
