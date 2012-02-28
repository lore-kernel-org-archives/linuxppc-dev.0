Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C9496B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 04:21:31 +1100 (EST)
Message-ID: <4F4D0D10.3040900@freescale.com>
Date: Tue, 28 Feb 2012 11:21:20 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 24/37] KVM: PPC: booke: rework rescheduling checks
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
 <1330093591-19523-25-git-send-email-agraf@suse.de>
 <4F4BD95B.9010809@freescale.com>
 <8C85FFCE-616B-4A3C-BD43-08997DB1E0B1@suse.de>
In-Reply-To: <8C85FFCE-616B-4A3C-BD43-08997DB1E0B1@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/28/2012 05:03 AM, Alexander Graf wrote:
> 
> On 27.02.2012, at 20:28, Scott Wood wrote:
> 
>> If there is a signal pending and MSR[WE] is set, we'll loop forever
>> without reaching this check.
> 
> Good point. How about something like this on top (will fold in later)?
> 
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 430055e..9f27258 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -477,15 +477,17 @@ static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>                         continue;
>                 }
>  
> +               if (signal_pending(current)) {
> +                       r = 1;
> +                       break;
> +               }
> +
>                 if (kvmppc_core_prepare_to_enter(vcpu)) {
>                         /* interrupts got enabled in between, so we
>                            are back at square 1 */
>                         continue;
>                 }
>  
> -               if (signal_pending(current))
> -                       r = 1;
> -
>                 break;
>         }

Looks OK.

-Scott
