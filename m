Return-Path: <onramp123@yahoo.com>
Received: from n10.bullet.mail.mud.yahoo.com (n10.bullet.mail.mud.yahoo.com
	[209.191.125.208]) by ozlabs.org (Postfix) with SMTP id 2283EDDFB9
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 16:47:07 +1100 (EST)
From: "Steve DeLaney" <onramp123@yahoo.com>
To: <linuxppc-dev@ozlabs.org>
Subject: RE: mpc8349e-mitx 2.6.25 serial IRQ assigned wrong
Date: Tue, 3 Mar 2009 21:39:19 -0800
Message-ID: <025a01c99c8b$90afb030$6b03a8c0@sdelaney2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: 
Reply-To: onramp123@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 

Here's an update on this issue.  

After verifying the device tree was OK, the OF traces led us to the root
cause.

powerpc irq.c irq_alloc_virt() assigns a virtual IRQ as a function of the
input hardware IRQ hint, AND NUM_ISA_INTERRUPTS.  it turns out that
asm-ppc/irq.h defines NUM_ISA_INTERRUPTS 16, so that the allocated virq
is offset by this amount.  this accounts for the remap shown below for 
i2c and serial device vectors.

I didn't realize before that /proc/interrupts 
serviced by irq.c show_interrupts() displays virtual vector numbers.

For the mpc8349e-mitx this must be incorrect since there is no ISA?
Essentially all that is needed is a 1:1 mapping hirq:virq since
each interrupt source in the system appears to have a unique vector
in the SOC IPIC.  It seems this scheme is needlessly complex, at least for
mpc8349e.

For now we simply define irq.h NUM_ISA_INTERRUPTS 0
but this isn't a complete solution since our PCI device
interrupt on hirq 20, ends up allocated on virq 1.  To force
this to work, the driver does an irq_create_mapping(NULL, 20),
then assigns its own dev->irq=20 before calling request_irq()

I'm sure someone has a more elegant solution but that's what
we've been able to come up with so far.

/steverino2

-----Original Message-----
From: Steve DeLaney [mailto:onramp123@yahoo.com] 
Sent: Saturday, February 28, 2009 8:08 AM
To: 'linuxppc-dev@ozlabs.org'
Subject: mpc8349e-mitx 2.6.25 serial IRQ assigned wrong

 
Hello all,

We completed a 2.6.25 build for MPC8349E-mITX platform, and u-booting using
the device tree under ...boot/dts/mpc8349emitx.dts

But the standard platform device IRQs are assigned wrong under
/proc/interrupts:
16 i2c-mpc
17 i2c-mpc
20 serial

According to the device tree, and the processor data sheet, it should be
like this:
9 serial
14 i2c-mpc
15 i2c-mpc

earlier builds (pre-dating device tree) of 2.6.13 and 2.6.16 are OK.
The IRQs are assigned correctly, with serial on 9.

Oddly enough the serial port works OK even though it is assigned to IRQ 20.
We could probably live with it, but this interferes with our application
that uses PCI.
On MPC8349E-mITX, PIC IRQ 20 is intended for PCI INTA that is input to the
MPC8349E processor on IRQ4* signal.

We turned on debug output in irq.c and prom_parse.c Any idea what might be
going wrong?  We would appreciate any suggestions on what to look for.

/steverino2
