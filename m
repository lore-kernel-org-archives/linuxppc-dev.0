Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 19CA4B6FC9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 16:40:58 +1000 (EST)
Message-ID: <1334730915.5989.265.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: o jordan <ojordan12345@hotmail.co.uk>
Date: Wed, 18 Apr 2012 08:35:15 +0200
In-Reply-To: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
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

On Die, 2012-04-17 at 20:49 +0100, o jordan wrote:=20
>=20
> I've been trying to get Kernel Mode Setting working on my iBook with
> Ubuntu 12.04.  I can only get it working by forcing PCI mode
> (agpmode=3D-1).  Setting agpmode=3D1 or a higher number just results in
> freezing and a flashing screen.

At which point? When radeon KMS initializes, or only when X starts?

> I've tried the Debian experimental kernel with the same results.  I
> notice with Fedora 16 they also recommend setting agpmode=3D-1 with a
> radeon card.  So I'm guessing there is no easy fix??

Probably not (AGP is flaky in general, but in particular with older
UniNorth bridges), but it might be interesting to see some kernel output
from booting without agpmode=3D-1. If you can't get it via ssh, maybe you
can via netconsole or so.


> With Userspace Mode Setting there is nolonger any 3D hardware
> acceleration
> (https://bugs.launchpad.net/ubuntu/+source/mesa/+bug/946677 )

=46rom the Mesa upstream POV, the drivers from the 7.11 branch could be
used for this.


> CONFIG_DRM_RADEON_KMS=3Dy
> CONFIG_FB_RADEON=3Dy

Not sure it's a good idea to set both of these =3Dy: It will prevent the
radeon driver from initializing at all by default if radeonfb is active.
If you want CONFIG_FB_RADEON=3Dy, I'd suggest leaving
CONFIG_DRM_RADEON_KMS disabled. KMS can always be enabled at boot time
with radeon.modeset=3D1.

> CONFIG_FB_ATY128=3Dy
> CONFIG_FB_ATY=3Dy

There's no KMS for pre-Radeon ATI cards yet, so these are not directly
related.


> I'm not sure if CONFIG_AGP_UNINORTH should be compiled as a module or
> built in. =20

I think it would only need to be built in if the radeon driver was built
in, which is not recommended.


P.S. The dri-devel list at freedesktop.org might be better for this, at
least in addition to linuxppc-dev.

--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
