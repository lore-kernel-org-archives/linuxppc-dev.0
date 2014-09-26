Return-Path: <thierry.reding@gmail.com>
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com
 [IPv6:2a00:1450:400c:c00::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38B0E1A0003
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 18:09:27 +1000 (EST)
Received: by mail-wg0-f48.google.com with SMTP id x13so5970547wgg.31
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 01:09:24 -0700 (PDT)
Date: Fri, 26 Sep 2014 10:09:22 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 03/22] MSI: Remove the redundant irq_set_chip_data()
Message-ID: <20140926080921.GE31106@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-4-git-send-email-wangyijing@huawei.com>
 <20140925071919.GH12423@ulmo> <5424C9BD.3040506@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
In-Reply-To: <5424C9BD.3040506@huawei.com>
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


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2014 at 10:04:45AM +0800, Yijing Wang wrote:
> On 2014/9/25 15:19, Thierry Reding wrote:
> > On Thu, Sep 25, 2014 at 11:14:13AM +0800, Yijing Wang wrote:
> >> Currently, pcie-designware, pcie-rcar, pci-tegra drivers
> >> use irq chip_data to save the msi_chip pointer. They
> >> already call irq_set_chip_data() in their own MSI irq map
> >> functions. So irq_set_chip_data() in arch_setup_msi_irq()
> >> is useless.
> >=20
> > Again, I think this should be the other way around. If drivers do
> > something that's already handled by the core, then the duplicate code
> > should be dropped from the drivers.
>=20
> Hi Thierry, this is different thing, because chip_data is specific to IRQ
> controller, and in other platform, like in x86, chip_data is used to save=
 irq_cfg.
> So we can not call irq_set_chip_data() in core code.
>=20
> x86 irq piece code
>=20
> int arch_setup_hwirq(unsigned int irq, int node)
> {
> 	struct irq_cfg *cfg;
> 	unsigned long flags;
> 	int ret;
>=20
> 	cfg =3D alloc_irq_cfg(irq, node);
> 	if (!cfg)
> 		return -ENOMEM;
>=20
> 	raw_spin_lock_irqsave(&vector_lock, flags);
> 	ret =3D __assign_irq_vector(irq, cfg, apic->target_cpus());
> 	raw_spin_unlock_irqrestore(&vector_lock, flags);
>=20
> 	if (!ret)
> 		irq_set_chip_data(irq, cfg);  ------------->Save irq_cfg
> 	else
> 		free_irq_cfg(irq, cfg);
> 	return ret;
> }

Okay, makes sense to keep irq_set_chip_data() for driver-specific data
then.

Thierry

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUJR8xAAoJEN0jrNd/PrOhmZMP/0tFUjT9MXPrTuCEiBWtia+2
ElYucD565UV4FjK6aINM4dHtmn0wUW+dDXB2YDSkAp10Ku534Tfi0zNfQd/xSe6M
SLBNIW/EK67YANcL5AvN2W1wSUn/t24SBwWJIvsoZfNJbsAcETvYySMnmLZJ2L05
k1v9mR+KAR52QhCs9nwga/dePFV/DBQ2bFrblq6Rxu/+hxki9EqgM9JtkRXS0F7d
DU1BqMERPy9AtP+oX5Wih6+8P15JALo4n/SETOfeeToDkhN2Zbh8Y3AoAmVAL1l1
ym3t6fPW7CFvJIX+Qpt02+wVvFu1amMpY8mXfzQmi18VccvTqQ9ylkaaVQ+ZsK/a
M/8qEyiKUc4T8obwUr8qb484vw7QxAlFynvU5A6AX1zlHU+yUVEklTBlVY9Av5jj
EW6MzXAPrhro6KKqu3m8h+P0O72K+oSZOT5bPri9/MfRfW3JCzMsCNIjeGXZ50fr
Komek7HKSPDIaIoavV7Fym7j9zddKbLvAj8DfkztLT7jmQ7i8EVb6eHwy8uMDXI7
cds9cH4RKRvE3ArNaHaOyEomxAD1fyAsQ3SPM2vuf92pJtiwoXpGc5qgrRusMjHw
ZfggWh7lVNYq9TP1fXQalqNmFvATMz3s1HW7lCsIf8AeuNvDkAm3pQRojX1vKPvc
uRsheVegzi0JliNoFkzC
=m1fq
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
