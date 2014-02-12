Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 921522C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 16:28:33 +1100 (EST)
Received: by mail-pd0-f176.google.com with SMTP id w10so8503556pde.21
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 21:28:29 -0800 (PST)
Date: Wed, 12 Feb 2014 13:28:16 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Stephen N Chivers <schivers@csc.com.au>
Subject: Re: Linux-3.14-rc2: Order of serial node compatibles in DTS files.
Message-ID: <20140212052816.GA15434@pek-khao-d1.corp.ad.wrs.com>
References: <alpine.LRH.2.00.1402071348380.10318@ra8135-ec1.am.freescale.net>
 <20140210110342.GA15806@visitor2.iram.es>
 <alpine.LRH.2.00.1402101056410.10318@ra8135-ec1.am.freescale.net>
 <20140211072606.GA26514@visitor2.iram.es>
 <OF6F6A0029.3B20EF5B-ONCA257C7C.0071BFDA-CA257C7C.00732AD3@csc.com>
 <63AEBD99-AA87-4FD7-BBDA-0CE419959F14@kernel.crashing.org>
 <52FAA97F.4060600@gmail.com>
 <1392162080.6733.404.camel@snotra.buserror.net>
 <52FAB65C.4090201@gmail.com>
 <OF9BA019D5.46DA1E29-ONCA257C7D.000089EA-CA257C7D.00020333@csc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
In-Reply-To: <OF9BA019D5.46DA1E29-ONCA257C7D.000089EA-CA257C7D.00020333@csc.com>
Cc: Chris Proctor <cproctor@csc.com.au>, Arnd Bergmann <arnd@arndb.de>,
 devicetree <devicetree@vger.kernel.org>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2014 at 10:21:58AM +1000, Stephen N Chivers wrote:
> But, the Interrupt Controller (MPIC)
> goes AWOL and it is down hill from there.
>=20
> The MPIC is specified in the DTS as:
>=20
>         mpic: pic@40000 {
>                         interrupt-controller;
>                         #address-cells =3D <0>;
>                         #interrupt-cells =3D <2>;
>                         reg =3D <0x40000 0x40000>;
>                         compatible =3D "chrp,open-pic";
>                         device_type =3D "open-pic";
>                         big-endian;
>                 };
>=20
> The board support file has the standard mechanism for allocating
> the PIC:
>=20
>         struct mpic *mpic;
>=20
>         mpic =3D mpic_alloc(NULL, 0, 0, 0, 256, " OpenPIC  ");
>         BUG_ON(mpic =3D=3D NULL);
>=20
>         mpic_init(mpic);
>=20
> I checked for damage in applying the patch and it has applied
> correctly.

How about the following fix?

diff --git a/drivers/of/base.c b/drivers/of/base.c
index ff85450d5683..ca91984d3c4b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -730,32 +730,40 @@ out:
 }
 EXPORT_SYMBOL(of_find_node_with_property);
=20
+static int of_match_type_name(const struct device_node *node,
+				const struct of_device_id *m)
+{
+	int match =3D 1;
+
+	if (m->name[0])
+		match &=3D node->name && !strcmp(m->name, node->name);
+
+	if (m->type[0])
+		match &=3D node->type && !strcmp(m->type, node->type);
+
+	return match;
+}
+
 static
 const struct of_device_id *__of_match_node(const struct of_device_id *matc=
hes,
 					   const struct device_node *node)
 {
 	const char *cp;
 	int cplen, l;
+	const struct of_device_id *m;
+	int match;
=20
 	if (!matches)
 		return NULL;
=20
 	cp =3D __of_get_property(node, "compatible", &cplen);
 	do {
-		const struct of_device_id *m =3D matches;
+		m =3D matches;
=20
 		/* Check against matches with current compatible string */
-		while (m->name[0] || m->type[0] || m->compatible[0]) {
-			int match =3D 1;
-			if (m->name[0])
-				match &=3D node->name
-					&& !strcmp(m->name, node->name);
-			if (m->type[0])
-				match &=3D node->type
-					&& !strcmp(m->type, node->type);
-			if (m->compatible[0])
-				match &=3D cp
-					&& !of_compat_cmp(m->compatible, cp,
+		while (m->compatible[0]) {
+			match =3D of_match_type_name(node, m);
+			match &=3D cp && !of_compat_cmp(m->compatible, cp,
 							strlen(m->compatible));
 			if (match)
 				return m;
@@ -770,6 +778,15 @@ const struct of_device_id *__of_match_node(const struc=
t of_device_id *matches,
 		}
 	} while (cp && (cplen > 0));
=20
+	/* Check against matches without compatible string */
+	m =3D matches;
+	while (!m->compatible[0] && (m->name[0] || m->type[0])) {
+		match =3D of_match_type_name(node, m);
+		if (match)
+			return m;
+		m++;
+	}
+
 	return NULL;
 }


Thanks,
Kevin
>=20
> Stephen Chivers,
> CSC Australia Pty. Ltd.
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJS+wZwAAoJEJNY7TDerrFxwe0H/if5TJun5BPaDp8Y0ucE+KRA
KQTILVanHPf6iUzp3u0UAkPWKvZXdQ/+1JzfPayk3fP6I0EERybXLkNPKGWKfgpm
tv5VGGQ4l6GUxN9XIvNgn2uauvUzLx2uJFvQL8HXNDuQ3ihL4HQ5SAn7Crx8++/G
9f9tw0UzVN1AC1pptw2PvrNuVplw9hVxVHGFrEzgL9e/9IR948yTibyYMYP4tVTF
6X2zQBb4U0Jt2wGYenvY8SeYE2jVVPjbq0eHI01XegJcKkDlXMZUILrnpv0rjtOk
ZQWMygGlkr9gCJ77jqzysqy36VbA1oSGGZXy0tSFu4jcmalvV5DW+AX8PV9Om/g=
=KyaM
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
