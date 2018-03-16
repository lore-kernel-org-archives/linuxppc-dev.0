Return-Path: <linus971@gmail.com>
Received: from mail-it0-x22f.google.com (mail-it0-x22f.google.com
 [IPv6:2607:f8b0:4001:c0b::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402sP448yJzF1Dg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 04:08:40 +1100 (AEDT)
Received: by mail-it0-x22f.google.com with SMTP id g7-v6so2932023itf.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 10:08:40 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180316101549.31238bdf@naga.suse.cz>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
 <b8253774e223530c808eed65d116deecc46ad36b.1521141122.git.msuchanek@suse.de>
 <20180316151823.2f28d5ea@roar.ozlabs.ibm.com>
 <20180316101549.31238bdf@naga.suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Mar 2018 10:08:37 -0700
Message-ID: <CA+55aFxYOrn0XRPF8EXvizqAf3GOGmUxu-aKrqvtOsbgxwP2tg@mail.gmail.com>
Subject: Re: [PATCH RFC rebase 3/9] powerpc/64: Use barrier_nospec in syscall
 entry
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Michael Neuling <mikey@neuling.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Joe Perches <joe@perches.com>, "Oliver O'Halloran" <oohall@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 16, 2018 at 2:15 AM, Michal Such=C3=A1nek <msuchanek@suse.de> w=
rote:
>
> As far as I understand barriers they separate code before the barrier
> and code after the barrier.

Almost certainly not. Even if you were to do an expensive
serialization before the branch, the branch will still predict after
the serialization.

The thing is, it doesn't make sense to insert a barrier before a
conditional branch for Spectre mitigation.

The problem is not that the data isn't ready for the branch - the
problem is that the branch is predicted _regardless_ of the data.

Sure, some micro-architecture might not predict branches at all if
they have a stable conditional, so a barrier _can_ make sense.

But fundamentally, good branch prediction - in order to be optimal -
has to happen before instructions have even been parsed, much less
things like "stable conditional register state" having been decided
on. You'll want to do I$ prefetching etc.

So the problem is that even if the data is ready, the branch will be
predicted according to some unrelated historical data, and a barrier
to make the branch conditional be stable is pointless.

A barrier *after* the branch, making sure that you don't actually
start executing instructions past it (even if you might have predicted
and fetched stuff past it) *if* you have mis-predicted the previous
branch, is what a sane architecture would specify.

Of course, on x86, we mostly tried to avoid branch prediction being
the critical problem and having to have barriers by just making it an
address generation dependency instead. That should presumably work on
powerpc too, since address generation is part of the memory ordering
definition. But obviously a microarchitecture *could* end up
speculating and just redoing even for memory ordering, and maybe the
ppc architects prefer the barrier since they are already used to crazy
and not very well architected barriers elsewhere.

              Linus
