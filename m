Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402fvg2MrSzDqBf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 20:15:58 +1100 (AEDT)
Date: Fri, 16 Mar 2018 10:15:49 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Michael Neuling <mikey@neuling.org>, "Bryant G. Ly"
 <bryantly@linux.vnet.ibm.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sergey
 Senozhatsky <sergey.senozhatsky@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Joe Perches <joe@perches.com>,
 Oliver O'Halloran <oohall@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "Tobin C.
 Harding" <me@tobin.cc>
Subject: Re: [PATCH RFC rebase 3/9] powerpc/64: Use barrier_nospec in
 syscall entry
Message-ID: <20180316101549.31238bdf@naga.suse.cz>
In-Reply-To: <20180316151823.2f28d5ea@roar.ozlabs.ibm.com>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
 <b8253774e223530c808eed65d116deecc46ad36b.1521141122.git.msuchanek@suse.de>
 <20180316151823.2f28d5ea@roar.ozlabs.ibm.com>
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

Hello,

On Fri, 16 Mar 2018 15:18:23 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Thu, 15 Mar 2018 20:15:52 +0100
> Michal Suchanek <msuchanek@suse.de> wrote:
> 
> > On powerpc syscall entry is done in assembly so patch in an explicit
> > barrier_nospec.  
> 
> Same comment as Linus for this -- the barriers are before the branch
> here, so is it possible the branch instruction can be speculative
> while the index is used to load the syscall table?

As far as I understand barriers they separate code before the barrier
and code after the barrier.

So inserting barrier_nospec after cmpldi means that the result of the
cmpldi has to be known before any instruction following barrier_nospec
that depends on the result can be executed. 

In many cases it is useful to put the barrier after a branch. It allows
the compiler to speculate on the computed value at compile time and if
it is constrained optimize out the branch. It may also result in the
need to include many barriers and less readable code.

However, you have probably knowledge of the powerpc implementation of
the barrier so if the semantic is actually different then please
enlighten me.

Thanks

Michal
