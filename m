Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E33CE1A0B01
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 04:29:17 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Sun, 27 Sep 2015 12:29:15 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id ACC3D19D803F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 12:20:05 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8RISA8j1180042
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 11:28:18 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8RISdcj020507
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2015 12:28:40 -0600
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>
Cc: <anton@samba.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <cl@linux.com>,
 <nacc@linux.vnet.ibm.com>, <gkurz@linux.vnet.ibm.com>,
 <grant.likely@linaro.org>, <nikunj@linux.vnet.ibm.com>,
 <raghavendra.kt@linux.vnet.ibm.com>, <khandual@linux.vnet.ibm.com>
Subject: [PATCH RFC  0/5] powerpc:numa Add serial nid support
Date: Sun, 27 Sep 2015 23:59:08 +0530
Message-Id: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Problem description:
Powerpc has sparse node numbering, i.e. on a 4 node system nodes are
numbered (possibly) as 0,1,16,17. At a lower level, we map the chipid
got from device tree is naturally mapped (directly) to nid.

Potential side effect of that is:

1) There are several places in kernel that assumes serial node numbering.
and memory allocations assume that all the nodes from 0-(highest nid)
exist inturn ending up allocating memory for the nodes that does not exist.

2) For virtualization use cases (such as qemu, libvirt, openstack), mapping
sparse nid of the host system to contiguous nids of guest (numa affinity,
placement) could be a challenge.

Possible Solutions:
1) Handling the memory allocations is kernel case by case: Though in some
cases it is easy to achieve, some cases may be intrusive/not trivial. 
at the end it does not handle side effect (2) above.

2) Map the sparse chipid got from device tree to a serial nid at kernel
level (The idea proposed in this series).
Pro: It is more natural to handle at kernel level than at lower (OPAL) layer.
con: The chipid is in device tree no longer the same as nid in kernel

3) Let the lower layer (OPAL) give the serial node ids after parsing the
chipid and the associativity etc [ either as a separate item in device tree
or by compacting the chipid numbers ]
Pros: kernel, device tree are on same page and less change in kernel
Con: is it the functionality expected in lower layer

As mentioned above, current patch series tries to map chipid from lower layer
to a contiguos nid at kernel level keeping the node distance calculation and
so on intact.

Result:
Before the patch: numactl -H

available: 4 nodes (0-1,16-17)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
node 0 size: 31665 MB
node 0 free: 29836 MB
node 1 cpus: 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
node 1 size: 32722 MB
node 1 free: 32019 MB
node 16 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
node 16 size: 32571 MB
node 16 free: 31222 MB
node 17 cpus: 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
node 17 size: 0 MB
node 17 free: 0 MB
node distances:
node   0   1  16  17 
  0:  10  20  40  40 
  1:  20  10  40  40 
 16:  40  40  10  20 
 17:  40  40  20  10 

After the patch: numactl -H

available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
node 0 size: 31665 MB
node 0 free: 30657 MB
node 1 cpus: 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
node 1 size: 32722 MB
node 1 free: 32566 MB
node 2 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
node 2 size: 32571 MB
node 2 free: 32401 MB
node 3 cpus: 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
node 3 size: 0 MB
node 3 free: 0 MB
node distances:
node   0   1   2   3 
  0:  10  20  40  40 
  1:  20  10  40  40 
  2:  40  40  10  20 
  3:  40  40  20  10 

(note that numa distances are intact). Apart from this, The following tests
are done with the patched kernel (both baremetal and KVM guest with multiple
nodes) to ensure there is no breakage.

1) offlining and onlining of memory in /sys/devices/system/node/nodeX path

2) offlining and onlining of cpus in /sys/devices/system/cpu/ path

3) Numactl tests from
ftp://oss.sgi.com/www/projects/libnuma/download/numactl-2.0.10.tar.gz

(infact there were more breakage before the patch because of sparse nid
and memoryless node cases of powerpc)

4) Thousands of docker containers were spawned.

Please let me know your comments.

 patch 1-3: cleanup patches
 patch 4: Adds helper function to map nid and chipid
 patch 5: Uses the mapping to get serial nid 

Raghavendra K T (5):
  powerpc:numa Add numa_cpu_lookup function to update lookup table
  powerpc:numa Rename functions referring to nid as chipid
  powerpc:numa create 1:1 mappaing between chipid and nid
  powerpc:numa Add helper functions to maintain chipid to nid mapping
  powerpc:numa Use chipid to nid mapping to get serial numa node ids

 arch/powerpc/include/asm/mmzone.h |   2 +-
 arch/powerpc/kernel/smp.c         |  10 ++--
 arch/powerpc/mm/numa.c            | 121 +++++++++++++++++++++++++++++++-------
 3 files changed, 105 insertions(+), 28 deletions(-)

-- 
1.7.11.7
