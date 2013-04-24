Return-Path: <tony@bakeyournoodle.com>
Date: Thu, 25 Apr 2013 09:48:38 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: lucaskt@linux.vnet.ibm.com
Subject: Re: [PATCHv4 1/2] ppc64: perform proper max_bus_speed detection
Message-ID: <20130424234838.GA1971@thor.bakeyournoodle.com>
References: <1366844090-5492-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1366844090-5492-2-git-send-email-lucaskt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
In-Reply-To: <1366844090-5492-2-git-send-email-lucaskt@linux.vnet.ibm.com>
Cc: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2013 at 07:54:49PM -0300, lucaskt@linux.vnet.ibm.com wrote:
> From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
>=20
> On pseries machines the detection for max_bus_speed should be done
> through an OpenFirmware property. This patch adds a function to perform
> this detection and a hook to perform dynamic adding of the function only =
for
> pseries. This is done by overwriting the weak
> pcibios_root_bridge_prepare function which is called by pci_create_root_b=
us().
>=20
> Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/machdep.h       |  2 ++
>  arch/powerpc/kernel/pci-common.c         |  8 +++++
>  arch/powerpc/platforms/pseries/pci.c     | 51 ++++++++++++++++++++++++++=
++++++
>  arch/powerpc/platforms/pseries/pseries.h |  4 +++
>  arch/powerpc/platforms/pseries/setup.c   |  2 ++
>  5 files changed, 67 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/as=
m/machdep.h
> index 3d6b410..8f558bf 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -107,6 +107,8 @@ struct machdep_calls {
>  	void		(*pcibios_fixup)(void);
>  	int		(*pci_probe_mode)(struct pci_bus *);
>  	void		(*pci_irq_fixup)(struct pci_dev *dev);
> +	int		(*pcibios_root_bridge_prepare)(struct pci_host_bridge
> +				*bridge);
> =20
>  	/* To setup PHBs when using automatic OF platform driver for PCI */
>  	int		(*pci_setup_phb)(struct pci_controller *host);
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-c=
ommon.c
> index fa12ae4..80986cf 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -844,6 +844,14 @@ int pci_proc_domain(struct pci_bus *bus)
>  	return 1;
>  }
> =20
> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	if (ppc_md.pcibios_root_bridge_prepare)
> +		return ppc_md.pcibios_root_bridge_prepare(bridge);
> +
> +	return 0;
> +}
> +
>  /* This header fixup will do the resource fixup for all devices as they =
are
>   * probed, but not for bridge ranges
>   */
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platform=
s/pseries/pci.c
> index 0b580f4..7f9c956 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -108,3 +108,54 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82=
C105,
>  			 fixup_winbond_82c105);
> +
> +int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	struct device_node *dn, *pdn;
> +	struct pci_bus *bus;
> +	const uint32_t *pcie_link_speed_stats;
> +
> +	bus =3D bridge->bus;
> +
> +	dn =3D pcibios_get_phb_of_node(bus);
> +	if (!dn)
> +		return 0;
> +
> +	for (pdn =3D dn; pdn !=3D NULL; pdn =3D pdn->parent) {
> +		pcie_link_speed_stats =3D (const uint32_t *) of_get_property(dn,
> +			"ibm,pcie-link-speed-stats", NULL);
> +		if (pcie_link_speed_stats)
> +			break;
> +	}

Please use the helpers in include/linux/of.h rather than open coding
this.

Yours Tony

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBCAAGBQJReG9WAAoJEEsCiJRY75GKutgQALTbZM0NmKDyU4mnJk8puy7W
vQ9ThCfhHr7RxEKEzSxKDW1JtzVyDNOrRFyKT9sfzcnuM4v5zRrfxZPws2JRm6Ub
Xgt7bpSxjPAXOUX8tkj47Me/QcmugUBVNumiIEWI9zKyo9/18KUaRdXxpdTo5k+S
B5LyQytSQQzbaguXW14inOa05cRHBOpgD+KhNcjQB2h6xGQf6HtLMrizOFYSQ2wH
CMEj/qzZCZAEWSnIayXv/coQb7N1IsMa2meDDk8t5BVLX9HkJaFEEhB+1f5xQTb9
e9e96cvPapVI52H2xuY6322d1ZhWyvAdA9ww/jjXcmktfWKnXz5LKxOiyCoFN5KM
bwvt2kNN6VBgIIoTiCgG0/pZul4LSsWR+ZRPdo6p21tamusGTW72DprLuFZd+HCk
VkgRfDN3ZPCXgiVnrmigyGhAazx0Y8mjxsyK+r5XC73rScrCHqrA77+nazqt/7yw
/KdZWUIOckE2iBl+KcSxvvIwFdUXIYeu6BlLfsFq2MxbszJ3fDeFOL8OohgLH70k
c07SyJ/w5lVQmowUUGPDeToP49KPvixzxGKO6bDm5g99Oh5AvAhYM4RPM/BlWKax
BfaW1b3uuJsaWqCQ4/tTIJy9Ei/Wfm852y1Zc/nEyR010uuO8WkDX/7xWSr5m1i/
+O5IWd9noA7h301EHm+z
=Dpcw
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
