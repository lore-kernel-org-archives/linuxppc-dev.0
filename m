Return-Path: <gerhard_pircher@gmx.net>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
 by ozlabs.org (Postfix) with SMTP id 29B95B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 02:23:40 +1000 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Wed, 18 Apr 2012 18:23:37 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1334765196.5989.336.camel@thor.local>
Message-ID: <20120418162337.128340@gmx.net>
MIME-Version: 1.0
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>	
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2liltbhkp.fsf@igel.home> <1334736133.5989.278.camel@thor.local>	
 <m24nshb7l9.fsf@igel.home> <1334756287.5989.326.camel@thor.local>	
 <m2bomp9krb.fsf@igel.home> <1334759498.5989.328.camel@thor.local>	
 <m27gxd9jie.fsf@igel.home> <1334761280.5989.332.camel@thor.local>	
 <20120418154916.128350@gmx.net> <1334765196.5989.336.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
To: =?iso-8859-1?Q?=22Michel_D=E4nzer=22?= <michel@daenzer.net>
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


-------- Original-Nachricht --------
> Datum: Wed, 18 Apr 2012 18:06:36 +0200
> Von: "Michel Dänzer" <michel@daenzer.net>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@lists.ozlabs.org, schwab@linux-m68k.org, ojordan12345@hotmail.co.uk
> Betreff: Re: PowerPC radeon KMS - is it possible?

> On Mit, 2012-04-18 at 17:49 +0200, Gerhard Pircher wrote: 
> > > Von: "Michel Dänzer" <michel@daenzer.net>
> > > On Mit, 2012-04-18 at 16:55 +0200, Andreas Schwab wrote: 
> > > > Michel Dänzer <michel@daenzer.net> writes:
> > > > 
> > > > > On Mit, 2012-04-18 at 16:28 +0200, Andreas Schwab wrote: 
> > > > >> Michel Dänzer <michel@daenzer.net> writes:
> > > > >> 
> > > > >> > Have you tried smaller aperture sizes (uninorth_agp.aperture)
> > > > >> > and/or radeon.test=1? (See commit
> > > > >> > 52f072cb084bbb460d3a4ae09f0b6efc3e7e8a8c)
> > > > >> 
> > > > >> Neither changes anything.
> > > > >
> > > > > How small aperture sizes have you tried?
> > > > 
> > > > 32M. With the old UMS driver 3D once worked fine ...
> > > 
> > > That doesn't necessarily mean much per se, as with UMS memory is
> > > only statically mapped into the AGP GART once (so most of those
> > > 32M are wasted at least most of the time), whereas with KMS it's
> > > dynamically (un)mapped on demand.
> > That may be a stupid question, but is it allowed (for a DRM client or
> > whatever does the mapping) to change the content of a page mapped into
> > the AGP GART or is it necessary to explicitly unmap the page, change
> > its content and map it again?
> 
> The former.
I know that the uninorth AGPGART driver does a cache flushing for newly
mapped pages, but is there any code in the driver that handles the
former case (or isn't this necessary on PPC Macs)?

> > I would say it's necessary to unmap the page first (sounds more like
> > the pci_[un]map_page() approach) - at least when it should work with
> > non-coherent architectures, too.
> 
> I'm afraid non-coherent platforms haven't really been a concern yet for
> KMS, and always doing the above dance would probably have a significant
> performance impact on coherent platforms.
Are there any plans for a page flushing API? I suppose that wouldn't
have such a big performance impact on coherent platforms (but probably
an impact on the userspace API).

Thanks!

Gerhard
-- 
Empfehlen Sie GMX DSL Ihren Freunden und Bekannten und wir
belohnen Sie mit bis zu 50,- Euro! https://freundschaftswerbung.gmx.de
