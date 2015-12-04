Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DBC51A0C65
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2015 20:01:54 +1100 (AEDT)
Date: Fri, 4 Dec 2015 10:01:50 +0100
From: Torsten Duwe <duwe@lst.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v4 4/9] ppc64 ftrace_with_regs configuration variables
Message-ID: <20151204090150.GA2861@lst.de>
References: <20151125172608.9588569260@newverein.lst.de>
 <20151125172916.9D50269260@newverein.lst.de>
 <20151203162008.GF8047@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151203162008.GF8047@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 03, 2015 at 05:20:08PM +0100, Petr Mladek wrote:
>
> IMHO, we should not define CC_USING_MPROFILE_KERNEL if it is not
> supported by the compiler.

Yes, true.

> I took inspiration from the CC_USING_FENTRY handling in
> linux/Makefile. The following code worked for me:
>
> CC_USING_MPROFILE_KERNEL := $(call cc-option, -pg -mprofile-kernel -DCC_USING_MPROFILE_KERNEL)
> CC_FLAGS_FTRACE := $(CC_USING_MPROFILE_KERNEL)
> KBUILD_CPPFLAGS += $(CC_USING_MPROFILE_KERNEL)

Excellent!

> I just do not understand why we need to add the flags also
> to KBUILD_CPPFLAGS. It seems that they are duplicated
> when compiling kernel/livepatch/core.o. But livepatching
> did not work without it. I wonder if you found the culprit.

Some assembler-with-cpp files also need to be notified?

My plan is to first get this working reliably and then fine tune.

	Torsten
