Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqw5q2QzF0XV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:20 +1100 (AEDT)
In-Reply-To: <20171223164923.10587-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [1/2] powerpc: System reset avoid interleaving oops using die
 synchronisation
Message-Id: <3zPxqv4M00z9sNx@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-12-23 at 16:49:22 UTC, Nicholas Piggin wrote:
> The die() oops path contains a serializing lock to prevent oops
> messages from being interleaved. In the case of a system reset
> initiated oops (e.g., qemu nmi command), __die was being called
> which lacks that synchronisation and oops reports could be
> interleaved across CPUs.
> 
> A recent patch 4388c9b3a6ee7 ("powerpc: Do not send system reset
> request through the oops path") changed this to __die to avoid
> the debugger() call, but there is no real harm to calling it twice
> if the first time fell through. So go back to using die() here.
> This was observed to fix the problem.
> 
> Fixes: 4388c9b3a6ee7 ("powerpc: Do not send system reset request through the oops path")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4552d128c26e0f0f27a5bd2fadc240

cheers
