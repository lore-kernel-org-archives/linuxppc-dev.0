Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DDB11A000B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 21:09:23 +1100 (AEDT)
Message-ID: <1455617356.31947.2.camel@ellerman.id.au>
Subject: Re: [PATCH v8 4/8] ppc64 ftrace_with_regs configuration variables
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>
Cc: Balbir Singh <bsingharora@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Jessica Yu
 <jeyu@redhat.com>,  Steven Rostedt <rostedt@goodmis.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Date: Tue, 16 Feb 2016 21:09:16 +1100
In-Reply-To: <20160215140408.GA22872@lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174450.9C065692C8@newverein.lst.de>
 <1455176897.2885.12.camel@gmail.com> <20160211084230.GB29683@lst.de>
 <1455532035.26205.5.camel@ellerman.id.au> <20160215140408.GA22872@lst.de>
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

On Mon, 2016-02-15 at 15:04 +0100, Torsten Duwe wrote:
> On Mon, Feb 15, 2016 at 09:27:15PM +1100, Michael Ellerman wrote:
> > 
> > There is explicit code in gcc to check whether the TOC setup is needed and only
> 
> That's undestood. The claim here is: that check is incomplete, at least.

OK at least we agree on what's happening.

> > emit it when it's required. One case where it's *not* required is when the
> > function does not TOC accesses. (See rs6000_global_entry_point_needed_p()).
> 
> n.b. I cannot find this symbol in the 4.9.3 tree, but I know what you mean.
> 
> The point here is: If you profile using "-pg", gcc perfectly recognises that
> it is generating a call to "_mcount", which may be non-local, and loads the TOC.
> If you use "-pg -mprofile-kernel", gcc seems to forget that, and omits the TOC
> load, for a similar assembler calling sequence.

That's by design.

mprofile-kernel is supposed to create as little overhead as possible in the
non-traced case. All of the burden is shifted to the trace function (_mcount).

The reason to do that is because modern distros always build with tracing, but
most of the time tracing will not actually be active. So we want the cost of
tracing-built-in-but-disabled to be ~zero.

> > Secondly it means the ftrace trampoline needs to cope with being called with r2
> > containing something other than the kernel TOC (ie. a module's TOC pointer).
> > But I think that's solvable also?
> 
> That was the alternative I asked about; but given that the _mcount / ftrace_caller
> trampoline hardly differs from a normal trampoline (so far), loading R2 would be the
> general case, or an excessive special case handling would result.

I'm not sure I follow what you mean there at the end.

Requiring ftrace_caller() to load the kernel TOC is not a problem IMHO.

I think I have an easier way to do it, I'll reply to the patch with that (if it
works).

cheers
