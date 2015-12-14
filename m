Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B8781A0C5A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 20:47:51 +1100 (AEDT)
In-Reply-To: <20151209201147.032e28c3@kryten>
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org, cyrilbur@gmail.com, scottwood@freescale.com,
 mikey@neuling.org, khandual@linux.vnet.ibm.com
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Fix DSCR inheritance over fork()
Message-Id: <20151214094750.F0DA4140556@ozlabs.org>
Date: Mon, 14 Dec 2015 20:47:50 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-12 at 09:11:47 UTC, Anton Blanchard wrote:
> Two DSCR tests have a hack in them:
> 
> 	/*
> 	 * XXX: Force a context switch out so that DSCR
> 	 * current value is copied into the thread struct
> 	 * which is required for the child to inherit the
> 	 * changed value.
> 	 */
> 	sleep(1);
> 
> We should not be working around this in the testcase, it is a kernel bug.
> Fix it by copying the current DSCR to the child, instead of what we
> had in the thread struct at last context switch.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/db1231dcdb4dc6cdcbdef0ba

cheers
