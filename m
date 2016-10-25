Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3Sr41w9LzDvRh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 09:44:04 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9PMi0uI058005
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 18:44:02 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26a8bva3xp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 18:44:01 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 25 Oct 2016 16:44:00 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D18521FF0025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 16:43:38 -0600 (MDT)
Subject: Re: [PATCH V6 7/8] powerpc: Check arch.vec earlier during boot for
 memory features
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <d6614f82-0c59-8457-188a-3f6dcaa92bb3@linux.vnet.ibm.com>
 <e26f1b5e-7f14-3915-12fe-2057a25eba77@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Tue, 25 Oct 2016 17:43:58 -0500
MIME-Version: 1.0
In-Reply-To: <e26f1b5e-7f14-3915-12fe-2057a25eba77@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <44260e88-ae05-7ce8-d596-9434479adf6a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

:
> On 09/21/2016 09:17 AM, Michael Bringmann wrote:
>> architecture.vec5 features: The boot-time memory management needs to
>> know the form of the "ibm,dynamic-memory-v2" property early during
>> scanning of the flattened device tree.  This patch moves execution of
>> the function pseries_probe_fw_features() early enough to be before
>> the scanning of the memory properties in the device tree to allow
>> recognition of the supported properties.
>>
>> [V2: No change]
>> [V3: Updated after commit 3808a88985b4f5f5e947c364debce4441a380fb8.]
>> [V4: Update comments]
>> [V5: Resynchronize/resubmit]
>> [V6: Resync to v4.7 kernel code]
>>
>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> ---
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index 946e34f..2034edc 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -753,6 +753,9 @@ void __init early_init_devtree(void *params)
>>  	 */
>>  	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
>>
>> +	/* Now try to figure out if we are running on LPAR and so on */
>> +	pseries_probe_fw_features();
>> +
> 
> I'll have to defer to others on whether calling this earlier in boot
> is ok.

It is scanning the flattened device tree supplied by the BMC, though this
is not the first such call to do so.  The relevant content of the device
tree should not change between the earlier point of the relocated point,
and the later point of the former location.

> I do notice that you do not remove the call later on, any reason?

Bug in patch.  Corrected in next patch group submission.

> -Nathan
> 
>>  	/* Scan memory nodes and rebuild MEMBLOCKs */
>>  	of_scan_flat_dt(early_init_dt_scan_root, NULL);
>>  	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
>>
> 
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
