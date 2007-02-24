Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A02DDDDE23
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 14:06:31 +1100 (EST)
Date: Fri, 23 Feb 2007 21:16:49 -0600
To: "Morrison, Tom" <tmorrison@empirix.com>
Subject: Re: Update on: MPC85xx git/MPC8548cds - PCI/PCIE problemS with Marvel
	SATA driver...
Message-ID: <20070224031649.GA26751@lixom.net>
References: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>
	<BE415006-0D71-4D2F-8699-3BD2A513D9C0@freescale.com>
	<BD261180E6D35F4D9D32F3E44FD3D9010685DCFC@EMPBEDEX.empirix.com>
	<8B9F6546-0D85-4AD0-A196-25F0F9C1A5A0@freescale.com>
	<BD261180E6D35F4D9D32F3E44FD3D901069D9CA4@EMPBEDEX.empirix.com>
	<20070223202921.GA22331@lixom.net>
	<BD261180E6D35F4D9D32F3E44FD3D901053E84AA@EMPBEDEX.empirix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D901053E84AA@EMPBEDEX.empirix.com>
From: olof@lixom.net (Olof Johansson)
Cc: Geary Sean-R60898 <sean.geary@freescale.com>, linuxppc-dev@ozlabs.org,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 23, 2007 at 05:47:22PM -0500, Morrison, Tom wrote:
> Olof,
> 
> Are you saying that it must 'know' about the PCI id(s)
> for this SATA card before it even probes that device???
> 
> Even though the module is compiled into the kernel and 
> I've verified that:
> 
>   a) the pci scan bus has detected this device
>   b) that the sata_mv driver is registering itself
>      as a PCI Device driver?

Yes. There's the device on the bus, and there's the PCI bus code that will
walk all busses and enumerate all devices. Then there's the driver. All
drivers have a small table that they use to specify which PCI devices
they are usable with, so if the device isn't listed, the driver won't
get involved.

See the sata_mv sources for more info, search for '7042' and you'll find
the table, at least if you're looking at the 2.6.20 sources.

> Also, fyi, its also complaining about the PCI Express 
> Root Bridge on the MPC8548 as an unknown device...
> 
>    manufacturer: 0x1957 (aka: Freescale)
>    class: 0xFFFF

What complains? lspci? Or the kernel? lspci is just a high-level program
that has a database that maps the numerical codes to manufacturers and
devices. The database might be out of date, or someone forgot to submit
the device IDs to it. It happens all the time.


> although that doesn't explain why the same PCI 
> Express SATA card / ~same sata_mv driver on an 
> Intel X86 platform doesn't get recognized either.

Same thing -- PCI id missing from the driver.

> Thank you for any additional insight you have on this Olof!


-Olof
