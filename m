Return-Path: <haokexin@gmail.com>
Received: from mail-qa0-x234.google.com (mail-qa0-x234.google.com
 [IPv6:2607:f8b0:400d:c00::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4051B1A0D94
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 16:52:01 +1100 (AEDT)
Received: by mail-qa0-f52.google.com with SMTP id x12so25307799qac.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 21:51:58 -0800 (PST)
Date: Sun, 1 Feb 2015 13:51:50 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 05/15] fbdev: imsttfb: remove the dependency on PPC_OF
Message-ID: <20150201055150.GA6681@pek-khao-d1.corp.ad.wrs.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-6-git-send-email-haokexin@gmail.com>
 <20150201134433.729a2389@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
In-Reply-To: <20150201134433.729a2389@canb.auug.org.au>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 01, 2015 at 01:44:33PM +1100, Stephen Rothwell wrote:
> Hi Kevin,
>=20
> On Sat, 31 Jan 2015 21:47:35 +0800 Kevin Hao <haokexin@gmail.com> wrote:
> >
> > The OF functionality has moved to a common place and be used by many
> > archs. So we don't need to depend on PPC_OF option any more. This is
> > a preparation for killing PPC_OF.
>=20
> I suspect that you want to do the PPC_OF -> PPC conversion on this file
> rather than just removing PPC_OF uses.

That was my first thought, but the codes protected by the PPC_OF seem not
ppc specific and should be safe for other archs which also support OF. So I
drop the PPC_OF completely. Did I miss something?

>=20
> > diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttf=
b.c
> > index aae10ce74f14..91a80bb8f988 100644
> > --- a/drivers/video/fbdev/imsttfb.c
> > +++ b/drivers/video/fbdev/imsttfb.c
> > @@ -1470,7 +1470,6 @@ static int imsttfb_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
> >  	unsigned long addr, size;
> >  	struct imstt_par *par;
> >  	struct fb_info *info;
> > -#ifdef CONFIG_PPC_OF
> >  	struct device_node *dp;
>=20
> I see no way in this file for struct device_node to be defined
> (especially if CONFIG_PPC is not set).  of.h may be included
> implicitly, but that is very dependent on the architecture and CONFIG_
> options.

This do pass the build test for the non-OF archs, such as x86. But your
concerns sound pretty reasonable, so I will explicitly include of.h.

>=20
> >  	dp =3D pci_device_to_OF_node(pdev);
> > @@ -1478,7 +1477,6 @@ static int imsttfb_probe(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
> >  		printk(KERN_INFO "%s: OF name %s\n",__func__, dp->name);
> >  	else
> >  		printk(KERN_ERR "imsttfb: no OF node for pci device\n");
> > -#endif /* CONFIG_PPC_OF */
>=20
> This will emit the above error if CONFIG_OF is not set whereas in the
> past it would not.

How about change it to:
	if (IS_ENABLED(CONFIG_OF))
  		printk(KERN_ERR "imsttfb: no OF node for pci device\n");

Thanks,
Kevin

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUzb72AAoJEJNY7TDerrFxHbMH/RRO1w9hO0T/7Y5rjZcfOUL4
AAOZWs25SVSskY6Jd0cxDBMmJ61uy34BGh7F3CPtZ3ptRzdbLFDNLUdtWnNX/lSR
SEFqKerunjZVw73kTvvH0+LBGCuw5Y/LJ5Nw0l3qpH7SZeKtYUl4AKee6Aaw8C67
A2/hcdNH8xCw5rkeKXZbNvvPyPGvvJCF4tM6l9zMONh7efK/cI0F1UdkKCCtIWwj
k90VWMLVWC3fYkKWpDxgotCf9lv5cce9N2dJn0CQTLwKL2JdOB9v0UpbIt++xIou
KEGObeWt2isk4V3QVIqntsmX+jwbEAZiqpTls3Gr7JZe83ckleNdgzmmJLxv0wM=
=0REw
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
