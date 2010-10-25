Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 992B5B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Oct 2010 00:23:16 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH -mm 0/2] RapidIO: Changes to handling of RIO switches
Date: Mon, 25 Oct 2010 06:22:54 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201445BA4@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4CC20923.8050400@neli.hopto.org>
References: <1287688250-14226-1-git-send-email-alexandre.bounine@idt.com>
	<4CC0AD74.8070800@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445906@CORPEXCH1.na.ads.idt.com>
	<4CC1D7DE.7060405@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445A6B@CORPEXCH1.na.ads.idt.com>
	<4CC20923.8050400@neli.hopto.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Micha Nelissen" <micha@neli.hopto.org>
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Micha Nelissen <micha@neli.hopto.org> wrote:
> Bounine, Alexandre wrote:
> > If we will need to identify the same physical switch by different
> > processors we may use the component tag which now is unique for
every
> > device.
>=20
> Yes, identification is the point. I think it might be confusing to
have
> a destid *and* a component tag id which are slightly different. The
> destid is unambiguous (if you know whether the device is a switch or
> endpoint) so I think it makes sense to use that if possible.

The component tag is the way to identify a RIO device (switch or
endpoint).
1. it is defined by RIO spec as a register existing in both types of
devices (this provides a universal access to the identification
information by any processor).
2. the Error Management specification already uses the CT as a device
identifier.
3. the CT value is large enough to be unique for max number of endpoints
in the large system and any reasonable number of switches. BTW, I am
planning to provide a patch that defines CT fields to ensure future
compatibility.

The destid does not exists as a HW element of switches and therefore
cannot be used as a universal identification token.

> > This actually gives me another idea: instead of using global
> > next_switchid counter make rswitch->switchid =3D component_tag and
> > switches in sysfs will look identical for every processor (or just
get
> > rid of rswitch->switchid and use component_tag directly for
switches).
>=20
> I still prefer the destid as the single identification id.

As I answered above, destid cannot be used as a universal identification
token - it is a routing element. The destID has register in endpoints
only to provide a packet filtering.

In your patch you allocate individual destid for switches. This method
has two problems:
1. The destid for the switch needs an additional mechanism to share it
among processors in the RIO network,
2. It takes ID value away from the pool of available IDs, what will
reduce number of IDs that can be assigned to endpoints. (NOTE: I am
actually working on destID assignment scheme that will recycle destID in
case of hot-swap events, i.e. if device is extracted its destID will be
returned to the pool of available IDs and may be reused later for device
insertion).

The only case when assigning individual destid to the switch is
justified is an "empty" switch - one without any endpoints attached to
it. But that destid should be assigned to an endpoint as soon as it is
attached to that switch. =20

Alex.
