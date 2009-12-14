Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0603B6F19
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 07:18:18 +1100 (EST)
Subject: Re: [PATCH] powerpc/mm: fix typo of cpumask_clear_cpu()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1260795709-16165-1-git-send-email-leoli@freescale.com>
References: <1260795709-16165-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Dec 2009 07:18:01 +1100
Message-ID: <1260821881.2217.36.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-12-14 at 21:01 +0800, Li Yang wrote:
> The function name of cpumask_clear_cpu was not correct.
> 
> Reported-by: Jin Qing <b24347@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> This also implies that the CONFIG_HOTPLUG_CPU was never tested.
> We are trying to add cpu hotplug for SMP suspend, but seeing the
> following error(on 2.6.31 with context patches applied).
> Any idea or suggestion?

Hotplug hass indeed never been tested on BookE as we lack a platform
that supports it :-)

As you log, it's useless since you haven't compiled verbose BUG info in
your kernel so the message indicating the file/line of the error is
absent.

Ben.

> ------------[ cut here ]------------
> Badness at c00161b0 [verbose debug info unavailable]
> NIP: c00161b0 LR: c0016190 CTR: c0038f7c
> REGS: eec61e10 TRAP: 0700   Not tainted  (2.6.31-00040-g7c92556-dirty)
> MSR: 00021000 <ME,CE>  CR: 22280028  XER: 00000000
> TASK = eec54980[0] 'swapper' THREAD: eec60000 CPU: 1
> GPR00: 00000001 eec61ec0 eec54980 c0562ea0 eecad500 00000000 00000000 00000001
> GPR08: 00eed000 00000000 00000001 eecad67c 00001ca8 00000000 00021000 eec60040
> GPR16: eec54b0c c05208a0 c055fbe8 00000001 ffffffff c0560000 c0562ea0 00000004
> GPR24: eec60000 00000001 00000000 c0562e80 eec60000 c05291f8 eecad500 c05291f8
> NIP [c00161b0] switch_mmu_context+0x54/0x520
> LR [c0016190] switch_mmu_context+0x34/0x520
> Call Trace:
> [eec61ec0] [c00709c8] tick_program_event+0x50/0x60 (unreliable)
> [eec61f20] [c03beb54] schedule+0x2bc/0x7bc
> [eec61fa0] [c0008a8c] cpu_idle+0x160/0x170
> [eec61fc0] [c03c4be0] start_secondary+0x2d0/0x2e8
> [eec61ff0] [c0001c9c] __secondary_start+0x30/0x84
> Instruction dump:
> 543c0024 7ec3b378 833c0008 483ab1bd 813e0184 2f9d0000 39290001 913e0184
> 419e001c 813d0184 7d200034 5400d97e <0f000000> 3929ffff 913d0184 3d20c055
> MMU: More active contexts than CPUs ! (3 vs 2)
> MMU: More active contexts than CPUs ! (3 vs 2)
> 
> 
>  arch/powerpc/mm/mmu_context_nohash.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
> index be4f34c..1044a63 100644
> --- a/arch/powerpc/mm/mmu_context_nohash.c
> +++ b/arch/powerpc/mm/mmu_context_nohash.c
> @@ -353,7 +353,7 @@ static int __cpuinit mmu_context_cpu_notify(struct notifier_block *self,
>  		read_lock(&tasklist_lock);
>  		for_each_process(p) {
>  			if (p->mm)
> -				cpu_mask_clear_cpu(cpu, mm_cpumask(p->mm));
> +				cpumask_clear_cpu(cpu, mm_cpumask(p->mm));
>  		}
>  		read_unlock(&tasklist_lock);
>  	break;
