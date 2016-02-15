Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C66B01A0330
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 21:27:22 +1100 (AEDT)
Message-ID: <1455532035.26205.5.camel@ellerman.id.au>
Subject: Re: [PATCH v8 4/8] ppc64 ftrace_with_regs configuration variables
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>, Balbir Singh <bsingharora@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>, Petr
 Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Date: Mon, 15 Feb 2016 21:27:15 +1100
In-Reply-To: <20160211084230.GB29683@lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174450.9C065692C8@newverein.lst.de>
 <1455176897.2885.12.camel@gmail.com> <20160211084230.GB29683@lst.de>
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

Hi guys,

Sorry I haven't been keeping up to date with this thread I've been away.

On Thu, 2016-02-11 at 09:42 +0100, Torsten Duwe wrote:
> On Thu, Feb 11, 2016 at 06:48:17PM +1100, Balbir Singh wrote:
> > On Wed, 2016-02-10 at 17:25 +0100, Torsten Duwe wrote:
> > > +
> > > +echo "int func() { return 0; }" | \
> > > +    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
> > > +    sed -n -e '/func:/,/bl _mcount/p' | grep -q TOC
> > > +
> > > +leaf_toc_result=$?
> > 
> > leaf_toc_result failed for me with gcc 5. I'll try and grab gcc-6
> > and give the patches a spin
> 
> Don't bother. _All_ gccs are broken in that respect currently.

I'm not sure where we got our wires crossed on this one, but this is not a gcc
bug. In fact it's a feature :)

There is explicit code in gcc to check whether the TOC setup is needed and only
emit it when it's required. One case where it's *not* required is when the
function does not TOC accesses. (See rs6000_global_entry_point_needed_p()).

So I think this is just one of the "fun" details we have to deal with to
implement kernel tracing.

The first implication of this is that there is not a single offset value for
the _mcount call, it needs to be calculated per-function. In practice there
will only be two values, so we could try both, or we could just have the code
work it out dynamically by looking for the expected code sequence?

Secondly it means the ftrace trampoline needs to cope with being called with r2
containing something other than the kernel TOC (ie. a module's TOC pointer).
But I think that's solvable also?

cheers
