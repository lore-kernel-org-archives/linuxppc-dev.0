Return-Path: <jezz@sysmic.org>
Received: from draco.sysmic.org (sysmic.org [88.191.45.54])
	by ozlabs.org (Postfix) with ESMTP id 5977EB7B96
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Oct 2009 02:21:09 +1100 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Nested function in drivers/of/of_mdio.c
From: =?iso-8859-1?q?J=E9r=F4me_Pouiller?= <jezz@sysmic.org>
Date: Wed, 7 Oct 2009 17:15:57 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200910071715.57249.jezz@sysmic.org>
Cc: netdev <netdev@vger.kernel.org>, linuxppc <linuxppc-dev@lists.ozlabs.org>,
	Andy Fleming <afleming@freescale.com>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear,

I have a problem with commit 8bc487d150b939e69830c39322df4ee486efe381=20
in file drivers/of/of_mdio.c in function of_phy_find_device.

As you see, this function define match() as a nested function. My=20
compiler (powerpc-e500-linux-gnu-gcc-3.4.1) raise an error during link=20
due to this nested definition:
  drivers/built-in.o(.text+0x5e2a4): In function `of_phy_find_device': /hom=
e/jezz/linux-next/drivers/of/of_mdio.c:107:=20
undefined reference to `__trampoline_setup'

I am sure I could solve problem by rebuilding my toolchain.=20
Nevertheless, I think nested function definition is not perfectly=20
supported by all compilers. Also, I suggest to place function match()=20
outside of scope of of_phy_find_device as in following patch.

diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index bacaa53..c7b2e26 100644
=2D-- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -97,6 +97,10 @@ int of_mdiobus_register(struct mii_bus *mdio, struct dev=
ice_node *np)
 }
 EXPORT_SYMBOL(of_mdiobus_register);

+static int match(struct device *dev, void *phy_np)
+{
+       return dev_archdata_get_node(&dev->archdata) =3D=3D phy_np;
+}
 /**
  * of_phy_find_device - Give a PHY node, find the phy_device
  * @phy_np: Pointer to the phy's device tree node
@@ -106,11 +110,6 @@ EXPORT_SYMBOL(of_mdiobus_register);
 struct phy_device *of_phy_find_device(struct device_node *phy_np)
 {
        struct device *d;
=2D       int match(struct device *dev, void *phy_np)
=2D       {
=2D               return dev_archdata_get_node(&dev->archdata) =3D=3D phy_n=
p;
=2D       }
=2D
        if (!phy_np)
                return NULL;


What do you think about it?

Best regards,

=2D-=20
J=E9r=F4me Pouiller (jezz AT sysmic DOT org)
