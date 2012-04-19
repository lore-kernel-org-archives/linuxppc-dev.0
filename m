Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id C4B6EB6FFB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 22:41:37 +1000 (EST)
Message-ID: <1334839276.5989.393.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Date: Thu, 19 Apr 2012 14:41:16 +0200
In-Reply-To: <20120419114825.203090@gmx.net>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2liltbhkp.fsf@igel.home> <1334736133.5989.278.camel@thor.local>
 <m24nshb7l9.fsf@igel.home> <1334756287.5989.326.camel@thor.local>
 <m2bomp9krb.fsf@igel.home> <1334759498.5989.328.camel@thor.local>
 <m27gxd9jie.fsf@igel.home> <1334761280.5989.332.camel@thor.local>
 <20120418154916.128350@gmx.net> <1334765196.5989.336.camel@thor.local>
 <20120418162337.128340@gmx.net> <1334817171.5989.366.camel@thor.local>
 <20120419114825.203090@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: schwab@linux-m68k.org, ojordan12345@hotmail.co.uk,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Don, 2012-04-19 at 13:48 +0200, Gerhard Pircher wrote:=20
> > Von: "Michel D=C3=A4nzer" <michel@daenzer.net>
> > On Mit, 2012-04-18 at 18:23 +0200, Gerhard Pircher wrote:=20
> > > > Von: "Michel D=C3=A4nzer" <michel@daenzer.net>
> > > > On Mit, 2012-04-18 at 17:49 +0200, Gerhard Pircher wrote:=20
> > > > >=20
> > > > > That may be a stupid question, but is it allowed (for a DRM clien=
t
> > > > > or whatever does the mapping) to change the content of a page
> > > > > mapped into the AGP GART or is it necessary to explicitly unmap
> > > > > the page, change its content and map it again?
> > > >=20
> > > > The former.
> > > I know that the uninorth AGPGART driver does a cache flushing for
> > > newly mapped pages, but is there any code in the driver that handles=
=20
> > > the former case (or isn't this necessary on PPC Macs)?
> >=20
> > If by 'former case' you mean userspace modifying memory mapped into the
> > AGP GART, then no, this generally doesn't require special treatment on
> > PowerMacs. (Ignoring the potential issue mentioned by Ben in this
> > thread)
> I guess you refer to the ordering issue here.

Yeah.

> The "former case" is an explanation, why I see data corruption with my
> AGPGART driver (more or less a copy of the uninorth driver) on my
> non-coherent platform. There are no cache flushes done for writes to
> already mapped pages.

As I said, the radeon driver always maps AGP memory uncacheable for the
CPU, so no such CPU cache flushes should be necessary.

> I tested this with radeon.test=3D1, but I'm not even sure if this code
> changes already mapped pages [...]

It does. radeon_bo_pin(..., RADEON_GEM_DOMAIN_GTT, ...) binds the buffer
memory into the AGP GART, and the test only maps it to the CPU after
that.

I take it the test fails for you? How exactly?


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
