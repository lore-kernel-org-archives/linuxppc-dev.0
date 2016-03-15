Return-Path: <mbenes@suse.cz>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPYgy56xnzDqjZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 23:23:58 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qPYgx6lTsz9sdQ
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2016 23:23:57 +1100 (AEDT)
Date: Tue, 15 Mar 2016 13:23:53 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Jiri Kosina <jikos@kernel.org>
cc: Petr Mladek <pmladek@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Jessica Yu <jeyu@redhat.com>, Vojtech Pavlik <vojtech@suse.com>,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 linuxppc-dev@ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 Torsten Duwe <duwe@suse.de>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] livepatch: Add some basic LivePatch documentation
In-Reply-To: <alpine.LNX.2.00.1603101005480.3656@cbobk.fhfr.pm>
Message-ID: <alpine.LNX.2.00.1603151256480.20252@pobox.suse.cz>
References: <1457532106-30925-1-git-send-email-pmladek@suse.com>
 <alpine.LNX.2.00.1603101005480.3656@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 10 Mar 2016, Jiri Kosina wrote:

> On Wed, 9 Mar 2016, Petr Mladek wrote:
> 
> > LivePatch framework deserves some documentation, definitely.
> > This is an attempt to provide some basic info. I hope that
> > it will be useful for both LivePatch producers and also
> > potential developers of the framework itself.
> 
> Thanks for starting the efforts; this is really needed if we want the 
> infrastructure to be used also by someone else than its developers :)

Indeed. Great job, Petr.

> [ ... snip ... ]
> > +7. Limitations
> > +==============
> 
> Miroslav Benes, who is working on creating the actual patches we are 
> shipping for our kernels, should already have a decent cheat-sheet 
> regarding things that the patch author should be extra careful when 
> creating a patch (inlining and other gcc optimizations such as isra, 
> functions that use switch_to(), percpu, ...).

Yes, my cheat-sheet is pretty long as of now, but the things there 
are mainly connected with the "userspace" part and they are not really 
limitations of current kernel implementation. Some of those are solvable 
with relocations and some depend on the patch development process 
(inlining, gcc optimizations and so on). I think it would be great to 
discuss it at Plumbers miniconference. It really depends on a future 
userspace tool which is on the list as well

> I am not really sure whether these should go to limitations, or maybe 
> they'd better be placed into a separate chapter, but I'd really like to 
> see it included.

Apart the limitations Petr has already described there are two more. And 
both quite serious to mention. First, we cannot patch and handle data 
structures. Sometimes it is possible by workaround (for example there 
could be a hole for a new member, because a data structure is aligned; or 
sometimes we can use an existing member for something else and so on), but 
generally we can't.

Second thing, which Jiri mentioned above, is switch_to macro and friends. 
switch_to is inlined to __schedule() (via context_switch()) with many 
other functions. The problem is that switch_to macro does not save RIP in 
x86_64 version (contrary to 32-bit version). So when one patches a 
function inlined to __schedule() (and thus they need to patch the very 
__schedule() because of inlining) it is perfectly possible to crash the 
kernel. New __schedule() function can easily have a different prologue and 
then the interesting thing happens. Let's have two different tasks. One 
calls __schedule(), its registers are stored in a defined order and it 
goes to sleep in switch_to macro. Then we have the second task which calls 
patched__schedule(), it goes to sleep there and as a next task the first 
one is picked. Its RSP is restored and now the registers should be 
restored as well. But the order is different in the new 
patched__schedule(), so... well you get the idea. As a result it is 
currently not possible to patch anything inlined to __schedule(). And 
there are some CVEs out there. For example LDT problem Andy discovered 
last year.

I leave aside that since 499d79559ffe ("sched/core: More notrace 
annotations") it is not even possible to patch __schedule() directly.

This is for sure something we should discuss as well. I have a more or 
less functional solution, but it modifies switch_to macro in a way which 
would easily be nacked by maintainers (I have to perform some measurements 
yet, but it is really ugly. Trust me.).

Miroslav
