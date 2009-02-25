Return-Path: <mbergandi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 21C7EDDDA1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 06:51:54 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so171775qwe.15
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 11:51:53 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 25 Feb 2009 14:51:52 -0500
Message-ID: <1c641bc80902251151v5a4a5e15g13f6711510acb7ee@mail.gmail.com>
Subject: MPC8313E-RDB and USB OTG
From: Michael Bergandi <mbergandi@gmail.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: multipart/alternative; boundary=0015175cdcc435d9900463c39145
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0015175cdcc435d9900463c39145
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

I am hoping someone can shed some light on the state of the USB support in
the
2.6.28 kernel for USB OTG on the MPC8313E RDB. The configuration options are
a bit different than the ones from the provided LTIB kernel--- for obvious
reasons---
and I am trying to figure out how to get OTG working in this version of the
kernel
on my board.

I have tried to configure the kernel as close as I could to the config for
the LTIB
kernel (2.6.23). This is what it looks like right now:

Kernel config
Device drivers --->
[*]   USB support --->
        --- USB support
        <*>   Support for Host-side USB
        [*]     USB verbose debug messages
        [*]     USB announce new devices

                 *** Miscellaneous USB options ***
        [*]     USB device filesystem
        [*]     USB device class-devices (DEPRECATED)
        [*]     USB Monitor

                    *** USB Host Controller Drivers ***
        <*>     EHCI HCD (USB 2.0) support
        -*-       Root Hub Transaction Translators
        [*]       Support for Freescale on-chip EHCI USB controller
        [*]       EHCI support for PPC USB controller on OF platform bus

                  *** USB Device Class drivers ***
        <*>   USB Mass Storage support
         [*]     USB Mass Storage verbose debug

                  *** USB Miscelaneous drivers ***
        <*>   USB Gadget Support  --->
                  --- USB gadget support
                  (2)   Maximum VBUS Power usage (2-500 mA)
                         USB Peripheral Controller (Freescale Highspeed USB
DR Peripheral Controller)  --->
                                 Freescale Highspeed USB DR Peripheral
Controller
                  <*>   USB Gadget Drivers (Ethernet Gadget (with CDC
Ethernet support))  --->
                                 Ethernet Gadget (with CDC Ethernet support)
                   [*]       RNDIS support

The device tree node seems to be pretty straight forward.
Device tree node:

        usb@23000 {
            compatible = "fsl-usb2-dr";
            reg = <0x23000 0x1000>;
            #address-cells = <1>;
            #size-cells = <0>;
            interrupt-parent = <&ipic>;
            interrupts = <38 0x8>;
            phy_type = "ulpi";
            dr_mode = "otg";
            sleep = <&pmc 0x00300000>;
        };

Here is the output I get from the kernel when bringing up the USB:

usbmon: debugfs is not available
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 38, io base 0xe0023000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Freescale On-Chip EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.28 ehci_hcd
usb usb1: SerialNumber: fsl-ehci.0
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
Freescale High-Speed USB SOC Device Controller driver (Apr 20, 2007)
udc: request mem region for fsl-usb2-udc failed
fsl-usb2-udc: probe of fsl-usb2-udc.0 failed with error -16

I tracked down the error to the fsl_udc_probe function in fsl_usb2_udc.c:

