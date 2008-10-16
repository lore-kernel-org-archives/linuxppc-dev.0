Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B99BDDF20
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 16:20:35 +1100 (EST)
Subject: Re: Problems with PCI-E devices not being detected with switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <AymanE@tanisys.com>
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
Content-Type: text/plain
Date: Thu, 16 Oct 2008 16:20:22 +1100
Message-Id: <1224134422.8157.549.camel@pasglop>
Mime-Version: 1.0
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org,
	Victor Gallardo <vgallardo@amcc.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-15 at 10:47 -0500, Ayman El-Khashab wrote:

Note for people on CC: This is a problem on 460EX on a canyonland using
the 4x port.

> The problem occurs when Linux boots. It sees the switch (and looking
> in /sys/bus/... confirms it), but nothing on the downstream sides of
> the switch (secondary busses) is visible.  There were no boot messages
> to indicate it had seen the Sil 3531 and it doesn't function.  We've 
> also tried other PCI-E devices (NI GPIB) on the downstream side and
> they are also not detected, so it seems to be something in Linux, my
> configuration, etc.  I've included the boot messages below from u-boot
> and the kernel.  It is more than just the pci boot messages, but I was
> not sure if something else in the log with provide some insight.

The messages below look really fishy indeed:

> pci 0001:02:00.0: unknown header type 03, ignoring device
> pci 0001:02:01.0: unknown header type 41, ignoring device
> pci 0001:02:02.0: unknown header type 03, ignoring device
> pci 0001:02:03.0: unknown header type 41, ignoring device
> pci 0001:02:04.0: ignoring class 1d09 (doesn't match header type 02)
> pci 0001:02:05.0: unknown header type 41, ignoring device
> pci 0001:02:06.0: ignoring class 1d09 (doesn't match header type 02)
> pci 0001:02:07.0: unknown header type 41, ignoring device
> pci 0001:02:08.0: unknown header type 03, ignoring device
> pci 0001:02:09.0: unknown header type 41, ignoring device
> pci 0001:02:0a.0: ignoring class 7d09 (doesn't match header type 02)
> pci 0001:02:0b.0: unknown header type 41, ignoring device
> pci 0001:02:0c.0: ignoring class 1d01 (doesn't match header type 02)
> pci 0001:02:0d.0: unknown header type 41, ignoring device
> pci 0001:02:0e.0: ignoring class 7d09 (doesn't match header type 02)
> pci 0001:02:0f.0: unknown header type 41, ignoring device
> pci 0001:02:10.0: unknown header type 03, ignoring device
> pci 0001:02:11.0: unknown header type 41, ignoring device
> pci 0001:02:12.0: unknown header type 03, ignoring device
> pci 0001:02:13.0: unknown header type 41, ignoring device
> pci 0001:02:14.0: unknown header type 03, ignoring device
> pci 0001:02:15.0: unknown header type 41, ignoring device
> pci 0001:02:16.0: ignoring class 3d09 (doesn't match header type 02)
> pci 0001:02:17.0: unknown header type 41, ignoring device
> pci 0001:02:18.0: unknown header type 03, ignoring device
> pci 0001:02:19.0: unknown header type 41, ignoring device
> pci 0001:02:1a.0: unknown header type 03, ignoring device
> pci 0001:02:1b.0: unknown header type 41, ignoring device
> pci 0001:02:1c.0: ignoring class 5d01 (doesn't match header type 02)
> pci 0001:02:1d.0: unknown header type 41, ignoring device
> pci 0001:02:1e.0: unknown header type 03, ignoring device
> pci 0001:02:1f.0: unknown header type 41, ignoring device

Stefan, do you reckon it could be that we aren't leaving enough time
for the things behind the switch to initialize ? Or could there be
a subtle kernel bug here ? It looks to me that config space
access behind the switch is broken.

Ayman, can you try adding a long delay (such as msleep(5000), ie 5s)
at the beginning of pcibios_init() in arch/powerpc/kernel/pci_32.c ?
This will add 5s delay between the init/reset of the port and the
probing by linux. Do that help ?

Stefan, shouldn't we find a nice way to avoid the whole port reset and
reconfiguration of the HW also when uboot already did a good enough job,
maybe via some device-tree property ? It would also significantly speed
up boot times.

Cheers,
Ben.
