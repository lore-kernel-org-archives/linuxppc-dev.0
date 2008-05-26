Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 824C0DDFBA
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 19:54:32 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] fs_enet: MDIO on GPIO support
Date: Mon, 26 May 2008 11:53:45 +0200
References: <200805261152.37636.laurentp@cse-semaphore.com>
In-Reply-To: <200805261152.37636.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2090545.1kyR6iepye";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200805261153.46131.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>, netdev@vger.kernel.org,
	jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2090545.1kyR6iepye
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Port the fs_enet driver to support the MDIO on GPIO driver for PHY access
in addition to the mii-bitbang driver.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 drivers/net/fs_enet/fs_enet-main.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_en=
et-main.c
index 67b4b07..b0eb1d2 100644
=2D-- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -43,6 +43,7 @@
 #include <asm/uaccess.h>
=20
 #ifdef CONFIG_PPC_CPM_NEW_BINDING
+#include <linux/of_gpio.h>
 #include <asm/of_platform.h>
 #endif
=20
@@ -1172,8 +1173,7 @@ static int __devinit find_phy(struct device_node *np,
                               struct fs_platform_info *fpi)
 {
 	struct device_node *phynode, *mdionode;
=2D	struct resource res;
=2D	int ret =3D 0, len;
+	int ret =3D 0, len, bus_id;
 	const u32 *data;
=20
 	data  =3D of_get_property(np, "fixed-link", NULL);
@@ -1190,19 +1190,28 @@ static int __devinit find_phy(struct device_node *n=
p,
 	if (!phynode)
 		return -EINVAL;
=20
=2D	mdionode =3D of_get_parent(phynode);
=2D	if (!mdionode)
+	data =3D of_get_property(phynode, "reg", &len);
+	if (!data || len !=3D 4) {
+		ret =3D -EINVAL;
 		goto out_put_phy;
+	}
=20
=2D	ret =3D of_address_to_resource(mdionode, 0, &res);
=2D	if (ret)
=2D		goto out_put_mdio;
+	mdionode =3D of_get_parent(phynode);
+	if (!mdionode) {
+		ret =3D -EINVAL;
+		goto out_put_phy;
+	}
=20
=2D	data =3D of_get_property(phynode, "reg", &len);
=2D	if (!data || len !=3D 4)
=2D		goto out_put_mdio;
+	bus_id =3D of_get_gpio(mdionode, 0);
+	if (bus_id < 0) {
+		struct resource res;
+		ret =3D of_address_to_resource(mdionode, 0, &res);
+		if (ret)
+			goto out_put_mdio;
+		bus_id =3D res.start;
+	}
=20
=2D	snprintf(fpi->bus_id, 16, "%x:%02x", res.start, *data);
+	snprintf(fpi->bus_id, 16, "%x:%02x", bus_id, *data);
=20
 out_put_mdio:
 	of_node_put(mdionode);
=2D-=20
1.5.0


=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2090545.1kyR6iepye
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIOoiq8y9gWxC9vpcRAk8kAJ9zKUmnFid0kVwfMbnhhFrt73ByzACgm2/l
34oiBoT7sv0VGZeUlrU4yeU=
=i3rx
-----END PGP SIGNATURE-----

--nextPart2090545.1kyR6iepye--
