Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C026E2C00E2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 06:40:03 +1000 (EST)
Message-ID: <1379363970.2536.151.camel@snotra.buserror.net>
Subject: Re: [PATCH v4] powerpc/mpc85xx: Update the clock device tree nodes
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian-B29983 <B29983@freescale.com>
Date: Mon, 16 Sep 2013 15:39:30 -0500
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B15089208@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1378882632-9053-1-git-send-email-Yuantian.Tang@freescale.com>
 <1378948229.12204.486.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150748AA@039-SN2MPN1-013.039d.mgd.msft.net>
 <1378997052.2536.5.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B15089208@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-Leo-R58472 <r58472@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-12 at 21:50 -0500, Tang Yuantian-B29983 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: 2013=E5=B9=B49=E6=9C=8812=E6=97=A5 =E6=98=9F=E6=9C=9F=E5=9B=9B =
22:44
> > To: Tang Yuantian-B29983
> > Cc: Wood Scott-B07421; galak@kernel.crashing.org; linuxppc-
> > dev@lists.ozlabs.org; devicetree@vger.kernel.org; Li Yang-Leo-R58472
> > Subject: Re: [PATCH v4] powerpc/mpc85xx: Update the clock device tree
> > nodes
> >=20
> > On Wed, 2013-09-11 at 20:31 -0500, Tang Yuantian-B29983 wrote:
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: 2013=E5=B9=B49=E6=9C=8812=E6=97=A5 =E6=98=9F=E6=9C=9F=E5=9B=
=9B 9:10
> > > > To: Tang Yuantian-B29983
> > > > Cc: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org;
> > > > devicetree@vger.kernel.org; Li Yang-Leo-R58472
> > > > Subject: Re: [PATCH v4] powerpc/mpc85xx: Update the clock device
> > > > tree nodes
> > > >
> > > > This description of "reg" is overly specific (assumes how the par=
ent
> > > > node's ranges are set up), incomplete (there's a size as well as =
the
> > > > offset), and does not apply to the clockgen node itself (you
> > > > probably shouldn't lump them together like this).
> > > >
> > > Do you mean I should explain the REG of clockgen and its child node
> > respectively?
> > >
> > > > > +- clocks : shall be the input parent clock phandle for the clo=
ck.
> > > >
> > > > Not required on the clockgen node
> > > >
> > > Required by child node of clockgen.
> >=20
> > My point is that you're lumping several different types of nodes toge=
ther
> > with one binding, when some parts of the binding are not applicable t=
o
> > the clockgen node.
> >=20
> Not several, just two types of nodes.
> One is clockgen node, the other is PLL and mux nodes.

clockgen + PLL + mux =3D 3 =3D several :-)

> The reason they lumped together is that the clockgen node is not only I=
P block
> Node but also a clock provider node

I don't understand why that merits lumping them together.

Just describe them separately.

> At first, I want to add a extra fixed-clock node and move the clock-fre=
quency of clockgen=20
> Node to it, but it is against the backward compatibility

Right.

> which I think it is not a big deal, Because nobody hasn't used it yet.

The point is it will require updating U-Boot to use it, versus existing
U-Boots which already patch up the clock-frequency in the clockgen node.
And there's nothing semantically wrong with the way it currently is.

> If I add a extra node with the clock-frequency property and don't move =
the
> clock-frequency property of clockgen, that would be redundant because b=
oth clockgen node
> and the extra node have the same clock-frequency node.
> So, I choose what I did now.

I'm not complaining about how you structured the nodes, just how you
documented them.

-Scott
