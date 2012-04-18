Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 1893CB6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 18:02:31 +1000 (EST)
Message-ID: <1334736133.5989.278.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Wed, 18 Apr 2012 10:02:13 +0200
In-Reply-To: <m2liltbhkp.fsf@igel.home>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2liltbhkp.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: o jordan <ojordan12345@hotmail.co.uk>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mit, 2012-04-18 at 09:54 +0200, Andreas Schwab wrote:=20
> Michel D=C3=A4nzer <michel@daenzer.net> writes:
>=20
> > Probably not (AGP is flaky in general, but in particular with older
> > UniNorth bridges), but it might be interesting to see some kernel outpu=
t
> > from booting without agpmode=3D-1. If you can't get it via ssh, maybe y=
ou
> > can via netconsole or so.
>=20
> While logging into KDE:
>=20
> radeon 0000:00:10.0: GPU lockup CP stall for more than 10064msec
> GPU lockup (waiting for 0x000003EE last fence id 0x000003ED)
> radeon: wait for empty RBBM fifo failed ! Bad things might happen.
> Failed to wait GUI idle while programming pipes. Bad things might happen.
> radeon 0000:00:10.0: (r300_asic_reset:414) RBBM_STATUS=3D0x8802C137
> radeon 0000:00:10.0: (r300_asic_reset:433) RBBM_STATUS=3D0x8802C137
> radeon 0000:00:10.0: (r300_asic_reset:445) RBBM_STATUS=3D0x8802C137
> radeon 0000:00:10.0: GPU reset succeed
> radeon 0000:00:10.0: GPU reset succeed
> radeon 0000:00:10.0: (r300_asic_reset:414) RBBM_STATUS=3D0x8802C137
> radeon 0000:00:10.0: (r300_asic_reset:433) RBBM_STATUS=3D0x8802C137
> radeon 0000:00:10.0: (r300_asic_reset:445) RBBM_STATUS=3D0x8802C137
> radeon 0000:00:10.0: GPU reset succeed
> radeon: wait for empty RBBM fifo failed ! Bad things might happen.
> Failed to wait GUI idle while programming pipes. Bad things might happen.

That's even with agpmode=3D1?

Note that I'm interested in seeing the full dmesg or at least all
agp/drm/radeon related messages.


> After that is is dead.

The whole machine? That's probably due to something going wrong (e.g. an
MCE) while trying to reset the GPU. I fixed one such problem recently,
but it's still not as reliable as on x86 unfortunately.

> GPU lockup appears to be a common problem with the radeon driver.

It's what happens when anything goes wrong with the GPU. If it doesn't
happen with agpmode=3D-1, it's probably an AGP related coherency issue.


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
