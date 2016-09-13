Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYNvL0w74zDsV0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 22:16:30 +1000 (AEST)
In-Reply-To: <20160902114921.GB12433@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [2/3] powerpc/mm: Preserve CFAR value on SLB miss caused by
 access to bogus address
Message-Id: <3sYNvL0LZCz9sdm@ozlabs.org>
Date: Tue, 13 Sep 2016 22:16:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-02-09 at 11:49:21 UTC, Paul Mackerras wrote:
> Currently, if userspace or the kernel accesses a completely bogus address,
> for example with any of bits 46-59 set, we first take an SLB miss interrupt,
> install a corresponding SLB entry with VSID 0, retry the instruction, then
> take a DSI/ISI interrupt because there is no HPT entry mapping the address.
> However, by the time of the second interrupt, the Come-From Address Register
> (CFAR) has been overwritten by the rfid instruction at the end of the SLB
> miss interrupt handler.  Since bogus accesses can often be caused by a
> function return after the stack has been overwritten, the CFAR value would
> be very useful as it could indicate which function it was whose return had
> led to the bogus address.
> 
> This patch adds code to create a full exception frame in the SLB miss handler
> in the case of a bogus address, rather than inserting an SLB entry with a
> zero VSID field.  Then we call a new slb_miss_bad_addr() function in C code,
> which delivers a signal for a user access or creates an oops for a kernel
> access.  In the latter case the oops message will show the CFAR value at the
> time of the access.
> 
> In the case of the radix MMU, a segment miss interrupt indicates an access
> outside the ranges mapped by the page tables.  Previously this was handled
> by the code for an unrecoverable SLB miss (one with MSR[RI] = 0), which is
> not really correct.  With this patch, we now handle these interrupts with
> slb_miss_bad_addr(), which is much more consistent.
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f0f558b131db0e793fd90aac5d

cheers
