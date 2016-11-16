Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJtZF2kxyzDvn1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 05:48:37 +1100 (AEDT)
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.84_2)
 (envelope-from <ben@decadent.org.uk>) id 1c74xR-0001Ml-4r
 for linuxppc-dev@lists.ozlabs.org; Wed, 16 Nov 2016 18:29:17 +0000
Date: Wed, 16 Nov 2016 18:29:17 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <20161116182916.GF2697@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K1n7F7fSdjvFAEnM"
Subject: [PATCH] cxl: Fix potential build failure - select ANON_INODES
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--K1n7F7fSdjvFAEnM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

cxl calls anon_inode_get() so must select ANON_INODES.

Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/misc/cxl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
index b75cf830d08a..e745f77ac6a6 100644
--- a/drivers/misc/cxl/Kconfig
+++ b/drivers/misc/cxl/Kconfig
@@ -16,6 +16,7 @@ config CXL
 	depends on PPC_POWERNV && PCI_MSI && EEH
 	select CXL_BASE
 	select CXL_AFU_DRIVER_OPS
+	select ANON_INODES
 	default m
 	help
 	  Select this option to enable driver support for IBM Coherent

--K1n7F7fSdjvFAEnM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWCylfOe/yOyVhhEJAQp0nhAAvVhV0BdlYLmL/PponV4XqSQws14Xncl5
ufOQ8os+aYM3TCfRO+e+/trD7xjSWCNt6VmVal/Oo0lhVITar1H8R2P3NYxzyU/K
RLPjWCX+SjLdfwqhNMgVXla0omOxCq6V8vs1W7Ll778sqbcOzPUVIfMPrwPh60A/
gXuDSk+6MD2m/7GRy4P0loSUxYo+0XrPj5qAwbNdMiRKbbWLPAG80CyGgvxRarA2
uz4oItJzU7apRmSUXqd3KqshtLzqEu71/JmuPgqXF3Zxbv3+GBk2PWXdJs7RR7zF
a7W+ROicDQfu8RnBG0OJh2RkLliuj73PQRBicq2bZG3mmz/TwsH1t9FMWexsUk/X
5nu9LivIlObA0S487n9QNWShcEOhdAZfkmL89popinkt/ZhCFjJqkyRXQ//nQLhA
wgXYqHPUMM/Toryaw/9A89YrsT3vWu46rZZEgvXzK0v6SjF9rqctYB28a1TUNTME
nIrAbiuOSaQHF8AyA9ftT5nkTMdmZqTwIe9hLijI3JQo8Quxqf69JWS6s19qo2YA
CT2WMX3OSTTkITZZ4qdLINO7etEqnEkKz/jQFdl7ddio29PiF9JQMtEcyLnUhXk7
+g9r1gPbQIo7EtZQVk2pkkHhfR4UvlFUaZg0FYXY6ZClw3RnmON4qB8r/lE4JRae
WnXZYCsWj40=
=XAlG
-----END PGP SIGNATURE-----

--K1n7F7fSdjvFAEnM--
