Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x231.google.com (mail-pd0-x231.google.com
 [IPv6:2607:f8b0:400e:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B01182C0084
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Aug 2013 10:45:51 +1000 (EST)
Received: by mail-pd0-f177.google.com with SMTP id u10so1947877pdi.22
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Aug 2013 17:45:49 -0700 (PDT)
Date: Sun, 4 Aug 2013 08:45:32 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 6/8] powerpc: introduce early_get_first_memblock_info
Message-ID: <20130804004531.GD19141@pek-khao-d1.corp.ad.wrs.com>
References: <1372942454-25191-7-git-send-email-haokexin@gmail.com>
 <1374884281.30721.40@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
In-Reply-To: <1374884281.30721.40@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2013 at 07:18:01PM -0500, Scott Wood wrote:
> >+ * This function run before early_init_devtree, so we have to init
> >+ * initial_boot_params. Since early_init_dt_scan_memory_ppc will be
> >+ * executed again in early_init_devtree, we have to reinitialize the
> >+ * memblock data before return.
> >+ */
> >+void __init early_get_first_memblock_info(void *params,
> >phys_addr_t *size)
> >+{
> >+	/* Setup flat device-tree pointer */
> >+	initial_boot_params =3D params;
> >+
> >+	/* Scan memory nodes and rebuild MEMBLOCKs */
> >+	of_scan_flat_dt(early_init_dt_scan_root, NULL);
> >+	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
> >+
> >+	if (size)
> >+		*size =3D first_memblock_size;
> >+
> >+	/* Undo what early_init_dt_scan_memory_ppc does to memblock */
> >+	memblock_reinit();
> >+}
> >+#endif
>=20
> Wouldn't it be simpler to set a flag so that
> early_init_dt_add_memory_arch() doesn't mess with memblocks on the
> first pass?

Do you mean something like this?

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 9a69d2d..e861394 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -523,6 +523,10 @@ static int __init early_init_dt_scan_memory_ppc(unsign=
ed long node,
=20
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
+#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_FSL_BOOKE)
+	static int first_time =3D 1;
+#endif
+
 #ifdef CONFIG_PPC64
 	if (iommu_is_off) {
 		if (base >=3D 0x80000000ul)
@@ -541,6 +545,13 @@ void __init early_init_dt_add_memory_arch(u64 base, u6=
4 size)
 	}
=20
 	/* Add the chunk to the MEMBLOCK list */
+
+#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_FSL_BOOKE)
+	if (first_time) {
+		first_time =3D 0;
+		return;
+	}
+#endif
 	memblock_add(base, size);
 }

Thanks,
Kevin
>=20
> -Scott

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR/aQrAAoJEJNY7TDerrFxgbcIAKeb25T4GXKm5NCRknbkfJ90
/EpoEjLRXc+FgFCqn2X+gXFcmcgh7QDU1JrlQfgNGSJ1u0whqkcUgi8NNhgTo+om
FK+tQzhJd3C1xKINdN/eHa5xvw0pcrSRkz32ZM6OFgnjlWgxgNaXD1w6V3Cz6FgG
/+ui6POSIGZqPzpb2cAm2bu5qfQrWM5Tfmqycg41r2cUN/zGTB5gYbCUZG0f8Qw4
akwXIt9iG4SdR+hod+jzrLz36rTTPD43Zwk8TC5mPjFjZ9D3/NlrGwd+0IQCfEZy
kJijvpQWMUtw7PaTZoiop13iJozSTw9aZ4ZjBFi2zCG1BRzkrLspsGjJ/tnstBU=
=JHXK
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
