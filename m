Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 54227DDE24
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 14:05:42 +1000 (EST)
Date: Fri, 24 Aug 2007 14:05:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] [02/10] pasemi_mac: Stop using the pci config space
	accessors for register read/writes
Message-Id: <20070824140531.ff7d66bf.sfr@canb.auug.org.au>
In-Reply-To: <20070823181310.GB31882@lixom.net>
References: <20070817205413.548020000@lixom.net>
	<20070822141248.GC16830@lixom.net>
	<20070823181310.GB31882@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__24_Aug_2007_14_05_31_+1000_is0RHKOjeyeyY/Sp"
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__24_Aug_2007_14_05_31_+1000_is0RHKOjeyeyY/Sp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Aug 2007 13:13:10 -0500 Olof Johansson <olof@lixom.net> wrote:
>
>  out:
> -	pci_dev_put(mac->iob_pdev);
> -out_put_dma_pdev:
> -	pci_dev_put(mac->dma_pdev);
> -out_free_netdev:
> +	if (mac->iob_pdev)
> +		pci_dev_put(mac->iob_pdev);
> +	if (mac->dma_pdev)
> +		pci_dev_put(mac->dma_pdev);

It is not documented as such (as far as I can see), but pci_dev_put is
safe to call with NULL. And there are other places in the kernel that
explicitly use that fact.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__24_Aug_2007_14_05_31_+1000_is0RHKOjeyeyY/Sp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGzlkUTgG2atn1QN8RAtKLAJ9wigSW2fn7t1hxx31DxeXH5sA7MwCgllYb
PvAfjEOfp+P5lPb62Cb8CZg=
=lj3f
-----END PGP SIGNATURE-----

--Signature=_Fri__24_Aug_2007_14_05_31_+1000_is0RHKOjeyeyY/Sp--
