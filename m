Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 281D81A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 02:23:11 +1100 (AEDT)
Date: Mon, 8 Feb 2016 16:23:06 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Jessica Yu <jeyu@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 04/10] ppc64 ftrace_with_regs configuration variables
Message-ID: <20160208152306.GF30328@pathway.suse.cz>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
 <20160204162053.C76A7692D8@newverein.lst.de>
 <20160205140517.GE3305@pathway.suse.cz>
 <20160205094803.1e0c6c91@gandalf.local.home>
 <20160205161834.GF731@pathway.suse.cz>
 <20160206103243.GB3130@lst.de>
 <20160208103406.GC30328@pathway.suse.cz>
 <20160208121245.GA921@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160208121245.GA921@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon 2016-02-08 13:12:45, Torsten Duwe wrote:
> On Mon, Feb 08, 2016 at 11:34:06AM +0100, Petr Mladek wrote:
> > On Sat 2016-02-06 11:32:43, Torsten Duwe wrote:
> > > On Fri, Feb 05, 2016 at 05:18:34PM +0100, Petr Mladek wrote:
> > > [...]
> > > > more complicated. Whem I think about it, the change below does similar
> > > > job and looks more strightforwad:
> > > 
> > > Had I only looked closer. That's exactly how I thought it would work
> > > in the first place. I'd call that a fix. Full ACK from my side.
> > 
> > Feel free to merge this into your patch. Or do you want to do
> > this in a separate one, please?
> 
> My Kconfig/Makefile changes depend on it, but OTOH this change (Fix!)
> is independent.
> 
> IMHO the right thing would be you resend your second mail from Feb-05,
> with your sign-off, my ack, FWIW, and Steven checks it in ;-)

Please, find it below. I guess that it should be applied before
the check causing the build error. It will help to keep
the tree bisectable.


>From 2b0fcb678d7720d03f9c9f233b61ed9ed4d420b3 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Mon, 8 Feb 2016 16:03:03 +0100
Subject: [PATCH] ftrace: Allow to explicitly disable the build of the dynamic
 ftrace with regs

This patch allows to explicitly disable
CONFIG_DYNAMIC_FTRACE_WITH_REGS. We will need to do so on
PPC with a broken gcc. This situation will be detected at
buildtime and could not be handled by Kbuild automatically.

Also it fixes the prompt of DYNAMIC_FTRACE. The uppercase
better fits the style of the other menu entries.

This patch does not change the default value.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Acked-by: Torsten Duwe <duwe@lst.de>
---
 kernel/trace/Kconfig | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a138f6d866ae..de6dab0f74f2 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -449,7 +449,7 @@ config PROBE_EVENTS
 	def_bool n
 
 config DYNAMIC_FTRACE
-	bool "enable/disable function tracing dynamically"
+	bool "Enable/Disable function tracing dynamically"
 	depends on FUNCTION_TRACER
 	depends on HAVE_DYNAMIC_FTRACE
 	default y
@@ -472,9 +472,17 @@ config DYNAMIC_FTRACE
 	  otherwise has native performance as long as no tracing is active.
 
 config DYNAMIC_FTRACE_WITH_REGS
-	def_bool y
+	bool "Pass registers to function tracer"
 	depends on DYNAMIC_FTRACE
 	depends on HAVE_DYNAMIC_FTRACE_WITH_REGS
+	default y
+	help
+	  This option enables passing the current state of processor
+	  registers to the function tracer. It allows to do a more
+	  detailed analyze and print more information.
+
+	  Say Y here if you are unsure. The only exception is if
+	  you want to pass a build error caused by a broken compiler.
 
 config FUNCTION_PROFILER
 	bool "Kernel function profiler"
-- 
1.8.5.6
