Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y8xjh70HpzDr3W
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Oct 2017 19:43:36 +1100 (AEDT)
In-Reply-To: <20170928133340.19312-1-seth.forshee@canonical.com>
To: Seth Forshee <seth.forshee@canonical.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Seth Forshee <seth.forshee@canonical.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc: Always initialize input array when calling
 epapr_hypercall()
Message-Id: <3y8xjh6CPKz9t5C@ozlabs.org>
Date: Sun,  8 Oct 2017 19:43:36 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-09-28 at 13:33:39 UTC, Seth Forshee wrote:
> Several callers to epapr_hypercall() pass an uninitialized stack
> allocated array for the input arguments, presumably because they
> have no input arguments. However this can produce errors like
> this one
> 
>  arch/powerpc/include/asm/epapr_hcalls.h:470:42: error: 'in' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   unsigned long register r3 asm("r3") = in[0];
>                                         ~~^~~
> 
> Fix callers to this function to always zero-initialize the input
> arguments array to prevent this.
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/186b8f1587c79c2fa04bfa392fdf08

cheers
