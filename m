Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x229.google.com (mail-pb0-x229.google.com
 [IPv6:2607:f8b0:400e:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3635A2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 21:32:18 +1100 (EST)
Received: by mail-pb0-f41.google.com with SMTP id up15so9115388pbc.28
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 02:32:15 -0800 (PST)
Date: Wed, 12 Feb 2014 18:31:53 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: Linux-3.14-rc2: Order of serial node compatibles in DTS files.
Message-ID: <20140212103153.GC15434@pek-khao-d1.corp.ad.wrs.com>
References: <alpine.LRH.2.00.1402101056410.10318@ra8135-ec1.am.freescale.net>
 <20140211072606.GA26514@visitor2.iram.es>
 <OF6F6A0029.3B20EF5B-ONCA257C7C.0071BFDA-CA257C7C.00732AD3@csc.com>
 <63AEBD99-AA87-4FD7-BBDA-0CE419959F14@kernel.crashing.org>
 <52FAA97F.4060600@gmail.com>
 <1392162080.6733.404.camel@snotra.buserror.net>
 <52FAB65C.4090201@gmail.com>
 <OF9BA019D5.46DA1E29-ONCA257C7D.000089EA-CA257C7D.00020333@csc.com>
 <20140212052816.GA15434@pek-khao-d1.corp.ad.wrs.com>
 <52FB3108.3000202@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
In-Reply-To: <52FB3108.3000202@gmail.com>
Cc: Chris Proctor <cproctor@csc.com.au>, Arnd Bergmann <arnd@arndb.de>,
 devicetree <devicetree@vger.kernel.org>,
 Stephen N Chivers <schivers@csc.com.au>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2014 at 09:30:00AM +0100, Sebastian Hesselbarth wrote:
> On 02/12/2014 06:28 AM, Kevin Hao wrote:
> >On Wed, Feb 12, 2014 at 10:21:58AM +1000, Stephen N Chivers wrote:
> >>But, the Interrupt Controller (MPIC)
> >>goes AWOL and it is down hill from there.
> >>
> >>The MPIC is specified in the DTS as:
> >>
> >>         mpic: pic@40000 {
> >>                         interrupt-controller;
> >>                         #address-cells =3D <0>;
> >>                         #interrupt-cells =3D <2>;
> >>                         reg =3D <0x40000 0x40000>;
> >>                         compatible =3D "chrp,open-pic";
> >>                         device_type =3D "open-pic";
> >>                         big-endian;
> >>                 };
> >>
> >>The board support file has the standard mechanism for allocating
> >>the PIC:
> >>
> >>         struct mpic *mpic;
> >>
> >>         mpic =3D mpic_alloc(NULL, 0, 0, 0, 256, " OpenPIC  ");
> >>         BUG_ON(mpic =3D=3D NULL);
> >>
> >>         mpic_init(mpic);
> >>
> >>I checked for damage in applying the patch and it has applied
> >>correctly.
> >
> >How about the following fix?
> >
> >diff --git a/drivers/of/base.c b/drivers/of/base.c
> >index ff85450d5683..ca91984d3c4b 100644
> >--- a/drivers/of/base.c
> >+++ b/drivers/of/base.c
> >@@ -730,32 +730,40 @@ out:
> >  }
> >  EXPORT_SYMBOL(of_find_node_with_property);
> >
> >+static int of_match_type_name(const struct device_node *node,
> >+				const struct of_device_id *m)
>=20
> I am fine with having a sub-function here, but it should rather be
> named of_match_type_or_name.

OK.

>=20
> >+{
> >+	int match =3D 1;
> >+
> >+	if (m->name[0])
> >+		match &=3D node->name && !strcmp(m->name, node->name);
> >+
> >+	if (m->type[0])
> >+		match &=3D node->type && !strcmp(m->type, node->type);
> >+
> >+	return match;
> >+}
> [...]
> >+	/* Check against matches without compatible string */
> >+	m =3D matches;
> >+	while (!m->compatible[0] && (m->name[0] || m->type[0])) {
>=20
> We shouldn't check for anything else than the sentinel here.
> Although I guess yours will not quit early as mine did but that
> way we don't have to worry about it.

Yes, this is still buggy. I will change something like this:

	m =3D matches;
	/* Check against matches without compatible string */
	while (m->name[0] || m->type[0] || m->compatible[0]) {
		if (m->compatible[0]) {
			m++;
			continue;
		}

		match =3D of_match_type_name(node, m);
		if (match)
			return m;
		m++;
	}

Thanks,
Kevin

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJS+02ZAAoJEJNY7TDerrFx6eEH/0c9N4fQc6JtK8IGHhWFnc1J
pispim0tMEah8kU8gXfLb4SLCZRz4pbu2BNduLAq0bQJe5131qaMTgeEyp2c+Cko
tBGSHdwGxYfDh0H4gwouGOORup+Pcm9MGN+wEpoiIkXwpjKPgifOYBqL46a3zMz/
LbNwcFnIVVoWmnjGwj+KJV+U7xaYe+HdoB98LPzE9JmhVD3R2n5zPxQGdpuFnqHn
mAAmTxILQJQV+ZY/HUfqTw/NDrEvqI234TbfqV2SModJ4ZCH/GC9J9uF+43KdFtN
2qPzNdJophfC284Lt1UXjwJZoMBkNoKQPRo6rOnjjIWR+baaD0tjYAA4yYQTA+0=
=qVT2
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
