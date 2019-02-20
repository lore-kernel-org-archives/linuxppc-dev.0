Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66895C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 16:38:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D0E2147C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 16:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D0E2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444NbD2112zDqLN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 03:38:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=lvivier@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444NYN4xj9zDqHv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 03:37:11 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C6B418ECA2;
 Wed, 20 Feb 2019 16:37:09 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-204-241.brq.redhat.com
 [10.40.204.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6C7967660;
 Wed, 20 Feb 2019 16:37:04 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sched/topology: fix kernel crash when a CPU is hotplugged in
 a memoryless node
Date: Wed, 20 Feb 2019 17:37:03 +0100
Message-Id: <20190220163703.4597-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 20 Feb 2019 16:37:09 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, Borislav Petkov <bp@suse.de>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When we hotplug a CPU in a memoryless/cpuless node, the kernel crashes when it
rebuilds the sched_domains data.

I reproduce this problem on POWER and with a pseries VM, with the following
QEMU parameters:

  -machine pseries -enable-kvm -m 8192 \
  -smp 2,maxcpus=8,sockets=4,cores=2,threads=1 \
  -numa node,nodeid=0,cpus=0-1,mem=0 \
  -numa node,nodeid=1,cpus=2-3,mem=8192 \
  -numa node,nodeid=2,cpus=4-5,mem=0 \
  -numa node,nodeid=3,cpus=6-7,mem=0

Then I can trigger the crash by hotplugging a CPU on node-id 3:

  (qemu) device_add host-spapr-cpu-core,core-id=7,node-id=3

    Built 2 zonelists, mobility grouping on.  Total pages: 130162
    Policy zone: Normal
    WARNING: workqueue cpumask: online intersect > possible intersect
    BUG: Kernel NULL pointer dereference at 0x00000400
    Faulting instruction address: 0xc000000000170edc
    Oops: Kernel access of bad area, sig: 11 [#1]
    LE SMP NR_CPUS=2048 NUMA pSeries
    Modules linked in: ip6t_rpfilter ipt_REJECT nf_reject_ipv4 ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_security iptable_raw ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter xts vmx_crypto ip_tables xfs libcrc32c virtio_net net_failover failover virtio_blk virtio_pci virtio_ring virtio dm_mirror dm_region_hash dm_log dm_mod
    CPU: 2 PID: 5661 Comm: kworker/2:0 Not tainted 5.0.0-rc6+ #20
    Workqueue: events cpuset_hotplug_workfn
    NIP:  c000000000170edc LR: c000000000170f98 CTR: 0000000000000000
    REGS: c000000003e931a0 TRAP: 0380   Not tainted  (5.0.0-rc6+)
    MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22284028  XER: 00000000
    CFAR: c000000000170f20 IRQMASK: 0
    GPR00: c000000000170f98 c000000003e93430 c0000000011ac500 c0000001efe22000
    GPR04: 0000000000000001 0000000000000000 0000000000000000 0000000000000010
    GPR08: 0000000000000001 0000000000000400 ffffffffffffffff 0000000000000000
    GPR12: 0000000000008800 c00000003fffd680 c0000001f14b0000 c0000000011e1bf0
    GPR16: c0000000011e61f4 c0000001efe22200 c0000001efe22020 c0000001fba80000
    GPR20: c0000001ff567a80 0000000000000001 c000000000e27a80 ffffffffffffe830
    GPR24: ffffffffffffec30 000000000000102f 000000000000102f c0000001efca1000
    GPR28: c0000001efca0400 c0000001efe22000 c0000001efe23bff c0000001efe22a00
    NIP [c000000000170edc] free_sched_groups+0x5c/0xf0
    LR [c000000000170f98] destroy_sched_domain+0x28/0x90
    Call Trace:
    [c000000003e93430] [000000000000102f] 0x102f (unreliable)
    [c000000003e93470] [c000000000170f98] destroy_sched_domain+0x28/0x90
    [c000000003e934a0] [c0000000001716e0] cpu_attach_domain+0x100/0x920
    [c000000003e93600] [c000000000173128] build_sched_domains+0x1228/0x1370
    [c000000003e93740] [c00000000017429c] partition_sched_domains+0x23c/0x400
    [c000000003e937e0] [c0000000001f5ec8] rebuild_sched_domains_locked+0x78/0xe0
    [c000000003e93820] [c0000000001f9ff0] rebuild_sched_domains+0x30/0x50
    [c000000003e93850] [c0000000001fa1c0] cpuset_hotplug_workfn+0x1b0/0xb70
    [c000000003e93c80] [c00000000012e5a0] process_one_work+0x1b0/0x480
    [c000000003e93d20] [c00000000012e8f8] worker_thread+0x88/0x540
    [c000000003e93db0] [c00000000013714c] kthread+0x15c/0x1a0
    [c000000003e93e20] [c00000000000b55c] ret_from_kernel_thread+0x5c/0x80
    Instruction dump:
    2e240000 f8010010 f821ffc1 409e0014 48000080 7fbdf040 7fdff378 419e0074
    ebdf0000 4192002c e93f0010 7c0004ac <7d404828> 314affff 7d40492d 40c2fff4
    ---[ end trace f992c4a7d47d602a ]---

    Kernel panic - not syncing: Fatal exception

This happens in free_sched_groups() because the linked list of the sched_groups
is corrupted. Here what happens when we hotplug the CPU:

 - build_sched_groups() builds a sched_groups linked list for sched_domain D1,
   with only one entry A, refcount=1

   D1: A(ref=1)

 - build_sched_groups() builds a sched_groups linked list for sched_domain D2,
   with the same entry A

   D2: A(ref=2)

 - build_sched_groups() builds a sched_groups linked list for sched_domain D3,
   with the same entry A and a new entry B:

   D3: A(ref=3) -> B(ref=1)

 - destroy_sched_domain() is called for D1:

   D1: A(ref=3) -> B(ref=1) and as ref is 1, memory of B is released,
                                             but A->next always points to B

 - destroy_sched_domain() is called for D3:

   D3: A(ref=2) -> B(ref=0)

kernels crashes when it tries to use data inside B, as the memory has been
corrupted as it has been freed, the linked list (next) is broken too.

This problem appears with commit 051f3ca02e46
("sched/topology: Introduce NUMA identity node sched domain").

If I compare function calls sequence before and after this commit I can see
in the the working case that build_overlap_sched_groups() is called instead of
build_sched_groups() and in this case the reference counters have all the
same value and the linked list can be correctly unallocated.

The problem happens because patch "sched/topology: Introduce NUMA
identity node sched domain" has removed the SDTL_OVERLAP flag
of the first topology level when it has introduced the NODE domain (and thus
build_sched_groups() is used instead of build_overlap_sched_groups()).

As I don't see any reason (and it is not documented in the involved commit)
to remove this flag, this patch re-introduces the SDTL_OVERLAP flag for the
first level. This fixes the problem described above and a CPU can be hotplugged
again without kernel crash.

Fixes: 051f3ca02e46 ("sched/topology: Introduce NUMA identity node sched domain")
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Borislav Petkov <bp@suse.de>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Nathan Fontenot <nfont@linux.vnet.ibm.com>
CC: Michael Bringmann <mwb@linux.vnet.ibm.com>
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 kernel/sched/topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 3f35ba1d8fde..372278605f0d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1651,6 +1651,7 @@ void sched_init_numa(void)
 	 */
 	tl[i++] = (struct sched_domain_topology_level){
 		.mask = sd_numa_mask,
+		.flags = SDTL_OVERLAP,
 		.numa_level = 0,
 		SD_INIT_NAME(NODE)
 	};
-- 
2.20.1

