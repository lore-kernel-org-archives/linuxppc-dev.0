Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5428467A73
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Mar 2005 18:50:41 +1100 (EST)
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j2D7mQgJ001461
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Mar 2005 01:48:29 -0600
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Sun, 13 Mar 2005 18:49:56 +1100
Message-Id: <1110700196.5787.114.camel@gaston>
Mime-Version: 1.0
Subject: [Fwd: Re: hda: lost interrupt starting with 2.6.8]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-------- Forwarded Message --------
From: Vince Weaver <vince@deater.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: debian-powerpc@lists.debian.org <debian-powerpc@lists.debian.org>
Subject: Re: hda: lost interrupt starting with 2.6.8
Date: Sun, 13 Mar 2005 02:46:37 -0500 (EST)
> Can you tell me what is the value of CONFIG_NR_CPUS in your .config,
> also, is this file including include/linux/threads.h before
> include/linux/cpumask.h, and finally, send me privately the resulting
> binary vmlinux.

There is no CONFIG_NR_CPUS in my .config.  Is that a problem?  My tree is 
a 2.6.4 tree that was patched incrementally, with "make oldconfig" run at 
each release.

With the following patch I've managed to get 2.6.11 to boot on my 
iBook2...  do you still want a copy of a broken vmlinux?

Vince

--- linux/arch/ppc/syslib/open_pic.c.2.6.11	2005-03-13 01:57:00.000000000 -0500
+++ linux/arch/ppc/syslib/open_pic.c	2005-03-13 01:58:17.000000000 -0500
@@ -313,6 +313,7 @@
  	u_int t, i;
  	u_int timerfreq;
  	const char *version;
+	cpumask_t cpu0=CPU_MASK_CPU0;

  	if (!OpenPIC_Addr) {
  		printk("No OpenPIC found !\n");
@@ -405,7 +406,7 @@
  		openpic_initirq(i, 8, i+offset, (sense & IRQ_POLARITY_MASK),
  				(sense & IRQ_SENSE_MASK));
  		/* Processor 0 */
-		openpic_mapirq(i, CPU_MASK_CPU0, CPU_MASK_NONE);
+		openpic_mapirq(i, cpu0, CPU_MASK_NONE);
  	}

  	/* Init descriptors */
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
