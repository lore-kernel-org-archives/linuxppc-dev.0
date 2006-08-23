Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 6E12667CE5
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 12:20:36 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7N2KVJ2015634
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 19:20:31 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7N2KSoZ027834
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 21:20:30 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH ] powerpc:  pass UPIO_TSI flag to 8259 serial driver
Date: Wed, 23 Aug 2006 10:20:27 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E532@zch01exm23.fsl.freescale.net>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch passes the UPIO_TSI flag to general 8259 serial driver

Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>=20

---
 arch/powerpc/kernel/legacy_serial.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c
b/arch/powerpc/kernel/legacy_serial.c
index 359ab89..07c2c00 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -115,6 +115,7 @@ static int __init add_legacy_soc_port(st
 	u64 addr;
 	u32 *addrp;
 	upf_t flags =3D UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ;
+	struct device_node *tsi =3D of_get_parent(np);
=20
 	/* We only support ports that have a clock frequency properly
 	 * encoded in the device-tree.
@@ -134,7 +135,10 @@ static int __init add_legacy_soc_port(st
 	/* Add port, irq will be dealt with later. We passed a
translated
 	 * IO port value. It will be fixed up later along with the irq
 	 */
-	return add_legacy_port(np, -1, UPIO_MEM, addr, addr, NO_IRQ,
flags, 0);
+	if (tsi && !strcmp(tsi->type, "tsi-bridge"))
+		return add_legacy_port(np, -1, UPIO_TSI, addr, addr,
NO_IRQ, flags, 0);
+	else=20
+		return add_legacy_port(np, -1, UPIO_MEM, addr, addr,
NO_IRQ, flags, 0);
 }
=20
 static int __init add_legacy_isa_port(struct device_node *np,
@@ -464,7 +468,7 @@ static int __init serial_dev_init(void)
 			fixup_port_irq(i, np, port);
 		if (port->iotype =3D=3D UPIO_PORT)
 			fixup_port_pio(i, np, port);
-		if (port->iotype =3D=3D UPIO_MEM)
+		if ((port->iotype =3D=3D UPIO_MEM) || (port->iotype =3D=3D
UPIO_TSI))
 			fixup_port_mmio(i, np, port);
 	}
=20
--=20
1.4.0
