Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qW70K2sfnzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 00:42:25 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qW70J5RPXz9sCk
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Mar 2016 00:42:24 +1100 (AEDT)
Date: Thu, 24 Mar 2016 14:42:21 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 6/6] powerpc/livepatch: Add live patching support on
 ppc64le
Message-ID: <20160324134221.GB29197@lst.de>
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
 <1458817445-5855-6-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458817445-5855-6-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 24, 2016 at 10:04:05PM +1100, Michael Ellerman wrote:
> +livepatch_handler:
> +	CURRENT_THREAD_INFO(r12, r1)
[...]
> +	/* Put ctr in r12 for global entry and branch there */
> +	mfctr	r12
> +	bctrl
            ^
I like this piece. No need to fiddle out the return helper address.

> +	/*
> +	 * Now we are returning from the patched function to the original
> +	 * caller A. We are free to use r0 and r12, and we can use r2 until we
> +	 * restore it.
> +	 */
> +
> +	CURRENT_THREAD_INFO(r12, r1)
> +
> +	/* Save stack pointer into r0 */
> +	mr	r0, r1
> +
> +	ld	r1, TI_livepatch_sp(r12)
> +
> +	/* Check stack marker hasn't been trashed */
> +	lis     r2,  STACK_END_MAGIC@h
> +	ori     r2,  r2, STACK_END_MAGIC@l
> +	ld	r12, -8(r1)
> +1:	tdne	r12, r2
> +	EMIT_BUG_ENTRY 1b, __FILE__, __LINE__ - 1, 0

This however worries me a bit. Sure, in the end, a stack overflow is
a stack overflow, and if all the information does not fit there,
there's little you can do.

But wouldn't it be better to kmalloc that area and realloc in
klp_arch_set_pc when it's full? Maybe along with a warning message?
That way a live patched kernel will not run into stack size problems
any earlier than an unpatched kernel would.
Just a thought.

Anyway, patch 5+6

Reviewed-by: Torsten Duwe <duwe@suse.de>

	Torsten
