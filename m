Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lwYP26VVzF0WK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 01:39:37 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w78Fd9Bb107116
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Aug 2018 11:39:35 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kr1evnseu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Aug 2018 11:39:34 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 8 Aug 2018 11:39:33 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w78FdUuc11796880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Aug 2018 15:39:30 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DF4F28066
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 11:38:18 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FA3928064
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 11:38:18 -0400 (EDT)
Received: from oc5000245537.ibm.com (unknown [9.85.216.127])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 11:38:18 -0400 (EDT)
Subject: Re: [PATCH v02] powerpc/mobility: Fix node detach/rename problem
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
References: <b3f658d9-efc5-e532-e8d4-162494b88194@linux.vnet.ibm.com>
 <87zhxx9cs7.fsf@concordia.ellerman.id.au>
 <19f9e274-26ae-2ae5-de9f-c0fcd6c00570@linux.vnet.ibm.com>
Date: Wed, 8 Aug 2018 10:39:28 -0500
MIME-Version: 1.0
In-Reply-To: <19f9e274-26ae-2ae5-de9f-c0fcd6c00570@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <aad5c2e9-eb7c-6c09-c539-2f3431a1ee71@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I will update the header files 'of_private.h' and 'of.h' and repost.

Michael

On 08/08/2018 10:37 AM, Michael Bringmann wrote:
> On 08/08/2018 09:02 AM, Michael Ellerman wrote:
>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>>> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
>>> index e245a88..efc9442 100644
>>> --- a/arch/powerpc/platforms/pseries/mobility.c
>>> +++ b/arch/powerpc/platforms/pseries/mobility.c
>>> @@ -22,6 +22,9 @@
>>>  #include <asm/rtas.h>
>>>  #include "pseries.h"
>>>  
>>> +extern int of_free_phandle_cache(void);
>>> +extern void of_populate_phandle_cache(void);
>>
>> We don't do that, they should be in a header.
>>
>> But that's a minor problem given that the patch doesn't compile, because
>> both those functions are static.
> 
> I am building against the latest 'linux-ppc' kernel.  It includes patch
> 
> Commit b9952b5218added5577e4a3443969bc20884cea9 Mon Sep 17 00:00:00 2001
> From: Frank Rowand <frank.rowand@sony.com>
> Date: Thu, 12 Jul 2018 14:00:07 -0700
> Subject: of: overlay: update phandle cache on overlay apply and remove
> 
> which makes the functions static.  I will rebuild and test with an
> earlier version if you will specify which one.
> 
>>
>> Presumably you have a hack in your tree to make them non-static?
>> Please try and compile your patches in a clean tree before sending.
>>
>> cheers
> 
> Regards,
> Michael
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
