Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E599C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:18:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99B92064D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 08:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcth4H3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99B92064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RN213p3yzF3SB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 18:18:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dcth4H3R";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="dcth4H3R"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RMw70HDYzF3Jg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 18:13:41 +1000 (AEST)
Received: by mail-wr1-x442.google.com with SMTP id z4-v6so12581155wrb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 01:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=KnHDBIUvlzt9rTbfCGWIVDG2qN/TNs+CUrI8dKvj7bI=;
 b=dcth4H3ROnKOQyOKfGZ3wqLPn8mtEolJcGhLyx8/0zKIcQk4TJIm7O7z4G7SlOSTnz
 ADXuQ1jpCFX+vFMMbgmBjMQkAEEQ3illmAB8I++XTVHTRcT2xR7sGGL04uEWMhdHhSOY
 r+yZxtiB9ejQw2hkDIA3w4InTwEjYyP2DEysE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=KnHDBIUvlzt9rTbfCGWIVDG2qN/TNs+CUrI8dKvj7bI=;
 b=CSJwOclft0nVrX7rVKfmcoaxTN+DDQ1Ys1BV1jxmcIc7KETT8Aj2E263/SNxDqTAn1
 Wn2FwejdEgNbTL1m6aCF9hb+bgT6pZ1DwAZRLL98XFQ5ai3rJ4v+ecGVxQiEEpo9/8Cl
 2Q3c75l7/YirD+RzMRsSbPxKPv6ieAKNjGhcUJ2ZhmYYzd6px4VOcY7h/owdh9wUuqYY
 Wb2W/ALYgSAy1tS5b/2qKSuyUEU/A+x0TTOHd56uFh1ZvyDIxRWwUzFvyo1g3+LkNS6N
 E+Rtkti7p3cpRabi9IIsUTjEEPq6Shi/+A+xi14Vzto0ZbTKJ8Sj3lAPc+8U0ibiCd6U
 j9jA==
X-Gm-Message-State: ABuFfoicJPkZcQ92XWYDQD1axK5Syn9bFgO4crFLXV6QpMYMblIlHYfc
 ROcY7WYEWwuOGtFxajuy+F0l+g==
X-Google-Smtp-Source: ACcGV63IEf58R+KLekGZgZT0K0BuHu6Zlug6fS+8p3vaemq45QqA8lsXEqdU7RfrP0IjMws0XPZRLA==
X-Received: by 2002:adf:8523:: with SMTP id 32-v6mr7729900wrh.72.1538727218578; 
 Fri, 05 Oct 2018 01:13:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:112:6f00:697e:67d9:a05d:22c7])
 by smtp.gmail.com with ESMTPSA id t4-v6sm6565620wrb.45.2018.10.05.01.13.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 01:13:37 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/9] patchable function pointers for pluggable crypto
 routines
Date: Fri,  5 Oct 2018 10:13:24 +0200
Message-Id: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Samuel Neves <sneves@dei.uc.pt>, Paul Mackerras <paulus@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Richard Weinberger <richard@nod.at>,
 Eric Biggers <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-crypto@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Linux's crypto API is widely regarded as being difficult to use for cases
where support for asynchronous accelerators or runtime dispatch of algorithms
(i.e., passed in as a string) are not needed. This leads to kludgy code and
also to actual security issues [0], although arguably, using AES in the wrong
mode can be done using any kind of crypto abstraction.

At the moment, the Zinc library [1] is being proposed as a solution for that,
and while it does address the usability problems, it does a lot more than
that, and what we end up with is a lot less flexible than what we have now.

