Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdpC326vLzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 23:31:11 +1000 (AEST)
In-Reply-To: <1496053567-29357-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: jk@ozlabs.org, viro@zeniv.linux.org.uk
Subject: Re: powerpc/spufs: Fix coredump of SPU contexts
Message-Id: <3wdpC23hz9z9sN1@ozlabs.org>
Date: Thu,  1 Jun 2017 23:31:10 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-29 at 10:26:07 UTC, Michael Ellerman wrote:
> If a process dumps core while it has SPU contexts active then we have
> code to also dump information about the SPU contexts.
> 
> Unfortunately it's been broken for 3 1/2 years, and we didn't notice. In
> commit 7b1f4020d0d1 ("spufs: get rid of dump_emit() wrappers") the nread
> variable was removed and rc used instead. That means when the loop exits
> successfully, rc has the number of bytes read, but it's then used as the
> return value for the function, which should return 0 on success.
> 
> So fix it by setting rc = 0 before returning in the success case.
> 
> Fixes: 7b1f4020d0d1 ("spufs: get rid of dump_emit() wrappers")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Jeremy Kerr <jk@ozlabs.org>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/99acc9bede06bbb2662aafff51f5b9

cheers
