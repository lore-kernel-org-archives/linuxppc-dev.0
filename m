Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rSjpZ1vlnzDqZ6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 16:40:54 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5D6dfg1147439
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 02:40:51 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23gc8vp0rp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 02:40:51 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Mon, 13 Jun 2016 12:10:47 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2CC72E005F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 12:14:19 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5D6e8Lt21430746
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 12:10:08 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5D6ee1e006968
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 12:10:42 +0530
Date: Mon, 13 Jun 2016 14:40:32 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
CC: Andrzej Hajda <a.hajda@samsung.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, tglx@linutronix.de,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc/nvram: Fix an incorrect partition merge
References: <3rLj4P6Swcz9t6B@ozlabs.org> <57550AB2.8090500@linux.vnet.ibm.com>
 <1465299544.16285.3.camel@ellerman.id.au>
In-Reply-To: <1465299544.16285.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <575E5560.5000307@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2016年06月07日 19:39, Michael Ellerman wrote:
> On Mon, 2016-06-06 at 13:31 +0800, xinhui wrote:
>> On 2016年06月03日 19:47, Michael Ellerman wrote:
>>> On Thu, 2015-10-12 at 07:30:02 UTC, xinhui wrote:
>>>> From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>>>>
>>>> When we merge two contiguous partitions whose signatures are marked
>>>> NVRAM_SIG_FREE, We need update prev's length and checksum, then write it
>>>> to nvram, not cur's. So lets fix this mistake now.
>>>>
>>>> Also use memset instead of strncpy to set the partition's name. It's
>>>> more readable if we want to fill up with duplicate chars .
>>>
>>> Does this ever happen in practice? ie. should we backport the fix to stable
>>> kernels?
>>
>> I did not see that nvram warning in practice. BUT I suggest to backport it to stable kernel. :)
>>
>> Let me recall the story. :)
>> In past days, I was using pstore to keep some kernel logs. and sometimes I found my own logs and the panic logs did not show.
>> pstore use a fixed-address reserved memory In x86 while nvram instead in ppc.
>>
>> Then I spent some days to review the nvram codes.
>> And worked out three patches to fix all issues that I found in nvram. BUT looks like I only sent out two of them. :)
>> I lost the third patch maybe...
>
> OK.
>
>>> Has it always been broken?
>>
>> no. after nvram partition corruption hit, all nvram partitions will be erased and re-alloc after the second machine reboot.
>> I don't know who does it but i guess it is the firmware. :)
>
> Actually I meant has the code always contained the bug, or was it added recently.
>
fix fa2b4e54d41f3c9f1bee6a7d63ecd4f0ab161e89 ("powerpc/nvram: Improve partition removal")
and it is from Ben.

So cc Ben :)
> cheers
>
