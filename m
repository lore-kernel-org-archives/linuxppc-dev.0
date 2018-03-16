Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402mWL00djzDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 00:28:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, Nicholas Piggin
 <npiggin@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Michael Neuling <mikey@neuling.org>, "Bryant G. Ly"
 <bryantly@linux.vnet.ibm.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sergey
 Senozhatsky <sergey.senozhatsky@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Joe Perches <joe@perches.com>,
 Oliver O'Halloran <oohall@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "Tobin C.
 Harding" <me@tobin.cc>
Subject: Re: [PATCH RFC rebase 3/9] powerpc/64: Use barrier_nospec in syscall
 entry
In-Reply-To: <20180316101549.31238bdf@naga.suse.cz>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
 <b8253774e223530c808eed65d116deecc46ad36b.1521141122.git.msuchanek@suse.de>
 <20180316151823.2f28d5ea@roar.ozlabs.ibm.com>
 <20180316101549.31238bdf@naga.suse.cz>
Date: Sat, 17 Mar 2018 00:28:42 +1100
Message-ID: <873710i1yt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michal,

Thanks for working on this series in the absence of any documentation.

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> On Fri, 16 Mar 2018 15:18:23 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>
>> On Thu, 15 Mar 2018 20:15:52 +0100
>> Michal Suchanek <msuchanek@suse.de> wrote:
>>=20
>> > On powerpc syscall entry is done in assembly so patch in an explicit
>> > barrier_nospec.=20=20
>>=20
>> Same comment as Linus for this -- the barriers are before the branch
>> here, so is it possible the branch instruction can be speculative
>> while the index is used to load the syscall table?
>
> As far as I understand barriers they separate code before the barrier
> and code after the barrier.
>
> So inserting barrier_nospec after cmpldi means that the result of the
> cmpldi has to be known before any instruction following barrier_nospec
> that depends on the result can be executed.=20

That would make sense, but I don't think that's how the barrier's been
defined.

I don't have a formal spec for it (yet), but what I do have indicates it
only orders older branches vs future instructions.

> However, you have probably knowledge of the powerpc implementation of
> the barrier so if the semantic is actually different then please
> enlighten me.

We have some knowledge, but only some :)

It's not necessarily implemented the same way on each chip revision, so
it's not entirely clear what the formal semantics will be vs what we are
seeing in current implementations. But I think it's safe to say it
should always go after the branch that might be speculatively executed.

Will try and get some better documentation for you.

cheers
