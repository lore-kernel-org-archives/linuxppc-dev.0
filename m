Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.tip.net.au [IPv6:2402:b800:7003:1::44])
	by ozlabs.org (Postfix) with ESMTP id 833B8B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Aug 2011 17:37:07 +1000 (EST)
Date: Fri, 5 Aug 2011 17:37:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc: Fix build without CONFIG_PCI
Message-Id: <20110805173700.19310798b5a30bfb666d7031@canb.auug.org.au>
In-Reply-To: <1312524247.8598.25.camel@pasglop>
References: <1312524247.8598.25.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__5_Aug_2011_17_37_00_+1000_wY2NK2K.QIPWNPp5"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__5_Aug_2011_17_37_00_+1000_wY2NK2K.QIPWNPp5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Fri, 05 Aug 2011 16:04:07 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> Commit fea80311a939a746533a6d7e7c3183729d6a3faf
> "iomap: make IOPORT/PCI mapping functions conditional"
>=20
> Broke powerpc build without CONFIG_PCI as we would still define
> pci_iomap(), which overlaps with the new empty inline in the headers.

If we are using a static inline implementation for !CONFIG_PCI, then we
should probably not EXPORT it in that case either ...

> @@ -143,6 +144,7 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *a=
ddr)
>  		return;
>  	iounmap(addr);
>  }
> +#endif /* CONFIG_PCI */
> =20
>  EXPORT_SYMBOL(pci_iomap);
>  EXPORT_SYMBOL(pci_iounmap);


--=20
Stephen Rothwell <sfr@canb.auug.org.au>

--Signature=_Fri__5_Aug_2011_17_37_00_+1000_wY2NK2K.QIPWNPp5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOO52cAAoJEDMEi1NhKgbsnaUIAKL1FuGsLODiXfLdbNYw8pTQ
BKMnXwl3cCHM0KgvbqHsTq6O55qAZJqaRnbJHlsdjYrPE0sdTIa98wXyE9kz0ghb
FuouXwv0147ZWuaJmUaQzDmjXdv8cC+0Jg8sLm/3shNjjt7FwR698qZI/1BepPaJ
2t6rJAng5lI66IgF8P9fxT17+ItDIxcX5kuWWPT6RFXhY+IfmvZ/HLwl39bSeGRs
aUGWXMJEw8lm+iliEf59LkRDTwUy6jdzKQ84mS3uVf9c/bQJcfv47lWHcwxBzA5C
aNLl1IIXilZqPSJIyXIRP0fXW2UOPTMozOjiBQkogr2xX9KLScsX3QrxJ1Dgiyo=
=laoI
-----END PGP SIGNATURE-----

--Signature=_Fri__5_Aug_2011_17_37_00_+1000_wY2NK2K.QIPWNPp5--
