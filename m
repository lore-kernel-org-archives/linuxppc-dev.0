Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix compile errors found by new ppc64e_defconfig
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1255712717-21221-2-git-send-email-galak@kernel.crashing.org>
References: <1255712717-21221-1-git-send-email-galak@kernel.crashing.org>
	<1255712717-21221-2-git-send-email-galak@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-8xcpczGALogZTfX0rPj5"
Date: Mon, 19 Oct 2009 10:58:28 +1100
Message-Id: <1255910308.4192.8.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-8xcpczGALogZTfX0rPj5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-10-16 at 12:05 -0500, Kumar Gala wrote:
> Fix the following 3 issues:
>=20
> arch/powerpc/kernel/process.c: In function 'arch_randomize_brk':
> arch/powerpc/kernel/process.c:1183: error: 'mmu_highuser_ssize' undeclare=
d (first use in this function)
> arch/powerpc/kernel/process.c:1183: error: (Each undeclared identifier is=
 reported only once
> arch/powerpc/kernel/process.c:1183: error: for each function it appears i=
n.)
> arch/powerpc/kernel/process.c:1183: error: 'MMU_SEGSIZE_1T' undeclared (f=
irst use in this function)
>=20
> In file included from arch/powerpc/kernel/setup_64.c:60:
> arch/powerpc/include/asm/mmu-hash64.h:132: error: redefinition of 'struct=
 mmu_psize_def'
> arch/powerpc/include/asm/mmu-hash64.h:159: error: expected identifier or =
'(' before numeric constant
> arch/powerpc/include/asm/mmu-hash64.h:396: error: conflicting types for '=
mm_context_t'
> arch/powerpc/include/asm/mmu-book3e.h:184: error: previous declaration of=
 'mm_context_t' was here
>=20
> cc1: warnings being treated as errors
> arch/powerpc/kernel/pci_64.c: In function 'pcibios_unmap_io_space':
> arch/powerpc/kernel/pci_64.c:100: error: unused variable 'res'
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/pci_64.c   |    2 ++
>  arch/powerpc/kernel/process.c  |    2 +-
>  arch/powerpc/kernel/setup_64.c |    1 -
>  3 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index ba949a2..ccf56ac 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -97,7 +97,9 @@ int pcibios_unmap_io_space(struct pci_bus *bus)
>  	 * to do an appropriate TLB flush here too
>  	 */
>  	if (bus->self) {
> +#ifdef CONFIG_PPC_STD_MMU_64
>  		struct resource *res =3D bus->resource[0];
> +#endif
> =20
>  		pr_debug("IO unmapping for PCI-PCI bridge %s\n",
>  			 pci_name(bus->self));
104=20
105 #ifdef CONFIG_PPC_STD_MMU_64                                           =
    =20
106                 __flush_hash_table_range(&init_mm, res->start + _IO_BAS=
E,
107                                          res->end + _IO_BASE + 1);
108 #endif
109		return 0;
110	 }

So just expand the ifdef around the pr_debug()?

cheers

--=-8xcpczGALogZTfX0rPj5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkrbq6QACgkQdSjSd0sB4dKLpwCfajRDM4SBJPjuPI8sOFKi11At
fpAAnjXtDe18QCwjbMSAPr6zjTFGSrQB
=62UV
-----END PGP SIGNATURE-----

--=-8xcpczGALogZTfX0rPj5--
