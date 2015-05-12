Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B15931A012A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 19:41:42 +1000 (AEST)
Message-ID: <1431423701.20440.1.camel@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/mce: fix off by one errors in mce event
 handling
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>
Date: Tue, 12 May 2015 19:41:41 +1000
In-Reply-To: <1431401039-15958-1-git-send-email-dja@axtens.net>
References: <1431401039-15958-1-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 Christoph Lameter <cl@linux.com>, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-05-12 at 13:23 +1000, Daniel Axtens wrote:
> Before 69111bac42f5 ("powerpc: Replace __get_cpu_var uses"), in
> save_mce_event, index got the value of mce_nest_count, and
> mce_nest_count was incremented *after* index was set.
> 
> However, that patch changed the behaviour so that mce_nest count was
> incremented *before* setting index.
> 
> This causes an off-by-one error, as get_mce_event sets index as
> mce_nest_count - 1 before reading mce_event.  Thus get_mce_event reads
> bogus data, causing warnings like
> "Machine Check Exception, Unknown event version 0 !"
> and breaking MCEs handling.
> 
> Restore the old behaviour and unbreak MCE handling by subtracting one
> from the newly incremented value.
> 
> The same broken change occured in machine_check_queue_event (which set
> a queue read by machine_check_process_queued_event).  Fix that too,
> unbreaking printing of MCE information.
> 
> Fixes: 69111bac42f5 ("powerpc: Replace __get_cpu_var uses")
> CC: stable@vger.kernel.org
> CC: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> CC: Christoph Lameter <cl@linux.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> ---
> 
> The code is still super racy, but this at least unbreaks the common,
> non-reentrant case for now until we figure out how to fix it properly.
> The proper fix will likely be quite invasive so it might be worth
> picking this up in stable rather than waiting for that?
> 
> mpe: the generated asm is below
> 
> 0000000000000070 <.save_mce_event>:
>   70:   e9 6d 00 30     ld      r11,48(r13)
>   74:   3d 22 00 00     addis   r9,r2,0
>   78:   39 29 00 00     addi    r9,r9,0
>   7c:   7d 2a 4b 78     mr      r10,r9
>   80:   39 29 00 08     addi    r9,r9,8
>   84:   7d 8a 58 2e     lwzx    r12,r10,r11
>   88:   39 8c 00 01     addi    r12,r12,1
>   8c:   7d 8a 59 2e     stwx    r12,r10,r11
>   90:   e9 0d 00 30     ld      r8,48(r13)
>   94:   7d 4a 40 2e     lwzx    r10,r10,r8
>   98:   39 4a ff ff     addi    r10,r10,-1
>   9c:   2f 8a 00 63     cmpwi   cr7,r10,99
> 
> AIUI, we get the per-cpu area in 70, the addr of mce_nest_count itself
> in 80, then load, incr, stor in 84-8c, then we get the address and
> load again in 90-94, then subtract 1 to make the count sensible again,
> then 9c is the conditional `if (index >= MAX_MC_EVT)'
> 
> I think that was what you expected?

Sort of. I wasn't expecting it to reload it after the increment. But I guess
that's an artifact of the macros.

Anyway it's much better than the current code which is just broken always.

cheers
