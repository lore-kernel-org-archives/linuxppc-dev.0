Return-Path: <hartleys@visionengravers.com>
Received: from exprod6og103.obsmtp.com (exprod6og103.obsmtp.com [64.18.1.185])
	by ozlabs.org (Postfix) with SMTP id A6D801007D5
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Dec 2009 06:37:53 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [PATCH] arch/powerpc/boot/devtree.c: use %pM to show MAC address
Date: Wed, 30 Dec 2009 14:30:39 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200F65E@mi8nycmail19.Mi8.com>
From: "H Hartley Sweeten" <hartleys@visionengravers.com>
To: <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the %pM kernel extension to display the MAC address.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index a7e21a3..a2f07a5 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -93,10 +93,7 @@ void dt_fixup_mac_address_by_alias(const char *alias, =
const u8 *addr)
 	void *devp =3D find_node_by_alias(alias);
=20
 	if (devp) {
-		printf("%s: local-mac-address <-"
-		       " %02x:%02x:%02x:%02x:%02x:%02x\n\r", alias,
-		       addr[0], addr[1], addr[2],
-		       addr[3], addr[4], addr[5]);
+		printf("%s: local-mac-address <- %pM\n\r", alias, addr);
=20
 		setprop(devp, "local-mac-address", addr, 6);
 	}
@@ -108,10 +105,7 @@ void dt_fixup_mac_address(u32 index, const u8 =
*addr)
 	                                     (void*)&index, sizeof(index));
=20
 	if (devp) {
-		printf("ENET%d: local-mac-address <-"
-		       " %02x:%02x:%02x:%02x:%02x:%02x\n\r", index,
-		       addr[0], addr[1], addr[2],
-		       addr[3], addr[4], addr[5]);
+		printf("ENET%d: local-mac-address <- %pM\n\r", index, addr);
=20
 		setprop(devp, "local-mac-address", addr, 6);
 	}=20
