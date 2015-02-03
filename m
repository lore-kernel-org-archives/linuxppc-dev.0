Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45C8F1A0BD4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 13:34:18 +1100 (AEDT)
Date: Tue, 3 Feb 2015 13:34:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 05/15] fbdev: imsttfb: remove the dependency on PPC_OF
Message-ID: <20150203133413.5cd9209c@canb.auug.org.au>
In-Reply-To: <20150201055150.GA6681@pek-khao-d1.corp.ad.wrs.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-6-git-send-email-haokexin@gmail.com>
 <20150201134433.729a2389@canb.auug.org.au>
 <20150201055150.GA6681@pek-khao-d1.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=oEKzMi7Hk+njHrUjh6cSpm"; protocol="application/pgp-signature"
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

--Sig_/=oEKzMi7Hk+njHrUjh6cSpm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Sun, 1 Feb 2015 13:51:50 +0800 Kevin Hao <haokexin@gmail.com> wrote:
>
> That was my first thought, but the codes protected by the PPC_OF seem not
> ppc specific and should be safe for other archs which also support OF. So=
 I
> drop the PPC_OF completely. Did I miss something?

Ah, ok.

> > >  	dp =3D pci_device_to_OF_node(pdev);
> > > @@ -1478,7 +1477,6 @@ static int imsttfb_probe(struct pci_dev *pdev, =
const struct pci_device_id *ent)
> > >  		printk(KERN_INFO "%s: OF name %s\n",__func__, dp->name);
> > >  	else
> > >  		printk(KERN_ERR "imsttfb: no OF node for pci device\n");
> > > -#endif /* CONFIG_PPC_OF */
> >=20
> > This will emit the above error if CONFIG_OF is not set whereas in the
> > past it would not.
>=20
> How about change it to:
> 	if (IS_ENABLED(CONFIG_OF))
>   		printk(KERN_ERR "imsttfb: no OF node for pci device\n");

Looks good.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/=oEKzMi7Hk+njHrUjh6cSpm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU0DOpAAoJEMDTa8Ir7ZwVeYAP/3bCPQTuqdnlR31YED5Gir9v
NLFLpy7qavxbxZSC1GJUN4azgejMUvlu5JV0j2eiTjWRkTbzI3NpFDawxyLMoGXK
qMgFTwXcbjW3ifcgeRv5kxHdMqznuVN0x1zD9kZ7izPj+LSmJurhgSBpIWmDTUjY
hMz7vqPY3+Tg9o/wQRCmHXvDM1MtrCNxb6+ht/VxPpQ2K0gnx+Nu2jVDxhw+xsLI
kOpztkrT6wrwEbJ+DLkXPJQr8+fyWrcwI3Jmrg4hxqnbv+TtvJD4glw9o5yRmhd7
XVdCnSNpe8QBCphHqHnk1Y+qsj64ryFxEva5DZNS/s+PzxUn0t9qHLPkiRckQPnU
SMY4SmVLwaAC55uoAMWe5dUmZuu/xwp24ZsSLYlnBbl77R9ETWdWplg5gvuiXUAM
cit9t4hm8ZnbgvBP/0YZda6LOVJIy55M8TLDRWF1Jzx5sFGIgMqsB5ItpFUtYwdN
qHE0tHrGXLzhsyaLEVV9WBI6oGj9vdKy8Z3YSfR5An1L7am8Eu0ngjPgY8QExJ+K
PxX+yfJy+p+A1U3pCFNRzkyZu4P3OxmqCX6YIRuDrr/SC0mctCMUQO84xMMmsMsd
6M2XMiQWk9QkvPoUt6Bm08i+qvmT0ulbay3TIemaVjHzCh004jLm6kQCKxbgcXSV
O1Ppz3123Jpn+OpMg5cC
=g3tv
-----END PGP SIGNATURE-----

--Sig_/=oEKzMi7Hk+njHrUjh6cSpm--
