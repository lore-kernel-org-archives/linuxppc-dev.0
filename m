Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C552E67C03
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 16:32:32 +1100 (EST)
Date: Tue, 12 Dec 2006 16:32:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Subject: Re: [PATCH 14/15] powerpc: avoid claiming some PCI bus
Message-Id: <20061212163220.b17d83cd.sfr@canb.auug.org.au>
In-Reply-To: <200612120439.kBC4dOUJ002218@toshiba.co.jp>
References: <200612120439.kBC4dOUJ002218@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_Dec_2006_16_32_20_+1100_uyEFBvKZ1ktg+sBd"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__12_Dec_2006_16_32_20_+1100_uyEFBvKZ1ktg+sBd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2006 13:39:23 +0900 (JST) Ishizaki Kou <kou.ishizaki@toshiba.co.jp> wrote:
>
> +#ifdef CONFIG_PPC_MULTIPLATFORM
> +	list_for_each_entry(b, &pci_root_buses, node) {
> +		if (!machine_is(celleb) ||
> +		    ppc_md.pci_probe_mode(b) == PCI_PROBE_DEVTREE)
> +			pcibios_claim_one_bus(b);
> +	}
> +#else
>  	list_for_each_entry(b, &pci_root_buses, node)
>  		pcibios_claim_one_bus(b);
> +#endif

All 64 bit platforms now have CONFIG_PPC_MULTIPLATFORM set, I think.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_Dec_2006_16_32_20_+1100_uyEFBvKZ1ktg+sBd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFfj7kFdBgD/zoJvwRAii4AJ0eISs8HQhrnJGBitORBVOgoErebgCfX6TF
Emhr+RLUAMQQPdmVOocBWEQ=
=ycpz
-----END PGP SIGNATURE-----

--Signature=_Tue__12_Dec_2006_16_32_20_+1100_uyEFBvKZ1ktg+sBd--
