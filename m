Return-Path: <thierry.reding@avionic-design.de>
Date: Thu, 13 Dec 2012 10:13:33 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Andrew Murray <Andrew.Murray@arm.com>
Subject: Re: [PATCH] pci: Provide support for parsing PCI DT ranges property
Message-ID: <20121213091333.GA14828@avionic-0098.adnet.avionic-design.de>
References: <20121212163749.GA17371@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <20121212163749.GA17371@arm.com>
Cc: Michal Simek <monstr@monstr.eu>, linux-pci@vger.kernel.org,
 devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Rob Herring <rob.herring@calxeda.com>,
 Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2012 at 04:37:50PM +0000, Andrew Murray wrote:
> DT bindings for PCI host bridges often use the ranges property to describe
> memory and IO ranges - this binding tends to be the same across architect=
ures
> yet several parsing implementations exist, e.g. arch/mips/pci/pci.c,
> arch/powerpc/kernel/pci-common.c, arch/sparc/kernel/pci.c and
> arch/microblaze/pci/pci-common.c (clone of PPC). Some of these duplicate
> functionality provided by drivers/of/address.c.
>=20
> This patch provides a common iterator-based parser for the ranges propert=
y, it
> is hoped this will reduce DT representation differences between architect=
ures
> and that architectures will migrate in part to this new parser.
>=20
> It is also hoped (and the motativation for the patch) that this patch will
> reduce duplication of code when writing host bridge drivers that are supp=
orted
> by multiple architectures.
>=20
> This patch provides struct resources from a device tree node, e.g.:
>=20
> 	u32 *last =3D NULL;
> 	struct resource res;
> 	while ((last =3D of_pci_process_ranges(np, res, last))) {
> 		//do something with res
> 	}
>=20
> Platforms with quirks can then do what they like with the resource or mig=
rate
> common quirk handling to the parser. In an ideal world drivers can just r=
equest
> the obtained resources and pass them on (e.g. pci_add_resource_offset).
>=20
> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> ---
>  drivers/of/address.c       |   53 ++++++++++++++++++++++++++++++++++++++=
+++++-
>  include/linux/of_address.h |    7 +++++
>  2 files changed, 59 insertions(+), 1 deletions(-)

Hi Andrew,

I don't like iterator interfaces too much, but I can live with that.
Other than that the patch looks good to me and I'll try to work it into
my Tegra PCIe patch series.

Just two minor comments below.

> diff --git a/drivers/of/address.c b/drivers/of/address.c
[...]
> @@ -421,7 +472,7 @@ u64 __of_translate_address(struct device_node *dev, c=
onst __be32 *in_addr,
>  		goto bail;
>  	bus =3D of_match_bus(parent);
> =20
> -	/* Cound address cells & copy address locally */
> +	/* Count address cells & copy address locally */
>  	bus->count_cells(dev, &na, &ns);
>  	if (!OF_CHECK_COUNTS(na, ns)) {
>  		printk(KERN_ERR "prom_parse: Bad cell count for %s\n",

This is really minor, but it should still go into a separate patch.

> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> index 01b925a..4582b20 100644
> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -26,6 +26,8 @@ static inline unsigned long pci_address_to_pio(phys_add=
r_t addr) { return -1; }
>  #define pci_address_to_pio pci_address_to_pio
>  #endif
> =20
> +const __be32 *of_pci_process_ranges(struct device_node *node,
> +				    struct resource *res, const __be32 *from);
>  #else /* CONFIG_OF_ADDRESS */
>  static inline int of_address_to_resource(struct device_node *dev, int in=
dex,
>  					 struct resource *r)
> @@ -48,6 +50,11 @@ static inline const u32 *of_get_address(struct device_=
node *dev, int index,
>  {
>  	return NULL;
>  }
> +const __be32 *of_pci_process_ranges(struct device_node *node,

There should be a blank line to separate the above two lines.

Thierry

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQyZw9AAoJEN0jrNd/PrOh27oQAJK1LVSVPt2bdH+fhBhgNB76
gYZmzRFSFbl2BnyahjOCX2QODhZTuNbhKwoEIFFWN8cyBKg+gdNiTRsSTmlbhpFn
ifkaZ9dt5oP2bmOvTB+m4NI7LxSAkf8HtAJm8ZSULaLJR49U9QoJvY3fp+fF2oXt
CfGkqMgiWh42gi/H3CXnomZUGtgSLsWxPXsWj1rEs73HdnEyUdZNx7Q83qOigBay
5y4lWsaApyHdYOOPq4eDhWDFQJ8UikwYSJi/gq/fPow7g+obXxRmarkYD4I6gFMS
4uXtRWzrlQjm0fFmviYG8ad2ultAts29SXFsImCGwdglbozV22z8OuxPxkHdlFNT
/iX8dtlWlFToI1TCacS0N1cSDZ9zBEh6nNjJot2w4o7/Q47O0kkYnyf0EhxfwTTV
EtObKtwbZPrddN1xcWEa02DdJPjTw6i4KwQyv2K0Bi9Z21nPkcEecTXrxNymqjdp
3Gx+Qt25xJIDDnSS/qTafbg72uckTpFVAukOrQ1wTO2qohZNvgnDSv5NAiQh7Lvx
NtxHDMtirkjPnN30YUD5ZYHKXukcPw8SLcuQg/pezCNcjn/xByk04bKyjlj3hfI6
TOKQArS9/BJ+UMMXRY7HvwLIjl6oZSVi+XDkhoZG4y3CN5klkK9lpcl2Kcq33bwG
CpniZNOorw/oX5+taazQ
=W+t0
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
