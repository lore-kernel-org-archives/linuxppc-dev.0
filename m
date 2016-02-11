Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BE911A003C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 17:18:32 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id e127so2065614pfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 22:18:32 -0800 (PST)
Message-ID: <1455171503.2885.6.camel@gmail.com>
Subject: Re: [PATCH v8 0/8] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
From: Balbir Singh <bsingharora@gmail.com>
To: Torsten Duwe <duwe@lst.de>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>, Jiri
 Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, live-patching@vger.kernel.org, Miroslav Benes
 <mbenes@suse.cz>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 11 Feb 2016 17:18:23 +1100
In-Reply-To: <20160210174221.EBBEC692C8@newverein.lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
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

On Wed, 2016-02-10 at 18:29 +0100, Torsten Duwe wrote:
> Changes since V7:
>   * drop "notrace" attribute for MMU-aiding functions
>     and their callees.
>   * merge "-mprofile-kernel"-stripping patches into one.
> 
> Changes since v6:
>   * include Petr's patch, on popular demand ;)
>   * move #ifdefs out of functions for readability;
>     introduce static helper functions instead.
>   * No more literal binary instructions in hex,
>     at least not added by this patch set.
>   * add compile time checker to detect the presence
>     of known-good -mprofile-kernel support.
>   * limit Kconfig / compile to the configurations really supported:
>     + (static) FTRACE with -pg
>     +  DYNAMIC_FTRACE with -pg with or without -mprofile-kernel
>        (depending on the compiler)
>     +  DYNAMIC_FTRACE_WITH_REGS only with -mprofile-kernel
>        (will error out if the compiler is broken)
> 
> Changes since v5:
>   * extra "std r0,LRSAVE(r1)" for gcc-6
>     This makes the code compiler-agnostic.
>   * Follow Petr Mladek's suggestion to avoid
>     redefinition of HAVE_LIVEPATCH
> 
> Changes since v4:
>   * change comment style in entry_64.S to C89
>     (nobody is using assembler syntax comments there).
>   * the bool function restore_r2 shouldn't return 2,
>     that's a little confusing.
>   * Test whether the compiler supports -mprofile-kernel
>     and only then define CC_USING_MPROFILE_KERNEL
>   * also make the return value of klp_check_compiler_support
>     depend on that.
> 
> Major changes since v3:
>   * the graph tracer works now.
>     It turned out the stack frame it tried to manipulate does not
>     exist at that point.
>   * changes only needed in order to support -mprofile-kernel are now
>     in a separate patch, prepended.
>   * Kconfig cleanup so this is only selectable on ppc64le.
> 
> Petr Mladek (1):
>   livepatch: Detect offset for the ftrace location during build
> 
> Torsten Duwe (7):
>   ppc64 (le): prepare for -mprofile-kernel
>   ppc64le FTRACE_WITH_REGS implementation
>   ppc use ftrace_modify_all_code default
>   ppc64 ftrace_with_regs configuration variables
>   ppc64 ftrace_with_regs: disable profiling for some files
>   Implement kernel live patching for ppc64le (ABIv2)
>   Enable LIVEPATCH to be configured on ppc64le and add livepatch.o if it
>     is selected
> 
>  arch/powerpc/Kconfig                        |   6 +
>  arch/powerpc/Makefile                       |  17 +++
>  arch/powerpc/gcc-mprofile-kernel-notrace.sh |  33 ++++++
>  arch/powerpc/include/asm/code-patching.h    |  24 ++++
>  arch/powerpc/include/asm/ftrace.h           |   5 +
>  arch/powerpc/include/asm/livepatch.h        |  45 ++++++++
>  arch/powerpc/kernel/Makefile                |  13 ++-
>  arch/powerpc/kernel/entry_64.S              | 169
> +++++++++++++++++++++++++++-
>  arch/powerpc/kernel/ftrace.c                | 129 ++++++++++++++++-----
>  arch/powerpc/kernel/livepatch.c             |  38 +++++++
>  arch/powerpc/kernel/module_64.c             |  56 ++++++++-
>  arch/powerpc/lib/Makefile                   |   4 +-
>  arch/s390/Kconfig                           |   1 +
>  kernel/livepatch/Makefile                   |  13 +++
>  kernel/livepatch/core.c                     |  12 +-
>  kernel/livepatch/ftrace-test.c              |   6 +
>  kernel/trace/Kconfig                        |   5 +
>  scripts/recordmcount.c                      |   6 +-
>  scripts/recordmcount.h                      |  17 ++-
>  19 files changed, 552 insertions(+), 47 deletions(-)
>  create mode 100755 arch/powerpc/gcc-mprofile-kernel-notrace.sh
>  create mode 100644 arch/powerpc/include/asm/livepatch.h
>  create mode 100644 arch/powerpc/kernel/livepatch.c
>  create mode 100644 kernel/livepatch/ftrace-test.c
> 

Quick question - I presume these apply on top of 4.5.0-rc2?

Balbir Singh.
