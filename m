Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A7F6B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Mar 2011 11:24:14 +1100 (EST)
Subject: Re: PowerMac7,3 dvd drive?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
In-Reply-To: <AANLkTikRU9W61m7EcNONx9=Uinj-F7escWBCOTTdh==N@mail.gmail.com>
References: <AANLkTikRU9W61m7EcNONx9=Uinj-F7escWBCOTTdh==N@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Mar 2011 11:24:04 +1100
Message-ID: <1300667044.2402.102.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-03-20 at 18:52 -0500, kevin diggs wrote:
> I am seeing ... issues with the optical drive (hda) under 2.6.36. I
> can't mount disks:
> 
> [root@PowerMacG5 ~]# mount -r /dev/hda /mnt/cdrom
> mount: /dev/hda already mounted or /mnt/cdrom busy
> 
> The log has:
> 
> [  239.922268] hda: irq timeout: status=0xd0 { Busy }
> [  239.922485] hda: possibly failed opcode: 0xa0
> 
> eject hda will hang ... longer than my patience.
> 
> At first I thought the drive was going south. But I don't see this (at
> least so far) on 2.6.28.

Do you see something similar if you use the new libata based driver
(macio-ata) instead of the old IDE driver ?

It does look like the drive itself is crashing tho. Maybe something the
IDE CDROM driver does upsets it...

Cheers,
Ben.
