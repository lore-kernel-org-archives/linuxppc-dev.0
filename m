Return-Path: <srs0=ovw1=ac=linux.vnet.ibm.com=nfont@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkLl02PTgzDqhL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Sep 2017 00:11:24 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xkLl01lncz8t2N
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Sep 2017 00:11:24 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xkLkz5y18z9s7c
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Sep 2017 00:11:23 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v81E8spo057753
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Sep 2017 10:11:21 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cq6nf3u5j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 01 Sep 2017 10:11:21 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 1 Sep 2017 10:11:20 -0400
Subject: Re: [FIX PATCH v0] powerpc: Fix memory unplug failure on radix guest
To: bharata@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, arbab@linux.vnet.ibm.com
References: <1502357028-27465-1-git-send-email-bharata@linux.vnet.ibm.com>
 <20170901065313.GA3093@in.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Fri, 1 Sep 2017 09:11:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170901065313.GA3093@in.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <e9eb4fb9-79ea-118a-f2b6-5501556a1181@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/01/2017 01:53 AM, Bharata B Rao wrote:
> On Thu, Aug 10, 2017 at 02:53:48PM +0530, Bharata B Rao wrote:
>> For a PowerKVM guest, it is possible to specify a DIMM device in
>> addition to the system RAM at boot time. When such a cold plugged DIMM
>> device is removed from a radix guest, we hit the following warning in the
>> guest kernel resulting in the eventual failure of memory unplug:
>>
>> remove_pud_table: unaligned range
>> WARNING: CPU: 3 PID: 164 at arch/powerpc/mm/pgtable-radix.c:597 remove_pagetable+0x468/0xca0
>> Call Trace:
>> remove_pagetable+0x464/0xca0 (unreliable)
>> radix__remove_section_mapping+0x24/0x40
>> remove_section_mapping+0x28/0x60
>> arch_remove_memory+0xcc/0x120
>> remove_memory+0x1ac/0x270
>> dlpar_remove_lmb+0x1ac/0x210
>> dlpar_memory+0xbc4/0xeb0
>> pseries_hp_work_fn+0x1a4/0x230
>> process_one_work+0x1cc/0x660
>> worker_thread+0xac/0x6d0
>> kthread+0x16c/0x1b0
>> ret_from_kernel_thread+0x5c/0x74
>>
>> The DIMM memory that is cold plugged gets merged to the same memblock
>> region as RAM and hence gets mapped at 1G alignment. However since the
>> removal is done for one LMB (lmb size 256MB) at a time, the address
>> of the LMB (which is 256MB aligned) would get flagged as unaligned
>> in remove_pud_table() resulting in the above failure.
>>
>> This problem is not seen for hot plugged memory because for the
>> hot plugged memory, the mappings are created separately for each
>> LMB and hence they all get aligned at 256MB.
>>
>> To fix this problem for the cold plugged memory, let us mark the
>> cold plugged memblock region explicitly as HOTPLUGGED so that the
>> region doesn't get merged with RAM. All the memory that is discovered
>> via ibm,dynamic-memory-configuration is marked so(1). Next identify
>> such regions in radix_init_pgtable() and create separate mappings
>> within that region for each LMB so that they get don't get aligned
>> like RAM region at 1G (2).
>>
>> (1) For PowerKVM guests, all boot time memory is represented via
>> memory@XXXX nodes and hot plugged/pluggable memory is represented via
>> ibm,dynamic-memory-reconfiguration property. We are marking all
>> hotplugged memory that is in ASSIGNED state during boot as HOTPLUGGED.
>> With this only cold plugged memory gets marked for PowerKVM but
>> need to check how this will affect PowerVM guests.
>>
>> (2) To create separate mappings for every LMB in the hot plugged
>> region, we need lmb-size. I am currently using memory_block_size_bytes()
>> API to get the lmb-size. Since this is early init time code, the
>> machine type isn't probed yet and hence memory_block_size_bytes()
>> would return the default LMB size as 16MB. Hence we end up creating
>> separate mappings at much lower granularity than what we can ideally
>> do for pseries machine.
>>
>> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/prom.c      |  1 +
>>  arch/powerpc/mm/pgtable-radix.c | 17 ++++++++++++++---
>>  2 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index f830562..24ecf53 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -524,6 +524,7 @@ static int __init early_init_dt_scan_drconf_memory(unsigned long node)
>>  					size = 0x80000000ul - base;
>>  			}
>>  			memblock_add(base, size);
>> +			memblock_mark_hotplug(base, size);
> 
> One of the suggestions was to make the above conditional to radix so
> that PowerVM doesn't get affected by this. However early_radix_enabled()
> check isn't usable yet at this point and MMU_FTR_TYPE_RADIX will get set
> only a bit later in early_init_devtree().

We do walk the dynamic reconfiguration memory again in the numa code, see
parse_drconf_memory() in numa.c, would it far enough along in boot to use
early_radix_enabled() and mark the memory hotplug at this point?

This may not be the ideal place to mark hotplug memory for radix but it may
be nicer than adding another walk of the device tree property somewhere else.

-Nathan

> 
> Regards,
> Bharata.
> 
