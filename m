Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id 6307867A06
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 04:48:39 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so354763wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Jun 2005 11:48:38 -0700 (PDT)
Message-ID: <528646bc050609114857191ca7@mail.gmail.com>
Date: Thu, 9 Jun 2005 12:48:38 -0600
From: Grant Likely <glikely@gmail.com>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <02ea73261175dc6bfb99047e73395fb1@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <528646bc05060907544d58da41@mail.gmail.com>
	<02ea73261175dc6bfb99047e73395fb1@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC52xx: sysfs failure on adding new device driver
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/9/05, Kumar Gala <kumar.gala@freescale.com> wrote:
>=20
> >> That changes the semantic of the driver names for the platform bus
> >> however, making the dot a "special" char.
> > Who needs to be asked about this?  Should I take this discussion over
> > the the LKML?
>=20
> GregKH would be the person to talk to about the driver core and taking
> this to LKML would be useful.  We probably have a similar issue with
> CPM comm channels.
>=20
> I always assumed multiple drivers would get probed and the drivers
> would fail in probe if they were not suppose to bind to the given
> channel/psc, etc..
>=20
I took another look at the sysfs layout, and it doesn't really look
like it is intended to support multiple drivers with the same name.=20
:-(  I'll ask GregKH about it.

In the mean time, here's another option:  Leave
arch/ppc/syslib/mpc52xx_devices.c alone, but modify the table in the
board setup code to assign specific drivers to the PSC devices before
the table is parsed by the platform bus.  This has the added advantage
of eliminating the need for mpc52xx_match_psc_function() and it's
cousins.

Thoughts?  Will this scheme negatively affect portability?

Here's a working example patch:

--------------------------------------------------------------------------
diff -ruN linux-2.6.12rc6.orig/arch/ppc/platforms/lite5200.c
linux-2.6.12rc6.spi2/arch/ppc/platforms/lite5200.c
--- linux-2.6.12rc6.orig/arch/ppc/platforms/lite5200.c=092005-06-08
17:22:05.000000000 -0600
+++ linux-2.6.12rc6.spi2/arch/ppc/platforms/lite5200.c=092005-06-09
12:23:26.000000000 -0600
@@ -50,17 +50,6 @@
 /* Platform specific code                                                 =
  */
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
=20
-/* Supported PSC function in "preference" order */
-struct mpc52xx_psc_func mpc52xx_psc_functions[] =3D {
-=09=09{       .id     =3D 0,
-=09=09=09.func   =3D "uart",
-=09=09},
-=09=09{       .id     =3D -1,   /* End entry */
-=09=09=09.func   =3D NULL,
-=09=09}
-=09};
-
-
 static int
 lite5200_show_cpuinfo(struct seq_file *m)
 {
@@ -198,6 +187,11 @@
 =09isa_io_base=09=09=3D 0;
 =09isa_mem_base=09=09=3D 0;
=20
+=09/* Assign driver names to PSC devices */
+=09ppc_sys_platform_devices[MPC52xx_PSC1].name =3D "mpc52xx-psc.uart";
+=09ppc_sys_platform_devices[MPC52xx_PSC2].name =3D "mpc52xx-psc.uart";
+=09ppc_sys_platform_devices[MPC52xx_PSC3].name =3D "mpc52xx-psc.spi";
+
 =09/* Powersave */
 =09/* This is provided as an example on how to do it. But you
 =09   need to be aware that NAP disable bus snoop and that may
diff -ruN linux-2.6.12rc6.orig/arch/ppc/syslib/mpc52xx_setup.c
linux-2.6.12rc6.spi2/arch/ppc/syslib/mpc52xx_setup.c
--- linux-2.6.12rc6.orig/arch/ppc/syslib/mpc52xx_setup.c=092005-06-08
17:22:05.000000000 -0600
+++ linux-2.6.12rc6.spi2/arch/ppc/syslib/mpc52xx_setup.c=092005-06-09
12:11:31.000000000 -0600
@@ -216,15 +216,3 @@
 =09tb_to_us =3D mulhwu_scale_factor(xlbfreq / divisor, 1000000);
 }
=20
-int mpc52xx_match_psc_function(int psc_idx, const char *func)
-{
-=09struct mpc52xx_psc_func *cf =3D mpc52xx_psc_functions;
-
-=09while ((cf->id !=3D -1) && (cf->func !=3D NULL)) {
-=09=09if ((cf->id =3D=3D psc_idx) && !strcmp(cf->func,func))
-=09=09=09return 1;
-=09=09cf++;
-=09}
-
-=09return 0;
-}
diff -ruN linux-2.6.12rc6.orig/drivers/Kconfig
linux-2.6.12rc6.spi2/drivers/Kconfig
--- linux-2.6.12rc6.orig/drivers/Kconfig=092005-03-02 00:38:26.000000000 -0=
700
+++ linux-2.6.12rc6.spi2/drivers/Kconfig=092005-06-08 17:27:23.000000000 -0=
600
@@ -58,4 +58,6 @@
=20
 source "drivers/infiniband/Kconfig"
=20
+source "drivers/spi/Kconfig"
+
 endmenu
diff -ruN linux-2.6.12rc6.orig/drivers/Makefile
linux-2.6.12rc6.spi2/drivers/Makefile
--- linux-2.6.12rc6.orig/drivers/Makefile=092005-06-08 17:22:08.000000000 -=
0600
+++ linux-2.6.12rc6.spi2/drivers/Makefile=092005-06-08 17:27:13.000000000 -=
0600
@@ -64,3 +64,4 @@
 obj-$(CONFIG_BLK_DEV_SGIIOC4)=09+=3D sn/
 obj-y=09=09=09=09+=3D firmware/
 obj-$(CONFIG_CRYPTO)=09=09+=3D crypto/
+obj-$(CONFIG_SPI)=09=09+=3D spi/
diff -ruN linux-2.6.12rc6.orig/drivers/serial/mpc52xx_uart.c
linux-2.6.12rc6.spi2/drivers/serial/mpc52xx_uart.c
--- linux-2.6.12rc6.orig/drivers/serial/mpc52xx_uart.c=092005-06-08
17:22:23.000000000 -0600
+++ linux-2.6.12rc6.spi2/drivers/serial/mpc52xx_uart.c=092005-06-09
12:14:40.000000000 -0600
@@ -29,8 +29,9 @@
 /* Platform device Usage :
  *
  * Since PSCs can have multiple function, the correct driver for each one
- * is selected by calling mpc52xx_match_psc_function(...). The function
- * handled by this driver is "uart".
+ * is selected based on the name assigned to the psc.  By convention, the
+ * function is appended to the device name in the board setup code.  For
+ * example, this uart psc driver will only bind to mpc52xx_psc.uart device=
s.
  *
  * The driver init all necessary registers to place the PSC in uart
mode without
  * DCD. However, the pin multiplexing aren't changed and should be set eit=
her
@@ -730,9 +731,6 @@
 =09if (idx < 0 || idx >=3D MPC52xx_PSC_MAXNUM)
 =09=09return -EINVAL;
=20
-=09if (!mpc52xx_match_psc_function(idx,"uart"))
-=09=09return -ENODEV;
-
 =09/* Init the port structure */
 =09port =3D &mpc52xx_uart_ports[idx];
=20
@@ -804,7 +802,7 @@
 #endif
=20
 static struct device_driver mpc52xx_uart_platform_driver =3D {
-=09.name=09=09=3D "mpc52xx-psc",
+=09.name=09=09=3D "mpc52xx-psc.uart",
 =09.bus=09=09=3D &platform_bus_type,
 =09.probe=09=09=3D mpc52xx_uart_probe,
 =09.remove=09=09=3D mpc52xx_uart_remove,
diff -ruN linux-2.6.12rc6.orig/drivers/spi/Kconfig
linux-2.6.12rc6.spi2/drivers/spi/Kconfig
--- linux-2.6.12rc6.orig/drivers/spi/Kconfig=091969-12-31 17:00:00.00000000=
0 -0700
+++ linux-2.6.12rc6.spi2/drivers/spi/Kconfig=092005-06-08 17:29:37.00000000=
0 -0600
@@ -0,0 +1,19 @@
+#
+# Character device configuration
+#
+
+menu "SPI support"
+
+config SPI
+=09tristate "SPI support"
+=09---help---
+=09  SPI is a serial bus protocol for connecting between ICs
+
+config SPI_MPC52XX_PSC
+=09tristate "SPI bus via MPC5xxx PSC port"
+=09depends on SPI
+=09help
+=09  Say Y here if you want SPI via an MPC5xxx PSC port.
+
+endmenu
+
diff -ruN linux-2.6.12rc6.orig/drivers/spi/Makefile
linux-2.6.12rc6.spi2/drivers/spi/Makefile
--- linux-2.6.12rc6.orig/drivers/spi/Makefile=091969-12-31
17:00:00.000000000 -0700
+++ linux-2.6.12rc6.spi2/drivers/spi/Makefile=092005-06-08
17:29:17.000000000 -0600
@@ -0,0 +1,6 @@
+#
+# Makefile for the spi core.
+#
+
+obj-$(CONFIG_SPI_MPC52XX_PSC)=09+=3D spi-mpc5xxx-psc.o
+
diff -ruN linux-2.6.12rc6.orig/drivers/spi/spi-mpc5xxx-psc.c
linux-2.6.12rc6.spi2/drivers/spi/spi-mpc5xxx-psc.c
--- linux-2.6.12rc6.orig/drivers/spi/spi-mpc5xxx-psc.c=091969-12-31
17:00:00.000000000 -0700
+++ linux-2.6.12rc6.spi2/drivers/spi/spi-mpc5xxx-psc.c=092005-06-09
12:20:28.000000000 -0600
@@ -0,0 +1,54 @@
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+
+#include <asm/mpc52xx.h>
+#include <asm/mpc52xx_psc.h>
+
+MODULE_LICENSE("Dual BSD/GPL");
+
+static int __devinit
+spi_mpc52xx_psc_probe(struct device *dev)
+{
+=09struct platform_device *pdev =3D to_platform_device(dev);
+=09/*struct resource *res =3D pdev->resource;*/
+=09int idx =3D pdev->id;
+
+=09printk(KERN_ALERT "spi-mpc52xx-psc: probing idx=3D%i\n", idx);
+
+=09return 0;
+}
+
+static int=20
+spi_mpc52xx_psc_remove(struct device *dev)
+{
+=09return 0;
+}
+
+static struct device_driver spi_mpc52xx_psc_platform_driver =3D {
+=09.name=09=09=3D "mpc52xx-psc.spi",
+=09.bus=09=09=3D &platform_bus_type,
+=09.probe=09=09=3D spi_mpc52xx_psc_probe,
+=09.remove=09=09=3D spi_mpc52xx_psc_remove,
+};
+
+static int __init spi_mpc52xx_psc_init(void)
+{
+=09int ret;
+
+=09printk(KERN_ALERT "spi_mpc52xx_psc: initializing\n");
+
+=09ret =3D driver_register(&spi_mpc52xx_psc_platform_driver);
+=09return ret;
+}
+
+static void __exit spi_mpc52xx_psc_exit(void)
+{
+=09driver_unregister(&spi_mpc52xx_psc_platform_driver);
+=09printk(KERN_ALERT "spi_mpc52xx_psc: exiting\n");
+}
+
+module_init(spi_mpc52xx_psc_init);
+module_exit(spi_mpc52xx_psc_exit);
diff -ruN linux-2.6.12rc6.orig/include/asm-ppc/mpc52xx.h
linux-2.6.12rc6.spi2/include/asm-ppc/mpc52xx.h
--- linux-2.6.12rc6.orig/include/asm-ppc/mpc52xx.h=092005-06-08
17:22:29.000000000 -0600
+++ linux-2.6.12rc6.spi2/include/asm-ppc/mpc52xx.h=092005-06-09
12:11:19.000000000 -0600
@@ -415,17 +415,6 @@
=20
 extern void mpc52xx_find_bridges(void);
=20
-
-=09/* Matching of PSC function */
-struct mpc52xx_psc_func {
-=09int id;
-=09char *func;
-};
-
-extern int mpc52xx_match_psc_function(int psc_idx, const char *func);
-extern struct  mpc52xx_psc_func mpc52xx_psc_functions[];
-=09/* This array is to be defined in platform file */
-
 #endif /* __ASSEMBLY__ */
