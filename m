Return-Path: <SRS0=2H2D=XA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301F1C3A5A5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 04:16:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EDC2206DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 04:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDC2206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46P6ns0QCBzDqjy
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 14:16:33 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46P6lg25ZHzDqd0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2019 14:14:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46P6lf4H6kz9s7T;
 Thu,  5 Sep 2019 14:14:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/64: system call implement the bulk of the
 logic in C
In-Reply-To: <20190902225835.17354-1-npiggin@gmail.com>
References: <20190902225835.17354-1-npiggin@gmail.com>
Date: Thu, 05 Sep 2019 14:14:38 +1000
Message-ID: <875zm7pefl.fsf@mpe.ellerman.id.au>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> System call entry and particularly exit code is beyond the limit of what
> is reasonable to implement in asm.
>
> This conversion moves all conditional branches out of the asm code,
> except for the case that all GPRs should be restored at exit.
>
> Null syscall test is about 5% faster after this patch, because the exit
> work is handled under local_irq_disable, and the hard mask and pending
> interrupt replay is handled after that, which avoids games with MSR.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Since v1:
> - Fix big endian build (mpe)
> - Fix order of exit tracing to after the result registers have been set.
> - Move ->softe store before MSR[EE] is set, fix the now obsolete comment.
> - More #ifdef tidyups and writing the accounting helpers nicer (Christophe)
> - Minor things like move the TM debug store into C

This doesn't build in a few configs.

It needed:

+#else
+static inline void kuap_check_amr(void) { }

In kup-radix.h to fix the KUAP=n build.

It still fails to build on ppc64e with:

  arch/powerpc/kernel/syscall_64.c:161:2: error: implicit declaration of function '__mtmsrd' [-Werror=implicit-function-declaration]

  http://kisskb.ellerman.id.au/kisskb/buildresult/13946972/

Which I haven't debugged yet.

cheers
