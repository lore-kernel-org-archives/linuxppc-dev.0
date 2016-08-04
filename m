Return-Path: <dja@axtens.net>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4YVQ1ychzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 12:17:17 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id i6so15942297pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 19:17:17 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: move hmi.c to arch/powerpc/kvm/
In-Reply-To: <1470224194-15412-1-git-send-email-pbonzini@redhat.com>
References: <1470224194-15412-1-git-send-email-pbonzini@redhat.com>
Date: Thu, 04 Aug 2016 12:17:02 +1000
Message-ID: <87mvktqnvl.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Paolo Bonzini <pbonzini@redhat.com> writes:

> hmi.c functions are unused unless sibling_subcore_state is nonzero, and
> that in turn happens only if KVM is in use.  So move the code to
> arch/powerpc/kvm/, putting it under CONFIG_KVM_BOOK3S_64_HANDLER
> rather than CONFIG_PPC_BOOK3S_64.  The sibling_subcore_state is also
> included in struct paca_struct only if KVM is supported by the kernel.

Ok. Initially I was concerned because there are a bunch of non-KVM
related HMI causes (e.g. the CAPP will raise an HMI if it loses the link
to the CAPI card.)
https://github.com/open-power/skiboot/blob/master/core/hmi.c lists lots
of HMIs created by hardware events.

Having said that, you're right that this particular file is KVM
specific.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Mahesh: is there a way to cause the TB to desynchronise and then test if
this resynchronisation works?

Regards,
Daniel

