Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 98609B7099
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2012 05:10:29 +1000 (EST)
Message-ID: <4F7F3F96.5070905@freescale.com>
Date: Fri, 6 Apr 2012 14:10:14 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Bharat Bhushan <r65777@freescale.com>
Subject: Re: [PATCH] Use clockevent multiplier and shifter for decrementer
References: <1333522311-1390-1-git-send-email-bharat.bhushan@freescale.com>
In-Reply-To: <1333522311-1390-1-git-send-email-bharat.bhushan@freescale.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/04/2012 01:51 AM, Bharat Bhushan wrote:
> Time for which the hrtimer is started for decrementer emulation is
> calculated using tb_ticks_per_usec. While hrtimer uses the clockevent
> for DEC reprogramming (if needed) and which calculate timebase ticks
> using the multiplier and shifter mechanism implemented within
> clockevent layer. It was observed that this conversion
> (timebase->time->timebase) are not correct because the mechanism are
> not consistent. In our setup it adds 2% jitter.
>
> With this patch clockevent multiplier and shifter mechanism are used
> when starting hrtimer for decrementer emulation. Now the jitter is <
> 0.5%.
>
> Signed-off-by: Bharat Bhushan<bharat.bhushan@freescale.com>
> ---
>   arch/powerpc/include/asm/time.h |    2 ++
>   arch/powerpc/kernel/time.c      |    6 ++++++
>   arch/powerpc/kvm/emulate.c      |    5 +++--
>   3 files changed, 11 insertions(+), 2 deletions(-)

Changes to arch/powerpc outside arch/powerpc/kvm need to
Cc: linuxppc-dev@lists.ozlabs.org

> diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
> index 7eb10fb..6d631b2 100644
> --- a/arch/powerpc/include/asm/time.h
> +++ b/arch/powerpc/include/asm/time.h
> @@ -202,6 +202,8 @@ extern u64 mulhdu(u64, u64);
>   extern void div128_by_32(u64 dividend_high, u64 dividend_low,
>   			 unsigned divisor, struct div_result *dr);
>
> +extern void get_clockevent_mult(u64 *multi, u64 *shift);
> +
>   /* Used to store Processor Utilization register (purr) values */
>
>   struct cpu_usage {
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 567dd7c..d229edd 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -910,6 +910,12 @@ static void __init init_decrementer_clockevent(void)
>   	register_decrementer_clockevent(cpu);
>   }
>
> +void get_clockevent_mult(u64 *multi, u64 *shift)
> +{
> +	*multi = decrementer_clockevent.mult;
> +	*shift = decrementer_clockevent.shift;
> +}

Maybe just make decrmenter_clockevent non-static?

> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> index afc9154..4bfcaa1 100644
> --- a/arch/powerpc/kvm/emulate.c
> +++ b/arch/powerpc/kvm/emulate.c
> @@ -76,6 +76,7 @@ void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
>   {
>   	unsigned long dec_nsec;
>   	unsigned long long dec_time;
> +	u64 mult, shift;
>
>   	pr_debug("mtDEC: %x\n", vcpu->arch.dec);
>   	hrtimer_try_to_cancel(&vcpu->arch.dec_timer);
> @@ -103,9 +104,9 @@ void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
>   	 * host ticks.
>   	 */
>
> +	get_clockevent_mult(&mult,&shift);
>   	dec_time = vcpu->arch.dec;
> -	dec_time *= 1000;
> -	do_div(dec_time, tb_ticks_per_usec);
> +	dec_time = (dec_time<<  shift) / mult;
>   	dec_nsec = do_div(dec_time, NSEC_PER_SEC);
>   	hrtimer_start(&vcpu->arch.dec_timer,
>   		ktime_set(dec_time, dec_nsec), HRTIMER_MODE_REL);

-Scott
