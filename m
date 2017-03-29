Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vt8k234m1zDq95
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 12:07:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@ozlabs.org
Cc: benh@kernel.crashing.org, paulus@ozlabs.org,
 Denis Kirjanov <kda@linux-powerpc.org>
Subject: Re: [PATCH] kvm: powerpc: book3s: Disable preemption while accessing
 paca xics_phys filed
In-Reply-To: <1490603214-30116-1-git-send-email-kda@linux-powerpc.org>
References: <1490603214-30116-1-git-send-email-kda@linux-powerpc.org>
Date: Wed, 29 Mar 2017 12:07:03 +1100
Message-ID: <87a884evrc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Denis Kirjanov <kda@linux-powerpc.org> writes:

> With CONFIG_DEBUG_PREEMPT enabled we see the following trace:
>
> [  129.314426] BUG: using smp_processor_id() in preemptible [00000000]
> code: modprobe/5459
> [  129.314580] caller is .kvmppc_book3s_init_hv+0x184/0x350 [kvm_hv]
> [  129.314697] CPU: 11 PID: 5459 Comm: modprobe Not tainted
> 4.11.0-rc3-00022-gc7e790c #1
> [  129.314848] Call Trace:
> [  129.314915] [c0000007d624b810] [c0000000023eef10] .dump_stack+0xe4/0x150 (unreliable)
> [  129.315065] [c0000007d624b8a0] [c000000001f6ec04] .check_preemption_disabled+0x134/0x150
> [  129.315210] [c0000007d624b940] [d00000000a010274] .kvmppc_book3s_init_hv+0x184/0x350 [kvm_hv]
> [  129.315339] [c0000007d624ba00] [c00000000191d5cc] .do_one_initcall+0x5c/0x1c0
> [  129.315416] [c0000007d624bad0] [c0000000023e9494] .do_init_module+0x84/0x240
> [  129.315492] [c0000007d624bb70] [c000000001aade18] .load_module+0x1f68/0x2a10
> [  129.315568] [c0000007d624bd20] [c000000001aaeb30] .SyS_finit_module+0xc0/0xf0
> [  129.315645] [c0000007d624be30] [c00000000191baec] system_call+0x38/0xfc
>
> Disable preemption while accessing paca struct to avoid inconsistent state
>
> Fixes: f725758 ("KVM: PPC: Book3S HV: Use OPAL XICS emulation on POWER9")
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 1ec86d9..8e96bab 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3913,6 +3913,10 @@ static int kvmppc_radix_possible(void)
>  static int kvmppc_book3s_init_hv(void)
>  {
>  	int r;
> +#ifdef CONFIG_SMP
> +	unsigned long xics_phys;
> +#endif
> +
>  	/*
>  	 * FIXME!! Do we need to check on all cpus ?
>  	 */
> @@ -3930,7 +3934,11 @@ static int kvmppc_book3s_init_hv(void)
>  	 * indirectly, via OPAL.
>  	 */
>  #ifdef CONFIG_SMP
> -	if (!get_paca()->kvm_hstate.xics_phys) {
> +	preempt_disable();
> +	xics_phys = get_paca()->kvm_hstate.xics_phys;
> +	preempt_enable();
> +
> +	if (!xics_phys) {
>  		struct device_node *np;
  
Can you tell me what actual problem (other than the warning) this is
fixing?

cheers
