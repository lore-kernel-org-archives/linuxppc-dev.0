Return-Path: <thierry.reding@gmail.com>
Received: from mail-we0-x232.google.com (mail-we0-x232.google.com
 [IPv6:2a00:1450:400c:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED8AF1A0ADC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 18:09:54 +1000 (EST)
Received: by mail-we0-f178.google.com with SMTP id t60so9106708wes.23
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 01:09:51 -0700 (PDT)
Date: Fri, 26 Sep 2014 10:09:49 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 03/22] MSI: Remove the redundant irq_set_chip_data()
Message-ID: <20140926080949.GF31106@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-4-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5CUMAwwhRxlRszMD"
In-Reply-To: <1411614872-4009-4-git-send-email-wangyijing@huawei.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, xen-devel@lists.xenproject.org,
 arnab.basu@freescale.com, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Xinwei Hu <huxinwei@huawei.com>, Tony Luck <tony.luck@intel.com>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 iommu@lists.linux-foundation.org, David Vrabel <david.vrabel@citrix.com>,
 Wuyun <wuyun.wu@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, Lucas Stach <l.stach@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 11:14:13AM +0800, Yijing Wang wrote:
> Currently, pcie-designware, pcie-rcar, pci-tegra drivers
> use irq chip_data to save the msi_chip pointer. They
> already call irq_set_chip_data() in their own MSI irq map
> functions. So irq_set_chip_data() in arch_setup_msi_irq()
> is useless.
>=20
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/msi.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

>=20
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 51d7e62..50f67a3 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -41,14 +41,13 @@ int __weak arch_setup_msi_irq(struct pci_dev *dev, st=
ruct msi_desc *desc)
>  	if (err < 0)
>  		return err;
> =20
> -	irq_set_chip_data(desc->irq, chip);
> -
>  	return 0;
>  }
> =20
>  void __weak arch_teardown_msi_irq(unsigned int irq)
>  {
> -	struct msi_chip *chip =3D irq_get_chip_data(irq);
> +	struct msi_desc *entry =3D irq_get_msi_desc(irq);
> +	struct msi_chip *chip =3D entry->dev->bus->msi;
> =20
>  	if (!chip || !chip->teardown_irq)
>  		return;
> --=20
> 1.7.1
>=20

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUJR9NAAoJEN0jrNd/PrOh5cAP/2aYAkwGt796/z3rQsXfEXhG
hPI6dXwueP4Re7P03WrSfn6JEowEsDYFLqLJJYQLwlDQa96WTd85jidBUhQRniqy
GPHoUY+c4qiQjJak+b2y4jMMNqJnWoLw57Wd1Nmy2g2pocWKwiKA1VEem2ZZPaxR
QxhYqhwK8IxOu092oPpVV8m2GtFSUzbuOoE0a3muYP+gExweDN6v485fm+PKfIVU
rmCMnmkkT9oUVNYUlQDSf0xXb+t0PNJDbGZHPM3rKQFQA45Xhadzs2D/nk1CSwoj
7EO8sq/qkfHnyXvxpvazxq2V1xsGkG63RTRmhIzP2VGDj/AI6G9AlM5dFOzPctSf
8v8FNLESIHmHKyp9IKT1pCWg6jbRHFlhL9be5+uudiDYgvXiGjtco4Jta1hlgHNk
Qd7zRsH6Y+ocewQ2sqDMrwkOEzetOfnGmjjtb3q6VaeahtwPdRKWhQcjfO//zIW3
83yoON4lx7AS1aDMRywNXbk8A6ja8ndVS2amfm6TJCbIVy6A78AnCRx4n/ShluFl
WD1TekKOyh2u2JtRagRSb0xxFwwsqzlYrOElj00zxCZJAKihIzjMf4ogfxnj2OOn
ZEF1WTMpjTpy+QB7r22R0qFX9yVBBCgRM8heGbQXeVMPD/AvmVhx803Ry2r6SmcU
iefPiqiqqocKKcpN4rMB
=jw7p
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--
