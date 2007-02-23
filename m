Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 5351BDDEC2
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 06:57:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Update on: MPC85xx git/MPC8548cds - PCI/PCIE problemS with Marvel
	SATA driver...
Date: Fri, 23 Feb 2007 14:57:38 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D901069D9CA4@EMPBEDEX.empirix.com>
In-Reply-To: <8B9F6546-0D85-4AD0-A196-25F0F9C1A5A0@freescale.com>
References: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>
	<BE415006-0D71-4D2F-8699-3BD2A513D9C0@freescale.com>
	<BD261180E6D35F4D9D32F3E44FD3D9010685DCFC@EMPBEDEX.empirix.com>
	<8B9F6546-0D85-4AD0-A196-25F0F9C1A5A0@freescale.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Andy Fleming" <afleming@freescale.com>
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

All,

I have yet to successfully gone through full initialization /=20
registration of this driver for this board.

I have both a Marvell PCI SATA Card (with 6042 chip)=20
and a Marvell PCI Express SATA card (with 7042 chip).

PCI/6042 Chip Marvel SATA Card
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
   On PCI Bus - the card is probed, and finds the SATA drive -=20
   goes through an ata add device process - up to adding scsi device -
   even goes all the way to checking the file system -and lastly says:

       SCSI device sda: write cache: enabled, read cache: enabled,=20
        sda: unknown partition table
       sd 0:0:0:0: Attached scsi disk sda

   After full boot (I am nfs mounting my root file system until I get
   this working), I try to mount drive - no good - I can't mount it
   (it also doesn't create a /dev/sda or /dev/sda1 device - I assume=20
   that if it knew the partitioning table - it would actually create
   these devices and Yes, I have ms-dos file system support compiled in?

   Is there anything else that=20

PCI Express/7042 Marvell Sata Card:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   On PCI Express Bus - it never performs the probe - even though
   the bus was scanned and device was found ("lspci" shows this device)

   FYI, I tried the PCI Express SATA Card in an X86 running Fedora
   Core 6 (2.6.19.1-2xxx) and this seemingly is the same behavior
   on this platform?

   Are there other things I need to configure or initialize to=20
   allow the to recognize/probe the SATA drive on the PCI Express bus?

   Or there has to be other PCI Express SATA Cards out there that
   Do NOT have this problem? How do they get around this?


Am I really missing something here or just going crazy?

Thank you for all your suggestions!!!

Sincerely,

Tom Morrison
Principal Software Engineer
EMPIRIX=20
20 Crosby Drive - Bedford, MA  01730
p: 781.266.3567 f: 781.266.3670=20
email: tmorrison@empirix.com=20
www.empirix.comz
