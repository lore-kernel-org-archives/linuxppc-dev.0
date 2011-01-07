Return-Path: <oakad@yahoo.com>
Received: from web37601.mail.mud.yahoo.com (web37601.mail.mud.yahoo.com
	[209.191.87.84]) by ozlabs.org (Postfix) with SMTP id 28B51B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Jan 2011 19:27:27 +1100 (EST)
Message-ID: <126175.85639.qm@web37601.mail.mud.yahoo.com>
Date: Fri, 7 Jan 2011 00:27:24 -0800 (PST)
From: Alex Dubov <oakad@yahoo.com>
Subject: [PATCH] powerpc: add support for multiple 85xx RapidIO development
	boards
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many RapidIO development boards do not require any board/vendor specific=0A=
tweaking at kernel start, and can rely on the flattened device tree for=0Aa=
ll their hardware configuration needs.=0A=0AThis patch adds support for "ge=
neric,mpc85xx-riodev" compatible boards=0Awith PCI disabled by default and =
RapidIO enabled. It will also try to=0Aread a "vendor" property from the ro=
ot of device tree to provide a possibly=0Auseful bit of information in the =
/proc/cpuinfo.=0A=0ASigned-off-by: Alex Dubov <oakad@yahoo.com>=0A---=0A ar=
ch/powerpc/configs/85xx/mpc85xx_riodev_defconfig |   82 ++++++++++++++=0A a=
rch/powerpc/platforms/85xx/Kconfig                |    9 ++=0A arch/powerpc=
/platforms/85xx/Makefile               |    1 +=0A arch/powerpc/platforms/8=
5xx/mpc85xx_riodev.c       |  116 ++++++++++++++++++++=0A 4 files changed, =
208 insertions(+), 0 deletions(-)=0A create mode 100644 arch/powerpc/config=
s/85xx/mpc85xx_riodev_defconfig=0A create mode 100644 arch/powerpc/platform=
s/85xx/mpc85xx_riodev.c=0A=0Adiff --git a/arch/powerpc/configs/85xx/mpc85xx=
_riodev_defconfig b/arch/powerpc/configs/85xx/mpc85xx_riodev_defconfig=0Ane=
w file mode 100644=0Aindex 0000000..5d0596e=0A--- /dev/null=0A+++ b/arch/po=
werpc/configs/85xx/mpc85xx_riodev_defconfig=0A@@ -0,0 +1,82 @@=0A+CONFIG_PP=
C_85xx=3Dy=0A+CONFIG_EXPERIMENTAL=3Dy=0A+CONFIG_SYSVIPC=3Dy=0A+CONFIG_LOG_B=
UF_SHIFT=3D14=0A+CONFIG_BLK_DEV_INITRD=3Dy=0A+# CONFIG_CC_OPTIMIZE_FOR_SIZE=
 is not set=0A+CONFIG_EMBEDDED=3Dy=0A+CONFIG_MODULES=3Dy=0A+CONFIG_MODULE_U=
