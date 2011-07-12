Return-Path: <B08248@freescale.com>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3C375B6F74
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2011 00:21:00 +1000 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: RFC: top level compatibles for virtual platforms
Date: Tue, 12 Jul 2011 14:20:54 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150317061A@039-SN1MPN1-003.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E150316EAB6@039-SN1MPN1-003.039d.mgd.msft.net>
	<CAOZdJXVp5LHqYEMoqpnKEkuWyuE6kwU+Z9VwUYLPcz-+h_gqfw@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E150316F97F@039-SN1MPN1-003.039d.mgd.msft.net>
	<4E1B1AAB.8010301@freescale.com>
	<20110711112418.4db9f41e@schlenkerla.am.freescale.net>
	<9F6FE96B71CF29479FF1CDC8046E150316FBA5@039-SN1MPN1-003.039d.mgd.msft.net>
	<20110711130430.4b3036f6@schlenkerla.am.freescale.net>
	<9F6FE96B71CF29479FF1CDC8046E150316FF6B@039-SN1MPN1-003.039d.mgd.msft.net>
	<20110711160646.291e977e@schlenkerla.am.freescale.net>
In-Reply-To: <20110711160646.291e977e@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Tabi Timur-B04825 <B04825@freescale.com>, Alexander Graf <agraf@suse.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Monday, July 11, 2011 4:07 PM
> To: Yoder Stuart-B08248
> Cc: Wood Scott-B07421; Tabi Timur-B04825; Grant Likely; Benjamin Herrensc=
hmidt; Gala Kumar-
> B11780; Alexander Graf; linuxppc-dev@ozlabs.org
> Subject: Re: RFC: top level compatibles for virtual platforms
>=20
> On Mon, 11 Jul 2011 15:41:35 -0500
> Yoder Stuart-B08248 <B08248@freescale.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Monday, July 11, 2011 1:05 PM
> > >
> > > Just because Linux does it that way now doesn't mean it needs to.
> > > The interrupt controller has a compatible property.  Match on it
> > > like any other device.  You can find which one is the root interrupt
> > > controller by looking for nodes with the interrupt-controller
> > > property that doesn't have an explicit interrupt-parent (or an interr=
upts property?  seems
> to be a conflict between ePAPR and the original interrupt mapping documen=
t).
> >
> > This may be the right long term thing to do, but restructuring how
> > Linux powerpc platforms work is a bigger effort.  I was looking for an
> > incremental improvement over what we do now, which is pass a
> > compatible of MPC8544DS and P4080DS for these virtual platforms.
>=20
> A hack is usually easier than doing it right. :-)
>=20
> Though often the effort required for the latter is overstated, and the "r=
ight long term thing"
> never makes the jump to "short term plan".
>=20
> There are a few things that need to be driven off the device tree that cu=
rrently aren't --
> using some mechanism other than the standard device model, if necessary (=
or as a first step) -
> - and then we need a does-nothing default platform as the match of last r=
esort.
>=20
> > However, they _are_ compatible with MPC8544DS and P4080DS so maybe
> > leaving the compatible string alone is ok for now.
>=20
> The virtual platforms are not compatible with MPC8544DS or P4080DS.  Only=
 a subset of what is
> on those boards is provided.  And in the case of direct device assignment=
, often the things
> that are present are incompatible (e.g.
> different type of eTSEC).

Hmm.  Perhaps what we need is a real binding that defines specifically
what those compatibles mean.   While not identical, a KVM
virtual machine is compatible in certain areas with those
boards.

The ePAPR defines the top level compatible as:

    Specifies a list of platform architectures with which this
    platform is compatible. This property can be used by
    operating systems in selecting platform specific code.

1275 doesn't mention compatible on the root from what I can
see.

Stuart
