Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 0D467B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 20:54:24 +1000 (EST)
Message-ID: <1334746446.5989.300.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 18 Apr 2012 12:54:06 +0200
In-Reply-To: <1334745439.3143.5.camel@pasglop>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334732346.1159.5.camel__22339.9641145535$1334732429$gmane$org@pasglop>
 <m2pqb5bhyo.fsf@igel.home> <1334745338.3143.3.camel@pasglop>
 <1334745439.3143.5.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, o jordan <ojordan12345@hotmail.co.uk>,
 Andreas Schwab <schwab@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mit, 2012-04-18 at 20:37 +1000, Benjamin Herrenschmidt wrote:=20
> On Wed, 2012-04-18 at 20:35 +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2012-04-18 at 09:46 +0200, Andreas Schwab wrote:
> > > Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> > >=20
> > > > Note also that KMS doesn't afaik have the power management code tha=
t
> > > > radeonfb has for those old Mac chipsets, so suspend/resume won't wo=
rk.
> > >=20
> > > How hard would it be to add it?
> >=20
> > The code itself is relatively self contained, but the KMS power
> > management side is a bit ... messy :-)

That's an interesting way to put it, given the hacks to make it work
between radeonfb and uninorth_agp. :) (Which are complicating making at
least hibernation work with KMS on uninorth_agp)

In contrast, radeon KMS uses the standard Linux device suspend/resume
hooks.

> > So the real deal is to figure out how best to "hook it up" there.
> >=20
> > There's some duplication=20
>=20
> Argh... bloody x220 touchpad...
>=20
> So I was saying, there's also some duplication in the area of dynamic
> clocks configuration. Some of this could be an issue as afaik, to work
> reliably, the suspend/resume code really wants the stuff to be setup
> exactly the way the code in radeon_pm does....

Are you referring to radeon_pm in radeonfb or radeon KMS?

Most of the latter isn't used on PPC laptops because it relies on an x86
video BIOS.


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
