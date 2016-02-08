Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DB141A0167
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 03:32:31 +1100 (AEDT)
Date: Mon, 8 Feb 2016 17:32:26 +0100
From: Petr Mladek <pmladek@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Torsten Duwe <duwe@lst.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Jessica Yu <jeyu@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 04/10] ppc64 ftrace_with_regs configuration variables
Message-ID: <20160208163226.GH30328@pathway.suse.cz>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
 <20160204162053.C76A7692D8@newverein.lst.de>
 <20160205140517.GE3305@pathway.suse.cz>
 <20160205094803.1e0c6c91@gandalf.local.home>
 <20160205161834.GF731@pathway.suse.cz>
 <20160206103243.GB3130@lst.de>
 <20160208103406.GC30328@pathway.suse.cz>
 <20160208121245.GA921@lst.de>
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

On Mon 2016-02-08 10:49:28, Steven Rostedt wrote:
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
> error? If so, then you can have Kbuild automatically detect this and
> set the proper value. We do this with 'asm goto'. There's tricks in the
> build system that can change the configs based on if a compiler is
> broken or not.

Just to be sure.

Do you suggest to define CONFIG_DYNAMIC_FTRACE_WITH_REGS
via a check in Makefile and rename it to e.g.
CC_FTRACE_WITH_REGS.

Or should we define another variable, e.g.
CC_BROKEN_DYNAMC_FTRACE_WITH_REGS? And then replace all occurences in
the code by something like:

-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#if defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS) && \
+    !defined(CC_BROKEN_DYNAMC_FTRACE_WITH_REGS)

?

Best Regards,
Petr
