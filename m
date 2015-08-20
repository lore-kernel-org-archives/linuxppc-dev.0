Return-Path: <balbi@ti.com>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DBDF1A05A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 01:36:31 +1000 (AEST)
Date: Thu, 20 Aug 2015 10:35:53 -0500
From: Felipe Balbi <balbi@ti.com>
To: Robert Baldyga <r.baldyga@samsung.com>
CC: <balbi@ti.com>, <gregkh@linuxfoundation.org>, <Peter.Chen@freescale.com>,
 <johnyoun@synopsys.com>, <dahlmann.thomas@arcor.de>,
 <nicolas.ferre@atmel.com>, <cernekee@gmail.com>, <leoli@freescale.com>,
 <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
 <robert.jarzmik@free.fr>, <michal.simek@xilinx.com>,
 <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
 <linux-usb@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-geode@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>, <andrzej.p@samsung.com>,
 <m.szyprowski@samsung.com>, <stern@rowland.harvard.edu>, <petr.cvek@tul.cz>
Subject: Re: [PATCH v5 01/46] usb: gadget: encapsulate endpoint claiming
 mechanism
Message-ID: <20150820153553.GD1639@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-2-git-send-email-r.baldyga@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
In-Reply-To: <1438351258-31578-2-git-send-email-r.baldyga@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 31, 2015 at 04:00:13PM +0200, Robert Baldyga wrote:
> So far it was necessary for usb functions to set ep->driver_data in
> endpoint obtained from autoconfig to non-null value, to indicate that
> endpoint is claimed by function (in autoconfig it was checked if endpoint
> has set this field to non-null value, and if it has, it was assumed that
> it is claimed). It could cause bugs because if some function doesn't
> set this field autoconfig could return the same endpoint more than one
> time.
>=20
> To help to avoid such bugs this patch adds claimed flag to struct usb_ep,
> and  encapsulates endpoint claiming mechanism inside usb_ep_autoconfig_ss=
()
> and usb_ep_autoconfig_reset(), so now usb functions don't need to perform
> any additional actions to mark endpoint obtained from autoconfig as claim=
ed.
>=20
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

just letting you know that this regresses all gadget drivers making them
try to disable previously disabled endpoints and enable previously
enabled endpoints.

I have a possible fix (see below) but then it shows a problem on the
host side when using with g_zero (see further below):

commit 3b8932100aacb6cfbffe288ca93025d8b8430c00
Author: Felipe Balbi <balbi@ti.com>
Date:   Wed Aug 19 18:05:27 2015 -0500

    usb: gadget: fix ep->claimed lifetime
   =20
    In order to fix a regression introduced by commit
    cc476b42a39d ("usb: gadget: encapsulate endpoint
    claiming mechanism") we have to introduce a simple
    helper to check if a particular is enabled or not.
   =20
    After that, we need to move ep->claimed lifetime to
    usb_ep_enable() and usb_ep_disable() since those
    are the only functions which actually enable and
    disable endpoints.
   =20
    A follow-up patch will come to drop all driver_data
    checks from function drivers, since those are, now,
    pointless.
   =20
    Fixes: cc476b42a39d ("usb: gadget: encapsulate endpoint
    	claiming mechanism")
    Cc: Robert Baldyga <r.baldyga@samsung.com>
    Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautocon=
f.c
index 978435a51038..ad45070cd76f 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -126,7 +126,6 @@ found_ep:
 	ep->address =3D desc->bEndpointAddress;
 	ep->desc =3D NULL;
 	ep->comp_desc =3D NULL;
-	ep->claimed =3D true;
 	return ep;
 }
 EXPORT_SYMBOL_GPL(usb_ep_autoconfig_ss);
@@ -182,11 +181,6 @@ EXPORT_SYMBOL_GPL(usb_ep_autoconfig);
  */
 void usb_ep_autoconfig_reset (struct usb_gadget *gadget)
 {
-	struct usb_ep	*ep;
-
-	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
-		ep->claimed =3D false;
-	}
 	gadget->in_epnum =3D 0;
 	gadget->out_epnum =3D 0;
 }
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index c14a69b36d27..9b3d60c1cf9f 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -243,6 +243,22 @@ static inline void usb_ep_set_maxpacket_limit(struct u=
sb_ep *ep,
 }
