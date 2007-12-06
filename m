Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8EA27DDE0A
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 22:51:30 +1100 (EST)
Date: Thu, 6 Dec 2007 22:51:21 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 8/10] powerpc: Merge PCI resource fixups
Message-Id: <20071206225121.d5bc5685.sfr@canb.auug.org.au>
In-Reply-To: <20071206081248.38101DE5B8@ozlabs.org>
References: <1196928690.864849.322811660859.qpush@grosgo>
	<20071206081248.38101DE5B8@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__6_Dec_2007_22_51_21_+1100_nm1WKBYJy0hLslyg"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__6_Dec_2007_22_51_21_+1100_nm1WKBYJy0hLslyg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 06 Dec 2007 19:11:36 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> @@ -316,19 +313,26 @@ void __devinit of_scan_bus(struct device
>  		dev =3D of_create_pci_dev(child, bus, devfn);
>  		if (!dev)
>  			continue;
> -		DBG("dev header type: %x\n", dev->hdr_type);
> +		DBG("    dev header type: %x\n", dev->hdr_type);
> +	}
> +
> +	/* Ally all fixups */
> +	pcibios_fixup_of_probed_bus(bus);
> =20
> +	/* Now scan child busses */
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE ||
> -		    dev->hdr_type =3D=3D PCI_HEADER_TYPE_CARDBUS)
> -			of_scan_pci_bridge(child, dev);
> +		    dev->hdr_type =3D=3D PCI_HEADER_TYPE_CARDBUS) {
> +			struct device_node *child =3D pci_device_to_OF_node(dev);
> +			if (dev)
                            ^^^
child?

> +				of_scan_pci_bridge(child, dev);
> +		}
>  	}
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__6_Dec_2007_22_51_21_+1100_nm1WKBYJy0hLslyg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHV+I+TgG2atn1QN8RAgrTAJ4wMppnrVzUGFF7L3PaqtztyFicRACfSKBi
2R/z6XXAwdYarxyFZJ3zrco=
=Shjc
-----END PGP SIGNATURE-----

--Signature=_Thu__6_Dec_2007_22_51_21_+1100_nm1WKBYJy0hLslyg--
