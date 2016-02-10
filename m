Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 711C51A03B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 05:01:15 +1100 (AEDT)
Date: Wed, 10 Feb 2016 19:01:12 +0100
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v7 06/10] ppc64 ftrace: disable profiling for some
 functions
Message-ID: <20160210180112.GB19199@lst.de>
References: <20160204161527.5F3AC692CD@newverein.lst.de>
 <20160204162107.65ECE692DF@newverein.lst.de>
 <1455069038.7576.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455069038.7576.6.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 10, 2016 at 12:50:38PM +1100, Michael Ellerman wrote:
> On Mon, 2016-01-25 at 16:31 +0100, Torsten Duwe wrote:
> 
> > At least POWER7/8 have MMUs that don't completely autoload;
> > a normal, recoverable memory fault might pass through these functions.
> > If a dynamic tracer function causes such a fault, any of these functions
> > being traced with -mprofile-kernel may cause an endless recursion.
> 
> I'm not really happy with this one, still :)

I understand :)

> At the moment I can trace these without any problems, with either ftrace or
> kprobes, but obviously it was causing you some trouble. So I'd like to
> understand why you were having issues when regular tracing doesn't.

It was causing huge trouble during development. Make the smallest mistake
and the machine appears to freeze, unless you happen to have a gdb
beneath the VM, which tells you that it's "only" locking rock-hard into
an endless recursion. Hint: printk() is part of the recurse, usually :-/

> If it's the case that tracing can work for these functions, but live patching
> doesn't (for some reason), then maybe these should be blocked by the live
> patching infrastructure rather than at the ftrace/kprobes level.

Now with a matured patch set, the machine survives up to the point where the
NOPs are placed and all is fine. (until someone places probes there :)

But I still have a bad feeling about this. On other architectures, this
functionality is done in hardware; the functions cannot be traced either,
and the don't break (usually ;) I would rather not instrument them.

But if you don't like this patch, and it strictly isn't neccessary --
here you go: v8.

	Torsten
