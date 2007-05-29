Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9987ADDED0
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 17:24:30 +1000 (EST)
Subject: Saving to 32 bits of GPRs in signal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 29 May 2007 17:24:15 +1000
Message-Id: <1180423456.19517.124.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Steve Munroe <sjmunroe@us.ibm.com>, Anton Blanchard <anton@samba.org>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Folks !

I've been looking at saving & restoring the top 32 bits of 64 bits
registers when delivering signals to 32 bits processes on a 64 bits
kernel. The principle is easy, but I wonder where to stick them.

I was initially tempted to add them to the end of struct mcontext32 but
decided against it.

Then, knowing that we have this uc_regs pointer that points to the
mcontext, I was thinking about adding next to it a uc_highregs pointer
that points to them (and I can then add them anywhere in the signal
frame, the user don't have to know, just follow the pointer).

But that means changing slightly the layout of ucontext32...

Thus my question is which fields in there have their location
ABIficated ? (not necessarily written ABI, but more like gdb "knows"
about them for example, or the infamous old style signal frame unmangler
in gcc C++ exception runtime).

Specifically, are everybody using the uc_regs pointer to get to the
mcontext or are some people likely to expect the mcontext to always be
at the same offset from the beginning of the signal frame ?

I'd like to add my highregs pointer just before the mcontext (after all
the other fields) but I see a uc_pad2 in there which makes me wonder...
I suppose I could also hijack one of the pad fields... they are only
here to make sure the mcontext is 16 bytes aligned right ?

There are a few other issues... one is, the pad fields aren't cleared.
Thus how can userland or rt_sigreturn differenciate between a valid
highregs pointers and ramdom junk ? Is there a trick one of you can come
up with that I could do to let userland/gdb/rt_sigreturn know that
there's something there ?

rt_sigreturn isn't much of a problem since I will initialize the
contexts I create to 0 in that field, and will check the pointer
validity so the worst that can happen is crap in the top 32 bits if some
app mucks around too much, which isn't not a problem.

I'm a bit more worried about how will gdb know that there's something
useful to peek/poke at in there.

Cheers,
Ben
