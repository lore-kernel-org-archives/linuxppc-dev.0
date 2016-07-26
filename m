Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz7p82pNFzDqZw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 16:42:08 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6Q6XjqJ016226
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 02:42:06 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24dvp6jaj4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 02:42:06 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 12:12:03 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 16F601258066
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 12:14:54 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6Q6frIL37093584
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 12:11:54 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6Q6fo4d012676
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 12:11:53 +0530
Subject: Re: [RFC PATCH 9/9] powerpc: rewrite local_t using soft_irq
To: Nicholas Piggin <npiggin@gmail.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469458342-26233-10-git-send-email-maddy@linux.vnet.ibm.com>
 <20160726155301.568771d8@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 26 Jul 2016 12:11:48 +0530
MIME-Version: 1.0
In-Reply-To: <20160726155301.568771d8@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3267ff1c-b8dd-8c28-8d3e-c5be67e31838@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 26 July 2016 11:23 AM, Nicholas Piggin wrote:
> On Mon, 25 Jul 2016 20:22:22 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> https://lkml.org/lkml/2008/12/16/450
>>
>> Modifications to Rusty's benchmark code:
>>   - Executed only local_t test
>>
>> Here are the values with the patch.
>>
>> Time in ns per iteration
>>
>> Local_t		Without Patch		With Patch
>>
>> _inc			28		8
>> _add			28		8
>> _read			3		3
>> _add_return		28		7
>>
>> Tested the patch in a
>>   - pSeries LPAR (with perf record)
> Very nice. I'd like to see these patches get in. We can
> probably use the feature in other places too.

Thanks for review.

Maddy

> Thanks,
> Nick
>
