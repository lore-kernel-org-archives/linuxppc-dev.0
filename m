Return-Path: <srs0=ns3j=3t=gmail.com=turtle.in.the.kernel@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2YZk254VzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 03:14:54 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w2YZk0mz4z8sZm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 03:14:54 +1000 (AEST)
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w2YZj3kKXz9sNZ
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2017 03:14:53 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id r49so505821qta.1
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 10:14:53 -0700 (PDT)
Subject: Re: WARN @lib/refcount.c:128 during hot unplug of I/O adapter.
To: Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
References: <E5B3D5CE-EB6A-4470-B7E9-4F6F7B029809@linux.vnet.ibm.com>
 <a7a782f2-3783-fd96-eda9-1c7634b2a2e5@linux.vnet.ibm.com>
 <8760ig983f.fsf@concordia.ellerman.id.au>
 <89aec36c-e352-e055-5e80-1235449762ce@linux.vnet.ibm.com>
 <871sszwc87.fsf@concordia.ellerman.id.au>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <eadda997-6e55-5741-e306-0ac723e19393@gmail.com>
Date: Tue, 11 Apr 2017 10:14:49 -0700
MIME-Version: 1.0
In-Reply-To: <871sszwc87.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/11/2017 02:00 AM, Michael Ellerman wrote:
> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
> 
>> On 04/06/2017 09:04 PM, Michael Ellerman wrote:
>>> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
>>>
>>>> On 04/06/2017 03:27 AM, Sachin Sant wrote:
>>>>> On a POWER8 LPAR running 4.11.0-rc5, a hot unplug operation on
>>>>> any I/O adapter results in the following warning
>>>>>
>>>>> This problem has been in the code for some time now. I had first seen this in
>>>>> -next tree.
>>>>>
>>
>> <snip>
>>
>>>>> Have attached the dmesg log from the system. Let me know if any additional
>>>>> information is required to help debug this problem.
>>>>
>>>> I remember you mentioning this when the issue was brought up for CPUs. I
>>>> assume the case is the same here where the issue is only seen with
>>>> adapters that were hot-added after boot (ie. hot-remove of adapter
>>>> present at boot doesn't trip the warning)?
>>>
>>> So who's fixing this?
>>
>> I started looking at it when Bharata submitted a patch trying to fix the
>> issue for CPUs, but got side tracked by other things. I suspect that
>> this underflow has actually been an issue for quite some time, and we
>> are just now becoming aware of it thanks to the recount_t patchset being
>> merged.
> 
> Yes I agree. Which means it might be broken in existing distros.

Definitely. I did some profiling last night, and I understand the
hotplug case. It turns out to be as I suggested in the original thread
about CPUs. When the devicetree code was worked to move the tree out of
proc and into sysfs the sysfs detach code added a of_node_put to remove
the original of_init reference. pSeries Being the sole original
*dynamic* device tree user we had always issued a of_node_put in our
dlpar specific detach function to achieve that end. So, this should be a
pretty straight forward trivial fix.

However, for the case where devices are present at boot it appears we a
leaking a lot of references resulting in the device nodes never actually
being released/freed after a dlpar remove. In the CPU case after boot I
count 8 more references taken than the hotplug case, and corresponding
of_node_put's are not called at dlpar remove time either. That will take
some time to track them down, review and clean up.

-Tyrel

> 
>> I'll look into it again this week.
> 
> Thanks.
> 
> cheers
> 
