Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3DFE62C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 04:38:39 +1000 (EST)
Date: Wed, 3 Jul 2013 13:38:26 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/6] KVM: PPC: Book3E: Add AltiVec support
To: Mihai Caraman <mihai.caraman@freescale.com>
In-Reply-To: <1372855359-13452-5-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Wed Jul  3 07:42:37 2013)
Message-ID: <1372876706.8183.139@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2013 07:42:37 AM, Mihai Caraman wrote:
> Add KVM Book3E AltiVec support. KVM Book3E FPU support gracefully =20
> reuse host
> infrastructure so follow the same approach for AltiVec.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>  arch/powerpc/kvm/booke.c |   72 =20
> ++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 70 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 3cae2e3..c3c3af6 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -98,6 +98,19 @@ static inline bool kvmppc_supports_spe(void)
>  	return false;
>  }
>=20
> +/*
> + * Always returns true is AltiVec unit is present, see
> + * kvmppc_core_check_processor_compat().
> + */
> +static inline bool kvmppc_supports_altivec(void)
> +{
> +#ifdef CONFIG_ALTIVEC
> +		if (cpu_has_feature(CPU_FTR_ALTIVEC))
> +			return true;
> +#endif
> +	return false;
> +}

Whitespace.

-Scott=
