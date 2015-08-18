Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65A4E1A0151
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 16:26:32 +1000 (AEST)
In-Reply-To: <e9e27ee5cee97ac3be2599646243fefc319f92a9.1439520906.git.sam.bobroff@au1.ibm.com>
To: Sam bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: khandual@linux.vnet.ibm.com
Subject: Re: [1/1] powerpc/xmon: Paged output for paca display
Message-Id: <20150818062632.3C4F114032F@ozlabs.org>
Date: Tue, 18 Aug 2015 16:26:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-14-08 at 02:55:14 UTC, Sam bobroff wrote:
> The paca display is already more than 24 lines, which can be problematic
> if you have an old school 80x24 terminal, or more likely you are on a
> virtual terminal which does not scroll for whatever reason.
> 
> This adds an optional letter to the "dp" and "dpa" xmon commands
> ("dpp" and "dppa"), which will enable a "per-page" display (with 16
> line pages): the first page  will be displayed and if there was data
> that didn't fit, it will display a message indicating that the user can
> use enter to display the next page. The intent is that this feels
> similar to the way the memory display functions work.
> 
> This is implemented by running over the entire output both for the
> initial command and for each subsequent page: the visible part is
> clipped out by checking line numbers. Handling the empty command as
> "more" is done by writing a special command into a static buffer that
> indicates where to move the sliding visibility window. This is similar
> to the approach used for the memory dump commands except that the
> state data is encoded into the "last_cmd" string, rather than a set of
> static variables. The memory dump commands could probably be rewritten
> to make use of the same buffer and remove their other static
> variables.
> 
> Sample output:
> 
> 0:mon> dpp1
> paca for cpu 0x1 @ c00000000fdc0480:
>  possible         = yes
>  present          = yes
>  online           = yes
>  lock_token       = 0x8000            	(0x8)
>  paca_index       = 0x1               	(0xa)
>  kernel_toc       = 0xc000000000eb2400	(0x10)
>  kernelbase       = 0xc000000000000000	(0x18)
>  kernel_msr       = 0xb000000000001032	(0x20)
>  emergency_sp     = 0xc00000003ffe8000	(0x28)
>  mc_emergency_sp  = 0xc00000003ffe4000	(0x2e0)
>  in_mce           = 0x0               	(0x2e8)
>  data_offset      = 0x7f170000        	(0x30)
>  hw_cpu_id        = 0x8               	(0x38)
>  cpu_start        = 0x1               	(0x3a)
>  kexec_state      = 0x0               	(0x3b)
> [Enter for next page]
> 0:mon>
>  __current        = 0xc00000007e696620	(0x290)
>  kstack           = 0xc00000007e6ebe30	(0x298)
>  stab_rr          = 0xb               	(0x2a0)
>  saved_r1         = 0xc00000007ef37860	(0x2a8)
>  trap_save        = 0x0               	(0x2b8)
>  soft_enabled     = 0x0               	(0x2ba)
>  irq_happened     = 0x1               	(0x2bb)
>  io_sync          = 0x0               	(0x2bc)
>  irq_work_pending = 0x0               	(0x2bd)
>  nap_state_lost   = 0x0               	(0x2be)
> 0:mon>
> 
> (Based on a similar patch by Michael Ellerman <mpe@ellerman.id.au>
> "[v2] powerpc/xmon: Allow limiting the size of the paca display".
> This patch is an alternative and cannot coexist with the original.)


So this is nice, but ... the diff is twice the size of my version, plus 128
bytes of BSS, so I'm not sure the added benefit is sufficient to justify the
added code complexity.

But you can convince me otherwise if you feel strongly about it.

cheers
