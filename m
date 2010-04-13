Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6AC17B7D0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Apr 2010 01:18:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v3 3/6] RapidIO: Add Port-Write handling for EM
Date: Tue, 13 Apr 2010 08:00:29 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552CBCBCD@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <20100412204949.862b3fab.akpm@linux-foundation.org>
References: <20100406212238.GC26292@amak.tundra.com>
	<20100412204949.862b3fab.akpm@linux-foundation.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Andrew Morton" <akpm@linux-foundation.org>,
	"Alexandre Bounine" <abounine@tundra.com>
Cc: linuxppc-dev@lists.ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, thomas.moll@sysgo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton wrote:
> On Tue, 6 Apr 2010 17:22:38 -0400 Alexandre Bounine
<abounine@tundra.com> wrote:
>=20
> >
> > From: Alexandre Bounine <alexandre.bounine@idt.com>
> >
> > Add RapidIO Port-Write message handling in the context
> > of Error Management Extensions Specification Rev.1.3.
> >
> > ...
> >
> > +static struct rio_dev *rio_get_comptag(u32 comp_tag, struct rio_dev
*from)
> > +{
> > +	struct list_head *n;
> > +	struct rio_dev *rdev;
> > +
> > +	WARN_ON(in_interrupt());
>=20
> The check should be unneeded - lockdep will warn about this.

Thank you. I will remove it in my next set of patches.=20

>=20
> > +	spin_lock(&rio_global_list_lock);
> > +	n =3D from ? from->global_list.next : rio_devices.next;
> > +
> > +	while (n && (n !=3D &rio_devices)) {
> > +		rdev =3D rio_dev_g(n);
> > +		if (rdev->comp_tag =3D=3D comp_tag)
> > +			goto exit;
> > +		n =3D n->next;
> > +	}
> > +	rdev =3D NULL;
> > +exit:
> > +	spin_unlock(&rio_global_list_lock);
> > +	return rdev;
> > +}
> > +
