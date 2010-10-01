Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6391AB70D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 03:59:57 +1000 (EST)
Subject: Re: Introduce support for little endian PowerPC
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1285935283.2463.78.camel@pasglop>
Date: Fri, 1 Oct 2010 12:59:31 -0500
Message-Id: <BBD78246-343E-4A96-9E55-3E40AD628C0B@kernel.crashing.org>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<2C5357FA-F87F-457E-B5C1-0DCC5A842DE7@kernel.crashing.org>
	<AANLkTinSDMvBb7rnnfwYMkEVOgDUqRetZg86rh-UmSAg@mail.gmail.com>
	<1285935283.2463.78.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
	Ian Munsie <imunsie@au1.ibm.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 1, 2010, at 7:14 AM, Benjamin Herrenschmidt wrote:

> On Fri, 2010-10-01 at 07:30 -0400, Josh Boyer wrote:
>>=20
>>> =46rom a community aspect is anyone actually going to use this?  Is
>> this going to be the equivalent of voyager on x86?  I've got nothing
>> against some of the endian clean ups this introduces.  However the
>> changes to misc_32.S are a bit ugly from a readability point of view.
>> Just seems like this is likely to bit-rot pretty quickly.
>>=20
>> I'm with Kumar on this one.  Why would we want to support this?  I
>> can't say I would be very willing to help anyone run in LE mode, let
>> alone have it randomly selectable.=20
>=20
> There's some good reasons on the field ... sadly.
>=20
> At this stage this is mostly an experiment, which went pretty well in
> the sense that it's actually quite easy and a lot of the "fixes" are
> actually reasonable cleanups to carry.
>=20
> Now, the main reasons in practice are anything touching graphics.
>=20
> There's quite a few IP cores out there for SoCs that don't have HW
> swappers, and -tons- of more or less ugly code that can't deal with =
non
> native pixel ordering (hell, even Xorg isn't good at it, we really =
only
> support cards that have HW swappers today).
>=20
> There's an even bigger pile of application code that deals with =
graphics
> without any regard for endianness and is essentially unfixable.
>=20
> So it becomes a matter of potential customers that will take it if it
> does LE and won't if it doesn't ...
>=20
> Now, I don't have a problem supporting that as the maintainer, as I
> said, from a kernel standpoint, it's all quite easy to deal with. Some
> of the most gory aspects in misc_32.S could probably be done in a way
> that is slightly more readable, but the approach is actually good, I
> think, to have macros to represent the high/low parts of register =
pairs.
>=20
> So at this stage, I'd say, let's not dismiss it just because we all =
come
> from a long education of hating LE for the sake of it :-)
>=20
> It makes -some- sense, even if it's not necessarily on the markets
> targeted by FSL today for example. At least from the kernel POV, it
> doesn't seem to me to be a significant support burden at all.
>=20
> Cheers,
> Ben.

I'm not against it, and I agree some of the patches seem like good clean =
up.  I'm concerned about this bit rotting pretty quickly.

- k
