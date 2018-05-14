Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ksKJ2xtyzF3SQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 17:10:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [powerpc:merge 138/138] arch/powerpc/kernel/setup_64.c:354:2:
 error: implicit declaration of function 'this_cpu_enable_ftrace';
 did you mean 'preempt_enable_notrace'?
In-Reply-To: <201805100608.5GVmAvCt%fengguang.wu@intel.com>
References: <201805100608.5GVmAvCt%fengguang.wu@intel.com>
Date: Mon, 14 May 2018 17:10:06 +1000
Message-ID: <871seer9v5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kbuild test robot <lkp@intel.com> writes:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git merge
> head:   900be8ab1549359ba980cfb042a043128204a963
> commit: 900be8ab1549359ba980cfb042a043128204a963 [138/138] Automatic merge of branches 'master', 'next' and 'fixes' into merge
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 900be8ab1549359ba980cfb042a043128204a963
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/ftrace.h:21:0,
>                     from arch/powerpc/include/asm/livepatch.h:23,
>                     from arch/powerpc/kernel/setup_64.c:67:
>    arch/powerpc/include/asm/ftrace.h:2:0: error: unterminated #ifndef
>     #ifndef _ASM_POWERPC_FTRACE
>     
>    arch/powerpc/kernel/setup_64.c: In function 'early_setup':
>>> arch/powerpc/kernel/setup_64.c:354:2: error: implicit declaration of function 'this_cpu_enable_ftrace'; did you mean 'preempt_enable_notrace'? [-Werror=implicit-function-declaration]
>      this_cpu_enable_ftrace();
>      ^~~~~~~~~~~~~~~~~~~~~~
>      preempt_enable_notrace
>    cc1: all warnings being treated as errors
> --
>    In file included from arch/powerpc/kernel/smp.c:62:0:
>    arch/powerpc/include/asm/ftrace.h:2:0: error: unterminated #ifndef
>     #ifndef _ASM_POWERPC_FTRACE

This was caused by a bad merge by me. Fixed now.

cheers
