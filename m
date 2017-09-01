Return-Path: <srs0=2ieg=ac=linux.vnet.ibm.com=bharata@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xk91g3KRGzDqk7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 16:53:27 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xk91g1v1Xz8vSj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 16:53:27 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xk91f4k68z9s83
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Sep 2017 16:53:26 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v816rIla032017
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Sep 2017 02:53:24 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cq2fc91c7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 01 Sep 2017 02:53:24 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Fri, 1 Sep 2017 16:53:21 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v816rJDL41353460
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Sep 2017 16:53:19 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v816rA1G025714
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Sep 2017 16:53:10 +1000
Date: Fri, 1 Sep 2017 12:23:13 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: nfont@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 arbab@linux.vnet.ibm.com
Subject: Re: [FIX PATCH v0] powerpc: Fix memory unplug failure on radix guest
Reply-To: bharata@linux.vnet.ibm.com
References: <1502357028-27465-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502357028-27465-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <20170901065313.GA3093@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 10, 2017 at 02:53:48PM +0530, Bharata B Rao wrote:
> For a PowerKVM guest, it is possible to specify a DIMM device in
> addition to the system RAM at boot time. When such a cold plugged DIMM
> device is removed from a radix guest, we hit the following warning in the
> guest kernel resulting in the eventual failure of memory unplug:
> 
> remove_pud_table: unaligned range
> WARNING: CPU: 3 PID: 164 at arch/powerpc/mm/pgtable-radix.c:597 remove_pagetable+0x468/0xca0
> Call Trace:
> remove_pagetable+0x464/0xca0 (unreliable)
> radix__remove_section_mapping+0x24/0x40
> remove_section_mapping+0x28/0x60
> arch_remove_memory+0xcc/0x120
> remove_memory+0x1ac/0x270
> dlpar_remove_lmb+0x1ac/0x210
> dlpar_memory+0xbc4/0xeb0
> pseries_hp_work_fn+0x1a4/0x230
> process_one_work+0x1cc/0x660
> worker_thread+0xac/0x6d0
> kthread+0x16c/0x1b0
> ret_from_kernel_thread+0x5c/0x74
> 
> The DIMM memory that is cold plugged gets merged to the same memblock
> region as RAM and hence gets mapped at 1G alignment. However since the
> removal is done for one LMB (lmb size 256MB) at a time, the address
> of the LMB (which is 256MB aligned) would get flagged as unaligned
> in remove_pud_table() resulting in the above failure.
> 
> This problem is not seen for hot plugged memory because for the
> hot plugged memory, the mappings are created separately for each
> LMB and hence they all get aligned at 256MB.
> 
> To fix this problem for the cold plugged memory, let us mark the
> cold plugged memblock region explicitly as HOTPLUGGED so that the
> region doesn't get merged with RAM. All the memory that is discovered
> via ibm,dynamic-memory-configuration is marked so(1). Next identify
> such regions in radix_init_pgtable() and create separate mappings
> within that region for each LMB so that they get don't get aligned
> like RAM region at 1G (2).
> 
> (1) For PowerKVM guests, all boot time memory is represented via
> memory@XXXX nodes and hot plugged/pluggable memory is represented via
> ibm,dynamic-memory-reconfiguration property. We are marking all
> hotplugged memory that is in ASSIGNED state during boot as HOTPLUGGED.
> With this only cold plugged memory gets marked for PowerKVM but
> need to check how this will affect PowerVM guests.
> 
> (2) To create separate mappings for every LMB in the hot plugged
> region, we need lmb-size. I am currently using memory_block_size_bytes()
> API to get the lmb-size. Since this is early init time code, the
> machine type isn't probed yet and hence memory_block_size_bytes()
> would return the default LMB size as 16MB. Hence we end up creating
> separate mappings at much lower granularity than what we can ideally
> do for pseries machine.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/prom.c      |  1 +
>  arch/powerpc/mm/pgtable-radix.c | 17 ++++++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index f830562..24ecf53 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -524,6 +524,7 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
>  					size = 0x80000000ul - base;
>  			}
>  			memblock_add(base, size);
> +			memblock_mark_hotplug(base, size);

One of the suggestions was to make the above conditional to radix so
that PowerVM doesn't get affected by this. However early_radix_enabled()
check isn't usable yet at this point and MMU_FTR_TYPE_RADIX will get set
only a bit later in early_init_devtree().

Regards,
Bharata.
