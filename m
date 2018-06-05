Return-Path: <huntbag@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410Qbv4fYFzF1g3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 18:54:51 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w558s5F8057548
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jun 2018 04:54:48 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jdm0ggpv7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jun 2018 04:54:48 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <huntbag@linux.vnet.ibm.com>;
 Tue, 5 Jun 2018 09:54:47 +0100
Subject: Re: [PATCH v2] cpuidle/powernv : Add Description for cpuidle state
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, paulus@samba.org,
 mpe@ellerman.id.au, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stewart@linux.vnet.ibm.com
References: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
 <0a28154deb468669a59c120a90d4aedc1e1e705b.camel@kernel.crashing.org>
 <20180604114500.3rlpuso5aftesnf5@aksadiga.ibm>
From: Abhishek <huntbag@linux.vnet.ibm.com>
Date: Tue, 5 Jun 2018 14:24:39 +0530
MIME-Version: 1.0
In-Reply-To: <20180604114500.3rlpuso5aftesnf5@aksadiga.ibm>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <17cd53ec-6bc1-5814-8824-3c6a4f0b90cd@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/04/2018 05:15 PM, Akshay Adiga wrote:
> On Mon, Jun 04, 2018 at 07:04:14PM +1000, Benjamin Herrenschmidt wrote:
>> Is this a new property ? I'm not fan of adding yet another of those
>> silly arrays.
>>
>> I would say this is the right time now to switch over to a node per
>> state instead, as we discussed with Vaidy.

It is not a new property. Name was being used for description as 
description was not present in device tree. A skiboot patch adding 
description to device tree have been posted. This patch reads those 
description instead of copying name itself into description. And we fall 
back to reading name into description to not break the comaptibility 
with older firmware.

Thanks
Abhishek

> I posted  the node based device tree here :
> skiboot patch :  https://patchwork.ozlabs.org/patch/923120/
> kernel patch : https://lkml.org/lkml/2018/5/30/1146
>
> Do you have any inputs for this design ?
>
>> Additionally, while doing that, we can provide the versioning mechanism
>> I proposed so we can deal with state specific issues and erratas.
>>
>> Cheers,
>> Ben.
>>