=20
 /**
+ * usb_ep_enabled - is endpoint enabled ?
+ * @ep: the endpoint being checked. may not be the endpoint named "ep0".
+ *
+ * Whenever a function driver wants to check if a particular endpoint is
+ * enabled or not, it must check using this helper function. This will
+ * encapsulate details about how the endpoint is checked, saving the funct=
ion
+ * driver from using private methods for doing so.
+ *
+ * return true if endpoint is enabled, false otherwise.
+ */
+static inline bool usb_ep_enabled(struct usb_ep *ep)
+{
+	return ep->claimed;
+}
+
+/**
  * usb_ep_enable - configure endpoint, making it usable
  * @ep:the endpoint being configured.  may not be the endpoint named "ep0".
  *	drivers discover endpoints through the ep_list of a usb_gadget.
@@ -264,7 +280,18 @@ static inline void usb_ep_set_maxpacket_limit(struct u=
sb_ep *ep,
  */
 static inline int usb_ep_enable(struct usb_ep *ep)
 {
-	return ep->ops->enable(ep, ep->desc);
+	int ret;
+
+	if (usb_ep_enabled(ep))
+		return 0;
+
+	ret =3D ep->ops->enable(ep, ep->desc);
+	if (ret)
+		return ret;
+
+	ep->claimed =3D true;
+
+	return 0;
 }
=20
 /**
@@ -281,7 +308,18 @@ static inline int usb_ep_enable(struct usb_ep *ep)
  */
 static inline int usb_ep_disable(struct usb_ep *ep)
 {
-	return ep->ops->disable(ep);
+	int ret;
+
+	if (!usb_ep_enabled(ep))
+		return 0;
+
+	ret =3D ep->ops->disable(ep);
+	if (ret)
+		return ret;
+
+	ep->claimed =3D false;
+
+	return 0;
 }
