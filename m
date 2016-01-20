Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C7A81A18CC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 20:07:18 +1100 (AEDT)
Date: Wed, 20 Jan 2016 10:07:14 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Jiri Kosina <jkosina@suse.cz>, Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v5 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
Message-ID: <20160120090714.GA7031@lst.de>
References: <20151204152419.28E0D691D2@newverein.lst.de>
 <20160106141730.GL3178@pathway.suse.cz>
 <1453269803.14751.10.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453269803.14751.10.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 20, 2016 at 05:03:23PM +1100, Michael Ellerman wrote:
> On Wed, 2016-01-06 at 15:17 +0100, Petr Mladek wrote:
> > On Fri 2015-12-04 15:45:29, Torsten Duwe wrote:
> > > Changes since v4:
> > >   * change comment style in entry_64.S to C89
> > >     (nobody is using assembler syntax comments there).
> > >   * the bool function restore_r2 shouldn't return 2,
> > >     that's a little confusing.
> > >   * Test whether the compiler supports -mprofile-kernel
> > >     and only then define CC_USING_MPROFILE_KERNEL
> > >   * also make the return value of klp_check_compiler_support
> > >     depend on that.
> >
> > Note that there is still needed the extra patch from
> > http://thread.gmane.org/gmane.linux.kernel/2093867/focus=2099603
> > to get the livepatching working.
> 
> Sorry which extra patch?
Message-ID: <20151203160004.GE8047@pathway.suse.cz>
By Petr Mladek, "Re: [PATCH v4 0/9] ftrace with regs + live patching..."
2015-12-03. It is further up in the function call hierarchy and basically
tells the arch-independent KLP to call the normal entry point on ppc64le, and
that the _mcount call site is 16 bytes further.


> > Both ftrace with regs and live patching works for me with this patch
> > set and the extra patch. So. for the whole patchset:
> >
> > Tested-by: Petr Mladek <pmladek@suse.com>
> 
> Can you give me some more info on how you're testing it? What config options,
> toolchain etc.?
> 
> For me the series doesn't even boot, even with livepatching disabled.

May indeed be a toolchain issue. I had to fix gcc-4.8.5 to get "notrace" working
for -mprofile-kernel. That's a gcc bug.

What are you using?

The config in the v5 patch series should be waterproof, especially with KLP disabled
ftrace with regs must work (all self-tests succeeded). If you send me your config
(via PM I suggest, spare the lists) I can verify it with the toolchain here.
Petr made a suggestion to reshuffle the config options to have it cleaner;
I suggest to patch that separately.

	Torsten
