Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81372DDDEC
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 19:25:19 +1100 (EST)
Subject: Re: Update on: MPC85xx git/MPC8548cds - PCI/PCIE problemS with
	Marvel SATA driver...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Morrison, Tom" <tmorrison@empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D901069D9CA4@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>
	<BE415006-0D71-4D2F-8699-3BD2A513D9C0@freescale.com>
	<BD261180E6D35F4D9D32F3E44FD3D9010685DCFC@EMPBEDEX.empirix.com>
	<8B9F6546-0D85-4AD0-A196-25F0F9C1A5A0@freescale.com>
	<BD261180E6D35F4D9D32F3E44FD3D901069D9CA4@EMPBEDEX.empirix.com>
Content-Type: text/plain
Date: Sat, 24 Feb 2007 09:25:05 +0100
Message-Id: <1172305505.1902.27.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Fri, 2007-02-23 at 14:57 -0500, Morrison, Tom wrote:
> All,
> 
> I have yet to successfully gone through full initialization / 
> registration of this driver for this board.
> 
> I have both a Marvell PCI SATA Card (with 6042 chip) 
> and a Marvell PCI Express SATA card (with 7042 chip).
> 
> PCI/6042 Chip Marvel SATA Card
> ==============================
>    On PCI Bus - the card is probed, and finds the SATA drive - 
>    goes through an ata add device process - up to adding scsi device -
>    even goes all the way to checking the file system -and lastly says:
> 
>        SCSI device sda: write cache: enabled, read cache: enabled, 
>         sda: unknown partition table
>        sd 0:0:0:0: Attached scsi disk sda
> 
>    After full boot (I am nfs mounting my root file system until I get
>    this working), I try to mount drive - no good - I can't mount it
>    (it also doesn't create a /dev/sda or /dev/sda1 device - I assume 
>    that if it knew the partitioning table - it would actually create
>    these devices and Yes, I have ms-dos file system support compiled in?

The above looks like it's working and you don't have a proper partition
table on the disk or you haven't compiled in support for the right type
of partition map (this is different from the filesystem type)....

Make sure you enable MS-DOS partition type support in addition to file
system type.

Ben.
