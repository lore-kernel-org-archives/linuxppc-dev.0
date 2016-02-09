Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C6941A02CE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 20:02:40 +1100 (AEDT)
Date: Tue, 9 Feb 2016 10:02:36 +0100
From: Torsten Duwe <duwe@lst.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Jessica Yu <jeyu@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 04/10] ppc64 ftrace_with_regs configuration variables
Message-ID: <20160209090236.GA20503@lst.de>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
 <20160204162053.C76A7692D8@newverein.lst.de>
 <20160205140517.GE3305@pathway.suse.cz>
 <20160205094803.1e0c6c91@gandalf.local.home>
 <20160205161834.GF731@pathway.suse.cz> <20160206103243.GB3130@lst.de>
 <20160208103406.GC30328@pathway.suse.cz> <20160208121245.GA921@lst.de>
 <20160208152306.GF30328@pathway.suse.cz>
 <20160208104928.3b86f8ff@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160208104928.3b86f8ff@gandalf.local.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 08, 2016 at 10:49:28AM -0500, Steven Rostedt wrote:
> On Mon, 8 Feb 2016 16:23:06 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > >From 2b0fcb678d7720d03f9c9f233b61ed9ed4d420b3 Mon Sep 17 00:00:00 2001  
> > From: Petr Mladek <pmladek@suse.com>
> > Date: Mon, 8 Feb 2016 16:03:03 +0100
> > Subject: [PATCH] ftrace: Allow to explicitly disable the build of the dynamic
> >  ftrace with regs
> > 
> > This patch allows to explicitly disable
> > CONFIG_DYNAMIC_FTRACE_WITH_REGS. We will need to do so on
> > PPC with a broken gcc. This situation will be detected at
> > buildtime and could not be handled by Kbuild automatically.
> 
> Wait. Can it be detected at build time? That is, does it cause a build

Yes, I wrote a test to detect it at build time. It is similar to "asm goto"
and part of the v7 patch set.

> error? If so, then you can have Kbuild automatically detect this and
> set the proper value. We do this with 'asm goto'. There's tricks in the
> build system that can change the configs based on if a compiler is
> broken or not.

Please clarify. All I could find is Makefile magic that does it. AFAICS
This runs _after_ Kconfig.

But what I'd like to see is to offer the user the full choice, where possible,
e.g.

Kernel Tracing ...
0) none
1) static FTRACE
2) DYNAMIC_FTRACE
3) DYNAMIC_FTRACE_WITH_REGS

Can such a test be used to simply reduce these options?
With Petr's patch, it comes quite close to the above, and if you select "3"
and your compiler is broken, compilation will fail. For "2", it will just do
the right thing ( fall back to plain "-pg" ).

Without Petr's patch you have *no* choice between "2" and "3".
(That's what I'd call a bug :)

So, the question is, can such a test be used to provide _input_ to
"make config" ? I can see the "env=" mechanism, but it seems not to be used
very heavily. That would then be a prerequisite to all "make *config".
Even if it can provide this input, you can still not choose between 2 and 3
where both are available.

	Torsten
