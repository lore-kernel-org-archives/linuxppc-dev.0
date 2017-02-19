Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vR4Qb3dfFzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2017 22:33:43 +1100 (AEDT)
In-Reply-To: <1487223525-2665-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [1/2] powerpc/mm: Convert slb_finish_load[_1T] to local symbols
Message-Id: <3vR4Qb2dC3z9sD6@ozlabs.org>
Date: Sun, 19 Feb 2017 22:33:43 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-02-16 at 05:38:44 UTC, Michael Ellerman wrote:
> slb_finish_load and slb_finish_load_1T are both only used within
> slb_low.S, so make them local symbols.
> 
> This makes the code a little clearer, as it's more obvious neither is
> intended to be an entry point from arbitrary other code, only the uses
> in this file.
> 
> It also prevents them being used with kprobes and other tracing tools,
> which is good because we're not able to safely take traps at these
> locations, so making them local symbols avoids us needing to blacklist
> them.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/e471c393dfafff54c65979cbda7d5a

cheers
