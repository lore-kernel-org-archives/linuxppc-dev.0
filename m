Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 748011A001D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 11:41:22 +1000 (EST)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 27 Aug 2014 02:41:19 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id E41AD2190023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 02:40:58 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7R1fGt334996460
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 01:41:17 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7QKdxlE011283
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 16:40:00 -0400
Message-ID: <1409103671.2466.15.camel@TP420>
Subject: Re: [PATCH v2] powerpc: Fix warning reported by
 verify_cpu_node_mapping()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 27 Aug 2014 09:41:11 +0800
In-Reply-To: <53FC8736.8080000@linux.vnet.ibm.com>
References: <1408608842.3003.20.camel@TP420>
 <20140821154529.GB10478@linux.vnet.ibm.com> <1408673576.2448.6.camel@TP420>
 <20140822220406.GA20951@linux.vnet.ibm.com> <1408951355.2477.8.camel@TP420>
 <53FC8736.8080000@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 二, 2014-08-26 at 08:10 -0500, Nathan Fontenot wrote:
> On 08/25/2014 02:22 AM, Li Zhong wrote:
> > With commit 2fabf084b, during boottime, cpu_numa_callback() is called
> > earlier(before their online) for each cpu, and verify_cpu_node_mapping()
> > uses cpu_to_node() to check whether siblings are in the same node. 
> > 
> > It skips the checking for siblings that are not online yet. So the only
> > check done here is for the bootcpu, which is online at that time. But
> > the per-cpu numa_node cpu_to_node() uses hasn't been set up yet (which
> > will be set up in smp_prepare_cpus()).
> > 
> > So I saw something like following reported:
> > [    0.000000] CPU thread siblings 1/2/3 and 0 don't belong to the same
> > node!
> > 
> > As we don't actually do the checking during this early stage, so maybe
> > we could directly call numa_setup_cpu() in do_init_bootmem().
> > 
> > Also, as Nish suggested, here it's better to use present cpu mask
> > instead of possible mask to avoid warning in numa_setup_cpu().
> > 
> > Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> > ---
> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > index d7737a5..3a9061e 100644
> > --- a/arch/powerpc/mm/numa.c
> > +++ b/arch/powerpc/mm/numa.c
> > @@ -1127,9 +1127,8 @@ void __init do_init_bootmem(void)
> >  	 * even before we online them, so that we can use cpu_to_{node,mem}
> >  	 * early in boot, cf. smp_prepare_cpus().
> >  	 */
> > -	for_each_possible_cpu(cpu) {
> > -		cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
> > -				  (void *)(unsigned long)cpu);
> > +	for_each_present_cpu(cpu) {
> > +		numa_setup_cpu((unsigned long)cpu);
> >  	}
> >  }
> >  
> 
> I am getting the following error on my system booting with this patch.
> 
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.16.0-202712-g9e81330-dirty #42
> task: c0000000fea40000 ti: c0000000fea80000 task.ti: c0000000fea80000
> NIP: c0000000001afad8 LR: c000000000193b68 CTR: 0000000000000000
> REGS: c0000000fea839e0 TRAP: 0300   Not tainted  (3.16.0-202712-g9e81330-dirty)
> MSR: 8000000100009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24000000  XER: 20000004
> CFAR: c0000000000084d4 DAR: 0000000000001690 DSISR: 40000000 SOFTE: 1 
> GPR00: c000000000b6db9c c0000000fea83c60 c000000000cd0628 0000000000001688 
> GPR04: 0000000000000001 0000000000000000 c0000000fea83c80 0000000009900000 
> GPR08: c000000000d531e0 c000000000d66218 c000000000d60628 ffffffffffffffff 
> GPR12: ffffffffffffffff c00000000ec60000 c00000000000bc88 0000000000000000 
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR20: 0000000000000000 0000000000000000 c000000000c21b88 c000000000c03738 
> GPR24: c000000000c03638 c000000000d24b10 c000000000c03638 c000000000c03738 
> GPR28: 0000000000000080 0000000000000080 c000000000d208e8 0000000000000010 
> NIP [c0000000001afad8] next_zones_zonelist+0x8/0xa0
> LR [c000000000193b68] local_memory_node+0x38/0x60
> Call Trace:
> [c0000000fea83c60] [c0000000fea83c90] 0xc0000000fea83c90 (unreliable)
> [c0000000fea83c90] [c000000000b6db9c] smp_prepare_cpus+0x16c/0x278
> [c0000000fea83d00] [c000000000b64098] kernel_init_freeable+0x150/0x340
> [c0000000fea83dc0] [c00000000000bca4] kernel_init+0x24/0x140
> [c0000000fea83e30] [c000000000009560] ret_from_kernel_thread+0x5c/0x7c
> Instruction dump:
> e9230038 39490f00 7fa35040 409c000c 38630780 4e800020 7d234b78 4bffff64 
> 60000000 60420000 2c250000 40c2004c <81230008> 7f892040 419d0014 48000030 
> ---[ end trace cb88537fdc8fa200 ]---
> 
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> I think the loop needs to go back to initializing all possibe cpus instead of
> only the present cpus. We can add a check for present cpus in numa_setup_cpu()
> to avoid printing the WARN_ON() for cpus that are not present, something like
> the following...

Ah, yes, seems the panic was caused by smp_prepare_cpus() using
uninitialized numa_cpu_lookup_table for cpus which are possible but not
present during boottime. 

However, by following change, it seems those cpus will be set to node 0
at boottime, and not be changed after they become present, because of
the following check in numa_setup_cpu(): 
        if ((nid = numa_cpu_lookup_table[lcpu]) >= 0) {
                map_cpu_to_node(lcpu, nid);
                return nid;
        }

Maybe we could change the smp_prepare_cpus() to set numa information for
present cpus instead? 

And for those possible, !present cpus, we could do the setup after they
are started. 

Thanks, Zhong

> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index d7737a5..b827f2e 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -554,7 +554,8 @@ static int numa_setup_cpu(unsigned long lcpu)
>  	cpu = of_get_cpu_node(lcpu, NULL);
> 
>  	if (!cpu) {
> -		WARN_ON(1);
> +		if (cpu_present(lcpu))
> +			WARN_ON(1);
>  		nid = 0;
>  		goto out;
>  	}
> @@ -1128,8 +1129,7 @@ void __init do_init_bootmem(void)
>  	 * early in boot, cf. smp_prepare_cpus().
>  	 */
>  	for_each_possible_cpu(cpu) {
> -		cpu_numa_callback(&ppc64_numa_nb, CPU_UP_PREPARE,
> -				  (void *)(unsigned long)cpu);
> +		numa_setup_cpu((unsigned long)cpu);
>  	}
>  }
> 
> 