>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: kvm-ppc@vger.kernel.org
> Cc: kvm@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> 	It would be nice to have this in 4.8, to minimize any 4.9 conflicts.
> 	Build-tested only, with and without KVM enabled.
>
>  arch/powerpc/include/asm/hmi.h                     |  2 +-
>  arch/powerpc/include/asm/paca.h                    | 10 +++++-----
>  arch/powerpc/kernel/Makefile                       |  2 +-
>  arch/powerpc/kvm/Makefile                          |  1 +
>  arch/powerpc/{kernel/hmi.c =3D> kvm/book3s_hv_hmi.c} |  0
>  5 files changed, 8 insertions(+), 7 deletions(-)
>  rename arch/powerpc/{kernel/hmi.c =3D> kvm/book3s_hv_hmi.c} (100%)
>
> diff --git a/arch/powerpc/include/asm/hmi.h b/arch/powerpc/include/asm/hm=
i.h
> index 88b4901ac4ee..d3b6ad6e137c 100644
> --- a/arch/powerpc/include/asm/hmi.h
> +++ b/arch/powerpc/include/asm/hmi.h
> @@ -21,7 +21,7 @@
>  #ifndef __ASM_PPC64_HMI_H__
>  #define __ASM_PPC64_HMI_H__
>=20=20
> -#ifdef CONFIG_PPC_BOOK3S_64
> +#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
>=20=20
>  #define	CORE_TB_RESYNC_REQ_BIT		63
>  #define MAX_SUBCORE_PER_CORE		4
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/p=
aca.h
> index 148303e7771f..625321e7e581 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -183,11 +183,6 @@ struct paca_struct {
>  	 */
>  	u16 in_mce;
>  	u8 hmi_event_available;		 /* HMI event is available */
> -	/*
> -	 * Bitmap for sibling subcore status. See kvm/book3s_hv_ras.c for
> -	 * more details
> -	 */
> -	struct sibling_subcore_state *sibling_subcore_state;
>  #endif
>=20=20
>  	/* Stuff for accurate time accounting */
> @@ -202,6 +197,11 @@ struct paca_struct {
>  	struct kvmppc_book3s_shadow_vcpu shadow_vcpu;
>  #endif
>  	struct kvmppc_host_state kvm_hstate;
> +	/*
> +	 * Bitmap for sibling subcore status. See kvm/book3s_hv_ras.c for
> +	 * more details
> +	 */
> +	struct sibling_subcore_state *sibling_subcore_state;
>  #endif
>  };
>=20=20
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index b2027a5cf508..fe4c075bcf50 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -41,7 +41,7 @@ obj-$(CONFIG_VDSO32)		+=3D vdso32/
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+=3D hw_breakpoint.o
>  obj-$(CONFIG_PPC_BOOK3S_64)	+=3D cpu_setup_ppc970.o cpu_setup_pa6t.o
>  obj-$(CONFIG_PPC_BOOK3S_64)	+=3D cpu_setup_power.o
> -obj-$(CONFIG_PPC_BOOK3S_64)	+=3D mce.o mce_power.o hmi.o
> +obj-$(CONFIG_PPC_BOOK3S_64)	+=3D mce.o mce_power.o
>  obj-$(CONFIG_PPC_BOOK3E_64)	+=3D exceptions-64e.o idle_book3e.o
>  obj-$(CONFIG_PPC64)		+=3D vdso64/
>  obj-$(CONFIG_ALTIVEC)		+=3D vecemu.o
> diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
> index 1f9e5529e692..855d4b95d752 100644
> --- a/arch/powerpc/kvm/Makefile
> +++ b/arch/powerpc/kvm/Makefile
> @@ -78,6 +78,7 @@ kvm-book3s_64-builtin-xics-objs-$(CONFIG_KVM_XICS) :=3D=
 \
>=20=20
>  ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  kvm-book3s_64-builtin-objs-$(CONFIG_KVM_BOOK3S_64_HANDLER) +=3D \
> +	book3s_hv_hmi.o \
>  	book3s_hv_rmhandlers.o \
>  	book3s_hv_rm_mmu.o \
>  	book3s_hv_ras.o \
> diff --git a/arch/powerpc/kernel/hmi.c b/arch/powerpc/kvm/book3s_hv_hmi.c
> similarity index 100%
> rename from arch/powerpc/kernel/hmi.c
> rename to arch/powerpc/kvm/book3s_hv_hmi.c
> --=20
> 1.8.3.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXoqWeAAoJEPC3R3P2I92FltIQAJrGgCl3j+ZGQg+ib1+NtJS9
8oKXTI09tfSVnTOYaY2aSNH1EsljjJhK8cF+VVkgMc+jPepxxsffgoHzOaYTZbsc
SdzTWTOlL9OVNmFcHwvG4R8y/+tuKlOZwSmUkwoa8yEjNYaoWhBHWNL2GDFXa1bG
g8puA5Svd3N5HIWCa/Kg2xrJYH1DEmHp0CCRe7GKsYnd5hRciwEkBog7ilQd3+3D
PC5kCcvaBae7adldodQwMLnOVOSczY7bF6k9RN5rPM5tLh1jaF1pzqGXP0OwIkYo
TWk/83mpg0v2DTvQ8wYX8jJEg/fmh8MigM2kP59O9oDs6S9TIlZxh/vnHcgSRjuq
TYU46mKB6s7KLnd9ck+e1WnLl1C8dJnJVQHhQcnAC7M7ygRZX4ANTRlAc43B0Dt8
bPoYW2H2Xn7LqkmX7eva7I7yYiyfnFGcFZ0bwx3tNTCMzWQT8iFfZIu8MRcDoz4q
a+mh+gOjUM4LORQKfi91WhOWPNTg6/GgMbL1QBrCXRBdVx8H7LdfLx/t0Nz6c3qf
nP67W1StfpkGrgIUbZdNS4o3Up6rKXbt2cekimZSho2MMhKlHL4NUm4d2binFb6l
CC//TTpGEFJH8IbY5AV4gXjpFCdWIM1IQRzCFQgR7aJviFz3Gqkc0oIarZ+eSC6A
+SirZHaHdJBKyPm/ACVl
=9zvn
-----END PGP SIGNATURE-----
--=-=-=--
