Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6F954140B04
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 01:40:33 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 5 May 2014 21:10:31 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E03EBE004B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 21:10:52 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s45FeZ9o65863920
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 21:10:36 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s45FeR1I002645
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 21:10:27 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: BOOK3S: HV: Don't try to allocate from kernel
 page allocator for hash page table.
In-Reply-To: <20FFDF8F-1A3D-4719-B492-1E4B70F9D1B4@suse.de>
References: <1399224322-22028-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <53677558.50900@suse.de> <87r4489ttk.fsf@linux.vnet.ibm.com>
 <20FFDF8F-1A3D-4719-B492-1E4B70F9D1B4@suse.de>
Date: Mon, 05 May 2014 21:10:26 +0530
Message-ID: <87a9aw9qtx.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

>> Am 05.05.2014 um 16:35 schrieb "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>:
>> 
>> Alexander Graf <agraf@suse.de> writes:
>> 
>>>> On 05/04/2014 07:25 PM, Aneesh Kumar K.V wrote:
>>>> We reserve 5% of total ram for CMA allocation and not using that can
>>>> result in us running out of numa node memory with specific
>>>> configuration. One caveat is we may not have node local hpt with pinned
>>>> vcpu configuration. But currently libvirt also pins the vcpu to cpuset
>>>> after creating hash page table.
>>> 
>>> I don't understand the problem. Can you please elaborate?
>> 
>> Lets take a system with 100GB RAM. We reserve around 5GB for htab
>> allocation. Now if we use rest of available memory for hugetlbfs
>> (because we want all the guest to be backed by huge pages), we would
>> end up in a situation where we have a few GB of free RAM and 5GB of CMA
>> reserve area. Now if we allow hash page table allocation to consume the
>> free space, we would end up hitting page allocation failure for other
>> non movable kernel allocation even though we still have 5GB CMA reserve
>> space free.
>
> Isn't this a greater problem? We should start swapping before we hit
> the point where non movable kernel allocation fails, no?

But there is nothing much to swap. Because most of the memory is
reserved for guest RAM via hugetlbfs. 

>
> The fact that KVM uses a good number of normal kernel pages is maybe
> suboptimal, but shouldn't be a critical problem.

Yes. But then in this case we could do better isn't it ? We already have
a large part of guest RAM kept aside for htab allocation which cannot be
used for non movable allocation. And we ignore that reserve space and
use other areas for hash page table allocation with the current code.

We actually hit this case in one of the test box.

 KVM guest htab at c000001e50000000 (order 30), LPID 1
 libvirtd invoked oom-killer: gfp_mask=0x2000d0, order=0,oom_score_adj=0
 libvirtd cpuset=/ mems_allowed=0,16
 CPU: 72 PID: 20044 Comm: libvirtd Not tainted 3.10.23-1401.pkvm2_1.4.ppc64 #1
 Call Trace:
 [c000001e3b63f150] [c000000000017330] .show_stack+0x130/0x200(unreliable)
 [c000001e3b63f220] [c00000000087a888] .dump_stack+0x28/0x3c
 [c000001e3b63f290] [c000000000876a4c] .dump_header+0xbc/0x228
 [c000001e3b63f360] [c0000000001dd838].oom_kill_process+0x318/0x4c0
 [c000001e3b63f440] [c0000000001de258] .out_of_memory+0x518/0x550
 [c000001e3b63f520] [c0000000001e5aac].__alloc_pages_nodemask+0xb3c/0xbf0
 [c000001e3b63f700] [c000000000243580] .new_slab+0x440/0x490
 [c000001e3b63f7a0] [c0000000008781fc] .__slab_alloc+0x17c/0x618
 [c000001e3b63f8d0] [c0000000002467fc].kmem_cache_alloc_node_trace+0xcc/0x300
 [c000001e3b63f990] [c00000000010f62c].alloc_fair_sched_group+0xfc/0x200
 [c000001e3b63fa60] [c000000000104f00].sched_create_group+0x50/0xe0
 [c000001e3b63fae0] [c000000000104fc0].cpu_cgroup_css_alloc+0x30/0x80
 [c000001e3b63fb60] [c0000000001513ec] .cgroup_mkdir+0x2bc/0x6e0
 [c000001e3b63fc50] [c000000000275aec] .vfs_mkdir+0x14c/0x220
 [c000001e3b63fcf0] [c00000000027a734] .SyS_mkdirat+0x94/0x110
 [c000001e3b63fdb0] [c00000000027a7e4] .SyS_mkdir+0x34/0x50
 [c000001e3b63fe30] [c000000000009f54] syscall_exit+0x0/0x98


Node 0 DMA free:23424kB min:23424kB low:29248kB high:35136kB
active_anon:0kB inactive_anon:128kB active_file:256kB inactive_file:384kB
unevictable:9536kB isolated(anon):0kB isolated(file):0kB present:67108864kB
managed:65931776kB mlocked:9536kB dirty:64kB writeback:0kB mapped:5376kB
shmem:0kB slab_reclaimable:23616kB slab_unreclaimable:1237056kB
kernel_stack:18256kB pagetables:1088kB unstable:0kB bounce:0kB free_cma:0kB
writeback_tmp:0kB pages_scanned:78 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Node 16 DMA free:5787008kB min:21376kB low:26688kB high:32064kB
active_anon:1984kB inactive_anon:2112kB active_file:896kB inactive_file:64kB
unevictable:0kB isolated(anon):0kB isolated(file):0kB present:67108864kB
managed:60060032kB mlocked:0kB dirty:128kB writeback:3712kB mapped:0kB
shmem:0kB slab_reclaimable:23424kB slab_unreclaimable:826048kB
kernel_stack:576kB pagetables:1408kB unstable:0kB bounce:0kB free_cma:5767040kB
writeback_tmp:0kB pages_scanned:756 all_unreclaimable? yes
