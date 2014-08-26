Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B65C21A0012
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 01:17:26 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 26 Aug 2014 09:17:24 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2E63F1FF004A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 09:17:20 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7QFHLvH24051812
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 17:17:21 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7QFHKYx004745
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Aug 2014 09:17:20 -0600
Date: Tue, 26 Aug 2014 08:17:16 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc: Fix warning reported by
 verify_cpu_node_mapping()
Message-ID: <20140826151716.GA19690@linux.vnet.ibm.com>
References: <1408608842.3003.20.camel@TP420>
 <20140821154529.GB10478@linux.vnet.ibm.com>
 <1408673576.2448.6.camel@TP420>
 <20140822220406.GA20951@linux.vnet.ibm.com>
 <1408951355.2477.8.camel@TP420>
 <53FC8736.8080000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53FC8736.8080000@linux.vnet.ibm.com>
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nathan,

On 26.08.2014 [08:10:14 -0500], Nathan Fontenot wrote:
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

With the patch below, you don't get the error, I assume? Does it boot
fully in that case?

-Nish
