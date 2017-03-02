Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYjSS2n1VzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 17:43:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shuah Khan <shuahkh@osg.samsung.com>, bamvor.zhangjian@huawei.com
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 hpa@zytor.com, LKML <linux-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/5] selftests: Fix selftests build to just build,
 not run tests
In-Reply-To: <93f8e25b-8ea6-9dc0-66c4-acb6644724de@osg.samsung.com>
References: <1486630590-9410-1-git-send-email-mpe@ellerman.id.au>
 <87shnhmsl1.fsf@concordia.ellerman.id.au>
 <93f8e25b-8ea6-9dc0-66c4-acb6644724de@osg.samsung.com>
Date: Thu, 02 Mar 2017 17:43:19 +1100
Message-ID: <874lzckwl4.fsf@concordia.ellerman.id.au>
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

Shuah Khan <shuahkh@osg.samsung.com> writes:
> Hi Bamovar,
>
> Your original series badly broke the selftest build. I can no longer
> build individual tests. For example:
>
> cd breakpoints/
> shuah@shuah-XPS-13-9350:/lkml/linux_4.11/tools/testing/selftests/breakpoints$ make
> gcc     breakpoint_test.c  -o /breakpoint_test
> /usr/bin/ld: cannot open output file /breakpoint_test: Permission denied
> collect2: error: ld returned 1 exit status
> ../lib.mk:54: recipe for target '/breakpoint_test' failed
> make: *** [/breakpoint_test] Error 1

I also got a report of that just yesterday.

You can do:

$ cd tools/testing/selftests ; make TARGETS=breakpoints

But it's not ideal.

> commit a8ba798bc8ec663cf02e80b0dd770324de9bafd9
> Author: bamvor.zhangjian@huawei.com <bamvor.zhangjian@huawei.com>
> Date:   Tue Nov 29 19:55:52 2016 +0800
>
>     selftests: enable O and KBUILD_OUTPUT
>
> I believe the above patch is one of the suspects. Michael fixed
> some of the problems in this patch and others he sent.

It is that patch which caused it yes.

> At the moment individual tests will not build.
> tools/testing/selftests/x86$ make
> Makefile:44: warning: overriding recipe for target 'clean'
> ../lib.mk:51: warning: ignoring old recipe for target 'clean'
> gcc -m64 -o /single_step_syscall_64 -O2 -g -std=gnu99 -pthread -Wall  single_step_syscall.c -lrt -ldl
> /usr/bin/ld: cannot open output file /single_step_syscall_64: Permission denied
> collect2: error: ld returned 1 exit status
> Makefile:50: recipe for target '/single_step_syscall_64' failed
> make: *** [/single_step_syscall_64] Error 1
>
>
> My guess is OUTPUT doesn't resolve in individual builds from the test directory.
> We have to get this fixed for 4.11-rc1

Yeah, OUTPUT is passed down from the top-level Makefile.

> Simply Reverting a8ba798bc8ec663cf02e80b0dd770324de9bafd9 doesn't work.
> Michael's patches depend on this. So anyway, please let me know if you
> can fix this quickly. I am going to be trying a few things today as well.

This seems to work, but needs some testing with and without OUTPUT set.

Basically if OUTPUT is not set, assume the current directory. It should
only take effect when someone builds from an individual directory,
because if you build from the top level OUTPUT is already set.


diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index ce96d80ad64f..9087fa949e82 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -2,6 +2,8 @@
 # Makefile can operate with or without the kbuild infrastructure.
 CC := $(CROSS_COMPILE)gcc
 
+OUTPUT ?= $(PWD)
+
 TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 


cheers
