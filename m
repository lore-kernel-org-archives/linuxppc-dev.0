Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C917F1007DA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 09:14:07 +1100 (EST)
Message-ID: <4F3ED122.3000901@freescale.com>
Date: Fri, 17 Feb 2012 16:13:54 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 21/30] KVM: PPC: make e500v2 and e500mc mutually exclusive
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
 <1329498837-11717-22-git-send-email-agraf@suse.de>
In-Reply-To: <1329498837-11717-22-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2012 11:13 AM, Alexander Graf wrote:
> We can't build e500v2 and e500mc (kvm) support inside the same kernel.
> So indicate that by making the 2 options mutually exclusive in kconfig.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/powerpc/kvm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index 44a998d..25ffc1e 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -134,7 +134,7 @@ config KVM_E500V2
>  
>  config KVM_E500MC
>  	bool "KVM support for PowerPC E500MC/E5500 processors"
> -	depends on EXPERIMENTAL && PPC_E500MC
> +	depends on EXPERIMENTAL && PPC_E500MC && !KVM_E500V2
>  	select KVM
>  	select KVM_MMIO
>  	select KVM_BOOKE_HV

Instead should make KVM_E500V2 not selectable if PPC_E500MC is present
-- it won't work due to the absence of PID1 on e500mc.

-Scott
