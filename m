Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7DF56DDE2D
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 06:41:58 +1000 (EST)
Date: Mon, 13 Aug 2007 22:41:55 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH, RFC] wake up from a serial port
In-Reply-To: <20070813155734.GB17535@ld0162-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.60.0708132207530.5643@poirot.grange>
References: <Pine.LNX.4.60.0708130015430.3895@poirot.grange>
	<20070813155734.GB17535@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org,
	Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 13 Aug 2007, Scott Wood wrote:

> On Mon, Aug 13, 2007 at 12:27:30AM +0200, Guennadi Liakhovetski wrote:
> > A number of Linkstation models from Buffalo Technology with PPC, ARM, and 
> > also MIPS (I think) CPUs have a power-management controller connected to a 
> > UART. Among other things that chip controlls power and reset buttons. 
> > Working on a standby support for one of these systems (ppc mpc8241 based), 
> > the only suitable wakeup source there is the power button, which means, I 
> > have to configure one of the two system UARTs to not be suspendsd. Using 
> > the device_*_wakeup API doesn't quite work because both serial ports share 
> > one device. The below patch proposes a new port flag UPF_MAY_WAKEUP to 
> > configure such UARTs. It also adds support for a new "can-wakeup" serial 
> > node property to the legacy_serial driver.
> 
> Shouldn't the ability to wakeup be configured through sysfs, rather than
> encoded into the device tree?  I'm assuming this is just a matter of
> configuration, and not that the hardware supports waking from one and not
> the other.

Well, sort of. One of them is more "natural" - it has a button on the 
front panel, to use the other one you have to modify the hardware. 
However, I like the idea - generally it does seem to be a better approach 
to have it run-time configurable over sysfs... Only - how? The only 
differentitaion ATM between the two ports are these two links:

# ls -l /sys/devices/platform/serial8250.0/tty*
lrwxrwxrwx 1 root root 0 Aug 13 22:05 /sys/devices/platform/serial8250.0/tty:ttyS0 -> ../../../class/tty/ttyS0
lrwxrwxrwx 1 root root 0 Aug 13 22:05 /sys/devices/platform/serial8250.0/tty:ttyS1 -> ../../../class/tty/ttyS1

And placing some wakeup file under the class/tty/ directory doesn't seem 
very consistent with the current policy - until now they only live under 
devices/... (Greg added to cc:).

Actually, it is good you replied, Scott:-) I wanted to ask you about the 
following: I've switched to your generic suspend/resume routines using the 
_TLF_NAPPING bit, the arch_suspend_{dis,en}able_irqs() hooks... On wakeup 
your _TLF_NAPPING trick should bypass calling the ISR and jump directly to 
the resume code. However, on wakeup, it looks like I do get the wakeup 
interrupt too. Is it the correct behaviour and is this the (approximately) 
correct explanation why:

1. the AVR connected to ttyS0 sends 1 byte on button press and 1 byte on 
button release. So, normally you would get 2 bytes and 2 interupts for one 
such button down-up.

2. Interrupt is configured as edge (is it correct - haven't found in 
mpc8245um, UARTs are usually edge), so, 

--- button down -> byte #1 -> IRQ line active -> IC interrupts
--- on resume interrupts are disabled, an EOI is performed (the line is 
	still active)
--- interrupts are re-enabled 

3. a second interrupt for the same byte is delivered.

I'm just trying to understand whether this is the correct and expected 
behaviour or something is wrong here.

Thanks
Guennadi
---
Guennadi Liakhovetski
