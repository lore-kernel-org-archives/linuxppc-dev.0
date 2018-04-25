Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40W4Z96BQQzF24b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 12:55:29 +1000 (AEST)
In-Reply-To: <152445952887.3244.567606806755236868.stgit@jupiter.in.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mce: Fix a bug where mce loops on memory UE.
Message-Id: <40W4Z938p6z9s0t@ozlabs.org>
Date: Wed, 25 Apr 2018 12:55:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-23 at 04:59:27 UTC, Mahesh J Salgaonkar wrote:
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
> [  325.384338]   NIP: [00007fffaae585f4] PID: 7168 Comm: find
> [  325.384339]   Initiator: CPU
> [  325.384341]   Error type: UE [Load/Store]
> [  325.384343]     Effective address: 00007fffaafe28ac
> [  325.384345]     Physical address:  00002017c0bd0000
> [  325.384350] find[7168]: unhandled signal 7 at 00007fffaae585f4 nip 00007fffaae585f4 lr 00007fffaae585e0 code 4
> [  325.388574] Memory failure: 0x2017c0bd: recovery action for dirty LRU page: Recovered
> 
> Fixes: 01eaac2b0591 ("powerpc/mce: Hookup ierror (instruction) UE errors")
> Fixes: ba41e1e1ccb9 ("powerpc/mce: Hookup derror (load/store) UE errors")
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/75ecfb49516c53da00c57b9efe48fa

cheers
