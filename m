Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd7lD4JT5zDrKB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 04:38:48 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAGHcWGp119376
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 12:38:45 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e9ec135sh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 12:38:39 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 16 Nov 2017 10:37:23 -0700
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 vAGHbLxC8782100
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 10:37:21 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C19C6E044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 10:37:21 -0700 (MST)
Received: from oc2832402873.ibm.com (unknown [9.53.92.243])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id D6FC26E03A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 10:37:20 -0700 (MST)
Subject: Re: RESEND [PATCH V3 1/4] powerpc/firmware: Add definitions for new
 drc-info firmware feature
To: linuxppc-dev@lists.ozlabs.org
References: <49f1f381-749b-2513-fa81-2c508bed47ac@linux.vnet.ibm.com>
 <df114380-88b7-65c0-bf00-7f8ae8f7e8d2@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 11:37:20 -0600
MIME-Version: 1.0
In-Reply-To: <df114380-88b7-65c0-bf00-7f8ae8f7e8d2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <2de76963-c62b-fbc9-b8eb-0715659030a9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/16/2017 11:06 AM, Nathan Fontenot wrote:
> On 11/15/2017 12:09 PM, Michael Bringmann wrote:
>> Firmware Features: Define new bit flag representing the presence of
>> new device tree property "ibm,drc-info".  The flag is used to tell
>> the front end processor whether the Linux kernel supports the new
>> property, and by the front end processor to tell the Linux kernel
>> that the new property is present in the device tree.
> 
> This patch seems to be adding a bit for the drc-info feature so that
> we can use the firmware_has_feature() interface to determine if the
> device tree has the new ibm,drc-info properties.
> 
> I'm not sure what front-end processor you're referring to? Is this
> in reference to the architecture vector that is exchanged with firmware?

I was trying to be generic instead of writing pHyp, BMC, or other.
We can change the comment if it is misleading.

> 
> -Nathan
> 
>>
>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/firmware.h       |    3 ++-
>>  arch/powerpc/include/asm/prom.h           |    1 +
>>  arch/powerpc/platforms/pseries/firmware.c |    1 +
>>  3 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
>> index 8645897..329d537 100644
>> --- a/arch/powerpc/include/asm/firmware.h
>> +++ b/arch/powerpc/include/asm/firmware.h
>> @@ -51,6 +51,7 @@
>>  #define FW_FEATURE_BEST_ENERGY	ASM_CONST(0x0000000080000000)
>>  #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
>>  #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
>> +#define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000400000000)
>>
>>  #ifndef __ASSEMBLY__
>>
>> @@ -67,7 +68,7 @@ enum {
>>  		FW_FEATURE_CMO | FW_FEATURE_VPHN | FW_FEATURE_XCMO |
>>  		FW_FEATURE_SET_MODE | FW_FEATURE_BEST_ENERGY |
>>  		FW_FEATURE_TYPE1_AFFINITY | FW_FEATURE_PRRN |
>> -		FW_FEATURE_HPT_RESIZE,
>> +		FW_FEATURE_HPT_RESIZE | FW_FEATURE_DRC_INFO,
>>  	FW_FEATURE_PSERIES_ALWAYS = 0,
>>  	FW_FEATURE_POWERNV_POSSIBLE = FW_FEATURE_OPAL,
>>  	FW_FEATURE_POWERNV_ALWAYS = 0,
>> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
>> index 825bd59..3243455 100644
>> --- a/arch/powerpc/include/asm/prom.h
>> +++ b/arch/powerpc/include/asm/prom.h
>> @@ -175,6 +175,7 @@ struct of_drconf_cell {
>>  #define OV5_HASH_GTSE		0x1940	/* Guest Translation Shoot Down Avail */
>>  /* Radix Table Extensions */
>>  #define OV5_RADIX_GTSE		0x1A40	/* Guest Translation Shoot Down Avail */
>> +#define OV5_DRC_INFO		0x1640	/* Redef Prop Structures: drc-info   */
>>
>>  /* Option Vector 6: IBM PAPR hints */
>>  #define OV6_LINUX		0x02	/* Linux is our OS */
>> diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
>> index 63cc82a..757d757 100644
>> --- a/arch/powerpc/platforms/pseries/firmware.c
>> +++ b/arch/powerpc/platforms/pseries/firmware.c
>> @@ -114,6 +114,7 @@ struct vec5_fw_feature {
>>  vec5_fw_features_table[] = {
>>  	{FW_FEATURE_TYPE1_AFFINITY,	OV5_TYPE1_AFFINITY},
>>  	{FW_FEATURE_PRRN,		OV5_PRRN},
>> +	{FW_FEATURE_DRC_INFO,		OV5_DRC_INFO},
>>  };
>>
>>  static void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
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
