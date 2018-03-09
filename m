Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyYFp2SCgzF1ms
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Mar 2018 03:47:26 +1100 (AEDT)
Date: Fri, 9 Mar 2018 17:47:18 +0100
From: Torsten Duwe <duwe@lst.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Nicholas
 Piggin <npiggin@gmail.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH v2] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20180309174718.2700b29e@blackhole.lan>
In-Reply-To: <20180308162616.yhbymodggnfzpskx@treble>
References: <20180305164928.GA17953@lst.de>
 <20180308162616.yhbymodggnfzpskx@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 8 Mar 2018 10:26:16 -0600
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> This doesn't seem to address some of my previous concerns:

You're right. That discussion quickly headed towards objtool
and I forgot about this one paragraph with the remarks.

> - Bailing on interrupt/exception frames

That is a good question. My current code keeps unwinding as long
as the trace looks sane. If the exception frame has a valid code
pointer in the LR slot it will continue. Couldn't there be cases
where this is desirable? Should this be configurable? Not that
I have an idea how this situation could occur for a thread
that is current or sleeping...

Michael, Balbir: is that possible? Any Idea how to reliably detect
an exception frame? My approach would be to look at the next return
address and compare it to the usual suspects (i.e. collect all 
"b ret" addresses in the EXCEPTION_COMMON macro, for BookS).

> - Function graph tracing return address conversion
> 
> - kretprobes return address conversion

You mean like in arch/x86/kernel/unwind_frame.c the call to
ftrace_graph_ret_addr ?

Forgive me my directness but I don't see why these should be handled in
arch-dependent code, other than maybe a hook, if inevitable, that calls
back into the graph tracer / kretprobes in order to get the proper
address, or simply call the trace unreliable in case it finds such a
return address.

I understand that x86 has a hard time with its multiple unwinders, but
there should be a simpler, generic solution for all other architectures.

	Torsten
