Subject: Re: S3 trio config
From: Leigh Brown <leigh@solinno.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>,
	Peter De Schrijver <p2@mind.be>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.4.21.0206011036580.13142-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0206011036580.13142-100000@vervain.sonytel.be>
Content-Type: multipart/mixed; boundary="=-cXPdHs+BgzKzHGy+wC+R"
Date: 02 Jun 2002 11:38:01 +0100
Message-Id: <1023014281.11116.14.camel@kettle.solinno.co.uk>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-cXPdHs+BgzKzHGy+wC+R
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2002-06-01 at 09:39, Geert Uytterhoeven wrote:
> On Sat, 1 Jun 2002, Paul Mackerras wrote:
> > I wrote:
> > > Does anyone know why we have this?  Is the S3 Trio display really only
> > > used on PReP or CHRP machines, not on any PCs?
> >
> > I should have said, not on any other PPC systems, of course, since
> > that code was in a CONFIG_PPC section.
>
> S3triofb relies on Open Firmware, so it can work on PowerMac/CHRP only. AFAIK
> it was used on CHRP only.

Well, S3triofb hasn't even compiled for ages.  I've attached a patch
that allows it to compile, and removes the dependency on OF.  However,
it still requires some sort of firmware to initialise the card.  I've
added a little hack so that it ignores the card if it wasn't initialised
by the firmware, since the driver doesn't have the code to initialise it
properly.

It works on the 7043-140 using a PReP kernel, and has been tested by
quite a few people.  Unfortunately, I no longer have an S3Trio card (and
to be honest, I know very little about graphics cards).

IMHO it's worth applying the patch as a working (just) driver is a
better starting point than a non-compiling one.

If there are other PPC systems that bring up the S3Trio in 640x480x8
mode then I suppose the driver will be applicable to them also....

Cheers,

Leigh.


--=-cXPdHs+BgzKzHGy+wC+R
Content-Disposition: attachment; filename=S3trio.patch.final
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=S3trio.patch.final; charset=ISO-8859-1

diff -ur linuxppc_2_4_devel/drivers/video/S3triofb.c linuxppc_2_4_devel-s3/=
drivers/video/S3triofb.c
--- linuxppc_2_4_devel/drivers/video/S3triofb.c	Sat Jun  1 22:27:27 2002
+++ linuxppc_2_4_devel-s3/drivers/video/S3triofb.c	Sun Jun  2 10:48:37 2002
@@ -17,8 +17,7 @@
  */
=20
 /*
-	Bugs : + OF dependencies should be removed.
-               + This driver should be merged with the CyberVision driver.=
 The
+	Bugs : + This driver should be merged with the CyberVision driver. The
                  CyberVision is a Zorro III implementation of the S3Trio64=
 chip.
=20
 */
@@ -37,9 +36,6 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/selection.h>
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
 #include <linux/pci.h>
 #ifdef CONFIG_FB_COMPAT_XPMAC
 #include <asm/vc_ioctl.h>
@@ -61,6 +57,7 @@
 #define IO_OUT16VAL(v, r)       (((v) << 8) | (r))
=20
 static int currcon =3D 0;
+static int disabled;
 static struct display disp;
 static struct fb_info fb_info;
 static struct { u_char red, green, blue, pad; } palette[256];
@@ -68,14 +65,20 @@
 static char *s3trio_base;
=20
 static struct fb_fix_screeninfo fb_fix;
-static struct fb_var_screeninfo fb_var =3D { 0, };
-
+static struct fb_var_screeninfo S3triofb_default_var =3D {
+	640, 480, 640, 480, 0, 0, 8, 0,
+	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
+	0, 0, -1, FB_ACCELF_TEXT, 39722, 40, 24, 32, 11, 96, 2,
+	FB_SYNC_COMP_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT,
+	FB_VMODE_NONINTERLACED
+};
+static struct fb_var_screeninfo fb_var =3D { 0,};
=20
     /*
      *  Interface used by the world
      */
=20
-static void __init s3triofb_of_init(struct device_node *dp);
+static void __init s3triofb_pci_init(struct pci_dev *dp);
 static int s3trio_get_fix(struct fb_fix_screeninfo *fix, int con,
 			  struct fb_info *info);
 static int s3trio_get_var(struct fb_var_screeninfo *var, int con,
@@ -260,16 +263,43 @@
 }
