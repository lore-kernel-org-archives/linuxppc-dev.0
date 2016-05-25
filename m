Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDyjF2VpLzDqW4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 13:40:33 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4P2BcYh015326
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 22:12:30 -0400
Message-Id: <201605250212.u4P2BcYh015326@mx0a-001b2d01.pphosted.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 234qhw4xe6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 22:12:29 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 25 May 2016 07:42:26 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B31E1394005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 07:42:23 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4P2CDWO23396742
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 07:42:13 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4P2CMVJ016661
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 07:42:23 +0530
Date: Wed, 25 May 2016 07:42:17 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au
CC: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org, ego@linux.vnet.ibm.com
Subject: Re: [PATCH v3 7/9] powerpc/powernv: Add platform support for stop
 instruction
References: <1464016722-7488-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464016722-7488-8-git-send-email-shreyas@linux.vnet.ibm.com>
 <886163be-b915-b60f-b25b-bf770f3ed821@linux.vnet.ibm.com>
In-Reply-To: <886163be-b915-b60f-b25b-bf770f3ed821@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/24/2016 02:17 PM, Madhavan Srinivasan wrote:
> 
> 
> On Monday 23 May 2016 08:48 PM, Shreyas B. Prabhu wrote:
>> POWER ISA v3 defines a new idle processor core mechanism. In summary,
>>  a) new instruction named stop is added. This instruction replaces
>> 	instructions like nap, sleep, rvwinkle.
>>  b) new per thread SPR named PSSCR is added which controls the behavior
>> 	of stop instruction.
> 
> Kindly expand the register name at first use like
> Processor Stop Status and Control Register (PSSCR)
> 
>>
>> PSSCR has following key fields
> 
> Having the PSSCR layout here will help? something like this
> 
> ----------------------------------------------------------
> | PLS | /// | SD | ESL | EC | PSLL | /// | TR | MTL | RL |
> ----------------------------------------------------------
> 0      4     41   42    43   44     48    54   56    60  
> 
>> 	Bits 0:3  - Power-Saving Level Status. This field indicates the lowest
>> 	power-saving state the thread entered since stop instruction was last
>> 	executed.
>>
>> 	Bit 42 - Enable State Loss
>> 	0 - No state is lost irrespective of other fields
>> 	1 - Allows state loss
>>
>> 	Bits 44:47 - Power-Saving Level Limit
>> 	This limits the power-saving level that can be entered into.
>>
>> 	Bits 60:63 - Requested Level
>> 	Used to specify which power-saving level must be entered on executing
>> 	stop instruction
>>
>> This patch adds support for stop instruction and PSSCR handling.
>>
>> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
>> ---

Hi Madhavan,

Thanks for the review. I have incorporated your review comments in v4.


Thanks,
Shreyas
