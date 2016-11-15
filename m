Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJJPv42KLzDvkR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 07:09:23 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAFK3oP4125192
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 15:09:21 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26r4c4wfp5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 15:09:21 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 15 Nov 2016 15:09:20 -0500
Subject: Re: [PATCH v6 3/3] powerpc/pseries: Implement indexed-count hotplug
 memory remove
To: Michael Roth <mdroth@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20161018171803.37287.54834.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <20161018172053.37287.78128.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <20161115005846.31168.3522@loki>
Cc: sahilmehta17@gmail.com
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 15 Nov 2016 14:09:16 -0600
MIME-Version: 1.0
In-Reply-To: <20161115005846.31168.3522@loki>
Content-Type: text/plain; charset=utf-8
Message-Id: <a469ca98-d499-76a2-5b7c-1bb9e0446419@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/14/2016 06:58 PM, Michael Roth wrote:
> Quoting Nathan Fontenot (2016-10-18 12:21:06)
>> From: Sahil Mehta <sahilmehta17@gmail.com>
>>
>> Indexed-count remove for memory hotplug guarantees that a contiguous block
>> of <count> lmbs beginning at a specified <index> will be unassigned (NOT
>> that <count> lmbs will be removed). Because of Qemu's per-DIMM memory
>> management, the removal of a contiguous block of memory currently
>> requires a series of individual calls. Indexed-count remove reduces
>> this series into a single call.
>>
>> Signed-off-by: Sahil Mehta <sahilmehta17@gmail.com>
>> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>> ---
>> v2:     -use u32s drc_index and count instead of u32 ic[]
>>          in dlpar_memory
>> v3:     -add logic to handle invalid drc_index input
>> v4:     -none
>> v5:     -Update for() loop to start at start_index
>> v6:     -none
>>
>>  arch/powerpc/platforms/pseries/hotplug-memory.c |   90 +++++++++++++++++++++++
>>  1 file changed, 90 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> index badc66d..19ad081 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> @@ -558,6 +558,92 @@ static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
>>         return rc;
>>  }
>>
>> +static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index,
>> +                                    struct property *prop)
>> +{
>> +       struct of_drconf_cell *lmbs;
>> +       u32 num_lmbs, *p;
>> +       int i, rc, start_lmb_found;
>> +       int lmbs_available = 0, start_index = 0, end_index;
>> +
>> +       pr_info("Attempting to hot-remove %u LMB(s) at %x\n",
>> +               lmbs_to_remove, drc_index);
>> +
>> +       if (lmbs_to_remove == 0)
>> +               return -EINVAL;
>> +
>> +       p = prop->value;
>> +       num_lmbs = *p++;
>> +       lmbs = (struct of_drconf_cell *)p;
>> +       start_lmb_found = 0;
>> +
>> +       /* Navigate to drc_index */
>> +       while (start_index < num_lmbs) {
>> +               if (lmbs[start_index].drc_index == drc_index) {
>> +                       start_lmb_found = 1;
>> +                       break;
>> +               }
>> +
>> +               start_index++;
>> +       }
>> +
>> +       if (!start_lmb_found)
>> +               return -EINVAL;
>> +
>> +       end_index = start_index + lmbs_to_remove;
>> +
>> +       /* Validate that there are enough LMBs to satisfy the request */
>> +       for (i = start_index; i < end_index; i++) {
>> +               if (lmbs[i].flags & DRCONF_MEM_RESERVED)
>> +                       break;
>> +
>> +               lmbs_available++;
>> +       }
>> +
>> +       if (lmbs_available < lmbs_to_remove)
>> +               return -EINVAL;
>> +
>> +       for (i = start_index; i < end_index; i++) {
>> +               if (!(lmbs[i].flags & DRCONF_MEM_ASSIGNED))
>> +                       continue;
>> +
>> +               rc = dlpar_remove_lmb(&lmbs[i]);
> 
> dlpar_remove_lmb() currently does both offlining of the memory as well
> as releasing the LMB back to the platform, but the specification for
> hotplug notifications has the following verbage regarding
> indexed-count/count identifiers:
> 
> 'When using “drc count” or “drc count indexed” as the Hotplug Identifier,
> the OS should take steps to verify the entirety of the request can be
> satisfied before proceeding with the hotplug / unplug operations. If
> only a partial count can be satisfied, the OS should ignore the entirety
> of the request. If the OS cannot determine this beforehand, it should
> satisfy the hotplug / unplug request for as many of the requested
> resources as possible, and attempt to revert to the original OS / DRC
> state.'
> 
> So doing the dlpar_remove->dlapr_add in case of failure is in line with
> the spec, but it should only be done as a last-resort. To me that
> suggests that we should be attempting to offline all the LMBs
> beforehand, and only after that's successful should we begin attempting
> to release LMBs back to the platform. Should we consider introducing
> that logic in the patchset? Or maybe as a follow-up?

Introducing it as a pre-cursor to this patch set may be best.

I'll send patches that split the dlpar_remove_lmb into a remove routine
that does the hotplug remove of the memory from the kernel and a new
dlpare_release_lmb routine that releases the drc-index and updates the
device tree. Plus a patch to make dlpar_add_lmb symmetrical.

-Nathan 

> 
>> +               if (rc)
>> +                       break;
>> +
>> +               lmbs[i].reserved = 1;
>> +       }
>> +
>> +       if (rc) {
>> +               pr_err("Memory indexed-count-remove failed, adding any removed LMBs\n");
>> +
>> +               for (i = start_index; i < end_index; i++) {
>> +                       if (!lmbs[i].reserved)
>> +                               continue;
>> +
>> +                       rc = dlpar_add_lmb(&lmbs[i]);
>> +                       if (rc)
>> +                               pr_err("Failed to add LMB, drc index %x\n",
>> +                                      be32_to_cpu(lmbs[i].drc_index));
>> +
>> +                       lmbs[i].reserved = 0;
>> +               }
>> +               rc = -EINVAL;
>> +       } else {
>> +               for (i = start_index; i < end_index; i++) {
>> +                       if (!lmbs[i].reserved)
>> +                               continue;
>> +
>> +                       pr_info("Memory at %llx (drc index %x) was hot-removed\n",
>> +                               lmbs[i].base_addr, lmbs[i].drc_index);
>> +
>> +                       lmbs[i].reserved = 0;
>> +               }
>> +       }
>> +
>> +       return rc;
>> +}
>> +
>>  #else
>>  static inline int pseries_remove_memblock(unsigned long base,
>>                                           unsigned int memblock_size)
>> @@ -853,6 +939,10 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>>                 } else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX) {
>>                         drc_index = hp_elog->_drc_u.drc_index;
>>                         rc = dlpar_memory_remove_by_index(drc_index, prop);
>> +               } else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_IC) {
>> +                       count = hp_elog->_drc_u.indexed_count[0];
>> +                       drc_index = hp_elog->_drc_u.indexed_count[1];
>> +                       rc = dlpar_memory_remove_by_ic(count, drc_index, prop);
>>                 } else {
>>                         rc = -EINVAL;
>>                 }
>>
