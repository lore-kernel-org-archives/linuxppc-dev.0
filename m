Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 98229B70D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 00:32:01 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 03/10] RapidIO: Use stored ingress port number instead
	of register read
Date: Mon, 20 Sep 2010 07:31:22 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201303D0E@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20100914151219.5d92c6f9.akpm@linux-foundation.org>
References: <1284476363-1677-1-git-send-email-alexandre.bounine@idt.com><1284476363-1677-4-git-send-email-alexandre.bounine@idt.com>
	<20100914151219.5d92c6f9.akpm@linux-foundation.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Andrew Morton" <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton <akpm@linux-foundation.org> wrote:
>=20
> > @@ -219,6 +219,7 @@ struct rio_net {
> >  /**
> >   * struct rio_switch - RIO switch info
> >   * @node: Node in global list of switches
> > + * @rdev: Associated RIO device structure
> >   * @switchid: Switch ID that is unique across a network
> >   * @hopcount: Hopcount to this switch
> >   * @destid: Associated destid in the path
> > @@ -234,6 +235,7 @@ struct rio_net {
> >   */
> >  struct rio_switch {
> >  	struct list_head node;
> > +	struct rio_dev *rdev;
> >  	u16 switchid;
> >  	u16 hopcount;
> >  	u16 destid;
>=20
> What is the locking for rdev?

This question prompted me consider the following change:

Because the rio_switch structure (in current implementation) is a
dynamically allocated part of rio_dev, I think it may be simpler to
combine them into single allocation by using zero length array
declaration:

struct rio_dev {
    struct list_head global_list;
    struct list_head net_list;
    .....
    ..... rest of rio_dev
    .....
    struct rio_switch switch[0];
}

This will remove extra memory allocation, remove overlapping structure
members and clean code sections like one shown below:

	u8 hopcount =3D 0xff;
	u16 destid =3D rdev->destid;

	if (rdev->rswitch) {
		destid =3D rdev->rswitch->destid;
		hopcount =3D rdev->rswitch->hopcount;
	}   =20

And this looks better aligned with RapidIO definitions - both: endpoints
and switches are RIO devices. The current implementation of rio_dev
somewhat separates rio_switch from its common part (this is why I have
added that link into rio_switch). We may keep using the pointer to
associated rio_dev, but reworking the rio_dev structure seems better way
to me.

Please, let me know what do you think about this conversion. And if
there are no objections I will make a patch.

Alex.
    =20
