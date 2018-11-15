Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2D4C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 09:22:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2971E2086C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 09:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2971E2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wbVJ553wzF3Xk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 20:22:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sathnaga@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wbS30ngVzF3WQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 20:20:18 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAF9K9CP044238
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 04:20:15 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ns43u5744-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 04:20:12 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sathnaga@linux.vnet.ibm.com>;
 Thu, 15 Nov 2018 09:20:00 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 15 Nov 2018 09:19:57 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAF9JuoI52035660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Nov 2018 09:19:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FF88A405C;
 Thu, 15 Nov 2018 09:19:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D67A7A405B;
 Thu, 15 Nov 2018 09:19:54 +0000 (GMT)
Received: from dhcp-9-193-110-205.in.ibm.com (unknown [9.122.211.233])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 15 Nov 2018 09:19:54 +0000 (GMT)
Date: Thu, 15 Nov 2018 14:49:48 +0530
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] powerpc/numa: fix hot-added CPU on memory-less node
References: <20181114170319.24828-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114170319.24828-1-lvivier@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18111509-0028-0000-0000-0000031A403E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111509-0029-0000-0000-000023D6AFBE
Message-Id: <20181115091948.GA14462@dhcp-9-193-110-205.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-15_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150085
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
Reply-To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: Satheesh Rajendran <satheera@in.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 14, 2018 at 06:03:19PM +0100, Laurent Vivier wrote:
> Trying to hotplug a CPU on an empty NUMA node (without
> memory or CPU) crashes the kernel when the CPU is onlined.
> 
> During the onlining process, the kernel calls start_secondary()
> that ends by calling
> set_numa_mem(local_memory_node(numa_cpu_lookup_table[cpu]))
> that relies on NODE_DATA(nid)->node_zonelists and in our case
> NODE_DATA(nid) is NULL.
> 
> To fix that, add the same checking as we already have in
> find_and_online_cpu_nid(): if NODE_DATA() is NULL, use
> the first online node.
> 
> Bug: https://github.com/linuxppc/linux/issues/184
> Fixes: ea05ba7c559c8e5a5946c3a94a2a266e9a6680a6
>        (powerpc/numa: Ensure nodes initialized for hotplug)
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  arch/powerpc/mm/numa.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

This patch causes regression for cold plug numa case(Case 1) and 
hotplug case + reboot(Case 2) with adding all vcpus into node 0.


Env: HW: Power8 Host.
Kernel: 4.20-rc2 + this patch

Case 1:
1. boot a guest with 8 vcpus(all available), spreadout in 4 numa nodes.
<vcpu placement='static'>8</vcpu>
...
   <numa>
      <cell id='0' cpus='0-1' memory='4194304' unit='KiB'/>
      <cell id='1' cpus='2-3' memory='4194304' unit='KiB'/>
      <cell id='2' cpus='4-5' memory='0' unit='KiB'/>
      <cell id='3' cpus='6-7' memory='0' unit='KiB'/>
    </numa>

2. Check lscpu --- all vcpus are added to node0 --> NOK

# lscpu
Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              8
On-line CPU(s) list: 0-7
Thread(s) per core:  1
Core(s) per socket:  8
Socket(s):           1
NUMA node(s):        4
Model:               2.1 (pvr 004b 0201)
Model name:          POWER8 (architected), altivec supported
Hypervisor vendor:   KVM
Virtualization type: para
L1d cache:           64K
L1i cache:           32K
NUMA node0 CPU(s):   0-7
NUMA node1 CPU(s):   
NUMA node2 CPU(s):   
NUMA node3 CPU(s): 

without this patch it was working fine.
# lscpu
Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              8
On-line CPU(s) list: 0-7
Thread(s) per core:  1
Core(s) per socket:  8
Socket(s):           1
NUMA node(s):        4
Model:               2.1 (pvr 004b 0201)
Model name:          POWER8 (architected), altivec supported
Hypervisor vendor:   KVM
Virtualization type: para
L1d cache:           64K
L1i cache:           32K
NUMA node0 CPU(s):   0,1
NUMA node1 CPU(s):   2,3
NUMA node2 CPU(s):   4,5
NUMA node3 CPU(s):   6,7


Case 2:
1. boot a guest with 8 vcpus(2 available, 6 possible), spreadout in 4 numa nodes.
<vcpu placement='static' current='2'>8</vcpu>
...
   <numa>
      <cell id='0' cpus='0-1' memory='0' unit='KiB'/>
      <cell id='1' cpus='2-3' memory='4194304' unit='KiB'/>
      <cell id='2' cpus='4-5' memory='0' unit='KiB'/>
      <cell id='3' cpus='6-7' memory='0' unit='KiB'/>
    </numa>

2. Hotplug all vcpus
# lscpu
Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              8
On-line CPU(s) list: 0-7
Thread(s) per core:  1
Core(s) per socket:  8
Socket(s):           1
NUMA node(s):        2
Model:               2.1 (pvr 004b 0201)
Model name:          POWER8 (architected), altivec supported
Hypervisor vendor:   KVM
Virtualization type: para
L1d cache:           64K
L1i cache:           32K
NUMA node0 CPU(s):   0,1,4-7
NUMA node1 CPU(s):   2,3


3. reboot the guest
# lscpu
Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              8
On-line CPU(s) list: 0-7
Thread(s) per core:  1
Core(s) per socket:  8
Socket(s):           1
NUMA node(s):        4
Model:               2.1 (pvr 004b 0201)
Model name:          POWER8 (architected), altivec supported
Hypervisor vendor:   KVM
Virtualization type: para
L1d cache:           64K
L1i cache:           32K
NUMA node0 CPU(s):   0-7
NUMA node1 CPU(s):
NUMA node2 CPU(s):
NUMA node3 CPU(s):


Without this patch, Case 2 crashes the guest during hotplug, i.e
issue reported in https://github.com/linuxppc/linux/issues/184

Regards,
-Satheesh.

> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 3a048e98a132..1b2d25a3c984 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -483,6 +483,15 @@ static int numa_setup_cpu(unsigned long lcpu)
>  	if (nid < 0 || !node_possible(nid))
>  		nid = first_online_node;
> 
> +	if (NODE_DATA(nid) == NULL) {
> +		/*
> +		 * Default to using the nearest node that has memory installed.
> +		 * Otherwise, it would be necessary to patch the kernel MM code
> +		 * to deal with more memoryless-node error conditions.
> +		 */
> +		nid = first_online_node;
> +	}
> +
>  	map_cpu_to_node(lcpu, nid);
>  	of_node_put(cpu);
>  out:
> -- 
> 2.17.2
> 

