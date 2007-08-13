Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D4FDADDF2A
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Aug 2007 01:57:45 +1000 (EST)
Date: Mon, 13 Aug 2007 10:57:34 -0500
From: Scott Wood <scottwood@freescale.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH, RFC] wake up from a serial port
Message-ID: <20070813155734.GB17535@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.60.0708130015430.3895@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0708130015430.3895@poirot.grange>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 13, 2007 at 12:27:30AM +0200, Guennadi Liakhovetski wrote:
> A number of Linkstation models from Buffalo Technology with PPC, ARM, and 
> also MIPS (I think) CPUs have a power-management controller connected to a 
> UART. Among other things that chip controlls power and reset buttons. 
> Working on a standby support for one of these systems (ppc mpc8241 based), 
> the only suitable wakeup source there is the power button, which means, I 
> have to configure one of the two system UARTs to not be suspendsd. Using 
> the device_*_wakeup API doesn't quite work because both serial ports share 
> one device. The below patch proposes a new port flag UPF_MAY_WAKEUP to 
> configure such UARTs. It also adds support for a new "can-wakeup" serial 
> node property to the legacy_serial driver.

Shouldn't the ability to wakeup be configured through sysfs, rather than
encoded into the device tree?  I'm assuming this is just a matter of
configuration, and not that the hardware supports waking from one and not
the other.

-Scott
