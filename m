Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id A434ADE104
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 04:00:31 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: OF compatible MTD platform RAM driver ?
Date: Mon, 10 Mar 2008 12:00:22 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0418505E@ismail.innsys.innovsys.com>
In-Reply-To: <200803101606.39184.laurentp@cse-semaphore.com>
References: <200803101606.39184.laurentp@cse-semaphore.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Laurent Pinchart" <laurentp@cse-semaphore.com>, <linuxppc-dev@ozlabs.org>
Cc: ben@simtec.co.uk, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

linuxppc-dev-bounces+runet=3Dinnovsys.com@ozlabs.org wrote:
> Hi everybody,
>=20
> as part of a ARCH=3Dppc to ARCH=3Dpowerpc migration process, I'm
> looking for an
> OpenFirmware compatible way to handle a RAM-based MTD device.
>=20
> On the platform_device based ppc architecture, the
> drivers/mtd/maps/plat-ram.c
> driver handled "mtd-ram" platform devices. There is no such
> driver for the
> OF-based powerpc architecture.
>=20
> As a temporary workaround I hacked the physmap_of driver to
> handle "direct-mapped" OF devices oh type "ram" by adding a
> corresponding entry in the of_flash_match[] array. This seems to work
> fine.=20
>=20
> What would be the preferred way to handle OF-compatible RAM-based MTD
> devices ? The 3 ways I can think of are
>=20
> 1. porting the plat-ram driver to OF (the driver isn't used
> in the kernel tree
> but I suspect it is used by out-of-tree boards)
>=20
> 2. creating a new plat-ram-of driver, much like the
> physmap_of driver comes
> from the physmap driver
>=20
> 3. extending the physmap_of driver to handle RAM devices (in
> which case
> references to "flash" in the function names should probably
> be replaced
> by "mtd")
>=20
> I live option 3 better so far.
>=20
> Has anyone already worked on this ? Is there any defined
> device tree mapping
> for MTD RAM devices ?
>=20
> Best regards,

We ran ito the same issue.=20
We did option 3, as it was efinetly the easiest,
here is the sram entry in our dts:

        sram@9,0 {
            device_type =3D "rom";
            compatible =3D "direct-mapped";
            probe-type =3D "RAM";
            reg =3D <9 0 20000>;
            bank-width =3D <2>;
            device-width =3D <2>;
            #address-cells =3D <1>;
            #size-cells =3D <1>;
            partition@0 {
                label =3D "SRAM";
                reg =3D <0 20000>;
            };

here is the change to physmap_of.c:

diff --git a/drivers/mtd/maps/physmap_of.c
b/drivers/mtd/maps/physmap_of.c
old mode 100644
new mode 100755
index aeed9ea..687ef54
--- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -201,6 +201,8 @@ static struct mtd_info * __devinit
obsolete_probe(struct of_device *dev,
 		return do_map_probe("cfi_probe", map);
 	} else if (strcmp(of_probe, "JEDEC") =3D=3D 0) {
 		return do_map_probe("jedec_probe", map);
+	} else if (strcmp(of_probe, "RAM") =3D=3D 0) {
+		return do_map_probe("map_ram", map);
 	} else {
 		if (strcmp(of_probe, "ROM") !=3D 0)
 			dev_warn(&dev->dev, "obsolete_probe: don't know
probe "
