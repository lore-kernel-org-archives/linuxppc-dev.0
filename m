Return-Path: <nd@bplan-gmbh.de>
Date: Mon, 6 Nov 2006 12:01:52 +0100 (MET)
Message-Id: <200611061101.kA6B1qWe002251@post.webmailer.de>
To: linuxppc-dev@ozlabs.org
From: "Nicolas DET"<nd@bplan-gmbh.de>
Subject: [PATCH] powerpc: Add of_platform support for OHCI/Bigendian HC
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="b_01_636d7be58669559d85937eac8e1dad56"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--b_01_636d7be58669559d85937eac8e1dad56
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//DE"><HTML><HEAD><=
META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">=
<TITLE>Message</TITLE></HEAD><BODY>
          <pre>This patch use of_platform device to probe and install OHCI =
big endian HC.<br><br>PS: I did not success to properly inline the file usi=
ng thrunderbird.<br><br>Signed-off-by: Nicolas DET &lt;nd@bplan-gmbh.de&gt;=
 <br>---<br>--- a/drivers/usb/host/ohci-ppc-of.c=091970-01-01 01:00:00.0000=
00000 +0100<br>+++ b/drivers/usb/host/ohci-ppc-of.c=092006-11-06 11:10:29.0=
00000000 +0100<br>@@ -0,0 +1,283 @@<br>+/*<br>+ * OHCI HCD (Host Controller=
 Driver) for USB.<br>+ *<br>+ * (C) Copyright 1999 Roman Weissgaerber &lt;w=
eissg@vienna.at&gt;<br>+ * (C) Copyright 2000-2002 David Brownell &lt;dbrow=
nell@users.sourceforge.net&gt;<br>+ * (C) Copyright 2002 Hewlett-Packard Co=
mpany<br>+ * (C) Copyright 2003-2005 MontaVista Software Inc.<br>+ * <br>+ =
* Probe and init OHCI Big endian HC from OpenFirmware device tree<br>+ * Te=
sted on Efika 5k2<br>+ *<br>+ * Modified by Dale Farnsworth &lt;dale@farnsw=
orth.org&gt; from ohci-sa1111.c<br>+ *<br>+ * This file is licenced under t=
he GPL.<br>+ */<br>+<br>+#include &lt;linux/signal.h&gt;<br>+<br>+#include =
&lt;asm/of_device.h&gt;<br>+#include &lt;asm/prom.h&gt;<br>+<br>+/* configu=
re so an HC device and id are always provided */<br>+/* always called with =
process context; sleeping is OK */<br>+<br>+/*<br>+ * usb_hcd_ppc_of_probe =
- initialize On-Chip HCDs<br>+ * Context: !in_interrupt()<br>+ *<br>+ * All=
ocates basic resources for this USB host controller.<br>+ *<br>+ * Store th=
is function in the HCD's struct pci_driver as probe().<br>+ */<br>+static i=
nt usb_hcd_ppc_of_probe(const struct hc_driver *driver,<br>+=09=09=09  stru=
ct of_device *dev, int is_bigendian)<br>+{<br>+=09int retval;<br>+=09struct=
 usb_hcd *hcd;<br>+=09struct ohci_hcd=09*ohci;<br>+=09struct resource res;<=
br>+=09int irq;<br>+=09int ret;<br>+<br>+=09pr_debug("initializing PPC-OF U=
SB Controllern");<br>+<br>+=09if ((ret =3D of_address_to_resource(dev-&gt;n=
ode, 0, &amp;res)) !=3D 0)<br>+=09=09return ret;<br>+<br>+=09hcd =3D usb_cr=
eate_hcd(driver, &amp;dev-&gt;dev, "PPC-OF USB");<br>+=09if (!hcd)<br>+=09=
=09return -ENOMEM;<br>+<br>+=09hcd-&gt;rsrc_start =3D res.start;<br>+=09hcd=
-&gt;rsrc_len =3D res.end - res.start + 1;<br>+<br>+=09if (!request_mem_reg=
ion(hcd-&gt;rsrc_start, hcd-&gt;rsrc_len, hcd_name)) {<br>+=09=09pr_debug(_=
_FILE__ ": request_mem_region failedn");<br>+=09=09retval =3D -EBUSY;<br>+=
=09=09goto err1;<br>+=09}<br>+<br>+=09irq =3D irq_of_parse_and_map(dev-&gt;=
node, 0);<br>+=09if (irq =3D=3D NO_IRQ) {<br>+=09=09retval =3D -EBUSY;<br>+=
=09=09goto err2;<br>+=09}<br>+<br>+=09hcd-&gt;regs =3D ioremap(hcd-&gt;rsrc=
_start, hcd-&gt;rsrc_len);<br>+=09if (!hcd-&gt;regs) {<br>+=09=09pr_debug(_=
_FILE__ ": ioremap failedn");<br>+=09=09retval =3D -ENOMEM;<br>+=09=09goto =
err2;<br>+=09}<br>+<br>+=09ohci =3D hcd_to_ohci(hcd);<br>+=09if (is_bigendi=
an)<br>+=09=09ohci-&gt;flags |=3D OHCI_BIG_ENDIAN;<br>+<br>+=09ohci_hcd_ini=
t(ohci);<br>+<br>+=09retval =3D usb_add_hcd(hcd, irq, 0);<br>+=09if (retval=
 =3D=3D 0)<br>+=09=09return retval;<br>+<br>+=09pr_debug("Removing PPC-OF U=
SB Controllern");<br>+<br>+=09iounmap(hcd-&gt;regs);<br>+ err2:<br>+=09rele=
ase_mem_region(hcd-&gt;rsrc_start, hcd-&gt;rsrc_len);<br>+ err1:<br>+ =09us=
b_put_hcd(hcd);<br>+=09return retval;<br>+}<br>+<br>+<br>+/* may be called =
without controller electrically present */<br>+/* may be called with contro=
ller, bus, and devices active */<br>+<br>+/*<br>+ * usb_hcd_ppc_of_remove -=
 shutdown processing for On-Chip HCDs<br>+ * @pdev: USB Host Controller bei=
ng removed<br>+ * Context: !in_interrupt()<br>+ *<br>+ * Reverses the effec=
t of usb_hcd_ppc_of_probe().<br>+ * It is always called from a thread<br>+ =
* context, normally "rmmod", "apmd", or something similar.<br>+ *<br>+ */<b=
r>+static void usb_hcd_ppc_of_remove(struct usb_hcd *hcd,<br>+=09=09struct =
of_device *op)<br>+{<br>+=09usb_remove_hcd(hcd);<br>+<br>+=09pr_debug("stop=
ping PPC-OF USB Controllern");<br>+<br>+=09iounmap(hcd-&gt;regs);<br>+=09re=
lease_mem_region(hcd-&gt;rsrc_start, hcd-&gt;rsrc_len);<br>+=09usb_put_hcd(=
hcd);<br>+}<br>+<br>+static int __devinit<br>+ohci_ppc_of_start(struct usb_=
hcd *hcd)<br>+{<br>+=09struct ohci_hcd=09*ohci =3D hcd_to_ohci(hcd);<br>+=
=09int=09=09ret;<br>+<br>+=09if ((ret =3D ohci_init(ohci)) &lt; 0)<br>+=09=
=09return ret;<br>+<br>+=09if ((ret =3D ohci_run(ohci)) &lt; 0) {<br>+=09=
=09err("can't start %s", ohci_to_hcd(ohci)-&gt;self.bus_name);<br>+=09=09oh=
ci_stop(hcd);<br>+=09=09return ret;<br>+=09}<br>+<br>+=09return 0;<br>+}<br=
>+<br>+static const struct hc_driver ohci_ppc_of_hc_driver =3D {<br>+=09.de=
scription =3D=09=09hcd_name,<br>+=09.hcd_priv_size =3D=09sizeof(struct ohci=
_hcd),<br>+<br>+=09/*<br>+=09 * generic hardware linkage<br>+=09 */<br>+=09=
.irq =3D=09=09=09ohci_irq,<br>+=09.flags =3D=09=09HCD_USB11 | HCD_MEMORY,<b=
r>+<br>+=09/*<br>+=09 * basic lifecycle operations<br>+=09 */<br>+=09.start=
 =3D=09=09ohci_ppc_of_start,<br>+=09.stop =3D=09=09=09ohci_stop,<br>+=09.sh=
utdown =3D =09=09ohci_shutdown,<br>+<br>+=09/*<br>+=09 * managing i/o reque=
sts and associated device resources<br>+=09 */<br>+=09.urb_enqueue =3D=09=
=09ohci_urb_enqueue,<br>+=09.urb_dequeue =3D=09=09ohci_urb_dequeue,<br>+=09=
.endpoint_disable =3D=09ohci_endpoint_disable,<br>+<br>+=09/*<br>+=09 * sch=
eduling support<br>+=09 */<br>+=09.get_frame_number =3D=09ohci_get_frame,<b=
r>+<br>+=09/*<br>+=09 * root hub support<br>+=09 */<br>+=09.hub_status_data=
 =3D=09ohci_hub_status_data,<br>+=09.hub_control =3D=09=09ohci_hub_control,=
<br>+=09.hub_irq_enable =3D=09ohci_rhsc_enable,<br>+#ifdef=09CONFIG_PM<br>+=
=09.bus_suspend =3D=09=09ohci_bus_suspend,<br>+=09.bus_resume =3D=09=09ohci=
_bus_resume,<br>+#endif<br>+=09.start_port_reset =3D=09ohci_start_port_rese=
t,<br>+};<br>+<br>+<br>+<br>+static int ohci_hcd_ppc_of_drv_remove(struct o=
f_device *op)<br>+{<br>+=09struct usb_hcd *hcd =3D dev_get_drvdata(&amp;op-=
&gt;dev);<br>+=09dev_set_drvdata(&amp;op-&gt;dev, NULL);<br>+<br>+=09usb_hc=
d_ppc_of_remove(hcd, op);<br>+=09return 0;<br>+}<br>+<br>+static int ohci_h=
cd_ppc_of_drv_shutdown(struct of_device *op)<br>+{<br>+=09struct usb_hcd *h=
cd =3D dev_get_drvdata(&amp;op-&gt;dev);<br>+<br>+        if (hcd-&gt;drive=
r-&gt;shutdown)<br>+                hcd-&gt;driver-&gt;shutdown(hcd);<br>+<=
br>+=09return 0;<br>+}<br>+<br>+/*<br>+ *<br>+*/<br>+<br>+static struct of_=
device_id ohci_hcd_ppc_of_match[] =3D {<br>+#ifdef CONFIG_USB_OHCI_HCD_PPC_=
OF_BE<br>+=09{<br>+=09=09.name =3D "usb",<br>+=09=09.compatible =3D "ohci-b=
igendian",<br>+=09},<br>+=09{<br>+=09=09.name =3D "usb",<br>+=09=09.compati=
ble =3D "ohci-be",<br>+=09},<br>+#endif<br>+#ifdef CONFIG_USB_OHCI_HCD_PPC_=
OF_LE<br>+=09{<br>+=09=09.name =3D "usb",<br>+=09=09.compatible =3D "ohci-l=
ittledian",<br>+=09},<br>+=09{<br>+=09=09.name =3D "usb",<br>+=09=09.compat=
ible =3D "ohci-le",<br>+=09},<br>+#endif<br>+=09{},<br>+};<br>+<br>+static =
int __devinit<br>+ohci_hcd_ppc_of_drv_probe(struct of_device *op, const str=
uct of_device_id *match)<br>+{<br>+=09struct device_node *dev;<br>+=09int r=
et;<br>+=09int is_bigendian;<br>+<br>+=09if (usb_disabled())<br>+=09=09retu=
rn -ENODEV;<br>+<br>+=09dev =3D op-&gt;node;<br>+=09is_bigendian =3D 0;<br>=
+<br>+=09if ( device_is_compatible(dev, "ohci-bigendian") )<br>+=09=09is_bi=
gendian =3D 1;<br>+<br>+=09if ( device_is_compatible(dev, "ohci-be") )<br>+=
=09=09is_bigendian =3D 1;=09<br>+<br>+=09ret =3D usb_hcd_ppc_of_probe(&amp;=
ohci_ppc_of_hc_driver, op, is_bigendian);<br>+=09return ret;<br>+}<br>+<br>=
+static struct of_platform_driver ohci_hcd_ppc_of_driver =3D {<br>+=09.name=
=09=3D "ppc-of-ohci",<br>+=09.match_table=09=3D ohci_hcd_ppc_of_match,<br>+=
=09.probe=09=09=3D ohci_hcd_ppc_of_drv_probe,<br>+=09.remove=09=09=3D ohci_=
hcd_ppc_of_drv_remove,<br>+=09.shutdown =09=3D ohci_hcd_ppc_of_drv_shutdown=
,<br>+#ifdef=09CONFIG_PM<br>+=09/*.suspend=09=3D ohci_hcd_ppc_soc_drv_suspe=
nd,*/<br>+=09/*.resume=09=3D ohci_hcd_ppc_soc_drv_resume,*/<br>+#endif<br>+=
=09.driver=09=09=3D {<br>+=09=09.name=09=3D "ppc-of-ohci",<br>+=09=09.owner=
=09=3D THIS_MODULE,<br>+=09},<br>+};<br>+<br>+static int __init ohci_hcd_pp=
c_of_init(void)<br>+{<br>+=09pr_debug(DRIVER_INFO " (PPC OF)n");<br>+=09pr_=
debug("block sizes: ed %d td %dn", sizeof(struct ed),<br>+=09=09=09=09=09=
=09=09sizeof(struct td));<br>+=09<br>+=09return of_register_driver(&amp;ohc=
i_hcd_ppc_of_driver);    <br>+}<br>+<br>+static void __exit ohci_hcd_ppc_of=
_cleanup(void)<br>+{<br>+=09of_unregister_driver(&amp;ohci_hcd_ppc_of_drive=
r);<br>+}<br>+<br>+module_init(ohci_hcd_ppc_of_init);<br>+module_exit(ohci_=
hcd_ppc_of_cleanup);<br>--- a/drivers/usb/host/Kconfig=092006-11-01 09:18:5=
6.000000000 +0100<br>+++ b/drivers/usb/host/Kconfig=092006-11-06 11:10:29.0=
00000000 +0100<br>@@ -106,6 +106,25 @@ config USB_OHCI_HCD_PPC_SOC<br> =09 =
 Enables support for the USB controller on the MPC52xx or<br> =09  STB03xxx=
 processor chip.  If unsure, say Y.<br> <br>+config USB_OHCI_HCD_PPC_OF<br>=
+=09bool "OHCI support for PPC USB controller for OpenFirmware platform"<br=
>+=09depends on USB_OHCI_HCD &amp;&amp; PPC_OF<br>+=09default y<br>+=09---h=
elp---<br>+=09  Enables support for the USB controller PowerPC OpenFirmware=
 platform<br>+<br>+config USB_OHCI_HCD_PPC_OF_BE<br>+=09bool "Support big e=
ndian HC"<br>+=09depends on USB_OHCI_HCD_PPC_OF<br>+=09default y<br>+=09sel=
ect USB_OHCI_BIG_ENDIAN<br>+<br>+config USB_OHCI_HCD_PPC_OF_LE<br>+=09bool =
"Support little endian HC"<br>+=09depends on USB_OHCI_HCD_PPC_OF<br>+=09def=
ault n<br>+=09select USB_OHCI_LITTLE_ENDIAN<br>+<br> config USB_OHCI_HCD_PC=
I<br> =09bool "OHCI support for PCI-bus USB controllers"<br> =09depends on =
USB_OHCI_HCD &amp;&amp; PCI &amp;&amp; (STB03xxx || PPC_MPC52xx)<br>--- a/d=
rivers/usb/host/ohci-hcd.c=092006-11-01 09:18:56.000000000 +0100<br>+++ b/d=
rivers/usb/host/ohci-hcd.c=092006-11-06 11:10:29.000000000 +0100<br>@@ -930=
,6 +930,10 @@ MODULE_LICENSE ("GPL");<br> #include "ohci-ppc-soc.c"<br> #en=
dif<br> <br>+#ifdef CONFIG_USB_OHCI_HCD_PPC_OF<br>+#include "ohci-ppc-of.c"=
<br>+#endif<br>+<br> #if defined(CONFIG_ARCH_AT91RM9200) || defined(CONFIG_=
ARCH_AT91SAM9261)<br> #include "ohci-at91.c"<br> #endif<br>@@ -950,6 +954,8=
 @@ MODULE_LICENSE ("GPL");<br>       || defined (CONFIG_ARCH_AT91RM9200) <=
br>       || defined (CONFIG_ARCH_AT91SAM9261) <br>       || defined (CONFI=
G_ARCH_PNX4008) <br>+      || defined (CONFIG_USB_OHCI_HCD_PPC_OF_LE) <br>+=
      || defined (CONFIG_USB_OHCI_HCD_PPC_OF_BE) <br> =09)<br> #error "miss=
