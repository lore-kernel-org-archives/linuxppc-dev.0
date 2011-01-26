Return-Path: <lasaine@lvk.cs.msu.su>
Received: from mail.lvk.cs.msu.su (gate.lvk.cs.msu.su [158.250.17.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lvk.cs.msu.su", Issuer "CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 97C0DB7140
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 03:27:55 +1100 (EST)
Date: Wed, 26 Jan 2011 19:27:43 +0300
From: Alexander Gordeev <lasaine@lvk.cs.msu.su>
To: tmarri@apm.com
Subject: Re: [PATCH V8 04/10] USB/ppc4xx: Add Synopsys DWC OTG HCD function
Message-ID: <20110126192743.646af6d2@desktopvm.lvknet>
In-Reply-To: <1295477855-14775-1-git-send-email-tmarri@apm.com>
References: <1295477855-14775-1-git-send-email-tmarri@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
	boundary="Sig_/T41vj+NdElP7gdgwpufoDGq";
	protocol="application/pgp-signature"
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>, Mark Miesfeld <mmiesfeld@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/T41vj+NdElP7gdgwpufoDGq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

Please consider squashing this little patch into yours. The driver
currently prints 0x00000000 as the register base. This patch will fix
that.

commit 2f850fe637101be287f116a37282b6b1a09e6a98
Author: Alexander Gordeev <lasaine@lvk.cs.msu.su>
Date:   Mon Nov 29 15:15:25 2010 +0300

    dwc_otg: set usb hcd resource address and length
   =20
    Signed-off-by: Alexander Gordeev <lasaine@lvk.cs.msu.su>

diff --git a/drivers/usb/dwc_otg/dwc_otg_hcd.c b/drivers/usb/dwc_otg/dwc_ot=
g_hcd.c
index 240ab0b..e420a8d 100644
--- a/drivers/usb/dwc_otg/dwc_otg_hcd.c
+++ b/drivers/usb/dwc_otg/dwc_otg_hcd.c
@@ -1269,6 +1269,8 @@ int __devinit dwc_otg_hcd_init(struct device *_dev,
 	}
 	dev_set_drvdata(_dev, dwc_otg_device);
 	hcd->regs =3D otg_dev->base;
+	hcd->rsrc_start =3D otg_dev->phys_addr;
+	hcd->rsrc_len =3D otg_dev->base_len;
 	hcd->self.otg_port =3D 1;
=20
 	/* Initialize the DWC OTG HCD. */

--=20
  Alexander

--Sig_/T41vj+NdElP7gdgwpufoDGq
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJNQEt/AAoJEElrwznyooJb5RkH/jfwHrbyKCYrcvY2DPA17Imm
zhS3l/5V/819C7vffCmGmezq7tD1MMSvPNM8OUPFarTns9wktrZD4tvZt538zT/D
KoSldwWXZO85sVg5H3cfFslUt9qsTkVHuPOatqqpFJKlLtJXs0pseVZh00Xn4Bvi
KbHIa3Rgv6z2+8bj4w2Q4DRxIghNdgM7wMANh9IfgbDBfjBhIcMSpn3pXIoQsHQf
uMrCrlm6MH+xAg4a1FDB0aqhGl0KglyWYIhGqx70hlfROEWj/XiT5tzgHBqSNCEc
R8irdhOCNHUj1QQXkHo14ubdcKLdUQ3bFhmg/xUXzol2uHqkY5LV4yrKEEgSlKI=
=/gop
-----END PGP SIGNATURE-----

--Sig_/T41vj+NdElP7gdgwpufoDGq--
