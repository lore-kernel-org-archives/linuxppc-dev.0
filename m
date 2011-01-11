Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E210EB70E4
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2011 11:54:01 +1100 (EST)
Subject: Re: PCI woes with 2.6.37
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
In-Reply-To: <4D2B1151.9040109@mlbassoc.com>
References: <4D279C90.8000006@mlbassoc.com>
	<1294472036.17779.253.camel@pasglop> <4D28617A.8020606@mlbassoc.com>
	<4D2B1151.9040109@mlbassoc.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 11 Jan 2011 11:53:49 +1100
Message-ID: <1294707229.17779.306.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> I found the problem - a change I had in <2.6.32 that I hadn't
> pushed forward.  It seems to be related to how I have the PCI
> controller setup (in RedBoot).  Because of this, using these
> settings in my DTS make things work properly:
>      ranges = <0x02000000 0x0 0x00000000 0xC0000000 0x0 0x20000000
>                0x01000000 0x0 0x00000000 0xB8000000 0x0 0x00100000>;
> Instead of
>      ranges = <0x02000000 0x0 0xC0000000 0xC0000000 0x0 0x20000000
>                0x01000000 0x0 0x00000000 0xB8000000 0x0 0x00100000>;

Right so instead of a 1:1 mapping you have a N:1 mapping. We support
both forms, tho it would have been nice if the fsl PCI code had properly
reconfigured the controller based on the DT.

> Sorry for the noise (wild goose chase), but discussing it did help
> me to work out some PCI issues in general.
> 
> Now that this is working, I'm trying to move to the next problem.
> The system works fine, but only to a point.  In this [embedded]
> system, I have an SIL SATA controller on the PCI bus.

Ok, those are pretty common and generally work fine.

>   On 2.6.28,
> this device is rock solid.  On 2.6.32 and now 2.6.37, I have issues.
> Operations work on the device (connected to a SSD), but after some
> arbitrary time, an operation will fail, causing the PCI bus (and
> indeed the whole system) to hang.  I've tried to peek in using a
> BDI and once it hangs, even the BDI can't access the CPU any more.

Ugh. Never hit a problem like this I'm afraid.

> I'm pretty lost on this one - it will execute hundreds of SATA operations
> properly and then die.  Turning on SATA/SCSI traces, I can see the
> final operation be issued and there seems to be no substantive difference
> between this operation and the previous ones that all worked.  In fact
> if I reset and rerun the same program, it _will_ fail but never on
> the same operation :-(
> 
> Any ideas what could cause this failure?  I have a similar system
> that uses a different SATA controller that I'm going to try.  Maybe
> it's something peculiar to the SIL device as opposed to generic PCI
> operations.

Yes, definitely try different controllers. Also check your voltages just
in case....

Other things you can do is double check the settings of things like max
read request size, max payload size etc... in the PCIe config space of
the device and the bridge.

Cheers,
Ben.
