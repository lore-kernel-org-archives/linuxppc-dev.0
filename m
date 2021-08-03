Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96323C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Aug 2021 10:54:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8273360F94
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Aug 2021 10:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8273360F94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GfBZX3b05z30Gg
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Aug 2021 20:54:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=geuqcauT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=geuqcauT; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GfBZ54t0kz306F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Aug 2021 20:53:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GfBZ34C1Mz9sS8;
 Tue,  3 Aug 2021 20:53:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1627988027;
 bh=cJNsL+t2vT3uJSBsFeq+A2MiJioWppOoB66u0oBhfjs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=geuqcauTtj4QzKe3/2N+ScP1OOtpDNibfxboxrZSujpKvEOdY8yTvu78eaRfKV/82
 4zwLxJGNh0OIRxSmKeonLzmqka+MgWP5MLt8L6pFM4NN/juSfujeFYykhKHXBEJsFH
 EdevlV3aJqVvsOXgVEb9NKPj29/FGUuYXHeoAmPa0yeQcSEPuKTl2LlzH4tR2uGvrY
 sP4sHHgNUkkHzhzQvgi9ndxu7oFPk5hvuObRaJlQZkQEVldyap4Y8/S1/DYMeVcLZv
 +n+pkQ1dGFYViWqmHvukLlPeQI0zY0S3n3QyPBPcd0Lf7qNUa2dVNFz1+JH9O9zBuK
 hj+4qXTx8v4rw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] selftests/powerpc: Add test for real address error
 handling
In-Reply-To: <20210730182349.625819-2-ganeshgr@linux.ibm.com>
References: <20210730182349.625819-1-ganeshgr@linux.ibm.com>
 <20210730182349.625819-2-ganeshgr@linux.ibm.com>
Date: Tue, 03 Aug 2021 20:53:43 +1000
Message-ID: <87sfzqol3c.fsf@mpe.ellerman.id.au>
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
Cc: mikey@neuling.org, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 mahesh@linux.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ganesh Goudar <ganeshgr@linux.ibm.com> writes:
> Add test for real address or control memory address access
> error handling, using NX-GZIP engine.
>
> The error is injected by accessing the control memory address
> using illegal instruction, on successful handling the process
> attempting to access control memory address using illegal
> instruction receives SIGBUS.
>
> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> ---
>  tools/testing/selftests/powerpc/Makefile      |  3 +-
>  tools/testing/selftests/powerpc/mce/Makefile  |  6 +++
>  .../selftests/powerpc/mce/inject-ra-err.c     | 42 +++++++++++++++++++
>  .../selftests/powerpc/mce/inject-ra-err.sh    | 19 +++++++++
>  4 files changed, 69 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/mce/Makefile
>  create mode 100644 tools/testing/selftests/powerpc/mce/inject-ra-err.c
>  create mode 100755 tools/testing/selftests/powerpc/mce/inject-ra-err.sh

This breaks the selftests build:

  https://github.com/ruscur/linux-ci/runs/3204665920?check_suite_focus=true

  make[2]: Entering directory '/linux/tools/testing/selftests/powerpc/mce'
  powerpc-linux-gnu-gcc -std=gnu99 -O2 -Wall -Werror -DGIT_VERSION='"77349a6"' -I/linux/tools/testing/selftests/powerpc/include     inject-ra-err.c  -o /output/kselftest/powerpc/mce/inject-ra-err
  Error: inject-ra-err.c:11:25: fatal error: asm/vas-api.h: No such file or directory

cheers
