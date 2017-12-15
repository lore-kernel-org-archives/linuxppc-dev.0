Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yykkg3NWLzDrd2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 19:54:19 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id o2so5370094pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Dec 2017 00:54:19 -0800 (PST)
Date: Fri, 15 Dec 2017 18:54:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v4 1/2] powerpc/crash: Remove the test for cpu_online in
 the IPI callback
Message-ID: <20171215185407.42856586@roar.ozlabs.ibm.com>
In-Reply-To: <20171215081455.11941-1-bsingharora@gmail.com>
References: <20171215081455.11941-1-bsingharora@gmail.com>
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

On Fri, 15 Dec 2017 19:14:54 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> Our check was extra cautious, we've audited crash_send_ipi
> and it sends an IPI only to online CPU's. Removal of this
> check should have not functional impact on crash kdump.
> 

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/kernel/crash.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> index cbabb5adccd9..29c56ca2ddfd 100644
> --- a/arch/powerpc/kernel/crash.c
> +++ b/arch/powerpc/kernel/crash.c
> @@ -69,9 +69,6 @@ static void crash_ipi_callback(struct pt_regs *regs)
>  
>  	int cpu = smp_processor_id();
>  
> -	if (!cpu_online(cpu))
> -		return;
> -
>  	hard_irq_disable();
>  	if (!cpumask_test_cpu(cpu, &cpus_state_saved)) {
>  		crash_save_cpu(regs, cpu);
