Return-Path: <B43198@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0132.outbound.protection.outlook.com [157.56.111.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71B031A01DA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 22:23:29 +1000 (AEST)
Message-ID: <55534225.1050305@freescale.com>
Date: Wed, 13 May 2015 15:23:01 +0300
From: Purcareata Bogdan <b43198@freescale.com>
MIME-Version: 1.0
To: Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>,
 <segher@kernel.crashing.org>, <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mpic: Remove WHOAMI readback after EOI
References: <1427193823-14597-1-git-send-email-bogdan.purcareata@freescale.com>
In-Reply-To: <1427193823-14597-1-git-send-email-bogdan.purcareata@freescale.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ping?

On 24.03.2015 12:43, Bogdan Purcareata wrote:
> After previous discussions regarding the subject [1][2], there's no clear
> explanation or reason why the call was needed in the first place. The sensible
> argument is some sort of synchronization between the CPU and the MPIC, which
> hasn't been pointed out precisely and is no longer required (at least on BookE
> platforms).
>
> The benefit of this change is saving a MMIO trap per interrupt when running in a
> KVM guest.
>
> [1] https://patchwork.ozlabs.org/patch/429098/
> [2] https://patchwork.ozlabs.org/patch/433557/
>
> Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
> ---
>   arch/powerpc/sysdev/mpic.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index bbfbbf2..045e72a9 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -655,7 +655,6 @@ static inline struct mpic * mpic_from_irq_data(struct irq_data *d)
>   static inline void mpic_eoi(struct mpic *mpic)
>   {
>   	mpic_cpu_write(MPIC_INFO(CPU_EOI), 0);
> -	(void)mpic_cpu_read(MPIC_INFO(CPU_WHOAMI));
>   }
>
>   /*
>
