Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yyZXl55PczDrhq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 13:45:11 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id p84so5127478pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 18:45:10 -0800 (PST)
Date: Fri, 15 Dec 2017 12:44:57 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v3 2/3] powerpc/powernv: Identify scom driven system reset
Message-ID: <20171215124457.69841739@roar.ozlabs.ibm.com>
In-Reply-To: <20171215012740.30291-2-bsingharora@gmail.com>
References: <20171215012740.30291-1-bsingharora@gmail.com>
 <20171215012740.30291-2-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 15 Dec 2017 12:27:39 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> In irq_set_pending_from_srr1() we were missing 0x2 as system
> reset identified from SRR1 caused by back to back system
> resets or when interrupts are caused by SCOM when the thread
> is not in power saving mode.
> 
> This helps us get to NMI handling in both the case where NMI
> is caused when in power-saving and not in power-saving mode.
> The actual exploitation is expected when we are doing a kdump
> and an offline CPU might not be in power-saving mode due to
> an already spurious IPI or any other reason.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

When not in power saving mode, we don't look at SRR1 at all, so
we don't need this. You should never be getting it returned as the
result of your idle instruction (except on DD1 which has a bug,
but firmware doesn't implement the NMI IPI).

It's possible we could pay more attention to the reason, for
example in the powernv system reset handle we might only call
the NMI IPI handler if it was a scom sreset... but that would
be a regs->msr test.

> ---
>  arch/powerpc/kernel/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index b7a84522e652..ec89104e8ab9 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -413,7 +413,7 @@ bool prep_irq_for_idle_irqsoff(void)
>  #define IRQ_SYSTEM_RESET	0xff
>  
>  static const u8 srr1_to_lazyirq[0x10] = {
> -	0, 0, 0,
> +	0, 0, IRQ_SYSTEM_RESET,
>  	PACA_IRQ_DBELL,
>  	IRQ_SYSTEM_RESET,
>  	PACA_IRQ_DBELL,