Currently, arch specific implementations (based on SIMD or optimized
assembler) live in arch/*/crypto, where each sub-community is in charge
of its own specialized versions of the various primitives (although still
under the purview of the crypto maintainer). Any proposal to change this
model should be judged on its own merit, and not blindly accepted as the
fallout of cleaning up some library code.

Also, Zinc removes the possibility to plug different versions of a routine,
and instead, keeps all versions in the same module. Currently, the kernel's
module support permits user land to take charge of the policies that decide
which version to use in which context (by loading or blacklisting modules).
Instead, Zinc moves to a model where the policy is hardcoded into the module
(e.g., ChaCha20 on ARM uses NEON unless on Cortex-A5 or A7). In the ARM
community, we have always attempted to avoid hardcoding policy like that:
the ARM SoC space is a very heteregeneous one, and putting policy like that
into the code will lead to an endless stream of patches from silicon vendors
that want tweaks for their cores into various parts of the kernel.

Creating monolithic modules for algorithms also makes it very difficult to
support driver based implementations. The kernel's driver model is heavily
based on modules, using alias strings to match drivers against the hardware.
As an example, there ARM ST platforms that support synchronous hardware based
CRC32, and plugging that into the monolithic Zinc model is difficult if not
impossible.

The primary justification for moving away from the module system is that it
depends heavily on function pointers, and in the post-Spectre world, those
are vulnerable and costly. For this reason, this series proposes a patchable
function pointer abstraction that, in its generic incarnation, consists
simply of function pointers and some plumbing to set or reset them (patch #1)

Patch #2 illustrates how architectures could optimize these abstractions by
using code patching techniques to get rid of the indirect calls, and use
fixed jumps instead. This has the side effect of making the function
pointer const, making it more robust as well.

The remainder of the series shows how we can use this abstraction to clean
up the CRC-T10DIF handling in the kernel, which is a pretty depressing
example of how cumbersome it is to expose crypto API algorithms as library
routines.

Note that the various arch specific implementations are kept in their
original place as modules, which can be automatically dispatched by udev
(as before) based on CPU feature bits.

Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Samuel Neves <sneves@dei.uc.pt>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org

[0] commit 428490e38b2e ("security/keys: rewrite all of big_key crypto")
[1] https://lore.kernel.org/lkml/20180925145622.29959-3-Jason@zx2c4.com/

Ard Biesheuvel (9):
  kernel: add support for patchable function pointers
  arm64: kernel: add arch support for patchable function pointers
  crypto: crc-t10dif - make crc_t10dif a static inline
  crypto: crc-t10dif - use patchable function pointer for core update
    routine
  crypto: crc-t10dif/arm64 - move PMULL based code into core library
  crypto: crc-t10dif/arm - move PMULL based code into core library
  crypto: crct10dif/generic - switch crypto API driver to core library
  crypto: crc-t10dif/powerpc - move PMULL based code into core library
  crypto: crc-t10dif/x86 - move PMULL based code into core library

 arch/Kconfig                                |   3 +
 arch/arm/crypto/crct10dif-ce-glue.c         |  78 +++-------
 arch/arm64/Kconfig                          |   1 +
 arch/arm64/crypto/crct10dif-ce-glue.c       |  61 ++------
 arch/arm64/include/asm/ffp.h                |  35 +++++
 arch/arm64/kernel/insn.c                    |  22 +++
 arch/powerpc/crypto/crct10dif-vpmsum_glue.c |  55 +-------
 arch/x86/crypto/crct10dif-pclmul_glue.c     |  98 ++-----------
 crypto/Kconfig                              |   1 +
 crypto/Makefile                             |   2 +-
 crypto/crct10dif_common.c                   |  82 -----------
 crypto/crct10dif_generic.c                  |   4 +-
 include/linux/crc-t10dif.h                  |  24 +++-
 include/linux/ffp.h                         |  43 ++++++
 lib/Kconfig                                 |   2 -
 lib/crc-t10dif.c                            | 149 +++++++-------------
 16 files changed, 235 insertions(+), 425 deletions(-)
 create mode 100644 arch/arm64/include/asm/ffp.h
 delete mode 100644 crypto/crct10dif_common.c
 create mode 100644 include/linux/ffp.h

-- 
2.11.0

