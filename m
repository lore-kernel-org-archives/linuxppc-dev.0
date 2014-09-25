Return-Path: <thierry.reding@gmail.com>
Received: from mail-we0-x22b.google.com (mail-we0-x22b.google.com
 [IPv6:2a00:1450:400c:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1A8C1A0076
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 02:49:44 +1000 (EST)
Received: by mail-we0-f171.google.com with SMTP id k48so8316809wev.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 09:49:40 -0700 (PDT)
Date: Thu, 25 Sep 2014 18:49:38 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [PATCH v2 00/22] Use MSI chip framework to configure MSI/MSI-X
 in all platforms
Message-ID: <20140925164937.GB30382@ulmo>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <20140925074235.GN12423@ulmo>
 <20140925144855.GB31157@bart.dudau.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
In-Reply-To: <20140925144855.GB31157@bart.dudau.co.uk>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, Bharat.Bhushan@freescale.com,
 sparclinux@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>,
 xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
 Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2014 at 03:48:55PM +0100, Liviu Dudau wrote:
> On Thu, Sep 25, 2014 at 09:42:36AM +0200, Thierry Reding wrote:
> > On Thu, Sep 25, 2014 at 11:14:10AM +0800, Yijing Wang wrote:
> > > This series is based Bjorn's pci/msi branch
> > > git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/msi
> > >=20
> > > Currently, there are a lot of weak arch functions in MSI code.
> > > Thierry Reding Introduced MSI chip framework to configure MSI/MSI-X i=
n arm.
> > > This series use MSI chip framework to refactor MSI code across all pl=
atforms
> > > to eliminate weak arch functions. Then all MSI irqs will be managed i=
n a=20
> > > unified framework. Because this series changed a lot of ARCH MSI code,
> > > so tests in the platforms which MSI code modified are warmly welcomed!
> >=20
> > Apart from the comments to the individual patches I very much like where
> > this is going. Thanks for taking care of this.
> >=20
> > Thierry
>=20
> I am actually in disagreement with you, Thierry. I don't like the general=
 direction
> of the patches, or at least I don't like the fact that we don't have a po=
rtable
> way of setting up the msi_chip without having to rely on weak architectur=
al hooks.

Oh, good. That's actually one of the things I said I wasn't happy with
either. =3D)

> I'm surprised no one considers the case of a platform having more than on=
e host
> bridge and possibly more than one MSI unit. With the current proposed pat=
chset I
> can't see how that would work.

The PCI core can already deal with that. An MSI chip can be set per bus
and the weak pcibios_add_bus() can be used to set that. Often it might
not even be necessary to do it via pcibios_add_bus() if you create the
root bus directly, since you can attach the MSI chip at that time.

> What I would like to see is a way of creating the pci_host_bridge structu=
re outside
> the pci_create_root_bus(). That would then allow us to pass this sort of =
platform
> details like associated msi_chip into the host bridge and the child busse=
s will
> have an easy way of finding the information needed by finding the root bu=
s and then
> the host bridge structure. Then the generic pci_scan_root_bus() can be us=
ed by (mostly)
> everyone and the drivers can remove their kludges that try to work around=
 the
> current limitations.

I think both issues are orthogonal. Last time I checked a lot of work
was still necessary to unify host bridges enough so that it could be
shared across architectures. But perhaps some of that work has
happened in the meantime.

But like I said, when you create the root bus, you can easily attach the
MSI chip to it.

Thierry

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUJEehAAoJEN0jrNd/PrOhAr0P/2iiNHf+l+IJjI4PmhgsJm9G
G4sbMUD6m+4pwYeaDcTdK94XdjseTOgRqew8atpBhNlsrJsLlrSBwC1YtQ++4SOx
7fY6wHZdYR89gJ0KSObsUNR/Nso7NZIkYBNLSBjWc6ADtryHb8GrwBz3GTZevt6R
upvjshtkfCM3VYamI9+PgAA/lJ6fIouUfhIL7tfZSoNrDeFwda6/n+ZHCfyFQNDb
l62EsyzpLQ8qNqxaxQOocboX1Sl114NkcRYiMSEspU/C7ioPnFtCr6w9962Lrxws
DDgrnQLEf/BV1wWj5y3eVw019uwpy8CTIgqGrqyt4ZZs0wFtzRuulXpoHTAicnhN
XwfjNup7GgpWrA3eceElnc21zgBO+VUXc0dKYKrJBpm5eEM9+hT5q8HMStx1GvsB
vOx24Bg7G6aMPT5zh4Ou34AQdxvRbY2Lnv+c7gMZHCNFeNO6sQd2y2FG3X95GkC+
sFhljOlxF8VZOXZtFzA0MKoPEZEK0m27nhbIDajZWC50Lopba0Sr3OLbN6L8OiTO
rpQvNiKi+SNTSIt932+/O+pgZFui93w5dWwSnxjW+ny4pvaAAjkNPfQrqedfOk3b
R4Nw0eX8LkJ2KQEeWCMX4A957F9FDCCEMe2IA8fBiM0Y6GOmkWLyVGYVi0AS6B8s
n/A0QFMmdPLn7uf5vrs2
=mBCk
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
