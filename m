Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 369CC1A01D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 03:47:18 +1100 (AEDT)
Date: Tue, 2 Feb 2016 17:47:14 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Miroslav Benes <mbenes@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, anton@samba.org,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v6 8/9] Implement kernel live patching for ppc64le (ABIv2)
Message-ID: <20160202164714.GU3305@pathway.suse.cz>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170804.A11DB692DD@newverein.lst.de>
 <alpine.LNX.2.00.1601261142190.24510@pobox.suse.cz>
 <20160126124853.GL3305@pathway.suse.cz>
 <20160202121224.GS3305@pathway.suse.cz>
 <20160202154523.GF32095@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160202154523.GF32095@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue 2016-02-02 16:45:23, Torsten Duwe wrote:
> On Tue, Feb 02, 2016 at 01:12:24PM +0100, Petr Mladek wrote:
> > 
> > Hmm, the size of the offset is not a constant. In particular, leaf
> > functions do not set TOC before the mcount location.
> 
> To be slightly more precise, a leaf function that additionally uses
> no global data. No global function calls, no global data access =>
> no need to load the TOC.

Thanks for explanation.
 
> > The result is that kernel crashes when trying to trace leaf function
> 
> The trampoline *requires* a proper TOC pointer to find the remote function
> entry point. If you jump onto the trampoline with the TOC from the caller's
> caller you'll grab some address from somewhere and jump into nirvana.

The dmesg messages suggested someting like this.


> > By other words, it seems that the code generated with -mprofile-kernel
> > option has been buggy in all gcc versions.
> 
> Either that or we need bigger trampolines for everybody.
> 
> Michael, should we grow every module trampoline to always load R2,
> or fix GCC to recognise the generated bl _mcount as a global function call?
> Anton, what do you think?

BTW: Is the trampoline used also for classic probes? If not, we might need
a trampoline for them as well.

Note that TOC is not set only when the problematic functions are
compiled with --mprofile-kernel. I still see the TOC stuff when
compiling only with -pg.


Best Regards,
Petr
