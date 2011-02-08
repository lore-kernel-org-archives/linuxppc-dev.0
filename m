Return-Path: <B08248@freescale.com>
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Meador Inge
	<meador_inge@mentor.com>
Subject: RE: [PATCH v3 1/4] powerpc: Removing support for 'protected-sources'
Date: Tue, 8 Feb 2011 15:13:13 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15030C2233@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>
	<1296861941-3370-2-git-send-email-meador_inge@mentor.com>
	<1297035336.14982.14.camel@pasglop>  <4D5033C9.8030407@mentor.com>
	<1297115136.14982.82.camel@pasglop>
In-Reply-To: <1297115136.14982.82.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Hollis Blanchard <hollis_blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: devicetree-discuss-
> bounces+stuart.yoder=3Dfreescale.com@lists.ozlabs.org [mailto:devicetree-
> discuss-bounces+stuart.yoder=3Dfreescale.com@lists.ozlabs.org] On Behalf =
Of
> Benjamin Herrenschmidt
> Sent: Monday, February 07, 2011 3:46 PM
> To: Meador Inge
> Cc: Hollis Blanchard; devicetree-discuss@lists.ozlabs.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH v3 1/4] powerpc: Removing support for 'protected-
> sources'
>=20
>=20
> > In my previous reply I said that "it is not so much as a need as it is
> > a potential simplification."  After further reflection, I don't think
> > that is completely true.  As we get into AMP systems with higher core
> > counts, then implementing this functionality using the existing
> > "protected-sources" implementation versus the new "pic-no-reset" work
> > is going to be harder to maintain.
>=20
> I'm not arguing that your approach isn't more suitable for AMP systems, I
> just want to leave the existing protected-sources mechanism alone. I'm no=
t
> opposing adding a new, better, mechanism for newer platforms.
>=20
> However, I'd name it differently. "pic-no-reset" doesn't carry enough
> meaning in that case. What we want to point out here is that the PIC has
> been pre-initialized.
>=20
> Another option, which may be cleaner, is to stick to "no-reset" (no need
> for pic- prefix) and make it do just that (prevent the reset), and then u=
se
> a positive variant of "protected-sources", call it "allowed-sources". May=
be
> even make it a series of ranges. Then have the MPIC only access these.
>=20
> I think this is more robust as it would also prevent "accidental" use of
> the wrong sources (bad device-tree, drivers that let you muck around with
> irq numbers, etc...).

What is the use case for "allowed-sources"?   For AMP the only device
nodes in your device tree should be your AMP partition's devices,
thus any interrupt specifiers in your dev tree are "allowed".

The MPIC is a shared device and thus the need for no-reset.

So, all newer platforms should need is "no-reset".

Stuart
