From: benh@kernel.crashing.org
To: Harald Welte <laforge@gnumonks.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.18-ben0 on G4 SMP: do_IRQ waiting for irq lock
Date: Fri, 8 Mar 2002 19:34:09 +0100
Message-Id: <20020308183409.25542@mailhost.mipsys.com>
In-Reply-To: <20020308090750.W6936@sunbeam.de.gnumonks.org>
References: <20020308090750.W6936@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I've tried to run 2.4.18-ben0 on my G4 SMP (dual 450 MHz) box.
>
>I've tried both, a kernel with all IRQ's routed to CPU0 - and a kernel
>where both CPU's can handle IRQ's.

For some yet unknown reason, letting interrupts be distributed on all
CPUs will cause occasional lockups on dual G4s. However, with interrupts
routed to CPU0, I have the machine running rock solid here.

>Unfortunately in both kernel images, I don't even get past all init scripts,
>at some (random) point during bootup:
>
>do_IRQ waiting for irq lock (holder=1)
>
>occurs.
>
>Any idea what's causing the problem?  I've already tried to boot in
>single user mode - and it's working fine.  Then I've started every single
>init script in /etc/rc2.d (it's debian) by hand - and the problem didn't
>occur.
>
>Am I right assuming that there is a deadlock where one CPU is holding
>the IRQ lock while the other wants to grab it?
>
>And how could this happen on a kernel where all IRQ's are routed to one
>CPU ??

Could be a driver bug showing up, difficult to say. The problem definitely
doesn't happen here (dual G4 450Mhz, 2x7400 CPU with highmem). The fact that
the IRQ lock can be held by the other CPU is normal though, both CPUs don't
take external IRQs but decrementer ones for example happen on both.

That said, I don't know what is causing your problem.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
