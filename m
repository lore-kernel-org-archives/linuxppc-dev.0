Return-Path: <srs0=im6g=hm=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40V67K70nWzF25m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 23:02:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40V67K69KBz8tKv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 23:02:21 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40V67K2HMVz9rxs
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 23:02:21 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3NCxM0J077676
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 09:02:19 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hhddnf20w-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 09:02:12 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 23 Apr 2018 14:01:41 +0100
Subject: Re: [PATCH] powerpc/mce: Fix a bug where mce loops on memory UE.
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <152445952887.3244.567606806755236868.stgit@jupiter.in.ibm.com>
 <CAKTCnznTiS2kQThYrCALGGKb8DfAu-diYzrCbOzwO2vd7Cfw9Q@mail.gmail.com>
 <cb831682-8cc6-4cd7-9778-52e5f4ad5af0@linux.vnet.ibm.com>
 <CAKTCnzm=OAXmUp0g7YrR9wFoFwB3TS_LnQiwZPR6QgeKk6ExYQ@mail.gmail.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 23 Apr 2018 18:31:36 +0530
MIME-Version: 1.0
In-Reply-To: <CAKTCnzm=OAXmUp0g7YrR9wFoFwB3TS_LnQiwZPR6QgeKk6ExYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <fd0c6a0b-9fc8-3188-8421-b1a370a1dc61@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/23/2018 04:44 PM, Balbir Singh wrote:
> On Mon, Apr 23, 2018 at 8:33 PM, Mahesh Jagannath Salgaonkar
> <mahesh@linux.vnet.ibm.com> wrote:
>> On 04/23/2018 12:21 PM, Balbir Singh wrote:
>>> On Mon, Apr 23, 2018 at 2:59 PM, Mahesh J Salgaonkar
>>> <mahesh@linux.vnet.ibm.com> wrote:
>>>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>>>
>>>> The current code extracts the physical address for UE errors and then
>>>> hooks it up into memory failure infrastructure. On successful extraction
>>>> of physical address it wrongly sets "handled = 1" which means this UE error
>>>> has been recovered. Since MCE handler gets return value as handled = 1, it
>>>> assumes that error has been recovered and goes back to same NIP. This causes
>>>> MCE interrupt again and again in a loop leading to hard lockup.
>>>>
>>>> Also, initialize phys_addr to ULONG_MAX so that we don't end up queuing
>>>> undesired page to hwpoison.
>>>>
>>>> Without this patch we see:
>>>> [ 1476.541984] Severe Machine check interrupt [Recovered]
>>>> [ 1476.541985]   NIP: [000000001002588c] PID: 7109 Comm: find
>>>> [ 1476.541986]   Initiator: CPU
>>>> [ 1476.541987]   Error type: UE [Load/Store]
>>>> [ 1476.541988]     Effective address: 00007fffd2755940
>>>> [ 1476.541989]     Physical address:  000020181a080000
>>>> [...]
>>>> [ 1476.542003] Severe Machine check interrupt [Recovered]
>>>> [ 1476.542004]   NIP: [000000001002588c] PID: 7109 Comm: find
>>>> [ 1476.542005]   Initiator: CPU
>>>> [ 1476.542006]   Error type: UE [Load/Store]
>>>> [ 1476.542006]     Effective address: 00007fffd2755940
>>>> [ 1476.542007]     Physical address:  000020181a080000
>>>> [ 1476.542010] Severe Machine check interrupt [Recovered]
>>>> [ 1476.542012]   NIP: [000000001002588c] PID: 7109 Comm: find
>>>> [ 1476.542013]   Initiator: CPU
>>>> [ 1476.542014]   Error type: UE [Load/Store]
>>>> [ 1476.542015]     Effective address: 00007fffd2755940
>>>> [ 1476.542016]     Physical address:  000020181a080000
>>>> [ 1476.542448] Memory failure: 0x20181a08: recovery action for dirty LRU page: Recovered
>>>> [ 1476.542452] Memory failure: 0x20181a08: already hardware poisoned
>>>> [ 1476.542453] Memory failure: 0x20181a08: already hardware poisoned
>>>> [ 1476.542454] Memory failure: 0x20181a08: already hardware poisoned
>>>> [ 1476.542455] Memory failure: 0x20181a08: already hardware poisoned
>>>> [ 1476.542456] Memory failure: 0x20181a08: already hardware poisoned
>>>> [ 1476.542457] Memory failure: 0x20181a08: already hardware poisoned
>>>> [...]
>>>> [ 1490.972174] Watchdog CPU:38 Hard LOCKUP
>>>>
>>>> After this patch we see:
>>>>
>>>> [  325.384336] Severe Machine check interrupt [Not recovered]
>>>
>>> How did you test for this?
>>
>> By injecting cache SUE using L2 FIR register (0x1001080c).
>>
>>> If the error was recovered, shouldn't the
>>> process have gotten
>>> a SIGBUS and we should have prevented further access as a part of the handling
>>> (memory_failure()). Do we just need a MF_MUST_KILL in the flags?
>>
>> We hook it up to memory_failure() through a work queue and by the time
>> work queue kicks in, the application continues to restart and hit same
>> NIP again and again. Every MCE again hooks the same address to memory
>> failure work queue and throws multiple recovered MCE messages for same
>> address. Once the memory_failure() hwpoisons the page, application gets
>> SIGBUS and then we are fine.
>>
> 
> That seems quite broken and not recovered is very confusing. So effectively
> we can never recover from a MCE UE. 

By not setting handle = 1, the recovery code will fall through
machine_check_exception()->opal_machine_check() and then SIGBUS is sent
to this process to recover OR head to panic path for kernel UE. We have
already hooked up the physical address to memory_failure() which will
later hwpoison the page whenever work queue kicks in. This patch makes
sure this happens.

> I think we need a notion of delayed
> recovery then? Where we do recover, but mark is as recovered with delays?

Yeah, may be we can set disposition for userspace mce event as recovery
in progress/delayed and then print the mce event again from work queue
by looking at return value from memory_failure(). What do you think ?

> We might want to revisit our recovery process and see if the recovery requires
> to turn the MMU on, but that is for later, I suppose.
> 
>> But in case of UE in kernel space, if early machine_check handler
>> "machine_check_early()" returns as recovered then
>> machine_check_handle_early() queues up the MCE event and continues from
>> NIP assuming it is safe causing a MCE loop. So, for UE in kernel we end
>> up in hard lockup.
>>
> 
> Yeah for the kernel, we need to definitely cause a panic for now, I've got other
> patches for things we need to do for pmem that would allow potential recovery.
> 
> Balbir Singh
> 
