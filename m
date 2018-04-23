Return-Path: <srs0=im6g=hm=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40V2sL2WXhzF22Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 20:35:02 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40V2sL1g59z8vVC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 20:35:02 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40V2sK4bvCz9rxp
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 20:35:01 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3NAYwSh180248
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 06:34:59 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hhahe1a4t-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 06:34:57 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 23 Apr 2018 11:34:01 +0100
Subject: Re: [PATCH] powerpc/mce: Fix a bug where mce loops on memory UE.
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <152445952887.3244.567606806755236868.stgit@jupiter.in.ibm.com>
 <CAKTCnznTiS2kQThYrCALGGKb8DfAu-diYzrCbOzwO2vd7Cfw9Q@mail.gmail.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 23 Apr 2018 16:03:56 +0530
MIME-Version: 1.0
In-Reply-To: <CAKTCnznTiS2kQThYrCALGGKb8DfAu-diYzrCbOzwO2vd7Cfw9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <cb831682-8cc6-4cd7-9778-52e5f4ad5af0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/23/2018 12:21 PM, Balbir Singh wrote:
> On Mon, Apr 23, 2018 at 2:59 PM, Mahesh J Salgaonkar
> <mahesh@linux.vnet.ibm.com> wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> The current code extracts the physical address for UE errors and then
>> hooks it up into memory failure infrastructure. On successful extraction
>> of physical address it wrongly sets "handled = 1" which means this UE error
>> has been recovered. Since MCE handler gets return value as handled = 1, it
>> assumes that error has been recovered and goes back to same NIP. This causes
>> MCE interrupt again and again in a loop leading to hard lockup.
>>
>> Also, initialize phys_addr to ULONG_MAX so that we don't end up queuing
>> undesired page to hwpoison.
>>
>> Without this patch we see:
>> [ 1476.541984] Severe Machine check interrupt [Recovered]
>> [ 1476.541985]   NIP: [000000001002588c] PID: 7109 Comm: find
>> [ 1476.541986]   Initiator: CPU
>> [ 1476.541987]   Error type: UE [Load/Store]
>> [ 1476.541988]     Effective address: 00007fffd2755940
>> [ 1476.541989]     Physical address:  000020181a080000
>> [...]
>> [ 1476.542003] Severe Machine check interrupt [Recovered]
>> [ 1476.542004]   NIP: [000000001002588c] PID: 7109 Comm: find
>> [ 1476.542005]   Initiator: CPU
>> [ 1476.542006]   Error type: UE [Load/Store]
>> [ 1476.542006]     Effective address: 00007fffd2755940
>> [ 1476.542007]     Physical address:  000020181a080000
>> [ 1476.542010] Severe Machine check interrupt [Recovered]
>> [ 1476.542012]   NIP: [000000001002588c] PID: 7109 Comm: find
>> [ 1476.542013]   Initiator: CPU
>> [ 1476.542014]   Error type: UE [Load/Store]
>> [ 1476.542015]     Effective address: 00007fffd2755940
>> [ 1476.542016]     Physical address:  000020181a080000
>> [ 1476.542448] Memory failure: 0x20181a08: recovery action for dirty LRU page: Recovered
>> [ 1476.542452] Memory failure: 0x20181a08: already hardware poisoned
>> [ 1476.542453] Memory failure: 0x20181a08: already hardware poisoned
>> [ 1476.542454] Memory failure: 0x20181a08: already hardware poisoned
>> [ 1476.542455] Memory failure: 0x20181a08: already hardware poisoned
>> [ 1476.542456] Memory failure: 0x20181a08: already hardware poisoned
>> [ 1476.542457] Memory failure: 0x20181a08: already hardware poisoned
>> [...]
>> [ 1490.972174] Watchdog CPU:38 Hard LOCKUP
>>
>> After this patch we see:
>>
>> [  325.384336] Severe Machine check interrupt [Not recovered]
> 
> How did you test for this? 

By injecting cache SUE using L2 FIR register (0x1001080c).

> If the error was recovered, shouldn't the
> process have gotten
> a SIGBUS and we should have prevented further access as a part of the handling
> (memory_failure()). Do we just need a MF_MUST_KILL in the flags?

We hook it up to memory_failure() through a work queue and by the time
work queue kicks in, the application continues to restart and hit same
NIP again and again. Every MCE again hooks the same address to memory
failure work queue and throws multiple recovered MCE messages for same
address. Once the memory_failure() hwpoisons the page, application gets
SIGBUS and then we are fine.

But in case of UE in kernel space, if early machine_check handler
"machine_check_early()" returns as recovered then
machine_check_handle_early() queues up the MCE event and continues from
NIP assuming it is safe causing a MCE loop. So, for UE in kernel we end
up in hard lockup.

> Why shouldn't we treat it as handled if we isolate the page?

Yes we should, but I think not until the page is actually hwpoisioned OR
until we send SIGBUS to process.

> 
> Thanks,
> Balbir Singh.
> 
