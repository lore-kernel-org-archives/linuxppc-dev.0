Return-Path: <srs0=wz6g=hm=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VNJp5ckKzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 09:41:30 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40VNJp4qmJz8syK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 09:41:30 +1000 (AEST)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40VNJn6SBQz9ryr
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2018 09:41:29 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id z9so10622794pfe.6
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 16:41:29 -0700 (PDT)
Message-ID: <a145e7507fc2e5242824c7ce80a0064bb549b7b7.camel@gmail.com>
Subject: Re: [PATCH] powerpc/mce: Fix a bug where mce loops on memory UE.
From: Balbir Singh <bsingharora@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>
Date: Tue, 24 Apr 2018 09:41:21 +1000
In-Reply-To: <152445952887.3244.567606806755236868.stgit@jupiter.in.ibm.com>
References: <152445952887.3244.567606806755236868.stgit@jupiter.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-23 at 10:29 +0530, Mahesh J Salgaonkar wrote:
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
> ---
>  arch/powerpc/kernel/mce_power.c |    8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index fe6fc63251fe..63b58ae5d601 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -441,7 +441,6 @@ static int mce_handle_ierror(struct pt_regs *regs,
>  					if (pfn != ULONG_MAX) {
>  						*phys_addr =
>  							(pfn << PAGE_SHIFT);
> -						handled = 1;
>  					}
>  				}
>  			}
> @@ -532,9 +531,8 @@ static int mce_handle_derror(struct pt_regs *regs,
>  			 * kernel/exception-64s.h
>  			 */
>  			if (get_paca()->in_mce < MAX_MCE_DEPTH)
> -				if (!mce_find_instr_ea_and_pfn(regs, addr,
> -								phys_addr))
> -					handled = 1;
> +				mce_find_instr_ea_and_pfn(regs, addr,
> +								phys_addr);
>  		}
>  		found = 1;
>  	}
> @@ -572,7 +570,7 @@ static long mce_handle_error(struct pt_regs *regs,
>  		const struct mce_ierror_table itable[])
>  {
>  	struct mce_error_info mce_err = { 0 };
> -	uint64_t addr, phys_addr;
> +	uint64_t addr, phys_addr = ULONG_MAX;
>  	uint64_t srr1 = regs->msr;
>  	long handled;
>  
> 

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
