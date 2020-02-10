Return-Path: <SRS0=cnDq=36=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3A7C352A4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Feb 2020 09:52:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A4C208C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Feb 2020 09:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="mRC1qUxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A4C208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48GLmj3rJnzDqJ1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Feb 2020 20:52:37 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48GLjt5t34zDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2020 20:50:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=mRC1qUxj; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48GLjs0k3Cz9s3x;
 Mon, 10 Feb 2020 20:50:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1581328209;
 bh=hRjy8Bnj/PCYJ3V15i1OVOLR2WxzGVo7Md7tk0dSU74=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=mRC1qUxjPxoRQ36c1Xqf/J8dCywbF1SvQN7UjdDZ4YyaBrUs02rgSQUNurlfuG0c8
 TY0VBTMRDIANzQjaXchE8PxBDPQVyqpSzU8ygVJ0lSgaLdIy/wPEoxGhhuZ8qJy3Ex
 mpfo27XdPKrLIm242RTVoxdOyHu0j7jLbpspzt/v+kuslamAXS2KzOWB/8T+KPJ5kl
 TrAyQbULoDeOITtibyoJ5o7hrcfov0okvZt5YyIhL4tDuoPg04ADXRWHwq3G0FrbGD
 T13VoUS4NBplob2m0gtErcO14c06Yu8+/akZYFHp6CibFLot0sDYoWyErQoArhueLy
 K/fq96rNqK8kw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Harish <harish@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RESEND][PATCH] selftests/vm: Fix vm tests build and run
In-Reply-To: <20200210073521.14117-1-harish@linux.ibm.com>
References: <20200210073521.14117-1-harish@linux.ibm.com>
Date: Mon, 10 Feb 2020 20:50:05 +1100
Message-ID: <871rr222lu.fsf@mpe.ellerman.id.au>
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
Cc: Harish <harish@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Harish <harish@linux.ibm.com> writes:
> A recent change overrides the ARCH env variable and hence runs
> using make fails with the following.
>
> $ make -C vm/
> make: Entering directory '/home/harish/linux/tools/testing/selftests/vm'
> make --no-builtin-rules ARCH=ppc64le -C ../../../.. headers_install
> make[1]: Entering directory '/home/harish/linux'
> Makefile:652: arch/ppc64le/Makefile: No such file or directory
> make[1]: *** No rule to make target 'arch/ppc64le/Makefile'.  Stop.
> make[1]: Leaving directory '/home/harish/linux'
> make: *** [../lib.mk:50: khdr] Error 2
> make: Leaving directory '/home/harish/linux/tools/testing/selftests/vm'
>
> Patch fixes this issue and also handles ppc64/ppc64le archs to enable
> few tests
>
> Signed-off-by: Harish <harish@linux.ibm.com>
> ---
>  tools/testing/selftests/vm/Makefile    | 4 ++--
>  tools/testing/selftests/vm/run_vmtests | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

I don't maintain the vm tests. You need to send the patch to the right
people.

But as Christophe points out I think Sandipan has already done that.

cheers
