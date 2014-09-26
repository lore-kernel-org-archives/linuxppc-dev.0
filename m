Return-Path: <thierry.reding@gmail.com>
Received: from mail-wg0-x234.google.com (mail-wg0-x234.google.com
 [IPv6:2a00:1450:400c:c00::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D45DB1A00FA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 19:05:44 +1000 (EST)
Received: by mail-wg0-f52.google.com with SMTP id n12so7503133wgh.23
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 02:05:40 -0700 (PDT)
Date: Fri, 26 Sep 2014 11:05:38 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
Message-ID: <20140926090537.GH31106@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <20140925074235.GN12423@ulmo>
 <20140925144855.GB31157@bart.dudau.co.uk>
 <20140925164937.GB30382@ulmo>
 <20140925171612.GC31157@bart.dudau.co.uk>
 <542505B3.7040208@huawei.com> <20140926085430.GG31106@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mhOzvPhkurUs4vA9"
In-Reply-To: <20140926085430.GG31106@ulmo>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>, Bharat.Bhushan@freescale.com,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Chris Metcalf <cmetcalf@tilera.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Liviu Dudau <liviu@dudau.co.uk>, Tony Luck <tony.luck@intel.com>,
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


--mhOzvPhkurUs4vA9
Content-Type: multipart/mixed; boundary="7J16OGEJ/mt06A90"
Content-Disposition: inline


--7J16OGEJ/mt06A90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 26, 2014 at 10:54:32AM +0200, Thierry Reding wrote:
[...]
> At least for Tegra it's trivial to just hook it up in tegra_pcie_scan_bus()
> directly (patch attached).

Really attached this time.

Thierry

--7J16OGEJ/mt06A90
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0001-PCI-tegra-Remove-.add_bus-callback.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 2cedfcf38cdfe21688d1363659f28e271ce43358 Mon Sep 17 00:00:00 2001
=46rom: Thierry Reding <treding@nvidia.com>
Date: Fri, 26 Sep 2014 10:35:47 +0200
Subject: [PATCH] PCI: tegra: Remove .add_bus() callback

The .add_bus() callback is called for every bus and used to associate an
MSI chip with each bus. However the PCI core code already propagates the
root bus' MSI chip to child busses, so it is enough to associate the MSI
chip with the root bus upon creation. Conveniently the Tegra PCIe host
bridge driver creates the root bus directly, so the association can be
done at the same time.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/host/pci-tegra.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 3d43874319be..d314e549ac0c 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -694,15 +694,6 @@ static int tegra_pcie_map_irq(const struct pci_dev *pd=
ev, u8 slot, u8 pin)
 	return irq;
 }
=20
-static void tegra_pcie_add_bus(struct pci_bus *bus)
-{
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		struct tegra_pcie *pcie =3D sys_to_pcie(bus->sysdata);
-
-		bus->msi =3D &pcie->msi.chip;
-	}
-}
-
 static struct pci_bus *tegra_pcie_scan_bus(int nr, struct pci_sys_data *sy=
s)
 {
 	struct tegra_pcie *pcie =3D sys_to_pcie(sys);
@@ -713,6 +704,9 @@ static struct pci_bus *tegra_pcie_scan_bus(int nr, stru=
ct pci_sys_data *sys)
 	if (!bus)
 		return NULL;
=20
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		bus->msi =3D &pcie->msi.chip;
+
 	pci_scan_child_bus(bus);
=20
 	return bus;
@@ -1885,7 +1879,6 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
 	hw.private_data =3D (void **)&pcie;
 	hw.setup =3D tegra_pcie_setup;
 	hw.map_irq =3D tegra_pcie_map_irq;
-	hw.add_bus =3D tegra_pcie_add_bus;
 	hw.scan =3D tegra_pcie_scan_bus;
 	hw.ops =3D &tegra_pcie_ops;
=20
--=20
2.1.0


--7J16OGEJ/mt06A90--

--mhOzvPhkurUs4vA9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUJSxhAAoJEN0jrNd/PrOhoLsQAMJ5GxCoND9IRjKBHBmrC/51
EfiGjh/v0yQqfkGFBzV41mV+tCThGSuHsefr0h7ItMMzGSclLZNdT2VKt/KaFqem
Q6V+CwdSlDiMMLcpCjAGvp4hdDi+0XDCy7Y8jkC2W03El4vSRXMuLEqqwrFdK0gB
05H6NYD2ozSZkLSz6kKZzDriAmV7soM2oCUtQ+lBTeYuz7dHFV0KFUtmka5mK5Hw
WRmES6tba2YsjZcBnVOuEkrGOcXmV7rSG/Q4VI45Dcq0xyQIIoMbk5StAhi3htzg
zmNTj58VhrHnqJeicxjD9PAwm2Pil1eAb97Rp/jTkGc7h8gdjHPjRiN4D2Hzv+3u
POIs9Wnw/B7Nu+cbah6VrwbhkZJ6ONOdO969FwEKVqUAgrYQNOlpb764IfsNqWSd
4SrBJxcX6Rf49cDgpeVdMu2M+y3JrSx8B34Y2Jvrjqfu7+Fqg1oUmaiIraZTw7Mx
2L+r9XOSjoImov5pWFOQK6TQLFAQxg/Jzc3VbQW/Asthgh9J1IdnaawQ1tUmd7X3
2SkPbFifpMXG/q4Kzo7ziNHEChdugUtgjqSedknGrxRhTgYMcoFuvmqg11yv5giF
cQ4aiPTi7iwKtIUJ6der5Ypyym8WH6g9McEkXHr8MHTPwy5VwjoOIa5f9h8c0DF3
JVw7pOJIyEgFtmcvn4p1
=YM+j
-----END PGP SIGNATURE-----

--mhOzvPhkurUs4vA9--
