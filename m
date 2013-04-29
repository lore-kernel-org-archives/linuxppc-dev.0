Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 21C722C00AD
 for <linuxppc-dev@ozlabs.org>; Tue, 30 Apr 2013 09:06:45 +1000 (EST)
Date: Tue, 30 Apr 2013 09:06:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix usage of setup_pci_atmu()
Message-Id: <20130430090636.5e06bbfc6db472e1e677cb0b@canb.auug.org.au>
In-Reply-To: <5881.1366004521@ale.ozlabs.ibm.com>
References: <1363201636-7318-1-git-send-email-galak@kernel.crashing.org>
 <5881.1366004521@ale.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__30_Apr_2013_09_06_36_+1000_W64OUeHgjdz5V5/F"
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__30_Apr_2013_09_06_36_+1000_W64OUeHgjdz5V5/F
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Mon, 15 Apr 2013 15:42:01 +1000 Michael Neuling <mikey@neuling.org> wrot=
e:
>
> Linux next is currently failing to compile mpc85xx_defconfig with:
>   arch/powerpc/sysdev/fsl_pci.c:944:2: error: too many arguments to funct=
ion 'setup_pci_atmu'
>=20
> This is caused by (from Kumar's next branch):
>   commit 34642bbb3d12121333efcf4ea7dfe66685e403a1
>   Author: Kumar Gala <galak@kernel.crashing.org>
>   powerpc/fsl-pci: Keep PCI SoC controller registers in pci_controller
>=20
> Which changed definition of setup_pci_atmu() but didn't update one of
> the callers.  Below fixes this.
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> Kumar: this is for your next tree
>=20
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 83918c3..a10a036 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -941,7 +941,7 @@ static int fsl_pci_resume(struct device *dev)
>  		return -ENODEV;
>  	}
> =20
> -	setup_pci_atmu(hose, &pci_rsrc);
> +	setup_pci_atmu(hose);
> =20
>  	return 0;
>  }
>=20

This is still not in your tree ...
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__30_Apr_2013_09_06_36_+1000_W64OUeHgjdz5V5/F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRfvz8AAoJEECxmPOUX5FE7e8P/0oIytPPeMTp3SQMhiThnp9H
oydgN3VZrAzKee/pwpSQfxp+Sa6fdERHkOGiwgOuqwRxwOaSSuMS2Y3SaFiokEKh
0Emzh63iO1S8oW6N+7kNRSiNMCfbDQTRh/KUee1Sy0aOjWW1AKJ7UwI9H960zvPG
XCk2iUTeBU+UW5QAxiKSsbvt9dw/EVy602s0IggEdAgvsdF6p2k/XzqzyX3PpF46
4J8z4um42qL8e16SANbHaLvvTSjaSLdZnOGLQEN+IS4qbjYfamMbIfdmqlMYwFvp
BVfldWKqBOQBvmFUXH48BMLIoDs7Xu2y6JHgd8iBa64f3x+Lw3IBPoKUHOwst824
bfJRjcQk+AkgqEgG2E0+XLovtepT6zvm8RWSxPIkfkmbT9ocNBQyVaiNhoQBMQjV
0buvQql9CpJdVualbaWQ8AGzaRqYaPDrjjMbuzegi2/IULpIMlM05UnPkt7n5wFm
0rY+nM1kAlxZCkxZztHLHwy3Rxukbxyp4FwSh30EOnULdWf9aDY9qxssHQX8DFPg
U/rdDyduqQdsivjI4Nttcv5unwenUEajVocNeXs80ClBfoS4AezHhg0OvSkxydDX
52v1bs5sccV1rmJ3ik/+MR1ozqIbaIwJr7RhAPTbwFdBHOniQKfhlO1YRiGl8WD4
jQVMZMNP3APivIq9lcU5
=mdcY
-----END PGP SIGNATURE-----

--Signature=_Tue__30_Apr_2013_09_06_36_+1000_W64OUeHgjdz5V5/F--