ing bus glue for ohci-hcd"<br> #endif<br><br></pre></BODY></HTML>
--b_01_636d7be58669559d85937eac8e1dad56
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

This patch use of_platform device to probe and install OHCI big endian HC.=
=0A=0APS: I did not success to properly inline the file using thrunderbird.=
=0A=0ASigned-off-by: Nicolas DET <nd@bplan-gmbh.de> =0A---=0A--- a/drivers/=
usb/host/ohci-ppc-of.c=091970-01-01 01:00:00.000000000 +0100=0A+++ b/driver=
s/usb/host/ohci-ppc-of.c=092006-11-06 11:10:29.000000000 +0100=0A@@ -0,0 +1=
,283 @@=0A+/*=0A+ * OHCI HCD (Host Controller Driver) for USB.=0A+ *=0A+ * =
(C) Copyright 1999 Roman Weissgaerber <weissg@vienna.at>=0A+ * (C) Copyrigh=
t 2000-2002 David Brownell <dbrownell@users.sourceforge.net>=0A+ * (C) Copy=
right 2002 Hewlett-Packard Company=0A+ * (C) Copyright 2003-2005 MontaVista=
 Software Inc.=0A+ * =0A+ * Probe and init OHCI Big endian HC from OpenFirm=
ware device tree=0A+ * Tested on Efika 5k2=0A+ *=0A+ * Modified by Dale Far=
nsworth <dale@farnsworth.org> from ohci-sa1111.c=0A+ *=0A+ * This file is l=
icenced under the GPL.=0A+ */=0A+=0A+#include <linux/signal.h>=0A+=0A+#incl=
ude <asm/of_device.h>=0A+#include <asm/prom.h>=0A+=0A+/* configure so an HC=
 device and id are always provided */=0A+/* always called with process cont=
ext; sleeping is OK */=0A+=0A+/*=0A+ * usb_hcd_ppc_of_probe - initialize On=
-Chip HCDs=0A+ * Context: !in_interrupt()=0A+ *=0A+ * Allocates basic resou=
rces for this USB host controller.=0A+ *=0A+ * Store this function in the H=
CD's struct pci_driver as probe().=0A+ */=0A+static int usb_hcd_ppc_of_prob=
e(const struct hc_driver *driver,=0A+=09=09=09  struct of_device *dev, int =
is_bigendian)=0A+{=0A+=09int retval;=0A+=09struct usb_hcd *hcd;=0A+=09struc=
t ohci_hcd=09*ohci;=0A+=09struct resource res;=0A+=09int irq;=0A+=09int ret=
;=0A+=0A+=09pr_debug("initializing PPC-OF USB Controller\n");=0A+=0A+=09if =
((ret =3D of_address_to_resource(dev->node, 0, &res)) !=3D 0)=0A+=09=09retu=
rn ret;=0A+=0A+=09hcd =3D usb_create_hcd(driver, &dev->dev, "PPC-OF USB");=
=0A+=09if (!hcd)=0A+=09=09return -ENOMEM;=0A+=0A+=09hcd->rsrc_start =3D res=
.start;=0A+=09hcd->rsrc_len =3D res.end - res.start + 1;=0A+=0A+=09if (!req=
uest_mem_region(hcd->rsrc_start, hcd->rsrc_len, hcd_name)) {=0A+=09=09pr_de=
bug(__FILE__ ": request_mem_region failed\n");=0A+=09=09retval =3D -EBUSY;=
=0A+=09=09goto err1;=0A+=09}=0A+=0A+=09irq =3D irq_of_parse_and_map(dev->no=
de, 0);=0A+=09if (irq =3D=3D NO_IRQ) {=0A+=09=09retval =3D -EBUSY;=0A+=09=
=09goto err2;=0A+=09}=0A+=0A+=09hcd->regs =3D ioremap(hcd->rsrc_start, hcd-=
>rsrc_len);=0A+=09if (!hcd->regs) {=0A+=09=09pr_debug(__FILE__ ": ioremap f=
ailed\n");=0A+=09=09retval =3D -ENOMEM;=0A+=09=09goto err2;=0A+=09}=0A+=0A+=
=09ohci =3D hcd_to_ohci(hcd);=0A+=09if (is_bigendian)=0A+=09=09ohci->flags =
|=3D OHCI_BIG_ENDIAN;=0A+=0A+=09ohci_hcd_init(ohci);=0A+=0A+=09retval =3D u=
sb_add_hcd(hcd, irq, 0);=0A+=09if (retval =3D=3D 0)=0A+=09=09return retval;=
=0A+=0A+=09pr_debug("Removing PPC-OF USB Controller\n");=0A+=0A+=09iounmap(=
hcd->regs);=0A+ err2:=0A+=09release_mem_region(hcd->rsrc_start, hcd->rsrc_l=
en);=0A+ err1:=0A+ =09usb_put_hcd(hcd);=0A+=09return retval;=0A+}=0A+=0A+=
=0A+/* may be called without controller electrically present */=0A+/* may b=
e called with controller, bus, and devices active */=0A+=0A+/*=0A+ * usb_hc=
d_ppc_of_remove - shutdown processing for On-Chip HCDs=0A+ * @pdev: USB Hos=
t Controller being removed=0A+ * Context: !in_interrupt()=0A+ *=0A+ * Rever=
ses the effect of usb_hcd_ppc_of_probe().=0A+ * It is always called from a =
thread=0A+ * context, normally "rmmod", "apmd", or something similar.=0A+ *=
=0A+ */=0A+static void usb_hcd_ppc_of_remove(struct usb_hcd *hcd,=0A+=09=09=
struct of_device *op)=0A+{=0A+=09usb_remove_hcd(hcd);=0A+=0A+=09pr_debug("s=
topping PPC-OF USB Controller\n");=0A+=0A+=09iounmap(hcd->regs);=0A+=09rele=
ase_mem_region(hcd->rsrc_start, hcd->rsrc_len);=0A+=09usb_put_hcd(hcd);=0A+=
}=0A+=0A+static int __devinit=0A+ohci_ppc_of_start(struct usb_hcd *hcd)=0A+=
{=0A+=09struct ohci_hcd=09*ohci =3D hcd_to_ohci(hcd);=0A+=09int=09=09ret;=
=0A+=0A+=09if ((ret =3D ohci_init(ohci)) < 0)=0A+=09=09return ret;=0A+=0A+=
=09if ((ret =3D ohci_run(ohci)) < 0) {=0A+=09=09err("can't start %s", ohci_=
to_hcd(ohci)->self.bus_name);=0A+=09=09ohci_stop(hcd);=0A+=09=09return ret;=
=0A+=09}=0A+=0A+=09return 0;=0A+}=0A+=0A+static const struct hc_driver ohci=
_ppc_of_hc_driver =3D {=0A+=09.description =3D=09=09hcd_name,=0A+=09.hcd_pr=
iv_size =3D=09sizeof(struct ohci_hcd),=0A+=0A+=09/*=0A+=09 * generic hardwa=
re linkage=0A+=09 */=0A+=09.irq =3D=09=09=09ohci_irq,=0A+=09.flags =3D=09=
=09HCD_USB11 | HCD_MEMORY,=0A+=0A+=09/*=0A+=09 * basic lifecycle operations=
=0A+=09 */=0A+=09.start =3D=09=09ohci_ppc_of_start,=0A+=09.stop =3D=09=09=
=09ohci_stop,=0A+=09.shutdown =3D =09=09ohci_shutdown,=0A+=0A+=09/*=0A+=09 =
* managing i/o requests and associated device resources=0A+=09 */=0A+=09.ur=
b_enqueue =3D=09=09ohci_urb_enqueue,=0A+=09.urb_dequeue =3D=09=09ohci_urb_d=
equeue,=0A+=09.endpoint_disable =3D=09ohci_endpoint_disable,=0A+=0A+=09/*=
=0A+=09 * scheduling support=0A+=09 */=0A+=09.get_frame_number =3D=09ohci_g=
et_frame,=0A+=0A+=09/*=0A+=09 * root hub support=0A+=09 */=0A+=09.hub_statu=
s_data =3D=09ohci_hub_status_data,=0A+=09.hub_control =3D=09=09ohci_hub_con=
trol,=0A+=09.hub_irq_enable =3D=09ohci_rhsc_enable,=0A+#ifdef=09CONFIG_PM=
=0A+=09.bus_suspend =3D=09=09ohci_bus_suspend,=0A+=09.bus_resume =3D=09=09o=
hci_bus_resume,=0A+#endif=0A+=09.start_port_reset =3D=09ohci_start_port_res=
et,=0A+};=0A+=0A+=0A+=0A+static int ohci_hcd_ppc_of_drv_remove(struct of_de=
vice *op)=0A+{=0A+=09struct usb_hcd *hcd =3D dev_get_drvdata(&op->dev);=0A+=
=09dev_set_drvdata(&op->dev, NULL);=0A+=0A+=09usb_hcd_ppc_of_remove(hcd, op=
);=0A+=09return 0;=0A+}=0A+=0A+static int ohci_hcd_ppc_of_drv_shutdown(stru=
ct of_device *op)=0A+{=0A+=09struct usb_hcd *hcd =3D dev_get_drvdata(&op->d=
ev);=0A+=0A+        if (hcd->driver->shutdown)=0A+                hcd->driv=
er->shutdown(hcd);=0A+=0A+=09return 0;=0A+}=0A+=0A+/*=0A+ *=0A+*/=0A+=0A+st=
atic struct of_device_id ohci_hcd_ppc_of_match[] =3D {=0A+#ifdef CONFIG_USB=
_OHCI_HCD_PPC_OF_BE=0A+=09{=0A+=09=09.name =3D "usb",=0A+=09=09.compatible =
=3D "ohci-bigendian",=0A+=09},=0A+=09{=0A+=09=09.name =3D "usb",=0A+=09=09.=
compatible =3D "ohci-be",=0A+=09},=0A+#endif=0A+#ifdef CONFIG_USB_OHCI_HCD_=
PPC_OF_LE=0A+=09{=0A+=09=09.name =3D "usb",=0A+=09=09.compatible =3D "ohci-=
littledian",=0A+=09},=0A+=09{=0A+=09=09.name =3D "usb",=0A+=09=09.compatibl=
e =3D "ohci-le",=0A+=09},=0A+#endif=0A+=09{},=0A+};=0A+=0A+static int __dev=
init=0A+ohci_hcd_ppc_of_drv_probe(struct of_device *op, const struct of_dev=
ice_id *match)=0A+{=0A+=09struct device_node *dev;=0A+=09int ret;=0A+=09int=
 is_bigendian;=0A+=0A+=09if (usb_disabled())=0A+=09=09return -ENODEV;=0A+=
=0A+=09dev =3D op->node;=0A+=09is_bigendian =3D 0;=0A+=0A+=09if ( device_is=
_compatible(dev, "ohci-bigendian") )=0A+=09=09is_bigendian =3D 1;=0A+=0A+=
=09if ( device_is_compatible(dev, "ohci-be") )=0A+=09=09is_bigendian =3D 1;=
=09=0A+=0A+=09ret =3D usb_hcd_ppc_of_probe(&ohci_ppc_of_hc_driver, op, is_b=
igendian);=0A+=09return ret;=0A+}=0A+=0A+static struct of_platform_driver o=
hci_hcd_ppc_of_driver =3D {=0A+=09.name=09=3D "ppc-of-ohci",=0A+=09.match_t=
able=09=3D ohci_hcd_ppc_of_match,=0A+=09.probe=09=09=3D ohci_hcd_ppc_of_drv=
_probe,=0A+=09.remove=09=09=3D ohci_hcd_ppc_of_drv_remove,=0A+=09.shutdown =
=09=3D ohci_hcd_ppc_of_drv_shutdown,=0A+#ifdef=09CONFIG_PM=0A+=09/*.suspend=
=09=3D ohci_hcd_ppc_soc_drv_suspend,*/=0A+=09/*.resume=09=3D ohci_hcd_ppc_s=
oc_drv_resume,*/=0A+#endif=0A+=09.driver=09=09=3D {=0A+=09=09.name=09=3D "p=
pc-of-ohci",=0A+=09=09.owner=09=3D THIS_MODULE,=0A+=09},=0A+};=0A+=0A+stati=
c int __init ohci_hcd_ppc_of_init(void)=0A+{=0A+=09pr_debug(DRIVER_INFO " (=
PPC OF)\n");=0A+=09pr_debug("block sizes: ed %d td %d\n", sizeof(struct ed)=
,=0A+=09=09=09=09=09=09=09sizeof(struct td));=0A+=09=0A+=09return of_regist=
er_driver(&ohci_hcd_ppc_of_driver);    =0A+}=0A+=0A+static void __exit ohci=
_hcd_ppc_of_cleanup(void)=0A+{=0A+=09of_unregister_driver(&ohci_hcd_ppc_of_=
driver);=0A+}=0A+=0A+module_init(ohci_hcd_ppc_of_init);=0A+module_exit(ohci=
_hcd_ppc_of_cleanup);=0A--- a/drivers/usb/host/Kconfig=092006-11-01 09:18:5=
6.000000000 +0100=0A+++ b/drivers/usb/host/Kconfig=092006-11-06 11:10:29.00=
0000000 +0100=0A@@ -106,6 +106,25 @@ config USB_OHCI_HCD_PPC_SOC=0A =09  En=
ables support for the USB controller on the MPC52xx or=0A =09  STB03xxx pro=
cessor chip.  If unsure, say Y.=0A =0A+config USB_OHCI_HCD_PPC_OF=0A+=09boo=
l "OHCI support for PPC USB controller for OpenFirmware platform"=0A+=09dep=
ends on USB_OHCI_HCD && PPC_OF=0A+=09default y=0A+=09---help---=0A+=09  Ena=
bles support for the USB controller PowerPC OpenFirmware platform=0A+=0A+co=
nfig USB_OHCI_HCD_PPC_OF_BE=0A+=09bool "Support big endian HC"=0A+=09depend=
s on USB_OHCI_HCD_PPC_OF=0A+=09default y=0A+=09select USB_OHCI_BIG_ENDIAN=
=0A+=0A+config USB_OHCI_HCD_PPC_OF_LE=0A+=09bool "Support little endian HC"=
=0A+=09depends on USB_OHCI_HCD_PPC_OF=0A+=09default n=0A+=09select USB_OHCI=
_LITTLE_ENDIAN=0A+=0A config USB_OHCI_HCD_PCI=0A =09bool "OHCI support for =
PCI-bus USB controllers"=0A =09depends on USB_OHCI_HCD && PCI && (STB03xxx =
|| PPC_MPC52xx)=0A--- a/drivers/usb/host/ohci-hcd.c=092006-11-01 09:18:56.0=
00000000 +0100=0A+++ b/drivers/usb/host/ohci-hcd.c=092006-11-06 11:10:29.00=
0000000 +0100=0A@@ -930,6 +930,10 @@ MODULE_LICENSE ("GPL");=0A #include "o=
hci-ppc-soc.c"=0A #endif=0A =0A+#ifdef CONFIG_USB_OHCI_HCD_PPC_OF=0A+#inclu=
de "ohci-ppc-of.c"=0A+#endif=0A+=0A #if defined(CONFIG_ARCH_AT91RM9200) || =
defined(CONFIG_ARCH_AT91SAM9261)=0A #include "ohci-at91.c"=0A #endif=0A@@ -=
950,6 +954,8 @@ MODULE_LICENSE ("GPL");=0A       || defined (CONFIG_ARCH_AT=
91RM9200) \=0A       || defined (CONFIG_ARCH_AT91SAM9261) \=0A       || def=
ined (CONFIG_ARCH_PNX4008) \=0A+      || defined (CONFIG_USB_OHCI_HCD_PPC_O=
F_LE) \=0A+      || defined (CONFIG_USB_OHCI_HCD_PPC_OF_BE) \=0A =09)=0A #e=
rror "missing bus glue for ohci-hcd"=0A #endif=0A=0A
--b_01_636d7be58669559d85937eac8e1dad56--
