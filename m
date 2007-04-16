Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id 59489DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 01:26:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux 2.6 and uboot
Date: Mon, 16 Apr 2007 11:27:00 -0400
Message-ID: <3C02138692C13C4BB675FE7EA2409529328549@bluefin.Soneticom.local>
In-Reply-To: <Pine.LNX.4.60.0704142053560.5114@poirot.grange>
From: "Clint Thomas" <cthomas@Soneticom.com>
To: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I tried combining the root file system and kernel images so that I could
just load a single image in u-boot, and I disabled networking in the
kernel config. When I do this, the kernel boots and loads into the shell
no problem. The problem seems to be related to the Marvell PHY, so my
plan is to investigate the IRQs and make sure it isn't getting the same
as another device. Not sure what I'll look for after that, can KGDB step
through the enet drivers on boot?

Clint=20

-----Original Message-----
From: Guennadi Liakhovetski [mailto:g.liakhovetski@gmx.de]=20
Sent: Saturday, April 14, 2007 3:02 PM
To: Clint Thomas
Cc: Kumar Gala; linuxppc-embedded@ozlabs.org
Subject: RE: Linux 2.6 and uboot

On Fri, 13 Apr 2007, Clint Thomas wrote:

> mice: PS/2 mouse device common for all mice i2c /dev entries driver=20
> TCP cubic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
>=20
> This is the point where it stops booting.

It might be just the point before root is mounted... That's what I'd
check anyway... I see it has 2 eth interfaces. Can it be that their
order has changed and it's trying the wrong one?

Thanks
Guennadi
---
Guennadi Liakhovetski
