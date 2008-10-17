Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75C5EDDEED
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 11:10:22 +1100 (EST)
Subject: RE: Problems with PCI-E devices not being detected with switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <AymanE@tanisys.com>
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F822@tanisys-ex2.Tanisys.Local>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
	<1224134422.8157.549.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F822@tanisys-ex2.Tanisys.Local>
Content-Type: text/plain
Date: Fri, 17 Oct 2008 11:10:09 +1100
Message-Id: <1224202209.7654.36.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-16 at 10:01 -0500, Ayman El-Khashab wrote:
> Benjamin Herrenschmidt wrote:
> > On Wed, 2008-10-15 at 10:47 -0500, Ayman El-Khashab wrote:
> > 
> > Note for people on CC: This is a problem on 460EX on a canyonland
> > using the 4x port. 
> > 
> >> The problem occurs when Linux boots. It sees the switch (and looking
> >> in /sys/bus/... confirms it), but nothing on the downstream sides of
> >> the switch (secondary busses) is visible.  There were no boot
> >> messages to indicate it had seen the Sil 3531 and it doesn't
> >> function.  We've also tried other PCI-E devices (NI GPIB) on the
> >> downstream side and they are also not detected, so it seems to be
> >> something in Linux, my configuration, etc.  I've included the boot
> >> messages below from u-boot and the kernel.  It is more than just the
> >> pci boot messages, but I was not sure if something else in the log
> >> with provide some insight. 
> > 
> > The messages below look really fishy indeed:

Ok, can you send me a full dmesg log with "debug" on the kernel command
line after adding a #define DEBUG 1 to the top of drivers/pci/probe.c
please ? (before the batch of #include).

The generic code is _supposed_ to somewhat figure out that bridges
haven't been setup by the firmware and fix that up, but for some reason
it's not happening I think. Or something else is wrong ...

Stefan, I could use the same log from your customer too.

Thanks,
Ben.
