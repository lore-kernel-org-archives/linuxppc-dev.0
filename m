Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9XTd6R9zzDr1y
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 14:48:53 +1000 (AEST)
Date: Fri, 12 Aug 2016 14:34:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 12/15] KVM: PPC: Enable IOMMU_API for
 KVM_BOOK3S_64 permanently
Message-ID: <20160812043417.GO16493@voom.fritz.box>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-13-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gqEssfNGWsEa4HfM"
In-Reply-To: <1470213656-1042-13-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--gqEssfNGWsEa4HfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2016 at 06:40:53PM +1000, Alexey Kardashevskiy wrote:
> It does not make much sense to have KVM in book3s-64 and
> not to have IOMMU bits for PCI pass through support as it costs little
> and allows VFIO to function on book3s KVM.
>=20
> Having IOMMU_API always enabled makes it unnecessary to have a lot of
> "#ifdef IOMMU_API" in arch/powerpc/kvm/book3s_64_vio*. With those
> ifdef's we could have only user space emulated devices accelerated
> (but not VFIO) which do not seem to be very useful.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/kvm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index b7c494b..63b60a8 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -65,6 +65,7 @@ config KVM_BOOK3S_64
>  	select KVM
>  	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
>  	select KVM_VFIO if VFIO
> +	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT
>  	---help---
>  	  Support running unmodified book3s_64 and book3s_32 guest kernels
>  	  in virtual machines on book3s_64 host processors.

I don't quite see how this change accomplishes the stated goal.
AFAICT even with this change you can still turn off IOMMU_SUPPORT,
which will break the IOMMU for VFIO passthrough, but not IOMMU
acceleration for emulated devices (since that requires no interaction
with the hardware IOMMU).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gqEssfNGWsEa4HfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrVHJAAoJEGw4ysog2bOSQWEP/3PMZKxb7ZhdycxGvdhjOPoS
jVlIgLL4kLr5QXIHxqKxQmTdKf+f8bri2Xi52MWX7pFxpbyQfN6/Tsze18slLr/e
++9T2ipLgzyL+KFRXhJ3/Mr8GOP/JEYJnTG5lkmtl2xuCeUtUQbEDexMhvnRWHcU
EozG4IbAw9DPJ621BV5a78H3hANhrf1nSmxSra+SJybCWp/a+kYaAD6+V4wvibMa
kMCrSGbmcrEB+TSdM2v1zQMGQZxKdS169nokbPFE/np/81Ae40C0tWDW0cVg2lfQ
HbnPtDQJkw4pSPIUMk7u7cVvbqd8nu+lSXvP1w2vQUlN4+b2WtJ43W3kI63jxsu8
adJhrxJiJ2HlFN943W00VSgeofHNF/Gg5UxU+CGJSzfpzhyhuPGvbbW7n8nqSE3r
xUeyhLSPfH2zcuk3r871nim954T3WCAJSzRzdaniaPNFdF/IawJXaATHn06sPjs3
AecVFFlO+klasaQUiQCiuPMQpXKI+9xjE7uXRhdp//i+FlbPnjbr1seJ/JUy+hgn
jLmo7ZPc4YJXBdq7LeECf8imnSmme1i6jDs3iLy2fmZ8P+qkIv4XcduMyDOJcC5b
6oZbvRcJZ1/pReOF/RCvA4wGQ+dKE0b1RG8exT69Sn3wMOB7Qbvo1dgFYg7JHJph
pnCWozjxOUsJsouJ+/d1
=hr54
-----END PGP SIGNATURE-----

--gqEssfNGWsEa4HfM--
