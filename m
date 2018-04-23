Return-Path: <srs0=wz6g=hm=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40V3kc5hpXzDr5X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 21:14:16 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40V3kc4lNPz8sy5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 21:14:16 +1000 (AEST)
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com
 [IPv6:2607:f8b0:400c:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40V3kb6RPnz9ry1
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 21:14:15 +1000 (AEST)
Received: by mail-vk0-x244.google.com with SMTP id b16so9117730vka.5
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 04:14:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cb831682-8cc6-4cd7-9778-52e5f4ad5af0@linux.vnet.ibm.com>
References: <152445952887.3244.567606806755236868.stgit@jupiter.in.ibm.com>
 <CAKTCnznTiS2kQThYrCALGGKb8DfAu-diYzrCbOzwO2vd7Cfw9Q@mail.gmail.com>
 <cb831682-8cc6-4cd7-9778-52e5f4ad5af0@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 23 Apr 2018 21:14:12 +1000
Message-ID: <CAKTCnzm=OAXmUp0g7YrR9wFoFwB3TS_LnQiwZPR6QgeKk6ExYQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mce: Fix a bug where mce loops on memory UE.
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 23, 2018 at 8:33 PM, Mahesh Jagannath Salgaonkar
<mahesh@linux.vnet.ibm.com> wrote:
> On 04/23/2018 12:21 PM, Balbir Singh wrote:
>> On Mon, Apr 23, 2018 at 2:59 PM, Mahesh J Salgaonkar
>> <mahesh@linux.vnet.ibm.com> wrote:
>>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>>
>>> The current code extracts the physical address for UE errors and then
>>> hooks it up into memory failure infrastructure. On successful extraction
>>> of physical address it wrongly sets "handled = 1" which means this UE error
>>> has been recovered. Since MCE handler gets return value as handled = 1, it
>>> assumes that error has been recovered and goes back to same NIP. This causes
>>> MCE interrupt again and again in a loop leading to hard lockup.
>>>
>>> Also, initialize phys_addr to ULONG_MAX so that we don't end up queuing
>>> undesired page to hwpoison.
>>>
>>> Without this patch we see:
>>> [ 1476.541984] Severe Machine check interrupt [Recovered]
>>> [ 1476.541985]   NIP: [000000001002588c] PID: 7109 Comm: find
>>> [ 1476.541986]   Initiator: CPU
>>> [ 1476.541987]   Error type: UE [Load/Store]
>>> [ 1476.541988]     Effective address: 00007fffd2755940
>>> [ 1476.541989]     Physical address:  000020181a080000
>>> [...]
>>> [ 1476.542003] Severe Machine check interrupt [Recovered]
>>> [ 1476.542004]   NIP: [000000001002588c] PID: 7109 Comm: find
>>> [ 1476.542005]   Initiator: CPU
>>> [ 1476.542006]   Error type: UE [Load/Store]
>>> [ 1476.542006]     Effective address: 00007fffd2755940
>>> [ 1476.542007]     Physical address:  000020181a080000
>>> [ 1476.542010] Severe Machine check interrupt [Recovered]
>>> [ 1476.542012]   NIP: [000000001002588c] PID: 7109 Comm: find
>>> [ 1476.542013]   Initiator: CPU
>>> [ 1476.542014]   Error type: UE [Load/Store]
>>> [ 1476.542015]     Effective address: 00007fffd2755940
>>> [ 1476.542016]     Physical address:  000020181a080000
>>> [ 1476.542448] Memory failure: 0x20181a08: recovery action for dirty LRU page: Recovered
>>> [ 1476.542452] Memory failure: 0x20181a08: already hardware poisoned
>>> [ 1476.542453] Memory failure: 0x20181a08: already hardware poisoned
>>> [ 1476.542454] Memory failure: 0x20181a08: already hardware poisoned
>>> [ 1476.542455] Memory failure: 0x20181a08: already hardware poisoned
>>> [ 1476.542456] Memory failure: 0x20181a08: already hardware poisoned
>>> [ 1476.542457] Memory failure: 0x20181a08: already hardware poisoned
>>> [...]
>>> [ 1490.972174] Watchdog CPU:38 Hard LOCKUP
>>>
>>> After this patch we see:
>>>
>>> [  325.384336] Severe Machine check interrupt [Not recovered]
>>
>> How did you test for this?
>
> By injecting cache SUE using L2 FIR register (0x1001080c).
>
>> If the error was recovered, shouldn't the
>> process have gotten
>> a SIGBUS and we should have prevented further access as a part of the handling
>> (memory_failure()). Do we just need a MF_MUST_KILL in the flags?
>
> We hook it up to memory_failure() through a work queue and by the time
> work queue kicks in, the application continues to restart and hit same
> NIP again and again. Every MCE again hooks the same address to memory
> failure work queue and throws multiple recovered MCE messages for same
> address. Once the memory_failure() hwpoisons the page, application gets
> SIGBUS and then we are fine.
>

That seems quite broken and not recovered is very confusing. So effectively
we can never recover from a MCE UE. I think we need a notion of delayed
recovery then? Where we do recover, but mark is as recovered with delays?
We might want to revisit our recovery process and see if the recovery requires
to turn the MMU on, but that is for later, I suppose.

> But in case of UE in kernel space, if early machine_check handler
> "machine_check_early()" returns as recovered then
> machine_check_handle_early() queues up the MCE event and continues from
> NIP assuming it is safe causing a MCE loop. So, for UE in kernel we end
> up in hard lockup.
>

Yeah for the kernel, we need to definitely cause a panic for now, I've got other
patches for things we need to do for pmem that would allow potential recovery.

Balbir Singh
