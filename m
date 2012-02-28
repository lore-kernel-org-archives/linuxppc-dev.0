Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 47735B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 15:23:11 +1100 (EST)
Date: Tue, 28 Feb 2012 15:23:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: linux-next: manual merge of the irqdomain tree with the powerpc tree
Message-Id: <20120228152302.fc40b12b9006bd15d2cf682b@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__28_Feb_2012_15_23_02_+1100_X=g_1Pk=xU.G0D/W"
Cc: linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__28_Feb_2012_15_23_02_+1100_X=g_1Pk=xU.G0D/W
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

Today's linux-next merge of the irqdomain tree got a conflict in
arch/powerpc/sysdev/mpic.c between commit fe83364f0bf1 ("powerpc/mpic:
Fix allocation of reverse-map for multi-ISU mpics") from the powerpc tree
and commit a8db8cf0d894 ("irq_domain: Replace irq_alloc_host() with
revmap-specific initializers") from the irqdomain tree.

I fixed it up (see below) and can carry the fix as necessary.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/powerpc/sysdev/mpic.c
index 16eb743,c83a512..0000000
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@@ -1355,9 -1345,9 +1355,9 @@@ struct mpic * __init mpic_alloc(struct=20
  	mpic->isu_shift =3D 1 + __ilog2(mpic->isu_size - 1);
  	mpic->isu_mask =3D (1 << mpic->isu_shift) - 1;
 =20
- 	mpic->irqhost =3D irq_alloc_host(mpic->node, IRQ_HOST_MAP_LINEAR,
+ 	mpic->irqhost =3D irq_domain_add_linear(mpic->node,
 -				       isu_size ? isu_size : mpic->num_sources,
 -				       &mpic_host_ops, mpic);
 +				       last_irq + 1, &mpic_host_ops,
- 				       intvec_top + 1);
++				       mpic);
 =20
  	/*
  	 * FIXME: The code leaks the MPIC object and mappings here; this

--Signature=_Tue__28_Feb_2012_15_23_02_+1100_X=g_1Pk=xU.G0D/W
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPTFamAAoJEECxmPOUX5FEbHQQAIXcrHAhJIS7+LSX+0MFkBwZ
kj+e8GTXYY3uVtbsa9pyJFH8J4Jw7ZItjhLzaQFa0/tv8UFZmk0woZ2uhO7Cli/I
gfytKAoHvnTjxHb8b4mDwVO8FLc6wdGzdMwZ/ZH0CTflEH3ztIopEyIiFB4S52so
b/iuuN23iEjvsEwyvW+f+YseQc8LrU/mac7zvkBoxJzIucfUEIT04+uQPCK5HOV2
axect5Jx9NY3oMmNb6SwTWK172DySTP8uiGEeme1NWUCQTjLs9+cnI4KEfrdpHc0
VpXk1oM4H+TSodueadC1+a7+rpiWHLp12YJ0D1I4TO292Oux+AVHbJGF2QBCBelB
/6LNrlQv8I+EEPGiHzUXGiuaMR/M3Yh/OvozialD+cjQ+HPRpo3D0jn3kycMgrmQ
oqBskWsNOglFNSNxTxgFLkYUxwx9DAT413ZsHBqbSXUonSS8O0EndMSNV57J7U7y
bNL1b+98jD73rdKNpjA97rOiFk9CDd4c8OmZZVIHNx0zUb6kyRR6iiwDlf4ybqmF
8bibPxLtIG+C538F0LjAfkaKGLajJJ72UBne74nFzye9iRBBhLCY9RcN2MmA2d6j
PFj4N9mdm8xYCes+A641qqFvgg7OwNRMn6CB+fwNUzawe81hcs1CBOdslzUJ9LOs
kU8otnraPitnkZwEecuW
=NIvD
-----END PGP SIGNATURE-----

--Signature=_Tue__28_Feb_2012_15_23_02_+1100_X=g_1Pk=xU.G0D/W--
