Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id E54712C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 00:58:46 +1000 (EST)
Message-ID: <5187C521.2070904@suse.de>
Date: Mon, 06 May 2013 16:58:41 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [v1][KVM][PATCH 1/1] kvm:ppc: enable doorbell exception with
 E500MC
References: <1367808836-28635-1-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1367808836-28635-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2013 04:53 AM, Tiejun Chen wrote:
> Actually E500MC also support doorbell exception, and CONFIG_PPC_E500MC
> can cover BOOK3E/BOOK3E_64 as well.
>
> Signed-off-by: Tiejun Chen<tiejun.chen@windriver.com>
> ---
>   arch/powerpc/kvm/booke.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 1020119..dc1f590 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -795,7 +795,7 @@ static void kvmppc_restart_interrupt(struct kvm_vcpu *vcpu,
>   		kvmppc_fill_pt_regs(&regs);
>   		timer_interrupt(&regs);
>   		break;
> -#if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_BOOK3E_64)
> +#if defined(CONFIG_PPC_E500MC)

I suppose you mean CONFIG_KVM_E500MC here? Why didn't this work for you 
before? The ifdef above should cover the same range of CPUs.


Alex