=20
=20
+#ifndef MODULE
+
+int __init s3triofb_setup(char *options) {
+	char *this_opt;
+
+	if (!options || !*options)
+		return 0;
+
+	while ((this_opt =3D strsep(&options, ",")) !=3D NULL) {
+		if (!*this_opt)
+			continue;
+
+		if (!strcmp(this_opt, "disabled"))
+			disabled =3D 1;
+	}
+	return 0;
+}
+
+
+
 int __init s3triofb_init(void)
 {
-	struct device_node *dp;
+	struct pci_dev *dp =3D NULL;
=20
-	dp =3D find_devices("S3Trio");
-	if (dp !=3D 0)
-	    s3triofb_of_init(dp);
-	return 0;
+	if (disabled)
+		return -ENXIO;
+
+	dp =3D pci_find_device(PCI_VENDOR_ID_S3, PCI_DEVICE_ID_S3_TRIO, dp);
+	if ((dp !=3D 0) && ((dp->class >> 16) =3D=3D PCI_BASE_CLASS_DISPLAY)) {
+		s3triofb_pci_init(dp);
+		return 0;
+	} else
+		return -ENODEV;
 }
=20
+#endif
+
 void __init s3trio_resetaccel(void){
=20
=20
@@ -313,111 +343,69 @@
 	outw( MF_PIX_CONTROL | MFA_SRC_FOREGR_MIX,  0xbee8);
 }
