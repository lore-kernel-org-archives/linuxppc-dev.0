Date: Thu, 14 Feb 2002 09:17:23 +0100
From: Xavier Grave <grave@ipno.in2p3.fr>
To: ghannon@cspi.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MVME5100 booting from SCSI disk
Message-ID: <20020214091723.A12583@ipnpcu5.in2p3.fr>
References: <85256B5F.00553845.00@pine.cspi.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
In-Reply-To: =?iso-8859-1?Q?=3C85256B5F=2E00553845=2E00?=
	=?iso-8859-1?Q?=40pine=2Ecspi=2Ecom=3E=3B_from_ghannon=40cspi=2Ecom_on_me?=
	=?iso-8859-1?B?ciwgZul2?= 13, 2002 at 17:30:32 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Le mer, 13 fév 2002 17:30:32, ghannon@cspi.com a écrit :
>
> I'm trying to find documentation on getting a Motorola 5100 board to boot
> from a
> hard drive.    What I spefically am wondering is do I need a "boot
> loader",
> or is that
> built into the kernel?

I have the same configuration. On my board I do a
pboot 10 60
to find the information (10 60) you need to do a ioi
You need to have a bootable prep partition (id 41 in fdisk)
Here is my disk partion
    Device Boot    Start       End    Blocks   Id  System
/dev/sda1             1         2      2032   41   PPC PReP Boot
/dev/sda2             3        21     19456   83  Linux
/dev/sda3            22       143    124928   82  Linux swap
/dev/sda4           144      8727   8790016    5  Extended
/dev/sda5           144      2096   1999856   83  Linux
/dev/sda6          2097      4049   1999856   83  Linux
/dev/sda7          4050      6002   1999856   83  Linux
/dev/sda8          6003      8727   2790384   83  Linux

You need to do a
dd if=zImage.initrd.pplus of=/dev/sda1
if you PPC PReP Boot partition is /dev/sda1

Hope it will help you.

O+ xavier
--
33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
