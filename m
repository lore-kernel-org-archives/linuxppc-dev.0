Return-Path: <srs0=fawz=iz=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411rgk6KXnzF0TM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 02:33:06 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 411rgk5ZTlz98rC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 02:33:06 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 411rgk23hRz9s1B
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2018 02:33:05 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w57GTagp050088
 for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2018 12:33:04 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jf5q18nty-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 07 Jun 2018 12:33:04 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 7 Jun 2018 17:33:02 +0100
Subject: Re: [v2 PATCH 0/5] powerpc/pseries: Machien check handler
 improvements.
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <152836568375.29173.3046879842311381046.stgit@jupiter.in.ibm.com>
 <20180607204554.05565a56@roar.ozlabs.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 7 Jun 2018 22:02:58 +0530
MIME-Version: 1.0
In-Reply-To: <20180607204554.05565a56@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <8c6bf4dd-b6f9-ec76-d4b2-7f45e37b77ff@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/07/2018 04:15 PM, Nicholas Piggin wrote:
> On Thu, 07 Jun 2018 15:36:25 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
>> This patch series includes some improvement to Machine check handler
>> for pseries. Patch 1 fixes an issue where machine check handler crashes
>> kernel while accessing vmalloc-ed buffer while in nmi context.
>> Patch 3 dumps the SLB contents on SLB MCE errors to improve the debugability.
>> Patch 4 display's the MCE error details on console.
>>
>> Change in V2:
>> - patch 4: Display additional info (NIP and task info) in MCE error details.
>> - patch 5: Fix endain bug while restoring of r3 in MCE handler.
>>
>> ---
>>
>> Mahesh Salgaonkar (5):
>>       powerpc/pseries: convert rtas_log_buf to linear allocation.
>>       powerpc/pseries: Define MCE error event section.
>>       powerpc/pseries: Dump and flush SLB contents on SLB MCE errors.
>>       powerpc/pseries: Display machine check error details.
>>       powerpc/pseries: Fix endainness while restoring of r3 in MCE handler.
> 
> These look good, should patch 5 be moved to patch 2 and the first 2
> patches marked for stable?

Yup. Will move patch 5 to 2nd position.

> 
> Do you also plan to dump SLB contents for bare metal MCEs?

Yes. That's the plan. Will do that separately.

Thanks,
-Mahesh.
