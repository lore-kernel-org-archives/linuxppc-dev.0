Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 853F71A003B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 23:10:24 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 26 Aug 2014 07:10:22 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 004923E40048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 07:10:19 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7QDAIqo28246088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 15:10:18 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7QDAHTN030531
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 07:10:18 -0600
Message-ID: <53FC8736.8080000@linux.vnet.ibm.com>
Date: Tue, 26 Aug 2014 08:10:14 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Li Zhong <zhong@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc: Fix warning reported by
 verify_cpu_node_mapping()
References: <1408608842.3003.20.camel@TP420>
 <20140821154529.GB10478@linux.vnet.ibm.com> <1408673576.2448.6.camel@TP420>
 <20140822220406.GA20951@linux.vnet.ibm.com> <1408951355.2477.8.camel@TP420>
In-Reply-To: <1408951355.2477.8.camel@TP420>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/25/2014 02:22 AM, Li Zhong wrote:
> With commit 2fabf084b, during boottime, cpu_numa_callback() is called
> earlier(before their online) for each cpu, and verify_cpu_node_mapping()
> uses cpu_to_node() to check whether siblings are in the same node. 
> 
> It skips the checking for siblings that are not online yet. So the only
> check done here is for the bootcpu, which is online at that time. But
> the per-cpu numa_node cpu_to_node() uses hasn't been set up yet (which
> will be set up in smp_prepare_cpus()).
> 
> So I saw something like following reported:
> [    0.000000] CPU thread siblings 1/2/3 and 0 don't belong to the same
> node!
> 
> As we don't actually do the checking during this early stage, so maybe
> we could directly call numa_setup_cpu() in do_init_bootmem().
> 
> Also, as Nish suggested, here it's better to use present cpu mask
> instead of possible mask to avoid warning in numa_setup_cpu().
> 
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> ---
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index d7737a5..3a9061e 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1127,9 +1127,8 @@ void __init do_init_bootmem(void)
>  	 * even before we online them, so that we can use cpu_to_{node,mem}
>  	 * early in boot, cf. smp_prepare_cpus().
>  	 */
> -	for_each_possible_cpu(cpu) {
> -		cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
> -				  (void *)(unsigned long)cpu);
> +	for_each_present_cpu(cpu) {
> +		numa_setup_cpu((unsigned long)cpu);
>  	}
>  }
>  

I am getting the following error on my system booting with this patch.

CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.16.0-202712-g9e81330-dirty #42
task: c0000000fea40000 ti: c0000000fea80000 task.ti: c0000000fea80000
NIP: c0000000001afad8 LR: c000000000193b68 CTR: 0000000000000000
REGS: c0000000fea839e0 TRAP: 0300   Not tainted  (3.16.0-202712-g9e81330-dirty)
MSR: 8000000100009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24000000  XER: 20000004
CFAR: c0000000000084d4 DAR: 0000000000001690 DSISR: 40000000 SOFTE: 1 
GPR00: c000000000b6db9c c0000000fea83c60 c000000000cd0628 0000000000001688 
GPR04: 0000000000000001 0000000000000000 c0000000fea83c80 0000000009900000 
GPR08: c000000000d531e0 c000000000d66218 c000000000d60628 ffffffffffffffff 
GPR12: ffffffffffffffff c00000000ec60000 c00000000000bc88 0000000000000000 
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
GPR20: 0000000000000000 0000000000000000 c000000000c21b88 c000000000c03738 
GPR24: c000000000c03638 c000000000d24b10 c000000000c03638 c000000000c03738 
GPR28: 0000000000000080 0000000000000080 c000000000d208e8 0000000000000010 
NIP [c0000000001afad8] next_zones_zonelist+0x8/0xa0
LR [c000000000193b68] local_memory_node+0x38/0x60
Call Trace:
[c0000000fea83c60] [c0000000fea83c90] 0xc0000000fea83c90 (unreliable)
[c0000000fea83c90] [c000000000b6db9c] smp_prepare_cpus+0x16c/0x278
[c0000000fea83d00] [c000000000b64098] kernel_init_freeable+0x150/0x340
[c0000000fea83dc0] [c00000000000bca4] kernel_init+0x24/0x140
[c0000000fea83e30] [c000000000009560] ret_from_kernel_thread+0x5c/0x7c
Instruction dump:
e9230038 39490f00 7fa35040 409c000c 38630780 4e800020 7d234b78 4bffff64 
60000000 60420000 2c250000 40c2004c <81230008> 7f892040 419d0014 48000030 
---[ end trace cb88537fdc8fa200 ]---

Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

I think the loop needs to go back to initializing all possibe cpus instead of
only the present cpus. We can add a check for present cpus in numa_setup_cpu()
to avoid printing the WARN_ON() for cpus that are not present, something like
the following...

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index d7737a5..b827f2e 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -554,7 +554,8 @@ static int numa_setup_cpu(unsigned long lcpu)
 	cpu = of_get_cpu_node(lcpu, NULL);
 
 	if (!cpu) {
-		WARN_ON(1);
+		if (cpu_present(lcpu))
+			WARN_ON(1);
 		nid = 0;
 		goto out;
 	}
@@ -1128,8 +1129,7 @@ void __init do_init_bootmem(void)
 	 * early in boot, cf. smp_prepare_cpus().
 	 */
 	for_each_possible_cpu(cpu) {
-		cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
-				  (void *)(unsigned long)cpu);
+		numa_setup_cpu((unsigned long)cpu);
 	}
 }
 
