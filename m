Message-ID: <16763.216.110.51.8.1078873137.squirrel@www.orkun.us>
Date: Tue, 9 Mar 2004 16:58:57 -0600 (CST)
Subject: PPC405GP: Spurious interrupt during handing level triggered
     interrupts
From: "listmember@orkun.us" <listmember@orkun.us>
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
References: 
In-Reply-To: 
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cogent CSB272 (PPC405GP)
U-Boot 1.0.2  (CVS)
Linux 2.4.25-pre4 snapshot from linuxppc-2.4 BK tree (via rsync)
There are a couple of minor patches for getting Linux working with U-Boot.

I am working with an I2C device which notifies certain events via
interrupt. It holds the irq line low until its status register is read and
and interrupt is cleared at the device. There can be multiple I2C devices
of this type on the same IRQ (wire-ored).

Because, I2C is too slow, we do not clear he interrupt (at the device) at
kernel space. I've written a simple device driver so user process can be
notified of events using select() and handle the event in the user daemon.

The interrupt handler basically:

- disables the interrupts on the particular line via disable_irq()
- wakes up the process sleeping on select()
- returns from the handler routine.

User process then wakes up, communicates with i2c devices to find out
which one has a pending event and clears the event and re-enables the
interrupt on the particular line by making an ioctl call.

Now I am getting an extra spurious interrupt after I re-enable interrupts
after the interrupting device de-asserted the interrupt request.

My understanding is the following is happening:

- Interrupt is asserted
- Linux executes prolog code and acks interrupt
- Since the interrupt is level triggered, this ack is no-op
- ISR entered and disables the interrupt
- Interrupt is de-assered by "user" code
- Interrupt is re-enabled via ioctl
- However PPC405 had already latched IRQ so PPC405 UIC0_SR bit is still set.
- Because of UIC0_SR bit still set, another ISR braching is taken
- Linux ACK the interrupt (UICO_SR bit is now clear)
- ISR entered and disables the interrupt
- "user" code cannot locate any interrupting device.
- Interrupt is de-assered by ioctl and interrupts is re-enabled.

I think my problem is similar to what is described here:

http://lists.linuxppc.org/linuxppc-embedded/200306/msg00123.html

Now, to prevent the second spurious branching, I used ack_irq() call
(actuall macro) to manually ack the interrupt (before enabling interrupts
again in ioctl). It works this way.

Is this OK to use or is there a preferred way to do this?

Best regards,
Tolunay

Note: I know this will probably would not be an issue if I changed to edge
triggering but I am concerned about lost interrupts when using edge
triggers especially when I have multiple I2C devices on the same irq line.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