NLOAD=3Dy=0A+# CONFIG_BLK_DEV_BSG is not set=0A+CONFIG_MPC85xx_RIODEV=3Dy=
=0A+CONFIG_HIGHMEM=3Dy=0A+CONFIG_NO_HZ=3Dy=0A+CONFIG_HIGH_RES_TIMERS=3Dy=0A=
+CONFIG_BINFMT_MISC=3Dy=0A+CONFIG_MATH_EMULATION=3Dy=0A+CONFIG_SPARSE_IRQ=
=3Dy=0A+# CONFIG_SECCOMP is not set=0A+CONFIG_PCI=3Dn=0A+CONFIG_PCIEPORTBUS=
=3Dn=0A+# CONFIG_PCIEASPM is not set=0A+CONFIG_NET=3Dy=0A+CONFIG_PACKET=3Dy=
=0A+CONFIG_UNIX=3Dy=0A+CONFIG_XFRM_USER=3Dy=0A+CONFIG_INET=3Dy=0A+CONFIG_IP=
_MULTICAST=3Dy=0A+CONFIG_IP_PNP=3Dy=0A+CONFIG_IP_PNP_DHCP=3Dy=0A+CONFIG_IP_=
PNP_BOOTP=3Dy=0A+CONFIG_SYN_COOKIES=3Dy=0A+# CONFIG_INET_LRO is not set=0A+=
# CONFIG_IPV6 is not set=0A+CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"=0A+=
# CONFIG_FW_LOADER is not set=0A+CONFIG_MTD=3Dy=0A+CONFIG_MTD_PARTITIONS=3D=
y=0A+CONFIG_MTD_OF_PARTS=3Dy=0A+CONFIG_MTD_CHAR=3Dy=0A+CONFIG_MTD_BLKDEVS=
=3Dy=0A+CONFIG_MTD_CFI=3Dy=0A+CONFIG_MTD_CFI_AMDSTD=3Dy=0A+CONFIG_MTD_PHYSM=
AP_OF=3Dy=0A+CONFIG_MTD_NAND_ECC_SMC=3Dy=0A+CONFIG_MTD_NAND=3Dy=0A+CONFIG_M=
TD_NAND_FSL_UPM=3Dy=0A+CONFIG_PROC_DEVICETREE=3Dy=0A+CONFIG_BLK_DEV_LOOP=3D=
y=0A+CONFIG_BLK_DEV_RAM=3Dy=0A+CONFIG_BLK_DEV_RAM_SIZE=3D32768=0A+CONFIG_NE=
TDEVICES=3Dy=0A+CONFIG_NET_ETHERNET=3Dy=0A+CONFIG_MII=3Dy=0A+CONFIG_GIANFAR=
=3Dy=0A+# CONFIG_INPUT_MOUSEDEV is not set=0A+# CONFIG_INPUT_KEYBOARD is no=
t set=0A+# CONFIG_INPUT_MOUSE is not set=0A+# CONFIG_SERIO is not set=0A+# =
CONFIG_VT is not set=0A+CONFIG_SERIAL_8250=3Dy=0A+CONFIG_SERIAL_8250_CONSOL=
E=3Dy=0A+# CONFIG_HW_RANDOM is not set=0A+CONFIG_I2C=3Dy=0A+CONFIG_I2C_CHAR=
DEV=3Dy=0A+CONFIG_I2C_MPC=3Dy=0A+CONFIG_VIDEO_OUTPUT_CONTROL=3Dy=0A+# CONFI=
G_USB_SUPPORT is not set=0A+CONFIG_INOTIFY=3Dy=0A+CONFIG_PROC_KCORE=3Dy=0A+=
CONFIG_TMPFS=3Dy=0A+CONFIG_JFFS2_FS=3Dy=0A+CONFIG_NFS_FS=3Dy=0A+CONFIG_ROOT=
_NFS=3Dy=0A+CONFIG_PARTITION_ADVANCED=3Dy=0A+# CONFIG_MSDOS_PARTITION is no=
t set=0A+CONFIG_DEBUG_KERNEL=3Dy=0A+CONFIG_DETECT_HUNG_TASK=3Dy=0A+CONFIG_D=
EBUG_MUTEXES=3Dy=0A+# CONFIG_DEBUG_BUGVERBOSE is not set=0A+# CONFIG_RCU_CP=
U_STALL_DETECTOR is not set=0A+CONFIG_SYSCTL_SYSCALL_CHECK=3Dy=0A+# CONFIG_=
CRYPTO_ANSI_CPRNG is not set=0Adiff --git a/arch/powerpc/platforms/85xx/Kco=
nfig b/arch/powerpc/platforms/85xx/Kconfig=0Aindex b6976e1..be48db0 100644=
=0A--- a/arch/powerpc/platforms/85xx/Kconfig=0A+++ b/arch/powerpc/platforms=
/85xx/Kconfig=0A@@ -97,6 +97,15 @@ config XES_MPC85xx=0A =09  Manufacturer:=
 Extreme Engineering Solutions, Inc.=0A =09  URL: <http://www.xes-inc.com/>=
=0A =0A+config MPC85xx_RIODEV=0A+=09bool "Generic MPC85xx board with serial=
 RapidIO"=0A+=09select DEFAULT_UIMAGE=0A+=09select HAS_RAPIDIO=0A+=09help=
=0A+=09  This option enables support for one of many RapidIO development=0A=
+=09  boards, which do not need any vendor specific kernel tweaks and=0A+=
=09  fully rely on flattened device tree for the hardware configuration.=0A=
+=0A config STX_GP3=0A =09bool "Silicon Turnkey Express GP3"=0A =09help=0Ad=
iff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/8=
5xx/Makefile=0Aindex dd70db7..228f0f9 100644=0A--- a/arch/powerpc/platforms=
/85xx/Makefile=0A+++ b/arch/powerpc/platforms/85xx/Makefile=0A@@ -14,6 +14,=
7 @@ obj-$(CONFIG_P1022_DS)    +=3D p1022_ds.o=0A obj-$(CONFIG_P3041_DS)   =
 +=3D p3041_ds.o corenet_ds.o=0A obj-$(CONFIG_P4080_DS)    +=3D p4080_ds.o =
corenet_ds.o=0A obj-$(CONFIG_P5020_DS)    +=3D p5020_ds.o corenet_ds.o=0A+o=
bj-$(CONFIG_MPC85xx_RIODEV) +=3D mpc85xx_riodev.o=0A obj-$(CONFIG_STX_GP3)=
=09  +=3D stx_gp3.o=0A obj-$(CONFIG_TQM85xx)=09  +=3D tqm85xx.o=0A obj-$(CO=
NFIG_SBC8560)     +=3D sbc8560.o=0Adiff --git a/arch/powerpc/platforms/85xx=
/mpc85xx_riodev.c b/arch/powerpc/platforms/85xx/mpc85xx_riodev.c=0Anew file=
 mode 100644=0Aindex 0000000..415f22b=0A--- /dev/null=0A+++ b/arch/powerpc/=
