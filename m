Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 523081A01D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 02:45:27 +1100 (AEDT)
Date: Tue, 2 Feb 2016 16:45:23 +0100
From: Torsten Duwe <duwe@lst.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, anton@samba.org,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v6 8/9] Implement kernel live patching for ppc64le (ABIv2)
Message-ID: <20160202154523.GF32095@lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170804.A11DB692DD@newverein.lst.de>
 <alpine.LNX.2.00.1601261142190.24510@pobox.suse.cz>
 <20160126124853.GL3305@pathway.suse.cz>
 <20160202121224.GS3305@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160202121224.GS3305@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 02, 2016 at 01:12:24PM +0100, Petr Mladek wrote:
> 
> Hmm, the size of the offset is not a constant. In particular, leaf
> functions do not set TOC before the mcount location.

To be slightly more precise, a leaf function that additionally uses
no global data. No global function calls, no global data access =>
no need to load the TOC.

> For example, the code generated for int_to_scsilun() looks like:
> 
> 
> 00000000000002d0 <int_to_scsilun>:
>  2d0:   a6 02 08 7c     mflr    r0
>  2d4:   10 00 01 f8     std     r0,16(r1)
>  2d8:   01 00 00 48     bl      2d8 <int_to_scsilun+0x8>
>                         2d8: R_PPC64_REL24      _mcount
[...]
> The above code is generated from kernel-4.5-rc1 sources using
> 
> $> gcc --version
> gcc (SUSE Linux) 4.8.5
> 
> But I get similar code also with
> 
> $> gcc-6 --version
> gcc-6 (SUSE Linux) 6.0.0 20160121 (experimental) [trunk revision 232670]
> 
> 
> The result is that kernel crashes when trying to trace leaf function

The trampoline *requires* a proper TOC pointer to find the remote function
entry point. If you jump onto the trampoline with the TOC from the caller's
caller you'll grab some address from somewhere and jump into nirvana.

> By other words, it seems that the code generated with -mprofile-kernel
> option has been buggy in all gcc versions.

Either that or we need bigger trampolines for everybody.

Michael, should we grow every module trampoline to always load R2,
or fix GCC to recognise the generated bl _mcount as a global function call?
Anton, what do you think?

	Torsten
