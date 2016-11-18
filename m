Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKprz3K62zDvsy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 18:04:34 +1100 (AEDT)
Date: Fri, 18 Nov 2016 16:04:27 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [RFC PATCH 2/4] powerpc: kprobe: add arch specific blacklist
Message-Id: <20161118160427.c1fa43473cd96e0bcc3b35a6@kernel.org>
In-Reply-To: <87y40hgwz2.fsf@concordia.ellerman.id.au>
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
 <e34af1637b3c190cc0f2e41131f2524e75720ed3.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
 <87y40hgwz2.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 18 Nov 2016 16:48:01 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > Add symbol to mark end of entry_*.S and use the same to blacklist all
> > addresses from kernel start (_stext) to entry code from kprobes. Much of
> > this code is early exception handling where we can't really take a trap.
> 
> I'm not sure about this. entry_*.S is actually a bit of jumble,
> especially the 64bit version. I've been wanting to split it up for a
> long time.
> 
> It doesn't actually contain any early exception handling. It does
> contain the common syscall handler, and the exception return paths, some
> of which should be black listed. And lots of other junk.
> 
> Also I'm not sure if it's guaranteed that there won't be other code
> between _stext and the end of entry, it's not handled explicitly in the
> linker script, it just tends to get linked early because it's in head-y.
> 
> So I think it would be better if we had a clearer picture of exactly
> what in this file we want to blacklist.

Fair enough.

OK, the purpose of the kprobe blacklist is to avoid crashing kernel
by putting kprobes in some critical area (critical for kprobes,
not what usually "critical region" means).

Since kprobes is using breakpoint(trap) exception, if there is another
kprobes(trap) on the path until kprobe_handler() handle it, the kernel
kicks same exception handler and fall into the recursive fault.
So the blacklist is used in kprobe to prohibit putting kprobes on such
functions for avoiding it.

So, we might be carefully choose the function for the blacklist.

BTW, Naveen, as far as I can see the kprobe implementation on ppc,
it still depends on exceptions_notify to handle trap. It is no more
recommended becuase notifier_call_chain involves too many unrelated
functions. I recommend you to callback kprobe_handler and
kprobe_post_handler directly from the trap handler as same as x86.

Unless that, kprobe_blacklist may not work.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
