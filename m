Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03E771A0338
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 22:39:14 +1100 (AEDT)
Message-ID: <1455709153.23614.4.camel@ellerman.id.au>
Subject: Re: [PATCH v8 1/8] ppc64 (le): prepare for -mprofile-kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>, Petr
 Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Date: Wed, 17 Feb 2016 22:39:13 +1100
In-Reply-To: <20160217113022.GA9578@lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174435.06578692C8@newverein.lst.de>
 <1455706540.4450.2.camel@ellerman.id.au> <20160217113022.GA9578@lst.de>
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

On Wed, 2016-02-17 at 12:30 +0100, Torsten Duwe wrote:
> On Wed, Feb 17, 2016 at 09:55:40PM +1100, Michael Ellerman wrote:
> > 
> > On a kernel built with the 2 instruction version this will fault when the
> > function we're looking at is located at the beginning of a page. Because
> > instruction[-3] goes off the front of the mapping.
> > 
> > We can probably fix that. But it's still a bit dicey.
> 
> Not necessarily. Now that it's a separate function, it can be nested a bit deeper,
> so we don't take chances on compiler optimisation:
> 
> if (instruction[-2] == PPC_INST_STD_LR) /* where should R0 come from? there must be... */
>   {
>     if (instruction[-3] == PPC_INST_MFLR)
>       return 1;
>   }
> else if (instruction[-2] == PPC_INST_MFLR)
>     return 1;
> return 0;

Yeah true that should work in practice.

It's still trivial to construct a module that will oops the loader, but I guess
that's always been true.

> > I'm wondering if we want to just say we only support the 2 instruction version.
> > Currently that means GCC 6 only, or a distro compiler with the backport of
> > e95d0248dace. But we could also ask GCC to backport it to 4.9 and 5.
> 
> IMHO that's a too weak reason for a too strong limitation. OTOH getting everyone
> to use the 2 insn version sounds appealing...

Fair enough. I'm just trying to manage the complexity explosion.

I'd certainly advocate that you backport it to your toolchain.

> Is e95d0248dace self-sufficient or does it depend on other improvements?

AFAIK it's self sufficient, it just deletes a single line. I'll ask the GCC
guys tomorrow if they can backport it if you don't beat me to it :)

cheers
