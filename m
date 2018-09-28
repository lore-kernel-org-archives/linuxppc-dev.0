Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9537BC43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 04:54:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EACC1216FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 04:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACC1216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Lzq65qYFzF3BX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 14:54:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Lzn64LTfzF396
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 14:52:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Lzn31BLwz9s3Z;
 Fri, 28 Sep 2018 14:52:22 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anders Roxell <anders.roxell@linaro.org>, yamada.masahiro@socionext.com,
 michal.lkml@markovi.net, shuah@kernel.org, bamv2005@gmail.com, brgl@bgdev.pl,
 pbonzini@redhat.com, akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
 aarcange@redhat.com
Subject: Re: [PATCH v6] selftests: add headers_install to lib.mk
In-Reply-To: <20180904104721.27535-1-anders.roxell@linaro.org>
References: <20180809080402.24469-1-anders.roxell@linaro.org>
 <20180904104721.27535-1-anders.roxell@linaro.org>
Date: Fri, 28 Sep 2018 14:52:22 +1000
Message-ID: <87y3bmte9l.fsf@concordia.ellerman.id.au>
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
Cc: Anders Roxell <anders.roxell@linaro.org>, linux-kbuild@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[ + linuxppc-dev ]

Anders Roxell <anders.roxell@linaro.org> writes:
> If the kernel headers aren't installed we can't build all the tests.
> Add a new make target rule 'khdr' in the file lib.mk to generate the
> kernel headers and that gets include for every test-dir Makefile that
> includes lib.mk If the testdir in turn have its own sub-dirs the
> top_srcdir needs to be set to the linux-rootdir to be able to generate
> the kernel headers.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
> ---
>
> I sent this (v5) a month ago and wondered if it got lost. Resending
> unchanged.
>
> Cheers,
> Anders
>
>  Makefile                                           | 14 +-------------
>  scripts/subarch.include                            | 13 +++++++++++++
>  tools/testing/selftests/android/Makefile           |  2 +-
>  tools/testing/selftests/android/ion/Makefile       |  2 ++
>  tools/testing/selftests/futex/functional/Makefile  |  1 +
>  tools/testing/selftests/gpio/Makefile              |  7 ++-----
>  tools/testing/selftests/kvm/Makefile               |  7 ++-----
>  tools/testing/selftests/lib.mk                     | 12 ++++++++++++
>  tools/testing/selftests/net/Makefile               |  1 +
>  .../selftests/networking/timestamping/Makefile     |  1 +
>  tools/testing/selftests/vm/Makefile                |  4 ----
>  11 files changed, 36 insertions(+), 28 deletions(-)
>  create mode 100644 scripts/subarch.include

This broke all the powerpc selftests :(

Why did it go in at rc5?

cheers