static int __init fsl_udc_probe(struct platform_device *pdev)
{
    struct resource *res;
    int ret = -ENODEV;
    unsigned int i;
    u32 dccparams;

    if (strcmp(pdev->name, driver_name)) {
        VDBG("Wrong device");
        return -ENODEV;
    }

    udc_controller = kzalloc(sizeof(struct fsl_udc), GFP_KERNEL);
    if (udc_controller == NULL) {
        ERR("malloc udc failed\n");
        return -ENOMEM;
    }

    spin_lock_init(&udc_controller->lock);
    udc_controller->stopped = 1;

    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    if (!res) {
        ret = -ENXIO;
        goto err_kfree;
    }

    if (!request_mem_region(res->start, res->end - res->start + 1,
                driver_name)) {
        ERR("request mem region for %s failed\n", pdev->name);
        ret = -EBUSY;
        goto err_kfree;
    }
...


Now, I can stick in a USB flash drive and mount it. So, I know the host side

is working fine. The gadget driver doesn't appear to be able to load,
presumably because the host driver has already registered its memory
resources and will not release/share them.

What is the correct configuration to have real OTG working? Specifically,
what is the configuration that will allow me to plug in a flash drive and
mount it, unmount it, plug in a host (laptop or such) and have it think it
is connected to a USB Ethernet gadget WITHOUT having to manually
load and unload modules?

Thanks any help you can provide.

Mike

--0015175cdcc435d9900463c39145
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>I am hoping someone can shed some light on the state of the =
USB support in the <br>2.6.28 kernel for USB OTG on the MPC8313E RDB. The c=
onfiguration options are<br>a bit different than the ones from the provided=
 LTIB kernel--- for obvious reasons---<br>
and I am trying to figure out how to get OTG working in this version of the=
 kernel<br>on my board.<br><br>I have tried to configure the kernel as clos=
e as I could to the config for the LTIB<br>kernel (2.6.23). This is what it=
 looks like right now:<br>
<br>Kernel config<br>Device drivers ---&gt;<br>[*]=A0=A0 USB support ---&gt=
; =A0=A0 <br>=A0=A0=A0=A0=A0=A0=A0 --- USB support<br>=A0=A0=A0=A0=A0=A0=A0=
 &lt;*&gt;=A0=A0 Support for Host-side USB<br>=A0=A0=A0=A0=A0=A0=A0 [*]=A0=
=A0=A0=A0 USB verbose debug messages <br>=A0=A0=A0=A0=A0=A0=A0 [*]=A0=A0=A0=
=A0 USB announce new devices<br>
<br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 *** Miscellaneous USB options ***<br=
>=A0=A0=A0=A0=A0=A0=A0 [*]=A0=A0=A0=A0 USB device filesystem<br>=A0=A0=A0=
=A0=A0=A0=A0 [*]=A0=A0=A0=A0 USB device class-devices (DEPRECATED)<br>=A0=
=A0=A0=A0=A0=A0=A0 [*]=A0=A0=A0=A0 USB Monitor<br><br>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *** USB Host Controller Drivers ***<br=
 clear=3D"all">
=A0=A0=A0=A0=A0=A0=A0 &lt;*&gt;=A0=A0=A0=A0 EHCI HCD (USB 2.0) support<br>=
=A0=A0=A0=A0=A0=A0=A0 -*-=A0=A0=A0=A0=A0=A0 Root Hub Transaction Translator=
s<br>=A0=A0=A0=A0=A0=A0=A0 [*]=A0=A0=A0=A0=A0=A0 Support for Freescale on-c=
hip EHCI USB controller<br>=A0=A0=A0=A0=A0=A0=A0 [*]=A0=A0=A0=A0=A0=A0 EHCI=
 support for PPC USB controller on OF platform bus<br>
<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *** USB Device Clas=
s drivers ***<br>=A0=A0=A0=A0=A0=A0=A0 &lt;*&gt;=A0=A0 USB Mass Storage sup=
port<br>=A0=A0=A0=A0=A0=A0=A0=A0 [*]=A0=A0=A0=A0 USB Mass Storage verbose d=
ebug<br><br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *** USB Mis=
celaneous drivers ***<br>=A0=A0=A0=A0=A0=A0=A0 &lt;*&gt;=A0=A0 USB Gadget S=
upport=A0 ---&gt;<br>
=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0=A0=A0=A0=A0=A0 --- USB gadget support =A0=
=A0=A0=A0=A0=A0 <br>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (2)=A0=A0 Maximum V=
BUS Power usage (2-500 mA)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 USB Peripheral Controller (Freescale Highspeed =
USB DR Peripheral Controller)=A0 ---&gt;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 Freescale Highspeed USB DR Peripheral Controller<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &lt;*&gt;=A0=A0 USB Gad=
get Drivers (Ethernet Gadget (with CDC Ethernet support))=A0 ---&gt;<br>=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =A0 =A0=A0 Ethernet Gadget (with CDC Ethernet support)<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [*]=A0=A0=A0=A0=A0=
=A0 RNDIS support=A0 <br><br>The device tree node seems to be pretty straig=
ht forward.<br>Device tree node:<br><br>=A0=A0=A0 =A0=A0=A0 usb@23000 {<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D &quot;fsl-usb2-dr&quot;;<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x23000 0x1000&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #address-cells =3D &lt;1&gt;;<br>=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 #size-cells =3D &lt;0&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 interrupt-parent =3D &lt;&amp;ipic&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 interrupts =3D &lt;38 0x8&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 phy_=
type =3D &quot;ulpi&quot;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dr_mode =3D &quot;otg&quot;;<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 sleep =3D &lt;&amp;pmc 0x00300000&gt;;<br>=A0=A0=A0 =A0=A0=
=A0 };<br><br>Here is the output I get from the kernel when bringing up the=
 USB:<br><br>usbmon: debugfs is not available<br>
ehci_hcd: USB 2.0 &#39;Enhanced&#39; Host Controller (EHCI) Driver<br>fsl-e=
hci fsl-ehci.0: Freescale On-Chip EHCI Host Controller<br>fsl-ehci fsl-ehci=
.0: new USB bus registered, assigned bus number 1<br>fsl-ehci fsl-ehci.0: i=
rq 38, io base 0xe0023000<br>
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00<br>usb usb1: configuration =
#1 chosen from 1 choice<br>hub 1-0:1.0: USB hub found<br>hub 1-0:1.0: 1 por=
t detected<br>usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D=
0002<br>
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1<br=
>usb usb1: Product: Freescale On-Chip EHCI Host Controller<br>usb usb1: Man=
ufacturer: Linux 2.6.28 ehci_hcd<br>usb usb1: SerialNumber: fsl-ehci.0<br>I=
nitializing USB Mass Storage driver...<br>
usbcore: registered new interface driver usb-storage<br>USB Mass Storage su=
pport registered.<br>Freescale High-Speed USB SOC Device Controller driver =
(Apr 20, 2007)<br>udc: request mem region for fsl-usb2-udc failed<br>fsl-us=
b2-udc: probe of fsl-usb2-udc.0 failed with error -16<br>
<br>I tracked down the error to the fsl_udc_probe function in fsl_usb2_udc.=
c:<br><br>static int __init fsl_udc_probe(struct platform_device *pdev)<br>=
{<br>=A0=A0=A0 struct resource *res;<br>=A0=A0=A0 int ret =3D -ENODEV;<br>=
=A0=A0=A0 unsigned int i;<br>
=A0=A0=A0 u32 dccparams;<br><br>=A0=A0=A0 if (strcmp(pdev-&gt;name, driver_=
name)) {<br>=A0=A0=A0 =A0=A0=A0 VDBG(&quot;Wrong device&quot;);<br>=A0=A0=
=A0 =A0=A0=A0 return -ENODEV;<br>=A0=A0=A0 }<br><br>=A0=A0=A0 udc_controlle=
r =3D kzalloc(sizeof(struct fsl_udc), GFP_KERNEL);<br>
=A0=A0=A0 if (udc_controller =3D=3D NULL) {<br>=A0=A0=A0 =A0=A0=A0 ERR(&quo=
t;malloc udc failed\n&quot;);<br>=A0=A0=A0 =A0=A0=A0 return -ENOMEM;<br>=A0=
=A0=A0 }<br><br>=A0=A0=A0 spin_lock_init(&amp;udc_controller-&gt;lock);<br>=
=A0=A0=A0 udc_controller-&gt;stopped =3D 1;<br><br>
=A0=A0=A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);<br>=A0=A0=
=A0 if (!res) {<br>=A0=A0=A0 =A0=A0=A0 ret =3D -ENXIO;<br>=A0=A0=A0 =A0=A0=
=A0 goto err_kfree;<br>=A0=A0=A0 }<br><br>=A0=A0=A0 if (!request_mem_region=
(res-&gt;start, res-&gt;end - res-&gt;start + 1,<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 driver_name)) {<br>=A0=A0=A0 =A0=A0=
=A0 ERR(&quot;request mem region for %s failed\n&quot;, pdev-&gt;name);<br>=
=A0=A0=A0 =A0=A0=A0 ret =3D -EBUSY;<br>=A0=A0=A0 =A0=A0=A0 goto err_kfree;<=
br>=A0=A0=A0 }<br>...<br><br><br>Now, I can stick in a USB flash drive and =
mount it. So, I know the host side <br>
is working fine. The gadget driver doesn&#39;t appear to be able to load, <=
br>presumably because the host driver has already registered its memory<br>=
resources and will not release/share them. <br><br>What is the correct conf=
iguration to have real OTG working? Specifically, <br>
what is the configuration that will allow me to plug in a flash drive and <=
br>mount it, unmount it, plug in a host (laptop or such) and have it think =
it <br>is connected to a USB Ethernet gadget WITHOUT having to manually <br=
>
load and unload modules?<br><br>Thanks any help you can provide.<br><br>Mik=
e<br>

--0015175cdcc435d9900463c39145--
