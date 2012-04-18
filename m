Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 7CAE3B7380
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 23:08:22 +1000 (EST)
Message-ID: <1334754483.5989.309.camel@thor.local>
Subject: Re: PowerPC radeon KMS - is it possible?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 18 Apr 2012 15:08:03 +0200
In-Reply-To: <1334747941.3143.13.camel@pasglop>
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2liltbhkp.fsf@igel.home> <1334736133.5989.278.camel@thor.local>
 <1334744414.3143.2.camel@pasglop> <1334745292.5989.291.camel@thor.local>
 <1334745854.5989.295.camel@thor.local> <1334747941.3143.13.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Andreas Schwab <schwab@linux-m68k.org>,
 o jordan <ojordan12345@hotmail.co.uk>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mit, 2012-04-18 at 21:19 +1000, Benjamin Herrenschmidt wrote:=20
> On Wed, 2012-04-18 at 12:44 +0200, Michel D=C3=A4nzer wrote:
> > On Mit, 2012-04-18 at 12:34 +0200, Michel D=C3=A4nzer wrote:=20
> > > On Mit, 2012-04-18 at 20:20 +1000, Benjamin Herrenschmidt wrote:=20
> > > >=20
> > > > I suspect there's a fundamental design issue with apple bridge in t=
hat
> > > > the CPU to memory path isn't coherent at all with the GPU to memory=
 path
> > > > ie. even vs. cache flush instructions (ie buffers in the memory
> > > > controllers can still be out of sync).
> > > >=20
> > > > Darwin does some gross hacks to work around that, some of them visi=
ble
> > > > in the AGP drivers, some burried in the Apple driver, I don't know =
for
> > > > sure. It's possible that they end up mapping all AGP memory as cach=
e
> > > > inhibited, but we can't do that because of our linear mapping.
> > >=20
> > > We are doing that though...
> >=20
> > This reminded me, I've been running with the patch below, but I'm not
> > sure it makes any difference. Maybe Andreas or Jordan can try it.
>=20
> It certainly is something we need to do, provided we also know there
> will be no subsequent access to that page via a cachable mapping until
> it's removed from AGP.

TTM should take care of that.


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
