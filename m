Return-Path: <srs0=wz6g=hm=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Txvm4SqNzF24B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 16:51:48 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40Txvm3Th3z8sWM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 16:51:48 +1000 (AEST)
Received: from mail-vk0-x22b.google.com (mail-vk0-x22b.google.com
 [IPv6:2607:f8b0:400c:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40Txvl5SRZz9s0x
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 16:51:47 +1000 (AEST)
Received: by mail-vk0-x22b.google.com with SMTP id 203so8710798vka.12
 for <linuxppc-dev@ozlabs.org>; Sun, 22 Apr 2018 23:51:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <152445952887.3244.567606806755236868.stgit@jupiter.in.ibm.com>
References: <152445952887.3244.567606806755236868.stgit@jupiter.in.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 23 Apr 2018 16:51:44 +1000
Message-ID: <CAKTCnznTiS2kQThYrCALGGKb8DfAu-diYzrCbOzwO2vd7Cfw9Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mce: Fix a bug where mce loops on memory UE.
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
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

On Mon, Apr 23, 2018 at 2:59 PM, Mahesh J Salgaonkar
<mahesh@linux.vnet.ibm.com> wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> The current code extracts the physical address for UE errors and then
> hooks it up into memory failure infrastructure. On successful extraction
> of physical address it wrongly sets "handled = 1" which means this UE error
> has been recovered. Since MCE handler gets return value as handled = 1, it
> assumes that error has been recovered and goes back to same NIP. This causes
> MCE interrupt again and again in a loop leading to hard lockup.
>
> Also, initialize phys_addr to ULONG_MAX so that we don't end up queuing
> undesired page to hwpoison.
>
> Without this patch we see:
> [ 1476.541984] Severe Machine check interrupt [Recovered]
> [ 1476.541985]   NIP: [000000001002588c] PID: 7109 Comm: find
> [ 1476.541986]   Initiator: CPU
> [ 1476.541987]   Error type: UE [Load/Store]
> [ 1476.541988]     Effective address: 00007fffd2755940
> [ 1476.541989]     Physical address:  000020181a080000
> [...]
> [ 1476.542003] Severe Machine check interrupt [Recovered]
> [ 1476.542004]   NIP: [000000001002588c] PID: 7109 Comm: find
> [ 1476.542005]   Initiator: CPU
> [ 1476.542006]   Error type: UE [Load/Store]
> [ 1476.542006]     Effective address: 00007fffd2755940
> [ 1476.542007]     Physical address:  000020181a080000
> [ 1476.542010] Severe Machine check interrupt [Recovered]
> [ 1476.542012]   NIP: [000000001002588c] PID: 7109 Comm: find
> [ 1476.542013]   Initiator: CPU
> [ 1476.542014]   Error type: UE [Load/Store]
> [ 1476.542015]     Effective address: 00007fffd2755940
> [ 1476.542016]     Physical address:  000020181a080000
> [ 1476.542448] Memory failure: 0x20181a08: recovery action for dirty LRU page: Recovered
> [ 1476.542452] Memory failure: 0x20181a08: already hardware poisoned
> [ 1476.542453] Memory failure: 0x20181a08: already hardware poisoned
> [ 1476.542454] Memory failure: 0x20181a08: already hardware poisoned
> [ 1476.542455] Memory failure: 0x20181a08: already hardware poisoned
> [ 1476.542456] Memory failure: 0x20181a08: already hardware poisoned
> [ 1476.542457] Memory failure: 0x20181a08: already hardware poisoned
> [...]
> [ 1490.972174] Watchdog CPU:38 Hard LOCKUP
>
> After this patch we see:
>
> [  325.384336] Severe Machine check interrupt [Not recovered]

How did you test for this? If the error was recovered, shouldn't the
process have gotten
a SIGBUS and we should have prevented further access as a part of the handling
(memory_failure()). Do we just need a MF_MUST_KILL in the flags?

Why shouldn't we treat it as handled if we isolate the page?

Thanks,
Balbir Singh.
