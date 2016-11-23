Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP1Ll6nvBzDw5d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 23:07:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH v2] powerpc: split ftrace bits into a separate file
In-Reply-To: <20161122163439.524-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20161122163439.524-1-naveen.n.rao@linux.vnet.ibm.com>
Date: Wed, 23 Nov 2016 23:07:56 +1100
Message-ID: <87inretn4z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> entry_*.S now includes a lot more than just kernel entry/exit code. As a
> first step at cleaning this up, let's split out the ftrace bits into
> separate files.
>
> No functional changes.
>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> v2: updated commit description.
>
>  arch/powerpc/kernel/Makefile    |   2 +
>  arch/powerpc/kernel/entry_32.S  | 107 -----------
>  arch/powerpc/kernel/entry_64.S  | 380 --------------------------------------
>  arch/powerpc/kernel/ftrace_32.S | 118 ++++++++++++
>  arch/powerpc/kernel/ftrace_64.S | 391 ++++++++++++++++++++++++++++++++++++++++

Thanks for having a crack at this.

I think I'd actually like to go the whole way, and move all the tracing
code into arch/powerpc/trace (or ftrace?).

There's the 32 and 64-bit asm, and ftrace.c, and trace_clock.c. And then
possibly later some of the ftrace module code could move in there too.

And as part of moving the asm, I think we can come up with a better way
to organise the code. If you look at the ftrace code in entry_64.S for
example the ifdefs look like:

#ifdef CONFIG_FUNCTION_TRACER
#ifdef CONFIG_DYNAMIC_FTRACE
#ifdef CONFIG_FUNCTION_GRAPH_TRACER
#endif
#else /* CC_USING_MPROFILE_KERNEL */
#ifdef CONFIG_LIVEPATCH
#endif
#ifdef CONFIG_LIVEPATCH
#endif
#ifdef CONFIG_LIVEPATCH
#endif
#ifdef CONFIG_FUNCTION_GRAPH_TRACER
#endif
#endif /* CC_USING_MPROFILE_KERNEL */
#ifdef CONFIG_LIVEPATCH
#endif
#else
#ifdef CONFIG_FUNCTION_GRAPH_TRACER
#endif
#endif /* CONFIG_DYNAMIC_FTRACE */
#ifdef CONFIG_FUNCTION_GRAPH_TRACER
#else /* CC_USING_MPROFILE_KERNEL */
#endif /* CC_USING_MPROFILE_KERNEL */
#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
#endif /* CONFIG_FUNCTION_TRACER */


Which is not easy to follow.

I think the main axis is CC_USING_MPROFILE_KERNEL y/n, so perhaps we split
it into two .S files based on that?

cheers
