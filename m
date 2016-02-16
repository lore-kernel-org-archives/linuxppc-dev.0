Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 565AC1A000C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 21:35:55 +1100 (AEDT)
Date: Tue, 16 Feb 2016 11:35:51 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Balbir Singh <bsingharora@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Jessica Yu <jeyu@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v8 4/8] ppc64 ftrace_with_regs configuration variables
Message-ID: <20160216103551.GA25103@lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174450.9C065692C8@newverein.lst.de>
 <1455176897.2885.12.camel@gmail.com> <20160211084230.GB29683@lst.de>
 <1455532035.26205.5.camel@ellerman.id.au> <20160215140408.GA22872@lst.de>
 <1455617356.31947.2.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455617356.31947.2.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 16, 2016 at 09:09:16PM +1100, Michael Ellerman wrote:
> On Mon, 2016-02-15 at 15:04 +0100, Torsten Duwe wrote:
> > If you use "-pg -mprofile-kernel", gcc seems to forget that, and omits the TOC
> > load, for a similar assembler calling sequence.
> 
> That's by design.

Ah, ok.

> mprofile-kernel is supposed to create as little overhead as possible in the
> non-traced case. All of the burden is shifted to the trace function (_mcount).

... or its helpers, see below.

> The reason to do that is because modern distros always build with tracing, but
> most of the time tracing will not actually be active. So we want the cost of
> tracing-built-in-but-disabled to be ~zero.

Ok, that's a design goal.

> > That was the alternative I asked about; but given that the _mcount / ftrace_caller
> > trampoline hardly differs from a normal trampoline (so far), loading R2 would be the
> > general case, or an excessive special case handling would result.
> 
> I'm not sure I follow what you mean there at the end.

This suggests you have not yet actively debugged this problem ;-)

> Requiring ftrace_caller() to load the kernel TOC is not a problem IMHO.

The problem is, you don't get to ftrace_caller in the first place :)

> I think I have an easier way to do it, I'll reply to the patch with that (if it
> works).

I doubt so. Either it works, _or_ it is easier ;)

To save you some work: by the design of minimal overhead you try to follow,
SQUASH_TOC_SAVE_INSN from my patches isn't sufficient. You'll need to load the
_current_ TOC _on_ the trampoline, and in turn it will be different from the regular
trampolines; and that needs to be recognised, or the normal module linker logic
won't work.

OTOH my proposed GCC change only affects a very limited number of functions...

Looking forward to your patch!

	Torsten
