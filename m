Return-Path: <SRS0=nxP5=37=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB32C352A4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 02:53:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A1520733
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 02:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="KiyG58KO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A1520733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48GnQm2NLNzDqDs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 13:53:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48GnLy1316zDqLt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2020 13:50:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=KiyG58KO; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48GnLx2h15z9sP7;
 Tue, 11 Feb 2020 13:50:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1581389417;
 bh=BUV6k8b4/tEi4PgXiYi4XOSMaNTQi4awrwVuF6nbQKg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=KiyG58KOvujvM95ACCeJJIpDaFgjROxtgymhz4D8vCzlr9CSrjHECEcd02zTz6mh0
 qm4p9sZFS4aXmJt3o6Ar/UO2zEqYlPwTh2VT9kKwEBGP+KJ/9GaYEJCutIQ/00Ebit
 qCyeh/TXMW0k4Zv11ydg02PcEc+YpCeSP1I8TvN1aDVjUMFik2gPqsTzzlQgRrtx3X
 03QEqasOQLwgW7Lg1l+AbQt+vGy68t/+u6sUADbX6rOGefrEJS/eBfZcj66ymDMB0i
 L38dBZcY4WJm8NlqI7096qn+FOeN7p8oNQN3EuiKiYKLSeeJD7K+26UBwwA74XmeHT
 ov63hnh/OiWZQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sandipan Das <sandipan@linux.ibm.com>, shuah@kernel.org,
 skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: vm: Fix 64-bit test builds for powerpc64le
In-Reply-To: <e9178d28dddfc64a23ffd51e2fecd06ad16ac92a.1580367152.git.sandipan@linux.ibm.com>
References: <cover.1580367152.git.sandipan@linux.ibm.com>
 <e9178d28dddfc64a23ffd51e2fecd06ad16ac92a.1580367152.git.sandipan@linux.ibm.com>
Date: Tue, 11 Feb 2020 13:50:16 +1100
Message-ID: <87imkdzvkn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-mm@kvack.org, kamalesh@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mhiramat@kernel.org, aneesh.kumar@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sandipan Das <sandipan@linux.ibm.com> writes:
> Some tests are built only for 64-bit systems. This makes
> sure that these tests are built for both big and little
> endian variants of powerpc64.
>
> Fixes: 7549b3364201 ("selftests: vm: Build/Run 64bit tests only on 64bit arch")
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
> ---
>  tools/testing/selftests/vm/Makefile    | 2 +-
>  tools/testing/selftests/vm/run_vmtests | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 3f2e2f0ccbc9..8074340c6b3a 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -19,7 +19,7 @@ TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += userfaultfd
>  
> -ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
> +ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64 sparc64 x86_64))
>  TEST_GEN_FILES += va_128TBswitch
>  TEST_GEN_FILES += virtual_address_range
>  endif
> diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
> index a692ea828317..db8e0d1c7b39 100755
> --- a/tools/testing/selftests/vm/run_vmtests
> +++ b/tools/testing/selftests/vm/run_vmtests
> @@ -59,7 +59,7 @@ else
>  fi
>  
>  #filter 64bit architectures
> -ARCH64STR="arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64"
> +ARCH64STR="arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64 sparc64 x86_64"
>  if [ -z $ARCH ]; then
>    ARCH=`uname -m 2>/dev/null | sed -e 's/aarch64.*/arm64/'`
>  fi
> -- 
> 2.17.1
