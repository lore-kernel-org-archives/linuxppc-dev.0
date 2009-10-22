Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.222])
	by ozlabs.org (Postfix) with ESMTP id 663B7B7D52
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 08:04:52 +1100 (EST)
Received: from neli.hopto.org (unknown [88.159.210.133])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id EF716122393
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Oct 2009 22:43:18 +0200 (CEST)
Received: from conroe.local ([90.0.0.126] ident=micha)
	by neli.hopto.org with esmtp (Exim 4.63)
	(envelope-from <micha@neli.hopto.org>) id 1N14VC-00087V-BH
	for linuxppc-dev@lists.ozlabs.org; Thu, 22 Oct 2009 22:43:18 +0200
Message-ID: <4AE0C33A.10804@neli.hopto.org>
Date: Thu, 22 Oct 2009 22:40:26 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Guarded load and bus error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm working on a MPC8548 processor, using its RapidIO bus. I have two 
kernel trees ported for a board, a linux 2.6.24-ppc, and a linux-2.6.31 
(powerpc) kernel. I don't think this bus behaviour is RapidIO specific 
though, as also the PCI bus and local bus must handle malfunctioning 
devices. The HID1[RFXE] bit is enabled.

To test bus error behaviour, I'm doing reads from mapped (RapidIO) I/O 
memory (mapped cache-inhibited, guarded). 32 bit aligned accesses are 
working fine, so the setup is good. A RapidIO error handler is installed 
(error/port-write interrupt) which printks some error bits from the 
RapidIO error registers and resets them. Now I'm provoking bus errors by:

1) reading from a RapidIO device that does not exist: a timeout is asserted
2) reading from an unaligned address

The MPC8548ERM mentions that interrupt latency is indeterminate for 
guarded loads. From this I conclude that the processor stalls until it 
receives data from the bus: it is not interruptable (machine check, 
interrupts or critical interrupts). However the following behaviour is seen:

Linux 2.6.24 ppc:
For 1) my application gets a SIGBUS, after this, the error interrupt is 
run reporting a packet timeout: good.
For 2) the kernel OOPSes while running do_IRQ, getting irq number. The 
kernel is not interrupt mode though: my application is killed and I may 
continue.

Linux 2.6.31 powerpc:
For 1) first some interrupt runs (apparantly), the machine check handler 
prints a stack trace showing do_IRQ and retrieving the irq number. The 
kernel in this instance detects it's running an interrupt and panic's 
and resets immediately.
For 2) things are even worse ;-).

The case 1) may be "solved" by disabling my own RapidIO error interrupt 
handling (I think that's the IRQ about to be executed, but the kernel 
hasn't gotten far enough to read the proper registers to tell me). If 
the error interrupt is disabled, then the application is killed. 
Behaviour seems proper; except I can't print my (diagnostic) errors.

With this "fix" though, the case 2) proceeds as follows: the kernel 
OOPSes in the machine check handler with the stack trace showing it's 
executing instructions in the softirq handler. The softirq process is 
killed (I assume). After this my application may continue, and I think 
it retries the I/O read because (after timeout) the machine check OOPSes 
again, this time showing a timer interrupt in progress (which is trying 
to wake the softirq process), thereby panic'ing and resetting the board.

If I "mangle" the machine check handler to print RapidIO error registers 
and return immediately always, then the behaviour is that I keep getting 
machine checks printing 'packet timeout' and/or 'illegal field in 
packet' ... apparantly the I/O operation is retried again and again. Not 
particularly nice for a so called "guarded load".

To verify the "guarded load" being really guarded, I set the timeout to 
maximum (~5 seconds), and tried to read from a non-existing device. 
Under these circumstances, the board is not pingable anymore, and telnet 
sessions to it are dead. These come back to life when the timeout has 
passed and a SIGBUS has killed the test application.

So, the guarded load does really seem to block external interrupts (at 
least timer and ethernet), but on the other hand I'm seeing inconsistent 
stack traces during the machine check handling (as the last instruction 
was in user space, I shouldn't be seeing stack traces down the kernel, 
softirq or where else).

The HID0 and HID1 registers are equal in the two kernels (except the 
2.6.31 sets DOZE mode, but disabling that had no effect).

How is it possible that behaviour differs between these two kernels?

How can I get my desired behaviour that my application is killed with a 
SIGBUS, and the rest of the kernel keeps running properly?

Thanks in advance for any insight,

Micha Nelissen
