Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 31ACCDDF6F
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 14:30:53 +1000 (EST)
Date: Tue, 15 May 2007 14:30:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix warning in pci_64.c
Message-Id: <20070515143042.987cba34.sfr@canb.auug.org.au>
In-Reply-To: <20070515041705.CCC00DDFC9@ozlabs.org>
References: <20070515041705.CCC00DDFC9@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_May_2007_14_30_42_+1000_=zUaYwBATS6dM+Jh"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_May_2007_14_30_42_+1000_=zUaYwBATS6dM+Jh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 15 May 2007 14:16:35 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>  void pcibios_add_platform_entries(struct pci_dev *pdev)
>  {
> -	device_create_file(&pdev->dev, &dev_attr_devspec);
> +	int rc = device_create_file(&pdev->dev, &dev_attr_devspec);
> +	WARN_ON(rc != 0);

If we really don't care if the file is not created, then it is probably
worth a comment as to why ...

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_May_2007_14_30_42_+1000_=zUaYwBATS6dM+Jh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGSTd3FdBgD/zoJvwRAv8QAJwKZ1XhJ7XqRhRpzLvbuZhp6yWb4wCglWZE
RsCmyDW1ydKPlpPJNeIw/Yg=
=NSzn
-----END PGP SIGNATURE-----

--Signature=_Tue__15_May_2007_14_30_42_+1000_=zUaYwBATS6dM+Jh--