platforms/85xx/mpc85xx_riodev.c=0A@@ -0,0 +1,116 @@=0A+/*=0A+ * Based on tq=
m85xx.c and other similar files.=0A+ *=0A+ * Copyright (c) 2011 Alex Dubov =
<oakad@yahoo.com>=0A+ *=0A+ * This program is free software; you can redist=
ribute  it and/or modify it=0A+ * under  the terms of  the GNU General  Pub=
lic License as published by the=0A+ * Free Software Foundation;  either ver=
sion 2 of the  License, or (at your=0A+ * option) any later version.=0A+ */=
=0A+=0A+#include <linux/seq_file.h>=0A+#include <linux/of_platform.h>=0A+=
=0A+#include <asm/machdep.h>=0A+#include <asm/mpic.h>=0A+#include <asm/udbg=
.h>=0A+=0A+#include <sysdev/fsl_soc.h>=0A+=0A+static void __init mpc85xx_ri=
odev_pic_init(void)=0A+{=0A+=09struct mpic *mpic;=0A+=09struct resource r;=
=0A+=09struct device_node *np;=0A+=0A+=09np =3D of_find_node_by_type(NULL, =
"open-pic");=0A+=09if (!np) {=0A+=09=09printk(KERN_ERR "Could not find open=
-pic node\n");=0A+=09=09return;=0A+=09}=0A+=0A+=09if (of_address_to_resourc=
e(np, 0, &r)) {=0A+=09=09printk(KERN_ERR "Could not map mpic register space=
\n");=0A+=09=09of_node_put(np);=0A+=09=09return;=0A+=09}=0A+=0A+=09mpic =3D=
 mpic_alloc(np, r.start,=0A+=09=09=09MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC=
_BIG_ENDIAN,=0A+=09=09=090, 256, " OpenPIC  ");=0A+=09BUG_ON(mpic =3D=3D NU=
LL);=0A+=09of_node_put(np);=0A+=0A+=09mpic_init(mpic);=0A+}=0A+=0A+/*=0A+ *=
 Setup the architecture=0A+ */=0A+static void __init mpc85xx_riodev_setup_a=
rch(void)=0A+{=0A+}=0A+=0A+static void mpc85xx_riodev_show_cpuinfo(struct s=
eq_file *m)=0A+{=0A+=09struct device_node *root =3D NULL;=0A+=09const char =
*vendor_str =3D NULL;=0A+=09uint pvid, svid, phid1;=0A+=0A+=09pvid =3D mfsp=
r(SPRN_PVR);=0A+=09svid =3D mfspr(SPRN_SVR);=0A+=0A+=09root =3D of_find_nod=
e_by_path("/");=0A+=09if (root) {=0A+=09=09vendor_str =3D of_get_property(r=
oot, "vendor", NULL);=0A+=09=09of_node_put(root);=0A+=09}=0A+=0A+=09if (!ve=
ndor_str)=0A+=09=09vendor_str =3D "generic";=0A+=0A+=09seq_printf(m, "vendo=
r\t\t: %s\n", vendor_str);=0A+=09seq_printf(m, "PVR\t\t: 0x%x\n", pvid);=0A=
+=09seq_printf(m, "SVR\t\t: 0x%x\n", svid);=0A+=0A+=09/* Display cpu Pll se=
tting */=0A+=09phid1 =3D mfspr(SPRN_HID1);=0A+=09seq_printf(m, "PLL setting=
\t: 0x%x\n", ((phid1 >> 24) & 0x3f));=0A+}=0A+=0A+static struct of_device_i=
d __initdata of_bus_ids[] =3D {=0A+=09{ .compatible =3D "simple-bus", },=0A=
+=09{ .compatible =3D "gianfar", },=0A+=09{},=0A+};=0A+=0A+static int __ini=
t declare_of_platform_devices(void)=0A+{=0A+=09of_platform_bus_probe(NULL, =
of_bus_ids, NULL);=0A+=0A+=09return 0;=0A+}=0A+machine_device_initcall(mpc8=
5xx_riodev, declare_of_platform_devices);=0A+=0A+/*=0A+ * Called very early=
, device-tree isn't unflattened=0A+ */=0A+static int __init mpc85xx_riodev_=
probe(void)=0A+{=0A+=09unsigned long root =3D of_get_flat_dt_root();=0A+=0A=
+=09return of_flat_dt_is_compatible(root, "generic,mpc85xx-riodev");=0A+}=
=0A+=0A+define_machine(mpc85xx_riodev) {=0A+=09.name=09=09=09=3D "MPC85xx w=
/ SRIO",=0A+=09.probe=09=09=09=3D mpc85xx_riodev_probe,=0A+=09.setup_arch=
=09=09=3D mpc85xx_riodev_setup_arch,=0A+=09.init_IRQ=09=09=3D mpc85xx_riode=
v_pic_init,=0A+=09.show_cpuinfo=09=09=3D mpc85xx_riodev_show_cpuinfo,=0A+=
=09.get_irq=09=09=3D mpic_get_irq,=0A+=09.restart=09=09=3D fsl_rstcr_restar=
t,=0A+=09.calibrate_decr=09=09=3D generic_calibrate_decr,=0A+=09.progress=
=09=09=3D udbg_progress,=0A+};=0A-- =0A1.7.3.2=0A=0A=0A=0A=0A      
