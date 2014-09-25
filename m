Return-Path: <thierry.reding@gmail.com>
Received: from mail-wg0-x22d.google.com (mail-wg0-x22d.google.com
 [IPv6:2a00:1450:400c:c00::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0462F1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 17:06:07 +1000 (EST)
Received: by mail-wg0-f45.google.com with SMTP id x13so6787338wgg.28
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 00:06:03 -0700 (PDT)
Date: Thu, 25 Sep 2014 09:06:01 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 02/22] PCI/MSI: Remove useless bus->msi assignment
Message-ID: <20140925070601.GF12423@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-3-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
In-Reply-To: <1411614872-4009-3-git-send-email-wangyijing@huawei.com>
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


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2014 at 11:14:12AM +0800, Yijing Wang wrote:
> Currently, PCI drivers will initialize bus->msi in
> pcibios_add_bus(). pcibios_add_bus() will be called
> in every pci bus initialization. So the bus->msi
> assignment in pci_alloc_child_bus() is useless.

I think this should be the other way around. The default should be to
inherit bus->msi from the parent. That way drivers don't typically have
to do it, yet they can still opt to override it if they need to.

For Tegra for example I think it would work if we assigned the MSI chip
to the root bus (in tegra_pcie_scan_bus()) and then have it propagated
to child busses in pci_alloc_child_bus() so that tegra_pcie_add_bus()
can be removed altogether.

Thierry

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUI77YAAoJEN0jrNd/PrOhZ/IQAMCSt26z+T6Q8TozfHBY40d1
VjyfIqF++JMHsJp9JBnJk7W/SdKcW+ClXvgZjtR4hqvTRlYUBPk6Sn3JWpi3RslY
GHt/y1pNGzk05qLADjlA8CAGVjq0Vspw5WO5SLjzu10gfvcddAX7YKRcWz5vW9uv
TcG+NFcDyGRaNg+ATkJ8Ep4rVN3eIkh9te9CE/pG5zQAV+NEZkaN4v9hRFubWIPy
HUXyDu+8aTJ3YUyhrXkbGR23i0lLzcWsqhrcjbbbQj0swxngijMgBbzJU2jJ0rxx
5CjTbs0mgvqKfsX1WQ3Df61rSN/krlMiZeD66YuMTuWdlzZkGJqpHCDkKdx2rITZ
o2IXg6faK1OARr8JfubrXil2utfpJkvBJR2fWmH0j37ZkEb249skTCAnb2yroyhJ
Mz3BmS+nAgPJkQUTTVZigeR+90KASb/WQrFPZhvOPK/ioMy0UyGy6uvNYm4rLXK+
gWN2TjIaniEFM60xJLFPgsVuf9XXKUZ0REybeTiDM65mofLUSkxtMbK/mrcBdHgF
kdO+JJ93hN6vnnqpqA/QjKNJebZm0PUjSTZvXIlzBs/v+gOh4bWewATJLbcgll/g
w85vBMPaceGBcjBIBul927T7Uf+2pLOmJHmM+eCzXSdxAyQ8qx75Su9uWOY3sX3Q
JDxVrWb34Dj7sIqL36a3
=f2MC
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
