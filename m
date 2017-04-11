Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2Lby2QzCzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 19:00:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARN @lib/refcount.c:128 during hot unplug of I/O adapter.
In-Reply-To: <89aec36c-e352-e055-5e80-1235449762ce@linux.vnet.ibm.com>
References: <E5B3D5CE-EB6A-4470-B7E9-4F6F7B029809@linux.vnet.ibm.com>
 <a7a782f2-3783-fd96-eda9-1c7634b2a2e5@linux.vnet.ibm.com>
 <8760ig983f.fsf@concordia.ellerman.id.au>
 <89aec36c-e352-e055-5e80-1235449762ce@linux.vnet.ibm.com>
Date: Tue, 11 Apr 2017 19:00:08 +1000
Message-ID: <871sszwc87.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:

> On 04/06/2017 09:04 PM, Michael Ellerman wrote:
>> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
>> 
>>> On 04/06/2017 03:27 AM, Sachin Sant wrote:
>>>> On a POWER8 LPAR running 4.11.0-rc5, a hot unplug operation on
>>>> any I/O adapter results in the following warning
>>>>
>>>> This problem has been in the code for some time now. I had first seen this in
>>>> -next tree.
>>>>
>
> <snip>
>
>>>> Have attached the dmesg log from the system. Let me know if any additional
>>>> information is required to help debug this problem.
>>>
>>> I remember you mentioning this when the issue was brought up for CPUs. I
>>> assume the case is the same here where the issue is only seen with
>>> adapters that were hot-added after boot (ie. hot-remove of adapter
>>> present at boot doesn't trip the warning)?
>> 
>> So who's fixing this?
>
> I started looking at it when Bharata submitted a patch trying to fix the
> issue for CPUs, but got side tracked by other things. I suspect that
> this underflow has actually been an issue for quite some time, and we
> are just now becoming aware of it thanks to the recount_t patchset being
> merged.

Yes I agree. Which means it might be broken in existing distros.

> I'll look into it again this week.

Thanks.

cheers
