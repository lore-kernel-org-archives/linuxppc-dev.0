Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 550572C0099
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2013 04:25:14 +1000 (EST)
Date: Mon, 8 Apr 2013 13:24:56 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
To: Wang Dongsheng-B40534 <B40534@freescale.com>
References: <1363949917.8238.25.camel@jlt4.sipsolutions.net>
 <1363990490.24790.12@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259ED9C2E@039-SN2MPN1-021.039d.mgd.msft.net>
 <1364949294.24520.29@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259EDC264@039-SN2MPN1-021.039d.mgd.msft.net>
 <1365020140.25627.9@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259EDDCAE@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EDDCAE@039-SN2MPN1-021.039d.mgd.msft.net>
 (from B40534@freescale.com on Sat Apr  6 22:01:45 2013)
Message-ID: <1365445496.28843.4@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/06/2013 10:01:45 PM, Wang Dongsheng-B40534 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, April 04, 2013 4:16 AM
> > To: Wang Dongsheng-B40534
> > Cc: Wood Scott-B07421; Johannes Berg; linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH] powerpc: add Book E support to 64-bit =20
> hibernation
> >
> > On 04/03/2013 12:36:41 AM, Wang Dongsheng-B40534 wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Wednesday, April 03, 2013 8:35 AM
> > > > To: Wang Dongsheng-B40534
> > > > Cc: Wood Scott-B07421; Johannes Berg; =20
> linuxppc-dev@lists.ozlabs.org
> > > > Subject: Re: [PATCH] powerpc: add Book E support to 64-bit
> > > hibernation
> > > >
> > > > On 04/02/2013 12:28:40 AM, Wang Dongsheng-B40534 wrote:
> > > > > Hi scott & Johannes,
> > > > >
> > > > > Thanks for reviewing.
> > > > >
> > > > > @scott, About this patch, could you please help ack this =20
> patch?
> > > >
> > > > Please investigate the issue of whether we are loading kernel =20
> module
> > > > code in this step, and whether cache flushing is needed as a =20
> result.
> > > >
> > > Sorry, I am not very clear what you mean.
> > > When the kernel boot end, modprobe some xx.ko?
> >
> > Suppose, before the kernel was suspended, modules had been loaded.  =20
> At
> > what point do those modules get restored, and when does the cache =20
> get
> > flushed?
> >
> Before the kernel was suspended, modules had been loaded, the modules =20
> is
> already in memory.

They *were* in memory, until the hardware was powered down.

> And /lib/modules/* is belong to vfs.

Huh?  I'm talking about modules that have been loaded, not where in the =20
filesystem they were loaded from.  Loading a module is not like =20
mmap()ing a file.

> When suspend to disk, all used pages will be saved.(Include VFS, =20
> Loaded modules)
> When restore, the kernel will not modprobe again.

Of course it won't modprobe again.  Still, at some point during the =20
resume process, the code has to be loaded from disk into RAM.  What I =20
don't know is if this is where that happens.

> The non-bootcpu will restore all pages.(Include VFS, Loaded modules)

I don't know what "non-bootcpu" has to do with anything.  What matters =20
is what piece of code does the restoring, and if the cache flush =20
properly happens then.

-Scott=
