Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe003.messaging.microsoft.com
 [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E2337B6FAF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 10:34:22 +1100 (EST)
Message-ID: <4F481E66.8010408@freescale.com>
Date: Fri, 24 Feb 2012 17:33:58 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 35/37] KVM: PPC: booke: Support perfmon interrupts
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
 <1330093591-19523-36-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-36-git-send-email-agraf@suse.de>
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

On 02/24/2012 08:26 AM, Alexander Graf wrote:
> When during guest context we get a performance monitor interrupt, we
> currently bail out and oops. Let's route it to its correct handler
> instead.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/powerpc/kvm/booke.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 7adef28..423701b 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -677,6 +677,10 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  		r = RESUME_GUEST;
>  		break;
>  
> +	case BOOKE_INTERRUPT_PERFORMANCE_MONITOR:
> +		r = RESUME_GUEST;
> +		break;
> +
>  	case BOOKE_INTERRUPT_HV_PRIV:
>  		r = emulation_exit(run, vcpu);
>  		break;

Why do we need to call timer_interrupt() explicitly, but can rely on
automatic retriggering for perfmon?

-Scott
