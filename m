Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A71167A64
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Mar 2005 17:47:52 +1100 (EST)
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j2D6jcgJ032621
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Mar 2005 00:45:39 -0600
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Sun, 13 Mar 2005 17:47:09 +1100
Message-Id: <1110696430.19810.105.camel@gaston>
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
Date: Sun, 13 Mar 2005 00:18:38 -0500 (EST)
OK, I've spent most of the day making my poor iBook compile kernels and 
I've tracked down the error.  I can't seem to figure out why it would 
happen on my machine and no one elses, at least unless it's a compiler 
issue (I am using gcc 3.2.2).

Somewhere between 2.6.8-rc1 and 2.6.8-rc2 interrupts just stop getting 
delivered.

I tracked it down to this patch to linux/arch/ppc/syslib/open_pic.c :

  /*
   *  Map an interrupt source to one or more CPUs
   */
-static void openpic_mapirq(u_int irq, u_int physmask, u_int keepmask)
+static void openpic_mapirq(u_int irq, cpumask_t physmask, cpumask_t keepmask)
  {
         if (ISR[irq] == 0)
                 return;
-       if (keepmask != 0)
-               physmask |= openpic_read(&ISR[irq]->Destination) & 
keepmask;
-       openpic_write(&ISR[irq]->Destination, physmask);
+       if (!cpus_empty(keepmask)) {
+               cpumask_t irqdest = { .bits[0] = 
openpic_read(&ISR[irq]->Destination) };
+               cpus_and(irqdest, irqdest, keepmask);
+               cpus_or(physmask, physmask, irqdest);
+       }
+       openpic_write(&ISR[irq]->Destination, cpus_addr(physmask)[0]);
  }

And this one:
-               openpic_mapirq(i, 1<<0, 0);
+               openpic_mapirq(i, CPU_MASK_CPU0, CPU_MASK_NONE);


Using printk's, I can see before the change I properly was writing "1" as 
the second argument to openpic_write, but afterwards it was 0.

It seems as though for some reason CPU_MASK_CPU0 is 0 on my kernel, rather 
than just a 1.

By patching the kernel to force it to write a 1 in openpic_write the 
kernel runs fine...

So, any ideas?  I'll be glad to try out anything else if you'd like me to.

Vince
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
