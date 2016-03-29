Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYzpY72jSzDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 16:28:53 +1100 (AEDT)
Message-ID: <1459229333.8173.12.camel@ellerman.id.au>
Subject: Re: [PATCH 6/6] powerpc/livepatch: Add live patching support on
 ppc64le
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com,  pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org,  mbenes@suse.cz
Date: Tue, 29 Mar 2016 16:28:53 +1100
In-Reply-To: <20160324134221.GB29197@lst.de>
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
 <1458817445-5855-6-git-send-email-mpe@ellerman.id.au>
 <20160324134221.GB29197@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-03-24 at 14:42 +0100, Torsten Duwe wrote:

> On Thu, Mar 24, 2016 at 10:04:05PM +1100, Michael Ellerman wrote:

> > +livepatch_handler:
> > +	CURRENT_THREAD_INFO(r12, r1)
> [...]

> > +	/* Put ctr in r12 for global entry and branch there */
> > +	mfctr	r12
> > +	bctrl
>             ^
> I like this piece. No need to fiddle out the return helper address.

Good.

> > +	/*
> > +	 * Now we are returning from the patched function to the original
> > +	 * caller A. We are free to use r0 and r12, and we can use r2 until we
> > +	 * restore it.
> > +	 */
> > +
> > +	CURRENT_THREAD_INFO(r12, r1)
> > +
> > +	/* Save stack pointer into r0 */
> > +	mr	r0, r1
> > +
> > +	ld	r1, TI_livepatch_sp(r12)
> > +
> > +	/* Check stack marker hasn't been trashed */
> > +	lis     r2,  STACK_END_MAGIC@h
> > +	ori     r2,  r2, STACK_END_MAGIC@l
> > +	ld	r12, -8(r1)
> > +1:	tdne	r12, r2
> > +	EMIT_BUG_ENTRY 1b, __FILE__, __LINE__ - 1, 0
> 
> This however worries me a bit. Sure, in the end, a stack overflow is
> a stack overflow, and if all the information does not fit there,
> there's little you can do.

Yeah stack overflow in the kernel is very very fatal.

> But wouldn't it be better to kmalloc that area and realloc in
> klp_arch_set_pc when it's full? Maybe along with a warning message?

You can't realloc in klp_arch_set_pc(), you might be patching sl*b and holding
one of its locks. You might also recurse.

We could allocate a larger buffer as a "klp stack" for each task when the first
live patch is installed, and for every task created afterward. But that
potentially significantly increases memory usage on live patched kernels :)

> That way a live patched kernel will not run into stack size problems
> any earlier than an unpatched kernel would.

Yeah that's true. I'm not sure what the best trade off is.

cheers
