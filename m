Return-Path: <bamvor.zhangjian@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMnPq1QPCzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:06:39 +1100 (AEDT)
Received: from mail-it0-x22e.google.com (mail-it0-x22e.google.com
 [IPv6:2607:f8b0:4001:c0b::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vMnPp3hsMz9s7M
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Feb 2017 14:06:38 +1100 (AEDT)
Received: by mail-it0-x22e.google.com with SMTP id 203so15914247ith.0
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Feb 2017 19:06:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486630590-9410-1-git-send-email-mpe@ellerman.id.au>
References: <1486630590-9410-1-git-send-email-mpe@ellerman.id.au>
From: Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>
Date: Tue, 14 Feb 2017 11:06:36 +0800
Message-ID: <CAFy1USTVyg5Mq65r-yskvEuaNrxxYHpckrFa1o0OUtn=_ZT38Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] selftests: Fix selftests build to just build,
 not run tests
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shuah Khan <shuahkh@osg.samsung.com>,
 "Zhang Jian(Bamvor)" <bamvor.zhangjian@huawei.com>,
 lkml <linux-kernel@vger.kernel.org>,
 linuxppc-dev@ozlabs.org, linux-kselftest@vger.kernel.org,
 linux-api <linux-api@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tested by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>

On 9 February 2017 at 16:56, Michael Ellerman <mpe@ellerman.id.au> wrote:
> In commit 88baa78d1f31 ("selftests: remove duplicated all and clean
> target"), the "all" target was removed from individual Makefiles and
> added to lib.mk.
>
> However the "all" target was added to lib.mk *after* the existing
> "runtests" target. This means "runtests" becomes the first (default)
> target for most of our Makefiles.
>
> This has the effect of causing a plain "make" to build *and run* the
> tests. Which is at best rude, but depending on which tests are run could
> oops someone's build machine.
>
>   $ make -C tools/testing/selftests/
>   ...
>   make[1]: Entering directory 'tools/testing/selftests/bpf'
>   gcc -Wall -O2 -I../../../../usr/include   test_verifier.c -o tools/testing/selftests/bpf/test_verifier
>   gcc -Wall -O2 -I../../../../usr/include   test_maps.c -o tools/testing/selftests/bpf/test_maps
>   gcc -Wall -O2 -I../../../../usr/include   test_lru_map.c -o tools/testing/selftests/bpf/test_lru_map
>   #0 add+sub+mul FAIL
>   Failed to load prog 'Function not implemented'!
>   #1 unreachable FAIL
>   Unexpected error message!
>   #2 unreachable2 FAIL
>   ...
>
> Fix it by moving the "all" target to the start of lib.mk, making it the
> default target.
>
> Fixes: 88baa78d1f31 ("selftests: remove duplicated all and clean target")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  tools/testing/selftests/lib.mk | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 01bb7782a35e..17ed4bbe3963 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -2,6 +2,11 @@
>  # Makefile can operate with or without the kbuild infrastructure.
>  CC := $(CROSS_COMPILE)gcc
>
> +TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
> +TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
> +
> +all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
> +
>  define RUN_TESTS
>         @for TEST in $(TEST_GEN_PROGS) $(TEST_PROGS); do \
>                 BASENAME_TEST=`basename $$TEST`;        \
> @@ -42,11 +47,6 @@ endef
>  emit_tests:
>         $(EMIT_TESTS)
>
> -TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
> -TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
> -
> -all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
> -
>  clean:
>         $(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-api" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
