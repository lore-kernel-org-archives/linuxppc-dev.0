Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KxfZ3VRMzF3Jl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 22:13:10 +1000 (AEST)
In-Reply-To: <20180924072704.6200-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 aneesh.kumar@linux.vnet.ibm.com, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/tm: Fix userspace r13 corruption
Message-Id: <42KxfZ2RhHz9s4s@ozlabs.org>
Date: Wed, 26 Sep 2018 22:13:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-09-24 at 07:27:04 UTC, Michael Neuling wrote:
> When we treclaim we store the userspace checkpointed r13 to a scratch
> SPR and then later save the scratch SPR to the user thread struct.
> 
> Unfortunately, this doesn't work as accessing the user thread struct
> can take an SLB fault and the SLB fault handler will write the same
> scratch SPRG that now contains the userspace r13.
> 
> To fix this, we store r13 to the kernel stack (which can't fault)
> before we access the user thread struct.
> 
> Found by running P8 guest + powervm + disable_1tb_segments + TM. Seen
> as a random userspace segfault with r13 looking like a kernel address.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Reviewed-by: Breno Leitao <leitao@debian.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/cf13435b730a502e814c63c84d93db

cheers
