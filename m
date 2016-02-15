Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D081A1A0338
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 01:04:13 +1100 (AEDT)
Date: Mon, 15 Feb 2016 15:04:08 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Balbir Singh <bsingharora@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Jessica Yu <jeyu@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v8 4/8] ppc64 ftrace_with_regs configuration variables
Message-ID: <20160215140408.GA22872@lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174450.9C065692C8@newverein.lst.de>
 <1455176897.2885.12.camel@gmail.com> <20160211084230.GB29683@lst.de>
 <1455532035.26205.5.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455532035.26205.5.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 15, 2016 at 09:27:15PM +1100, Michael Ellerman wrote:
> 
> There is explicit code in gcc to check whether the TOC setup is needed and only

That's undestood. The claim here is: that check is incomplete, at least.

> emit it when it's required. One case where it's *not* required is when the
> function does not TOC accesses. (See rs6000_global_entry_point_needed_p()).

n.b. I cannot find this symbol in the 4.9.3 tree, but I know what you mean.

The point here is: If you profile using "-pg", gcc perfectly recognises that
it is generating a call to "_mcount", which may be non-local, and loads the TOC.
If you use "-pg -mprofile-kernel", gcc seems to forget that, and omits the TOC
load, for a similar assembler calling sequence.

Looking at the code I can _understand_ why this is so, but my GCC knowledge
is not that deep that I could easily _fix_ this reliably.

[...]

> Secondly it means the ftrace trampoline needs to cope with being called with r2
> containing something other than the kernel TOC (ie. a module's TOC pointer).
> But I think that's solvable also?

That was the alternative I asked about; but given that the _mcount / ftrace_caller
trampoline hardly differs from a normal trampoline (so far), loading R2 would be the
general case, or an excessive special case handling would result.

I'd rather see gcc getting fixed than to have workarounds in all projects that use
it, and others agreed.

	Torsten
