Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1DAF3B70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Oct 2010 08:08:58 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH -mm 0/2] RapidIO: Changes to handling of RIO switches
Date: Fri, 22 Oct 2010 14:04:38 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201445A6B@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4CC1D7DE.7060405@neli.hopto.org>
References: <1287688250-14226-1-git-send-email-alexandre.bounine@idt.com>
	<4CC0AD74.8070800@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445906@CORPEXCH1.na.ads.idt.com>
	<4CC1D7DE.7060405@neli.hopto.org>
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
>=20
> Bounine, Alexandre wrote:
> > Looks like I formulated it bad - better would be: they have
different
> > interpretation by hardware but logically in RapidIO they have single
> > role - destid/hopcount are a device coordinates in the RIO network
used
> > to access that device.
>=20
> They are logically different as well (for a non-host).
>=20
> rswitch->destid with hopcount is the way to reach that switch.
>=20

OK. This is moved to rdev->destid now to make access unified with
endpoints.=20

> rswitch->rdev->destid should be the id associated with a given switch,
> so that every (processor) device can agree what id some switch has.
For
> a non-host, the path to reach a switch may use a different id than the
> switch itself has; it's just the id by which it was discovered.
> However, it's possible to fix that by fixing the id+hopcount once the
> switch is found using the path with its own id: then you know the
right
> hopcount.

I have got an impression that we are discussing slightly different
implementations
here. The suggested role of rswitch->rdev->destid is not clear to me.
I agree that destid and hopcount for switch will be different for every
processor.
There is nothing wrong with it because a switch physically does not have
its own ID.
If we will need to identify the same physical switch by different
processors we may use the component tag which now is unique for every
device.

This actually gives me another idea: instead of using global
next_switchid counter make rswitch->switchid =3D component_tag and
switches in sysfs will look identical for every processor (or just get
rid of rswitch->switchid and use component_tag directly for switches).


> >> can be defined to point to the switch that a given rio_dev is
> > connected
> >> to. This is useful for quick lookups. How else can to know to which
> >> switch a given device is connected?
> >
> > rdev->rswitch is not a pointer to the entire switch device object -
it
> > is a pointer to the switch specific extension associated with given
> > rio_dev (if applicable). There is no other role for rdev->rswitch.
>=20
> I know this, it doesn't answer my question.
>=20
> > Why would you keep a pointer to device data extension instead of the
> > pointer to attached device object itself?
>=20
> There is no particular reason, but this is a useful way to define the
> fields that are there.
>=20
> My point is, now that you remove the pointer field, that information
(to
> which switch is a particular device connected) cannot be stored in
this
> way, so do you have an alternative proposal for that? Maybe add a new
field.
>

See my comment below ;).

> > BTW, I have back and forward links added in previous patches and
only
> > one link that may be added later is a forward link from mport to the
> > attached rio_dev (ptr to rio_switch will not work here because it
can be
> > switchless connection). But this reference has to be added into
> > rio_mport.
>=20
> Possible, but I suggest to put it in the rio_net: fields rdev_host,
and
> rdev_self. You can see it in the patch I sent you.

Yes, we may rework rio_net that way and use some good things from there.

Alex.