=20
-int __init s3trio_init(struct device_node *dp){
-
-    u_char bus, dev;
-    unsigned int t32;
-    unsigned short cmd;
-
-	pci_device_loc(dp,&bus,&dev);
-                pcibios_read_config_dword(bus, dev, PCI_VENDOR_ID, &t32);
-                if(t32 =3D=3D (PCI_DEVICE_ID_S3_TRIO << 16) + PCI_VENDOR_I=
D_S3) {
-                        pcibios_read_config_dword(bus, dev, PCI_BASE_ADDRE=
SS_0, &t32);
-                        pcibios_read_config_dword(bus, dev, PCI_BASE_ADDRE=
SS_1, &t32);
-			pcibios_read_config_word(bus, dev, PCI_COMMAND,&cmd);
-
-			pcibios_write_config_word(bus, dev, PCI_COMMAND, PCI_COMMAND_IO | PCI_C=
OMMAND_MEMORY);
-
-			pcibios_write_config_dword(bus, dev, PCI_BASE_ADDRESS_0,0xffffffff);
-                        pcibios_read_config_dword(bus, dev, PCI_BASE_ADDRE=
SS_0, &t32);
-
-/* This is a gross hack as OF only maps enough memory for the framebuffer =
and
-   we want to use MMIO too. We should find out which chunk of address spac=
e
-   we can use here */
-			pcibios_write_config_dword(bus,dev,PCI_BASE_ADDRESS_0,0xc6000000);
-
-			/* unlock s3 */
-
-			outb(0x01, 0x3C3);
-
-			outb(inb(0x03CC) | 1, 0x3c2);
-
-			outw(IO_OUT16VAL(0x48, 0x38),0x03D4);
-			outw(IO_OUT16VAL(0xA0, 0x39),0x03D4);
-			outb(0x33,0x3d4);
-			outw(IO_OUT16VAL((inb(0x3d5) & ~(0x2 | 0x10 |  0x40)) |
-					  0x20, 0x33), 0x3d4);
-
-			outw(IO_OUT16VAL(0x6, 0x8), 0x3c4);
-
-			/* switch to MMIO only mode */
-
-			outb(0x58, 0x3d4);
-			outw(IO_OUT16VAL(inb(0x3d5) | 3 | 0x10, 0x58), 0x3d4);
-			outw(IO_OUT16VAL(8, 0x53), 0x3d4);
-
-			/* switch off I/O accesses */
-
-#if 0
-			pcibios_write_config_word(bus, dev, PCI_COMMAND,
-				        PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
-#endif
-			return 1;
-                }
+int __init s3trio_init(struct pci_dev *dp)
+{
+	/* unlock s3 */
+	outb(0x01, 0x3C3);
+	outb(inb(0x03CC) | 1, 0x3c2);
+	outw(IO_OUT16VAL(0x48, 0x38),0x03D4);
+	outw(IO_OUT16VAL(0xA0, 0x39),0x03D4);
+	outb(0x33,0x3d4);
+	outw(IO_OUT16VAL((inb(0x3d5) & ~(0x2 | 0x10 |  0x40)) |
+			  0x20, 0x33), 0x3d4);
+
+	outw(IO_OUT16VAL(0x6, 0x8), 0x3c4);
+	printk("S3trio: unlocked s3\n");
+
+	/* switch to MMIO only mode */
+	outb(0x58, 0x3d4);
+	outw(IO_OUT16VAL(inb(0x3d5) | 3 | 0x10, 0x58), 0x3d4);
+	outw(IO_OUT16VAL(8, 0x53), 0x3d4);
+	printk("S3trio: switched to mmio only mode\n");
=20
-	return 0;
+	return 1;
 }
=20
=20
     /*
      *  Initialisation
-     *  We heavily rely on OF for the moment. This needs fixing.
      */
=20
-static void __init s3triofb_of_init(struct device_node *dp)
+static void __init s3triofb_pci_init(struct pci_dev *dp)
 {
-    int i, *pp, len;
+    int i;
     unsigned long address, size;
     u_long *CursorBase;
+    u16 cmd;
=20
-    strncat(s3trio_name, dp->name, sizeof(s3trio_name));
-    s3trio_name[sizeof(s3trio_name)-1] =3D '\0';
     strcpy(fb_fix.id, s3trio_name);
=20
-    if((pp =3D (int *)get_property(dp, "vendor-id", &len)) !=3D NULL
-	&& *pp!=3DPCI_VENDOR_ID_S3) {
-	printk("%s: can't find S3 Trio board\n", dp->full_name);
-	return;
-    }
+    fb_var =3D S3triofb_default_var;
+    fb_fix.line_length =3D fb_var.xres_virtual;
+    fb_fix.smem_len =3D fb_fix.line_length*fb_var.yres;
=20
-    if((pp =3D (int *)get_property(dp, "device-id", &len)) !=3D NULL
-	&& *pp!=3DPCI_DEVICE_ID_S3_TRIO) {
-	printk("%s: can't find S3 Trio board\n", dp->full_name);
-	return;
+    /* This driver cannot cope if the firmware has not initialised the
+     * device.  So, if the device isn't enabled we simply return
+     */
+    pci_read_config_word(dp, PCI_COMMAND, &cmd);
+    if (!(cmd & PCI_COMMAND_MEMORY)) {
+	    printk(KERN_NOTICE "S3trio: card was not initialised by firmware\n");
+	    return;
     }
=20
-    if ((pp =3D (int *)get_property(dp, "depth", &len)) !=3D NULL
-	&& len =3D=3D sizeof(int) && *pp !=3D 8) {
-	printk("%s: can't use depth =3D %d\n", dp->full_name, *pp);
-	return;
+    /* Enable it anyway */
+    if (pci_enable_device(dp)) {
+	    printk(KERN_ERR "S3trio: failed to enable PCI device\n");
+	    return;
     }
-    if ((pp =3D (int *)get_property(dp, "width", &len)) !=3D NULL
-	&& len =3D=3D sizeof(int))
-	fb_var.xres =3D fb_var.xres_virtual =3D *pp;
-    if ((pp =3D (int *)get_property(dp, "height", &len)) !=3D NULL
-	&& len =3D=3D sizeof(int))
-	fb_var.yres =3D fb_var.yres_virtual =3D *pp;
-    if ((pp =3D (int *)get_property(dp, "linebytes", &len)) !=3D NULL
-	&& len =3D=3D sizeof(int))
-	fb_fix.line_length =3D *pp;
-    else
-	fb_fix.line_length =3D fb_var.xres_virtual;
-    fb_fix.smem_len =3D fb_fix.line_length*fb_var.yres;
=20
-    address =3D 0xc6000000;
-    size =3D 64*1024*1024;
-    if (!request_mem_region(address, size, "S3triofb"))
+    /* There is only one memory region and it covers the mmio and fb areas=
 */
+    address =3D pci_resource_start(dp, 0);
+    size    =3D pci_resource_len(dp, 0); /* size =3D 64*1024*1024; */
+    if (!request_mem_region(address, size, "S3triofb")) {
+	printk("S3trio: failed to allocate memory region\n");
 	return;
+    }
=20
     s3trio_init(dp);
     s3trio_base =3D ioremap(address, size);
@@ -552,8 +540,7 @@
 #endif
     disp.scrollmode =3D fb_var.accel_flags & FB_ACCELF_TEXT ? 0 : SCROLL_Y=
REDRAW;
=20
-    strcpy(fb_info.modename, "Trio64 ");
-    strncat(fb_info.modename, dp->full_name, sizeof(fb_info.modename));
+    strcpy(fb_info.modename, "Trio64");
     fb_info.node =3D -1;
     fb_info.fbops =3D &s3trio_ops;
 #if 0
@@ -591,7 +578,7 @@
 	return;
=20
     printk("fb%d: S3 Trio frame buffer device on %s\n",
-	   GET_FB_IDX(fb_info.node), dp->full_name);
+	   GET_FB_IDX(fb_info.node), dp->name);
 }
=20
=20

--=-cXPdHs+BgzKzHGy+wC+R--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