=20
 /**



[   73.290345] WARNING: CPU: 0 PID: 300 at lib/kobject.c:240 kobject_add_in=
ternal+0x25c/0x2d8()
[   73.299172] kobject_add_internal failed for ep_81 with -EEXIST, don't tr=
y to register things with the same name in the same directory.
[   73.311825] Modules linked in: usbtest usb_f_ss_lb g_zero libcomposite x=
hci_plat_hcd xhci_hcd usbcore joydev dwc3 udc_core usb_common m25p80 evdev =
spi_nor omapfb cpufreq_dt cfbfillrect snd_soc_simple_card cfbimgblt thermal=
_sys cfbcopyarea hwmon leds_gpio matrix_keypad led_class matrix_keymap pane=
l_dpi pwm_bl snd_soc_tlv320aic3x snd_soc_davinci_mcasp snd_soc_edma snd_soc=
_omap snd_soc_core omapdss snd_compress snd_pcm_dmaengine snd_pcm dwc3_omap=
 extcon snd_timer pwm_tiecap snd lis3lv02d_i2c lis3lv02d soundcore  input_p=
olldev spi_ti_qspi tps65218_pwrbutton rtc_omap omap_wdt phy_omap_usb2 autof=
s4
 [   73.367114] CPU: 0 PID: 300 Comm: testusb Tainted: G        W  4.2.0-rc=
7-next-20150819-00002-g3ccb6c8b6305 #1080
 [   73.378236] Hardware name: Generic AM43 (Flattened Device Tree)
 [   73.384439] [<c0016f14>] (unwind_backtrace) from [<c001339c>] (show_sta=
ck+0x10/0x14)
 [   73.392566] [<c001339c>] (show_stack) from [<c0636cec>] (dump_stack+0x8=
4/0x9c)
 [   73.400164] [<c0636cec>] (dump_stack) from [<c003db48>] (warn_slowpath_=
common+0x78/0xb4)
 [   73.408649] [<c003db48>] (warn_slowpath_common) from [<c003dbb4>] (warn=
_slowpath_fmt+0x30/0x40)
 [   73.417783] [<c003dbb4>] (warn_slowpath_fmt) from [<c03473e4>] (kobject=
_add_internal+0x25c/0x2d8)
 [   73.427063] [<c03473e4>] (kobject_add_internal) from [<c03474ac>] (kobj=
ect_add+0x4c/0x98)
 [   73.435641] [<c03474ac>] (kobject_add) from [<c03d8a58>] (device_add+0x=
d4/0x56c)
 [   73.443466] [<c03d8a58>] (device_add) from [<bf2c17b0>] (usb_create_ep_=
devs+0x60/0xac [usbcore])
 [   73.452788] [<bf2c17b0>] (usb_create_ep_devs [usbcore]) from [<bf2bb210=
>] (create_intf_ep_devs+0x48/0x70 [usbcore])
 [   73.463801] [<bf2bb210>] (create_intf_ep_devs [usbcore]) from [<bf2bbae=
0>] (usb_set_interface+0x1c4/0x2f4 [usbcore])
 [   73.474891] [<bf2bbae0>] (usb_set_interface [usbcore]) from [<bf33d370>=
] (usbtest_ioctl+0x840/0x14c8 [usbtest])
 [   73.485659] [<bf33d370>] (usbtest_ioctl [usbtest]) from [<bf2c569c>] (u=
sbdev_ioctl+0x1728/0x17fc [usbcore])
 [   73.495947] [<bf2c569c>] (usbdev_ioctl [usbcore]) from [<c0185764>] (do=
_vfs_ioctl+0x3f4/0x6c4)
 [   73.504989] [<c0185764>] (do_vfs_ioctl) from [<c0185aa0>] (SyS_ioctl+0x=
6c/0x7c)
 [   73.512662] [<c0185aa0>] (SyS_ioctl) from [<c000f540>] (ret_fast_syscal=
l+0x0/0x54)
 [   73.520605] ---[ end trace 4576b2ea698fb13f ]---


--=20
balbi

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV1fPZAAoJEIaOsuA1yqREI24P/Ai5r31e20GXR2CF+euHcyn0
17Z5VxSAbve3eLnWR+SBit1bKFLXPqAgkJgN5o3y8xI5Wo/cGsILgYu/WL9ECeuC
AggjNKbOWd4bQV6eKNbRLMg5QSB89zZGgHsyslxrDVwAd6e8mY2/L7e7Qpi3KMUN
+Nfp8BOKPUrd2pIEKXvKAsTKOgTFO/NGeHBWLh5wQJi3s3l7FdHI9UW873G5svlI
PPPFP3qRq4tk0vjCj3b2YrdZk8L/zedYRvZ6buVgsOfxKPu63q1tVNmSrwsdN2GG
6F46zHwRGghUuOb93LP7g7UOkdrLtd6lfxbcSYaK75cpbYhX+zaBdjKVNNQ6Eex+
QZyWSxAp075vRGj5+Nos4jBw9oyWgjNilhfBtxrgsOIrjDEy97eUsKlnzWJTzG56
gLgjPwSq1U3NUnrLnPtHbcUl+mbokhox+/lsk2f8ZzDwdOkNJgS54RUs1NieGpKt
/Pv+e5KbxGge3TJ+mi5h7p+egpGZwVmgkUFkHw1vn2ShaKR0VHcyHl8Qsqy4f5r2
K0uKyO4WVl8IsSLnEoqvpkOrwkI9Z5H5L4b0KflISUQMovCPzoMjNQlmNuVQPQN9
+947YezlyK+Km9JOph+mUt94FBNHvpunEGUnRlqn8ljcMLpHE7gwiy2kWgeYeLRL
J/f9TPeVLcIm8cS+kZow
=oxcx
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
