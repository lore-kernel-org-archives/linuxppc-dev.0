Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F6871A0145
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 07:46:04 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 6 Apr 2015 15:46:02 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 6B9F93E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2015 15:46:00 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t36Lk38W28311758
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Apr 2015 14:46:03 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t36Ljxl8012324
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Apr 2015 15:46:00 -0600
Date: Mon, 6 Apr 2015 14:45:58 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Topology updates and NUMA-level sched domains
Message-ID: <20150406214558.GA38501@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Boqun Feng <boqun.feng@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter,

As you are very aware, I think, power has some odd NUMA topologies (and
changes to the those topologies) at run-time. In particular, we can see
a topology at boot:

Node 0: all Cpus
Node 7: no cpus

Then we get a notification from the hypervisor that a core (or two) have
moved from node 0 to node 7. This results in the:

[   64.496687] BUG: arch topology borken
[   64.496689]      the CPU domain not a subset of the NUMA domain

messages for each moved CPU. I think this is because when we first came
up, we degrade (elide altogether?) the NUMA domain for node 7 as it has
no CPUs:

[    0.305823] CPU0 attaching sched-domain:
[    0.305831]  domain 0: span 0-7 level SIBLING
[    0.305834]   groups: 0 (cpu_power = 146) 1 (cpu_power = 146) 2
(cpu_power = 146) 3 (cpu_power = 146) 4 (cpu_power = 146) 5 (cpu_power =
146) 6 (cpu_power = 146) 7 (cpu_power = 146)
[    0.305854]   domain 1: span 0-79 level CPU
[    0.305856]    groups: 0-7 (cpu_power = 1168) 8-15 (cpu_power = 1168)
16-23 (cpu_power = 1168) 24-31 (cpu_power = 1168) 32-39 (cpu_power =
1168) 40-47 (cpu_power = 1168) 48-55 (cpu_power = 1168) 56-63 (cpu_power
= 1168) 64-71 (cpu_power = 1168) 72-79 (cpu_power = 1168)

For those cpus that moved, we get after the update:

[   64.505819] CPU8 attaching sched-domain:
[   64.505821]  domain 0: span 8-15 level SIBLING
[   64.505823]   groups: 8 (cpu_power = 147) 9 (cpu_power = 147) 10
(cpu_power = 147) 11 (cpu_power = 146) 12 (cpu_power = 147) 13
(cpu_power = 147) 14 (cpu_power = 146) 15 (cpu_power = 147)
[   64.505842]   domain 1: span 8-23,72-79 level CPU
[   64.505845]    groups: 8-15 (cpu_power = 1174) 16-23 (cpu_power =
1175) 72-79 (cpu_power = 1176)

while the non-modified CPUs report, correctly:

[   64.497186] CPU0 attaching sched-domain:
[   64.497189]  domain 0: span 0-7 level SIBLING
[   64.497192]   groups: 0 (cpu_power = 147) 1 (cpu_power = 147) 2
(cpu_power = 146) 3 (cpu_power = 147) 4 (cpu_power = 147) 5 (cpu_power =
147) 6 (cpu_power = 147) 7 (cpu_power = 146)
[   64.497213]   domain 1: span 0-7,24-71 level CPU
[   64.497215]    groups: 0-7 (cpu_power = 1174) 24-31 (cpu_power =
1173) 32-39 (cpu_power = 1176) 40-47 (cpu_power = 1175) 48-55 (cpu_power
= 1176) 56-63 (cpu_power = 1175) 64-71 (cpu_power = 1174)
[   64.497234]    domain 2: span 0-79 level NUMA
[   64.497236]     groups: 0-7,24-71 (cpu_power = 8223) 8-23,72-79
(cpu_power = 3525)

It seems like we might need something like this (HORRIBLE HACK, I know,
just to get discussion):

@@ -6958,6 +6960,10 @@ void partition_sched_domains(int ndoms_new,
cpumask_var_t doms_new[],
 
        /* Let architecture update cpu core mappings. */
        new_topology = arch_update_cpu_topology();
+       /* Update NUMA topology lists */
+       if (new_topology) {
+               sched_init_numa();
+       }
 
        n = doms_new ? ndoms_new : 0;

or a re-init API (which won't try to reallocate various bits), because
the topology could be completely different now (e.g.,
sched_domains_numa_distance will also be inaccurate now).  Really, a
topology update on power (not sure on s390x, but those are the only two
archs that return a positive value from arch_update_cpu_topology() right
now, afaics) is a lot like a hotplug event and we need to re-initialize
any dependent structures.

I'm just sending out feelers, as we can limp by with the above warning,
it seems, but is less than ideal. Any help or insight you could provide
would be greatly appreciated!

-Nish
