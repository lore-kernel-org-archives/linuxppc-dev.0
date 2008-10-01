Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B0974DDDD8
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 04:07:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Disabling L1 D-cache and side effects
Date: Wed, 1 Oct 2008 11:07:10 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C0605380A@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <1222815376.9006.83.camel@pasglop>
References: <9323BAFB78DE7C4183466AD03F73EA424D46071D@SDCEXCHANGE01.ad.amcc.com>
	<AC5E1C3367E37D44970B81A6ADD1DA2C060530C1@SDCEXCHANGE01.ad.amcc.com>
	<20080929180455.GA19014@lixom.net>
	<AC5E1C3367E37D44970B81A6ADD1DA2C060531D6@SDCEXCHANGE01.ad.amcc.com>
	<20080929211401.GA22039@lixom.net>
	<AC5E1C3367E37D44970B81A6ADD1DA2C0605320F@SDCEXCHANGE01.ad.amcc.com>
	<1222758980.9006.43.camel@pasglop>
	<AC5E1C3367E37D44970B81A6ADD1DA2C06053428@SDCEXCHANGE01.ad.amcc.com>
	<1222810236.9006.54.camel@pasglop>
	<AC5E1C3367E37D44970B81A6ADD1DA2C060535A8@SDCEXCHANGE01.ad.amcc.com>
	<1222815376.9006.83.camel@pasglop>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: <benh@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Ben,
  You are right. After I corrected copy_page and __copy_tofrom_user
functions Linux booted normally. Thanks a lot for the suggestions.
Thanks,
Marri

-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]=20
Sent: Tuesday, September 30, 2008 3:56 PM
To: Tirumala Reddy Marri
Cc: Olof Johansson; linuxppc-dev@ozlabs.org
Subject: RE: Disabling L1 D-cache and side effects

On Tue, 2008-09-30 at 15:26 -0700, Tirumala Reddy Marri wrote:
> Ben,
>     I got to bring up Linux on one of the 440 processors with out L1=20
> dcache to do some bench marking  and compare with  L1 d-cache enabled.
>=20
> I am avoiding any references to dcbz ,dcbt and dcbst .   Also the
TLB's
> are created with cache inhibited. I looked at lwarx/stwcx description,

> there seem to be no dependency on L1 cache.

Ok. Well, they are generally implemented at the L2 level but maybe not
on 440, architecturally, they must be used on cacheable memory but it's
possible that 440 being not SMP coherent, the actual implementation of
those is too dumb to care.

> I don't see any critical exceptions or traps. All I  see is /init/bin=20
> failing to execute because data is corrupted.

Have you properly replaced dcbz with multiple stores ? I did some bring
up work internally on some stuff where dcbz wasn't quite there yet and
one pitfall to be careful is that if you force-enable the alternate
CONFIG_8xx implementation in the various copy & memset routines in
arch/powerpc/lib, you also need to fix those implementations to copy or
clear 32 bytes instead of just 16, as 8xx has 16 byte cache lines.

Typically failing to do so causes things like memset to fail to properly
clear things such as page tables and thus random crap occurs.

Cheers,
Ben.

> Thanks,
> Marri

>=20
> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> Sent: Tuesday, September 30, 2008 2:31 PM
> To: Tirumala Reddy Marri
> Cc: Olof Johansson; linuxppc-dev@ozlabs.org
> Subject: RE: Disabling L1 D-cache and side effects
>=20
> On Tue, 2008-09-30 at 09:57 -0700, Tirumala Reddy Marri wrote:
> > Ben,
> >   Thanks for the response. I am wondering how user space would get=20
> > affected by absence of L1 Dcache.
>=20
> You didn't answer my question :-)
>=20
> Well, as I said, things like lwarx/stwcx not working, dcbz taking=20
> alignment exceptions, etc...
>=20
> Ben.
>=20
> > Thanks,
> > Marri
> >=20
> > -----Original Message-----
> > From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> > Sent: Tuesday, September 30, 2008 12:16 AM
> > To: Tirumala Reddy Marri
> > Cc: Olof Johansson; linuxppc-dev@ozlabs.org
> > Subject: RE: Disabling L1 D-cache and side effects
> >=20
> > On Mon, 2008-09-29 at 14:38 -0700, Tirumala Reddy Marri wrote:
> > > Could you please point me to the which does the Critical error=20
> > > (Machine
> > > Check) recovery. BTW I am successful booting the Linux until=20
> > > rootfs is
> >=20
> > > being mounted. It fails to mount the Linux saying that blocks are=20
> > > corrupted in file system. I had to modify lots of initial bring up

> > > code to disable D-cache and make sure all TLB's are cache
inhibited.
> > > Ando also made sure none of the misc_32.S , entry_32.S and head.S=20
> > > makes any references to d-cache.
> >=20
> > Why the heck are you doing that btw ? AFAIK, as Olof says, things=20
> > like
>=20
> > atomic operations will not work, dcbz neither etc... it's likely=20
> > that even if you manage to plaster around all of this in the kernel,

> > whatever userspace code you'll try to run in userspace will blow up
> too...
> >=20
> > Cheers,
> > Ben.
