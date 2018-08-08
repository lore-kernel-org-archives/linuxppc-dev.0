Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltw75bgJzDqkP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:25:43 +1000 (AEST)
In-Reply-To: <153072702900.29016.3698488484610157863.stgit@jupiter.in.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michal Suchanek <msuchanek@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
 stable@vger.kernel.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [v6,
 2/8] powerpc/pseries: Defer the logging of rtas error to irq work
 queue.
Message-Id: <41ltvz2J03z9s4Z@ozlabs.org>
Date: Thu,  9 Aug 2018 00:25:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-07-04 at 17:57:21 UTC, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> rtas_log_buf is a buffer to hold RTAS event data that are communicated
> to kernel by hypervisor. This buffer is then used to pass RTAS event
> data to user through proc fs. This buffer is allocated from vmalloc
> (non-linear mapping) area.
> 
> On Machine check interrupt, register r3 points to RTAS extended event
> log passed by hypervisor that contains the MCE event. The pseries
> machine check handler then logs this error into rtas_log_buf. The
> rtas_log_buf is a vmalloc-ed (non-linear) buffer we end up taking up a
> page fault (vector 0x300) while accessing it. Since machine check
> interrupt handler runs in NMI context we can not afford to take any
> page fault. Page faults are not honored in NMI context and causes
> kernel panic. Apart from that, as Nick pointed out, pSeries_log_error()
> also takes a spin_lock while logging error which is not safe in NMI
> context. It may endup in deadlock if we get another MCE before releasing
> the lock. Fix this by deferring the logging of rtas error to irq work queue.
> 
> Current implementation uses two different buffers to hold rtas error log
> depending on whether extended log is provided or not. This makes bit
> difficult to identify which buffer has valid data that needs to logged
> later in irq work. Simplify this using single buffer, one per paca, and
> copy rtas log to it irrespective of whether extended log is provided or
> not. Allocate this buffer below RMA region so that it can be accessed
> in real mode mce handler.
> 
> Fixes: b96672dd840f ("powerpc: Machine check interrupt is a non-maskable interrupt")
> Cc: stable@vger.kernel.org
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/94675cceacaec27a30eefb142c4c59

cheers
