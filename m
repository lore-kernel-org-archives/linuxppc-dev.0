Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D35A2DDEF5
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 07:14:24 +1000 (EST)
Date: Mon, 13 Aug 2007 23:14:22 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH, RFC] wake up from a serial port
In-Reply-To: <46C0C419.6060009@freescale.com>
Message-ID: <Pine.LNX.4.60.0708132307200.5643@poirot.grange>
References: <Pine.LNX.4.60.0708130015430.3895@poirot.grange>
	<20070813155734.GB17535@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.60.0708132207530.5643@poirot.grange>
	<46C0C419.6060009@freescale.com>
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

> Guennadi Liakhovetski wrote:
> > 
> > # ls -l /sys/devices/platform/serial8250.0/tty*
> > lrwxrwxrwx 1 root root 0 Aug 13 22:05
> > /sys/devices/platform/serial8250.0/tty:ttyS0 -> ../../../class/tty/ttyS0
> > lrwxrwxrwx 1 root root 0 Aug 13 22:05
> > /sys/devices/platform/serial8250.0/tty:ttyS1 -> ../../../class/tty/ttyS1
> > 
> > And placing some wakeup file under the class/tty/ directory doesn't seem
> > very consistent with the current policy - until now they only live under
> > devices/... (Greg added to cc:).
> 
> Hmm... I'd assumed each port would have its own device directory.  Would
> anything break horribly if it were changed so that each tty:ttySx is a
> directory, which contains both a wakeup file and the symlink?

Yeah, I'd love to know the answer too:-) As you see, atm it is one 
platform device as defined in arch/powerpc/kernel/legacy_serial.c:

static struct platform_device serial_device = {
	.name	= "serial8250",
	.id	= PLAT8250_DEV_PLATFORM,
	.dev	= {
		.platform_data = legacy_serial_ports,
	},
};

with a list of ports in platform data:

static struct plat_serial8250_port legacy_serial_ports[MAX_LEGACY_SERIAL_PORTS+1];

Hence one device directory. Same on a PC

$ ls -l /sys/devices/platform/serial8250/tty*
lrwxrwxrwx  1 root root 0 Aug 13 23:10 /sys/devices/platform/serial8250/tty:ttyS0 -> ../../../class/tty/ttyS0
lrwxrwxrwx  1 root root 0 Aug 13 23:10 /sys/devices/platform/serial8250/tty:ttyS1 -> ../../../class/tty/ttyS1
lrwxrwxrwx  1 root root 0 Aug 13 23:10 /sys/devices/platform/serial8250/tty:ttyS2 -> ../../../class/tty/ttyS2
lrwxrwxrwx  1 root root 0 Aug 13 23:10 /sys/devices/platform/serial8250/tty:ttyS3 -> ../../../class/tty/ttyS3

> You should get the interrupt, but not until after the PM code enables IRQs.
> Are you saying that the interrupt handler runs before then?

Great, it is working correctly then! Don't think the ISR runs return from 
PM, no.

Thanks
Guennadi
---
Guennadi Liakhovetski
