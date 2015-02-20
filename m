Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D483A1A0CC3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 00:45:15 +1100 (AEDT)
Message-ID: <54E73A64.5020608@suse.de>
Date: Fri, 20 Feb 2015 14:45:08 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-rt-users@vger.kernel.org,
 bigeasy@linutronix.de, pbonzini@redhat.com
Subject: Re: [PATCH 2/2] powerpc/kvm: Limit MAX_VCPUS for guests running on
 RT Linux
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
 <1424251955-308-3-git-send-email-bogdan.purcareata@freescale.com>
In-Reply-To: <1424251955-308-3-git-send-email-bogdan.purcareata@freescale.com>
Content-Type: text/plain; charset=windows-1252
Cc: scottwood@freescale.com, mihai.caraman@freescale.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 18.02.15 10:32, Bogdan Purcareata wrote:
> Due to the introduction of the raw_spinlock for the KVM openpic, guests with a
> high number of VCPUs may induce great latencies on the underlying RT Linux
> system (e.g. cyclictest reports latencies of ~15ms for guests with 24 VCPUs).
> This can be further aggravated by sending a lot of external interrupts to the
> guest.
> 
> A malicious app can abuse this scenario, causing a DoS of the host Linux.
> Until the KVM openpic code is refactored to use finer lock granularity, impose
> a limitation on the number of VCPUs a guest can have when running on a
> PREEMPT_RT_FULL system with KVM_MPIC emulation.
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
> Reviewed-by: Scott Wood <scottwood@freescale.com>

I don't think this patch is reasonable to take upstream. If we have a
latency issue, whoever spawned KVM VMs made a decision to spawn such big
VMs.

I'd say let's leave it at MAX_VCPUS == NR_CPUS for now and rather get
someone to resolve any locking problems for real ;).


Alex

> ---
>  arch/powerpc/include/asm/kvm_host.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 8ef0512..6f6b928 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -36,8 +36,14 @@
>  #include <asm/cacheflush.h>
>  #include <asm/hvcall.h>
>  
> +#if defined(CONFIG_PREEMPT_RT_FULL) && defined(CONFIG_KVM_MPIC)
> +/* Limit the number of vcpus due to in-kernel mpic concurrency */
> +#define KVM_MAX_VCPUS		4
> +#define KVM_MAX_VCORES		4
> +#else
>  #define KVM_MAX_VCPUS		NR_CPUS
>  #define KVM_MAX_VCORES		NR_CPUS
> +#endif
>  #define KVM_USER_MEM_SLOTS 32
>  #define KVM_MEM_SLOTS_NUM KVM_USER_MEM_SLOTS
>  
> 
