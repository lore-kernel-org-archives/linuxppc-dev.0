Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzB6338GyzDqKd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 15:26:51 +1000 (AEST)
Date: Thu, 6 Apr 2017 15:22:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: gleb@kernel.org, agraf@suse.de, KVM-PPC <kvm-ppc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, pbonzini@redhat.com,
 KVM <kvm@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] powerpc/powernv: Introduce a machine check hook
 for Guest MCEs.
Message-ID: <20170406052258.GB12179@umbus>
References: <149142508580.28284.10052904644951828717.stgit@jupiter.in.ibm.com>
 <149142524189.28284.14876788789820474952.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
In-Reply-To: <149142524189.28284.14876788789820474952.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 02:17:22AM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>=20
> This patch introduces a mce hook which is invoked at the time of guest
> exit to facilitate the host-side handling of machine check exception
> before the exception is passed on to the guest. This hook will be invoked
> from host virtual mode from KVM (before exiting the guest with
> KVM_EXIT_NMI reason) for machine check exception that occurs in the guest.
>=20
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Um.. this introduces the hook, and puts in an implementation of it,
but AFAICT, nothing calls it, either here or in the next patch.  That
seems a bit pointless.

> ---
>  arch/powerpc/include/asm/machdep.h     |    7 +++++++
>  arch/powerpc/include/asm/opal.h        |    4 ++++
>  arch/powerpc/platforms/powernv/opal.c  |   26 ++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/setup.c |    3 +++
>  4 files changed, 40 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/as=
m/machdep.h
> index 5011b69..9d74e7a 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -15,6 +15,7 @@
>  #include <linux/export.h>
> =20
>  #include <asm/setup.h>
> +#include <asm/mce.h>
> =20
>  /* We export this macro for external modules like Alsa to know if
>   * ppc_md.feature_call is implemented or not
> @@ -112,6 +113,12 @@ struct machdep_calls {
>  	/* Called during machine check exception to retrive fixup address. */
>  	bool		(*mce_check_early_recovery)(struct pt_regs *regs);
> =20
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	/* Called after KVM interrupt handler finishes handling MCE for guest */
> +	int		(*machine_check_exception_guest)
> +					(struct machine_check_event *evt);
> +#endif
> +
>  	/* Motherboard/chipset features. This is a kind of general purpose
>  	 * hook used to control some machine specific features (like reset
>  	 * lines, chip power control, etc...).
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/o=
pal.h
> index 1ff03a6..9b1fcbf 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -17,6 +17,7 @@
>  #ifndef __ASSEMBLY__
> =20
>  #include <linux/notifier.h>
> +#include <asm/mce.h>
> =20
>  /* We calculate number of sg entries based on PAGE_SIZE */
>  #define SG_ENTRIES_PER_NODE ((PAGE_SIZE - 16) / sizeof(struct opal_sg_en=
try))
> @@ -273,6 +274,9 @@ extern int opal_hmi_handler_init(void);
>  extern int opal_event_init(void);
> =20
>  extern int opal_machine_check(struct pt_regs *regs);
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +extern int opal_machine_check_guest(struct machine_check_event *evt);
> +#endif
>  extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
>  extern int opal_hmi_exception_early(struct pt_regs *regs);
>  extern int opal_handle_hmi_exception(struct pt_regs *regs);
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platfor=
ms/powernv/opal.c
> index e0f856b..5e633a4 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -479,6 +479,32 @@ int opal_machine_check(struct pt_regs *regs)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +/*
> + * opal_machine_check_guest() is a hook which is invoked at the time
> + * of guest exit to facilitate the host-side handling of machine check
> + * exception before the exception is passed on to the guest. This hook
> + * is invoked from host virtual mode from KVM (before exiting the guest
> + * with KVM_EXIT_NMI reason) for machine check exception that occurs in
> + * the guest.
> + *
> + * Currently no action is performed in the host other than printing the
> + * event information. The machine check exception is passed on to the
> + * guest kernel and the guest kernel will attempt for recovery.
> + */
> +int opal_machine_check_guest(struct machine_check_event *evt)
> +{
> +	/* Print things out */
> +	if (evt->version !=3D MCE_V1) {
> +		pr_err("Machine Check Exception, Unknown event version %d !\n",
> +		       evt->version);
> +		return 0;
> +	}
> +	machine_check_print_event_info(evt);
> +	return 0;
> +}
> +#endif
> +
>  /* Early hmi handler called in real mode. */
>  int opal_hmi_exception_early(struct pt_regs *regs)
>  {
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platfo=
rms/powernv/setup.c
> index d50c7d9..333ee09 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -264,6 +264,9 @@ static void __init pnv_setup_machdep_opal(void)
>  	ppc_md.mce_check_early_recovery =3D opal_mce_check_early_recovery;
>  	ppc_md.hmi_exception_early =3D opal_hmi_exception_early;
>  	ppc_md.handle_hmi_exception =3D opal_handle_hmi_exception;
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	ppc_md.machine_check_exception_guest =3D opal_machine_check_guest;
> +#endif
>  }
> =20
>  static int __init pnv_probe(void)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY5dCwAAoJEGw4ysog2bOSrNgQAM0VqG5ziJHusRG2u58lyl4N
8n6z5hSa+oRLPaouvemaAXMHDB2uHCLgQhcBf/HfozKCDgC+ZmkbxBHbmqVxKN7H
aNkGQ2aEfFffpzqpUDAx7ekficiZE8ahnTv7ERCSDP8GNIAEt7uWBzc6xe4LkBSI
jUxqEOCMpenVRaCiXvsZM9oozZGpwvtocW89oCHOUQw4SrrnrVP5icc/I3R2VEJq
z+9DlJh2vuUyvlfhrnqK18sk9djM+Yf3XvbzxQDiAxxhV2OJqD6VORJg1mOf4sol
EFIZuF8LSsKo6PBHkZu2yfbv9lucrPz7s8t6otQqlaa9HupCrPSRMhCIhYZNE9Zy
nWP/64YdrhB8Kocf7PHB6WgKzyLlBYXVWVt7acT6HPOlaeNDJQjK3/xfU1zO51Lj
C6kHe+ZDAulyl/EV81QOnsHgn91gcSFRVViQLVDJAamOpBSy/q/HsMYTQ5bgTVUL
OvS+LwJi1v60368CAU3Ks+E0pwzWDvG595w0aByYaJXURlZlWeh90BWW5hTEiATM
18CsFrb3zmyIJw3oAm3k+ShkuRDN8TSg64x4CcOT6Ip3Msgb3GA+esrvIJYbOoNo
M4e7WCvI/uJde6FnMWjm4Njspxa2tdpjdRTJpAE93LkBVuNugti8VVWfTegFx6/r
Ya5Sdho7gcntQMBKy47t
=kH8g
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
