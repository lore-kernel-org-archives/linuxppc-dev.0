Return-Path: <B08248@freescale.com>
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: RE: [PATCH 1/2] powerpc: document the MPIC device tree binding
Date: Thu, 20 Jan 2011 15:50:47 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E150307A5C8@039-SN1MPN1-004.039d.mgd.msft.net>
References: <4D34E448.8000902@mentor.com>
	<AANLkTi=QX4BfLvPfQDMOgmh90TtX4MQqio6AOZR8JKas@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E150306BF11@039-SN1MPN1-004.039d.mgd.msft.net>
	<4D377CE3.6000608@mentor.com>
In-Reply-To: <4D377CE3.6000608@mentor.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
	Wood Scott-B07421 <B07421@freescale.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Meador Inge [mailto:meador_inge@mentor.com]
> Sent: Wednesday, January 19, 2011 6:08 PM
> To: Yoder Stuart-B08248
> Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; devicetree-
> discuss@lists.ozlabs.org; Blanchard, Hollis
> Subject: Re: [PATCH 1/2] powerpc: document the MPIC device tree binding
>=20
> On 01/19/2011 04:14 PM, Yoder Stuart-B08248 wrote:
> >
> >> +** Optional properties:
> >> +
> >> +   - no-reset : The presence of this property indicates that the MPIC
> >> +                should not be reset during runtime initialization.
> >> +   - protected-sources : Specifies a list of interrupt sources that
> >> + are not
> >> +                         available for use and whose corresponding
> >> + vectors
> >> +                         should not be initialized.  A typical use
> >> + case for
> >> +                         this property is in AMP systems where multip=
le
> >> +                         independent operating systems need to share
> >> + the MPIC
> >> +                         without clobbering each other.
> >
> > Is "protected-sources" really needed for AMP systems to tell the OSes
> > not to clobber each other?  Won't each OS be given a device tree with
> > only its interrupt sources?  ...so you know what you are allowed to
> > touch.
>=20
> This was discussed a little bit already [1, 2].  The MPIC driver currentl=
y
> initializes the VECPRI register for all interrupt sources, which can lead
> to the aforementioned clobbering.

For sources that are protected and not to be touched, it seems
that the other need is for the OS to know (be guaranteed?) that
those sources have been put in state where the source is masked
or directed to other cores.   You can't have interrupts occurring
on sources that you are not allowed to initialize.

So the "no-reset" property could potentially cover this as well-- if it was
defined to mean "don't reset the mpic" and boot firmware has put all source=
s
in a sane initial state.   And we wouldn't need the "protected-sources"
property any longer.

Stuart


Right...so it would seem that the no-reset property if prop
