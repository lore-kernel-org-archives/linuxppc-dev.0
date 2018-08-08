Return-Path: <srs0=st7t=kx=linux.vnet.ibm.com=naveen.n.rao@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lvJ425YyzDr5r
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:43:00 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41lvJ33RpLz8tD9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:42:59 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41lvJ24zc3z9s3Z
 for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2018 00:42:58 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w78EeQX2087847
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2018 10:42:57 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kqyb81058-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 08 Aug 2018 10:42:56 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 8 Aug 2018 15:42:54 +0100
Date: Wed, 08 Aug 2018 20:12:47 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/64s: Make unrecoverable SLB miss less confusing
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: anton@samba.org, linuxppc-dev@ozlabs.org, paulus@samba.org
References: <20180726130151.16410-1-mpe@ellerman.id.au>
 <20180801121111.308ff705@roar.ozlabs.ibm.com>
 <87tvo59c1d.fsf@concordia.ellerman.id.au>
In-Reply-To: <87tvo59c1d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1533739262.go63i3r5vv.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>> On Thu, 26 Jul 2018 23:01:51 +1000
>> Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>>> If we take an SLB miss while MSR[RI]=3D0 we can't recover and have to
>>> oops. Currently this is reported by faking up a 0x4100 exception, eg:
>>>=20
>>>   Unrecoverable exception 4100 at 0
>>>   Oops: Unrecoverable exception, sig: 6 [#1]
>>>   ...
>>>   CPU: 0 PID: 1262 Comm: sh Not tainted 4.18.0-rc3-gcc-7.3.1-00098-g7fc=
2229fb2ab-dirty #9
>>>   NIP:  0000000000000000 LR: c00000000000b9e4 CTR: 00007fff8bb971b0
>>>   REGS: c0000000ee02bbb0 TRAP: 4100
>>>   ...
>>>   LR [c00000000000b9e4] system_call+0x5c/0x70
>>>=20
>>> The 0x4100 value was chosen back in 2004 as part of the fix for the
>>> "mega bug" - "ppc64: Fix SLB reload bug". Back then it was obvious
>>> that 0x4100 was not a real trap value, as the highest actual trap was
>>> less than 0x2000.
>>>=20
>>> Since then however the architecture has changed and now we have
>>> "virtual mode" or "relon" exceptions, in which exceptions can be
>>> delivered with the MMU on starting at 0x4000.
>>>=20
>>> At a glance 0x4100 looks like a virtual mode 0x100 exception, aka
>>> system reset exception. A close reading of the architecture will show
>>> that system reset exceptions can't be delivered in virtual mode, and
>>> so 0x4100 is not a valid trap number. But that's not immediately
>>> obvious. There's also nothing about 0x4100 that suggests SLB miss.
>>>=20
>>> So to make things a bit less confusing switch to a fake but unique and
>>> hopefully more helpful numbering. For data SLB misses we report a
>>> 0x390 trap and for instruction we report 0x490. Compared to 0x380 and
>>> 0x480 for the actual data & instruction SLB exceptions.
>>>=20
>>> Also add a C handler that prints a more explicit message. The end
>>> result is something like:
>>>=20
>>>   Oops: Unrecoverable SLB miss (MSR[RI]=3D0), sig: 6 [#3]
>>
>> This is all good, but allow me to nitpick. Our unrecoverable
>> exception messages (and other messages, but those) are becoming a bit
>> ad-hoc and messy.
>>
>> It would be nice to go the other way eventually and consolidate them
>> into one. Would be nice to have a common function that takes regs and
>> returns the string of the corresponding exception name that makes
>> these more readable.
>=20
> Yeah that's true, though some of them aren't simply a mapping from the
> trap number, eg. the kernel bad stack one.
>=20
> But in general our whole oops output, regs, stack trace etc. could use a
> revamp.
>=20
> I've been thinking of making the trap number more prominent and
> providing a text description, because apparently not everyone knows the
> trap numbers by heart :)

Yes please, guilty as charged :)
https://patchwork.ozlabs.org/patch/899980/

Thanks,
Naveen

=
