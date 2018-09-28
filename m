Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAD1C43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 03:49:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9023216FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 03:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9023216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42LyNf6WHlzF3B0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 13:49:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=srikar@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LyLb1JRWzF39c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 13:47:50 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8S3iQj1134665
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 23:47:48 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2msb6gavq9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 23:47:48 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Fri, 28 Sep 2018 04:47:47 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 28 Sep 2018 04:47:44 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w8S3lhpc51642406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Sep 2018 03:47:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDB564C044;
 Fri, 28 Sep 2018 06:47:26 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6ED354C04A;
 Fri, 28 Sep 2018 06:47:25 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.199.53.215])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 28 Sep 2018 06:47:25 +0100 (BST)
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/numa: Skip onlining a offline node in kdump path
Date: Fri, 28 Sep 2018 09:17:32 +0530
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18092803-0008-0000-0000-000002780BF3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092803-0009-0000-0000-000021E11696
Message-Id: <1538106452-7643-1-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-09-28_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809280039
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
Cc: Pavithra Prakash <pavrampu@in.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Bringmann <mbringm@us.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

With Commit 2ea626306810 ("powerpc/topology: Get topology for shared
processors at boot"), kdump kernel on shared lpar may crash.

The necessary conditions are
- Shared Lpar with atleast 2 nodes having memory and CPUs.
- Memory requirement for kdump kernel must be met by the first N-1 nodes
  where there are atleast N nodes with memory and CPUs.

Example numactl of such a machine.
 numactl -H
available: 5 nodes (0,2,5-7)
node 0 cpus:
node 0 size: 0 MB
node 0 free: 0 MB
node 2 cpus:
node 2 size: 255 MB
node 2 free: 189 MB
node 5 cpus: 24 25 26 27 28 29 30 31
node 5 size: 4095 MB
node 5 free: 4024 MB
node 6 cpus: 0 1 2 3 4 5 6 7 16 17 18 19 20 21 22 23
node 6 size: 6353 MB
node 6 free: 5998 MB
node 7 cpus: 8 9 10 11 12 13 14 15 32 33 34 35 36 37 38 39
node 7 size: 7640 MB
node 7 free: 7164 MB
node distances:
node   0   2   5   6   7
  0:  10  40  40  40  40
  2:  40  10  40  40  40
  5:  40  40  10  40  40
  6:  40  40  40  10  20
  7:  40  40  40  20  10

Steps to reproduce.
1. Load / start kdump service.
2. Trigger a kdump (for example : echo c > /proc/sysrq-trigger)

When booting a kdump kernel with 2048M
kexec: Starting switchover sequence.
I'm in purgatory
Using 1TB segments
hash-mmu: Initializing hash mmu with SLB
Linux version 4.19.0-rc5-master+ (srikar@linux-xxu6) (gcc version 4.8.5 (SUSE Linux)) #1 SMP Thu Sep 27 19:45:00 IST 2018
Found initrd at 0xc000000009e70000:0xc00000000ae554b4
Using pSeries machine description
-----------------------------------------------------
ppc64_pft_size    = 0x1e
phys_mem_size     = 0x88000000
dcache_bsize      = 0x80
icache_bsize      = 0x80
cpu_features      = 0x000000ff8f5d91a7
  possible        = 0x0000fbffcf5fb1a7
  always          = 0x0000006f8b5c91a1
cpu_user_features = 0xdc0065c2 0xef000000
mmu_features      = 0x7c006001
firmware_features = 0x00000007c45bfc57
htab_hash_mask    = 0x7fffff
physical_start    = 0x8000000
-----------------------------------------------------
numa:   NODE_DATA [mem 0x87d5e300-0x87d67fff]
numa:     NODE_DATA(0) on node 6
numa:   NODE_DATA [mem 0x87d54600-0x87d5e2ff]
Top of RAM: 0x88000000, Total RAM: 0x88000000
Memory hole size: 0MB
Zone ranges:
  DMA      [mem 0x0000000000000000-0x0000000087ffffff]
  DMA32    empty
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   6: [mem 0x0000000000000000-0x0000000087ffffff]
Could not find start_pfn for node 0
Initmem setup node 0 [mem 0x0000000000000000-0x0000000000000000]
On node 0 totalpages: 0
Initmem setup node 6 [mem 0x0000000000000000-0x0000000087ffffff]
On node 6 totalpages: 34816

Unable to handle kernel paging request for data at address 0x00000060
Faulting instruction address: 0xc000000008703a54
Oops: Kernel access of bad area, sig: 11 [#1]
LE SMP NR_CPUS=2048 NUMA pSeries
Modules linked in:
CPU: 11 PID: 1 Comm: swapper/11 Not tainted 4.19.0-rc5-master+ #1
NIP:  c000000008703a54 LR: c000000008703a38 CTR: 0000000000000000
REGS: c00000000b673440 TRAP: 0380   Not tainted  (4.19.0-rc5-master+)
MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24022022  XER: 20000002
CFAR: c0000000086fc238 IRQMASK: 0
GPR00: c000000008703a38 c00000000b6736c0 c000000009281900 0000000000000000
GPR04: 0000000000000000 0000000000000000 fffffffffffff001 c00000000b660080
GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000220
GPR12: 0000000000002200 c000000009e51400 0000000000000000 0000000000000008
GPR16: 0000000000000000 c000000008c152e8 c000000008c152a8 0000000000000000
GPR20: c000000009422fd8 c000000009412fd8 c000000009426040 0000000000000008
GPR24: 0000000000000000 0000000000000000 c000000009168bc8 c000000009168c78
GPR28: c00000000b126410 0000000000000000 c00000000916a0b8 c00000000b126400
NIP [c000000008703a54] bus_add_device+0x84/0x1e0
LR [c000000008703a38] bus_add_device+0x68/0x1e0
Call Trace:
[c00000000b6736c0] [c000000008703a38] bus_add_device+0x68/0x1e0 (unreliable)
[c00000000b673740] [c000000008700194] device_add+0x454/0x7c0
[c00000000b673800] [c00000000872e660] __register_one_node+0xb0/0x240
[c00000000b673860] [c00000000839a6bc] __try_online_node+0x12c/0x180
[c00000000b673900] [c00000000839b978] try_online_node+0x58/0x90
[c00000000b673930] [c0000000080846d8] find_and_online_cpu_nid+0x158/0x190
[c00000000b673a10] [c0000000080848a0] numa_update_cpu_topology+0x190/0x580
[c00000000b673c00] [c000000008d3f2e4] smp_cpus_done+0x94/0x108
[c00000000b673c70] [c000000008d5c00c] smp_init+0x174/0x19c
[c00000000b673d00] [c000000008d346b8] kernel_init_freeable+0x1e0/0x450
[c00000000b673dc0] [c0000000080102e8] kernel_init+0x28/0x160
[c00000000b673e30] [c00000000800b65c] ret_from_kernel_thread+0x5c/0x80
Instruction dump:
60000000 60000000 e89e0020 7fe3fb78 4bff87d5 60000000 7c7d1b79 4082008c
e8bf0050 e93e0098 3b9f0010 2fa50000 <e8690060> 38630018 419e0114 7f84e378
---[ end trace 593577668c2daa65 ]---

However a regular kernel with 4096M (2048 gets reserved for
crash kernel) boots properly.

Unlike regular kernels, which mark all available nodes as online, kdump
kernel only marks just enough nodes as online and marks the rest as
offline at boot.  However kdump kernel boots with all available CPUs.
With Commit 2ea626306810 ("powerpc/topology: Get topology for shared
processors at boot"), all CPUs are onlined on their respective nodes at
boot time. try_online_node() tries to online the offline nodes but fails
as all needed subsystems are not yet initialized.

As part of fix, detect and skip early onlining of a offline node.

Fixes: 2ea626306810 ("powerpc/topology: Get topology for shared processors at boot")
Reported-by: Pavithra Prakash <pavrampu@in.ibm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index e94148a1d7e4..d88139acdfe6 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1217,9 +1217,10 @@ int find_and_online_cpu_nid(int cpu)
 		 * Need to ensure that NODE_DATA is initialized for a node from
 		 * available memory (see memblock_alloc_try_nid). If unable to
 		 * init the node, then default to nearest node that has memory
-		 * installed.
+		 * installed. Skip onlining a node if the subsystems are not
+		 * yet initialized.
 		 */
-		if (try_online_node(new_nid))
+		if (!topology_inited || try_online_node(new_nid))
 			new_nid = first_online_node;
 #else
 		/*
-- 
2.12.3

