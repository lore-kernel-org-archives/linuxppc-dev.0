Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 418D5B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 16:33:11 +1000 (EST)
Message-ID: <1334817171.5989.366.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Date: Thu, 19 Apr 2012 08:32:51 +0200
In-Reply-To: <20120418162337.128340@gmx.net>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2liltbhkp.fsf@igel.home> <1334736133.5989.278.camel@thor.local>
 <m24nshb7l9.fsf@igel.home> <1334756287.5989.326.camel@thor.local>
 <m2bomp9krb.fsf@igel.home> <1334759498.5989.328.camel@thor.local>
 <m27gxd9jie.fsf@igel.home> <1334761280.5989.332.camel@thor.local>
 <20120418154916.128350@gmx.net> <1334765196.5989.336.camel@thor.local>
 <20120418162337.128340@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, ojordan12345@hotmail.co.uk,
 schwab@linux-m68k.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mit, 2012-04-18 at 18:23 +0200, Gerhard Pircher wrote:=20
> > Von: "Michel D=C3=A4nzer" <michel@daenzer.net>
> > On Mit, 2012-04-18 at 17:49 +0200, Gerhard Pircher wrote:=20
> > > > Von: "Michel D=C3=A4nzer" <michel@daenzer.net>
> > > > On Mit, 2012-04-18 at 16:55 +0200, Andreas Schwab wrote:=20
> > > > > Michel D=C3=A4nzer <michel@daenzer.net> writes:
> > > > >=20
> > > > > > On Mit, 2012-04-18 at 16:28 +0200, Andreas Schwab wrote:=20
> > > > > >> Michel D=C3=A4nzer <michel@daenzer.net> writes:
> > > > > >>=20
> > > > > >> > Have you tried smaller aperture sizes (uninorth_agp.aperture=
)
> > > > > >> > and/or radeon.test=3D1? (See commit
> > > > > >> > 52f072cb084bbb460d3a4ae09f0b6efc3e7e8a8c)
> > > > > >>=20
> > > > > >> Neither changes anything.
> > > > > >
> > > > > > How small aperture sizes have you tried?
> > > > >=20
> > > > > 32M. With the old UMS driver 3D once worked fine ...
> > > >=20
> > > > That doesn't necessarily mean much per se, as with UMS memory is
> > > > only statically mapped into the AGP GART once (so most of those
> > > > 32M are wasted at least most of the time), whereas with KMS it's
> > > > dynamically (un)mapped on demand.
> > > That may be a stupid question, but is it allowed (for a DRM client or
> > > whatever does the mapping) to change the content of a page mapped int=
o
> > > the AGP GART or is it necessary to explicitly unmap the page, change
> > > its content and map it again?
> >=20
> > The former.
> I know that the uninorth AGPGART driver does a cache flushing for newly
> mapped pages,

Ah, right, that probably explains why the map_page_into_agp change
doesn't make any difference.


> but is there any code in the driver that handles the former case (or
> isn't this necessary on PPC Macs)?

If by 'former case' you mean userspace modifying memory mapped into the
AGP GART, then no, this generally doesn't require special treatment on
PowerMacs. (Ignoring the potential issue mentioned by Ben in this
thread)


> > > I would say it's necessary to unmap the page first (sounds more like
> > > the pci_[un]map_page() approach) - at least when it should work with
> > > non-coherent architectures, too.
> >=20
> > I'm afraid non-coherent platforms haven't really been a concern yet for
> > KMS, and always doing the above dance would probably have a significant
> > performance impact on coherent platforms.
> Are there any plans for a page flushing API? I suppose that wouldn't
> have such a big performance impact on coherent platforms (but probably
> an impact on the userspace API).

Not that I know of.

Note that this isn't necessarily the only possible approach for
addressing this problem. The driver knows which memory buffers are used
by a GPU command stream sequence, so it should be able to take any
measures necessary to ensure the device sees their contents as of when
the command stream was submitted.


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
