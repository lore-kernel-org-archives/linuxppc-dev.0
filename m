Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 663362C0079
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 03:47:35 +1100 (EST)
Date: Mon, 3 Dec 2012 10:47:08 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] KVM: PPC: Make EPCR a valid field for booke64 and bookehv
To: Alexander Graf <agraf@suse.de>
References: <1354370305-12344-1-git-send-email-agraf@suse.de>
In-Reply-To: <1354370305-12344-1-git-send-email-agraf@suse.de> (from
 agraf@suse.de on Sat Dec  1 07:58:25 2012)
Message-ID: <1354553228.2960.4@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 "kvm@vger.kernel.org list" <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2012 07:58:25 AM, Alexander Graf wrote:
> In BookE, EPCR is defined and valid when either the HV or the 64bit
> category are implemented. Reflect this in the field definition.
>=20
> Today the only KVM target on 64bit is HV enabled, so there is no
> change in actual source code, but this keeps the code closer to the
> spec and doesn't build up artificial road blocks for a PR KVM
> on 64bit.
[snip]
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/powerpc/include/asm/kvm_host.h |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h =20
> b/arch/powerpc/include/asm/kvm_host.h
> index 62fbd38..3480526 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -405,14 +405,19 @@ struct kvm_vcpu_arch {
>  #ifdef CONFIG_KVM_BOOKE_HV
>  	u32 host_mas4;
>  	u32 host_mas6;
> -	u32 shadow_epcr;
> -	u32 epcr;
>  	u32 shadow_msrp;
>  	u32 eplc;
>  	u32 epsc;
>  	u32 oldpir;
>  #endif
>=20
> +#if defined(CONFIG_BOOKE)
> +#if defined(CONFIG_KVM_BOOKE_HV) || defined(CONFIG_64BIT)
> +	u32 shadow_epcr;
> +	u32 epcr;
> +#endif
> +#endif

On a PR-mode implementation, why would we be have a shadow_epcr?  It =20
would always be set based on the host kernel, just like when running =20
any other userspace process.

-Scott=
