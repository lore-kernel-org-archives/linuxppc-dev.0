Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vnBN3g9bzF1P8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 20:35:24 +1000 (AEST)
In-Reply-To: <1534517679-10792-1-git-send-email-srikar@linux.vnet.ibm.com>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michal Suchanek <msuchanek@suse.de>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Manjunatha H R <manjuhr1@in.ibm.com>, Michael Bringmann <mbringm@us.ibm.com>
Subject: Re: [v5] powerpc/topology: Get topology for shared processors at boot
Message-Id: <41vnBN2hf3z9s8T@ozlabs.org>
Date: Tue, 21 Aug 2018 20:35:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-17 at 14:54:39 UTC, Srikar Dronamraju wrote:
> On a shared lpar, Phyp will not update the cpu associativity at boot
> time. Just after the boot system does recognize itself as a shared lpar and
> trigger a request for correct cpu associativity. But by then the scheduler
> would have already created/destroyed its sched domains.
> 
> This causes
> - Broken load balance across Nodes causing islands of cores.
> - Performance degradation esp if the system is lightly loaded
> - dmesg to wrongly report all cpus to be in Node 0.
> - Messages in dmesg saying borken topology.
> - With commit 051f3ca02e46 ("sched/topology: Introduce NUMA identity
>   node sched domain"), can cause rcu stalls at boot up.
> 
> >From a scheduler maintainer's perspective, moving cpus from one node to
> another or creating more numa levels after boot is not appropriate
> without some notification to the user space.
> https://lore.kernel.org/lkml/20150406214558.GA38501@linux.vnet.ibm.com/T/#u
> 
> The sched_domains_numa_masks table which is used to generate cpumasks is
> only created at boot time just before creating sched domains and never
> updated.  Hence, its better to get the topology correct before the sched
> domains are created.
> 
> For example on 64 core Power 8 shared lpar, dmesg reports
> 
> [    2.088360] Brought up 512 CPUs
> [    2.088368] Node 0 CPUs: 0-511
> [    2.088371] Node 1 CPUs:
> [    2.088373] Node 2 CPUs:
> [    2.088375] Node 3 CPUs:
> [    2.088376] Node 4 CPUs:
> [    2.088378] Node 5 CPUs:
> [    2.088380] Node 6 CPUs:
> [    2.088382] Node 7 CPUs:
> [    2.088386] Node 8 CPUs:
> [    2.088388] Node 9 CPUs:
> [    2.088390] Node 10 CPUs:
> [    2.088392] Node 11 CPUs:
> ...
> [    3.916091] BUG: arch topology borken
> [    3.916103]      the DIE domain not a subset of the NUMA domain
> [    3.916105] BUG: arch topology borken
> [    3.916106]      the DIE domain not a subset of the NUMA domain
> ...
> 
> numactl/lscpu output will still be correct with cores spreading across
> all nodes.
> 
> Socket(s):             64
> NUMA node(s):          12
> Model:                 2.0 (pvr 004d 0200)
> Model name:            POWER8 (architected), altivec supported
> Hypervisor vendor:     pHyp
> Virtualization type:   para
> L1d cache:             64K
> L1i cache:             32K
> NUMA node0 CPU(s): 0-7,32-39,64-71,96-103,176-183,272-279,368-375,464-471
> NUMA node1 CPU(s): 8-15,40-47,72-79,104-111,184-191,280-287,376-383,472-479
> NUMA node2 CPU(s): 16-23,48-55,80-87,112-119,192-199,288-295,384-391,480-487
> NUMA node3 CPU(s): 24-31,56-63,88-95,120-127,200-207,296-303,392-399,488-495
> NUMA node4 CPU(s):     208-215,304-311,400-407,496-503
> NUMA node5 CPU(s):     168-175,264-271,360-367,456-463
> NUMA node6 CPU(s):     128-135,224-231,320-327,416-423
> NUMA node7 CPU(s):     136-143,232-239,328-335,424-431
> NUMA node8 CPU(s):     216-223,312-319,408-415,504-511
> NUMA node9 CPU(s):     144-151,240-247,336-343,432-439
> NUMA node10 CPU(s):    152-159,248-255,344-351,440-447
> NUMA node11 CPU(s):    160-167,256-263,352-359,448-455
> 
> Currently on this lpar, the scheduler detects 2 levels of Numa and
> created numa sched domains for all cpus, but it finds a single DIE
> domain consisting of all cpus. Hence it deletes all numa sched domains.
> 
> To address this, detect the shared processor and update topology soon after
> cpus are setup so that correct topology is updated just before scheduler
> creates sched domain.
> 
> With the fix, dmesg reports
> 
> [    0.491336] numa: Node 0 CPUs: 0-7 32-39 64-71 96-103 176-183 272-279 368-375 464-471
> [    0.491351] numa: Node 1 CPUs: 8-15 40-47 72-79 104-111 184-191 280-287 376-383 472-479
> [    0.491359] numa: Node 2 CPUs: 16-23 48-55 80-87 112-119 192-199 288-295 384-391 480-487
> [    0.491366] numa: Node 3 CPUs: 24-31 56-63 88-95 120-127 200-207 296-303 392-399 488-495
> [    0.491374] numa: Node 4 CPUs: 208-215 304-311 400-407 496-503
> [    0.491379] numa: Node 5 CPUs: 168-175 264-271 360-367 456-463
> [    0.491384] numa: Node 6 CPUs: 128-135 224-231 320-327 416-423
> [    0.491389] numa: Node 7 CPUs: 136-143 232-239 328-335 424-431
> [    0.491394] numa: Node 8 CPUs: 216-223 312-319 408-415 504-511
> [    0.491399] numa: Node 9 CPUs: 144-151 240-247 336-343 432-439
> [    0.491404] numa: Node 10 CPUs: 152-159 248-255 344-351 440-447
> [    0.491409] numa: Node 11 CPUs: 160-167 256-263 352-359 448-455
> 
> and lscpu would also report
> 
> Socket(s):             64
> NUMA node(s):          12
> Model:                 2.0 (pvr 004d 0200)
> Model name:            POWER8 (architected), altivec supported
> Hypervisor vendor:     pHyp
> Virtualization type:   para
> L1d cache:             64K
> L1i cache:             32K
> NUMA node0 CPU(s): 0-7,32-39,64-71,96-103,176-183,272-279,368-375,464-471
> NUMA node1 CPU(s): 8-15,40-47,72-79,104-111,184-191,280-287,376-383,472-479
> NUMA node2 CPU(s): 16-23,48-55,80-87,112-119,192-199,288-295,384-391,480-487
> NUMA node3 CPU(s): 24-31,56-63,88-95,120-127,200-207,296-303,392-399,488-495
> NUMA node4 CPU(s):     208-215,304-311,400-407,496-503
> NUMA node5 CPU(s):     168-175,264-271,360-367,456-463
> NUMA node6 CPU(s):     128-135,224-231,320-327,416-423
> NUMA node7 CPU(s):     136-143,232-239,328-335,424-431
> NUMA node8 CPU(s):     216-223,312-319,408-415,504-511
> NUMA node9 CPU(s):     144-151,240-247,336-343,432-439
> NUMA node10 CPU(s):    152-159,248-255,344-351,440-447
> NUMA node11 CPU(s):    160-167,256-263,352-359,448-455
> 
> Previous attempt to solve this problem
> https://patchwork.ozlabs.org/patch/530090/
> 
> Reported-by: Manjunatha H R <manjuhr1@in.ibm.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2ea62630681027c455117aa471ea3a

cheers
