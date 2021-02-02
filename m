Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7C7C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 00:44:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9839464F6A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 00:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9839464F6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DVjc74JkQzDqX1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 11:44:07 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DVLhj1BhGzDq8W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2021 21:31:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=LzeUqkRm; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4DVLhh1pSXz9vFB;
 Tue,  2 Feb 2021 21:31:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1612261908;
 bh=JuePySg4dvC1vNBXBhd6zw84fZMgcuih6ehxVEdH+gI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=LzeUqkRm9gkm9Vshtms9B9q/tDJrcKEjwYcVTGyt9pMR8lMdKfQcvdJgRsbwVYKZJ
 IRRmOKyku+QbiDYxRXY5uwJEXZer5da4Vc8qWjL8jf8AIr5UYvCTcdYM/fb7dDPd4y
 ss8kFGXBqGfLH0EJ9diWIuRCY2Dve2sJUzGoCL5Wk2+V1q1pAjj/inxBBowsr09FbN
 /S6EGlp2AvWuu85VMHETq0Dke1tl+Wa0xozq1wjChhe/URl1jJ1zJEigf8BJTpGYRR
 i00p+Jvn/w/tlrlhJA9EV3AMo+PSiff57MylG57wKAQi8RZMrDUjS/mE7mSUERkway
 wJZDQdunAiP0Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 42/42] powerpc/64s: power4 nap fixup in C
In-Reply-To: <20210130130852.2952424-43-npiggin@gmail.com>
References: <20210130130852.2952424-1-npiggin@gmail.com>
 <20210130130852.2952424-43-npiggin@gmail.com>
Date: Tue, 02 Feb 2021 21:31:43 +1100
Message-ID: <878s86dals.fsf@mpe.ellerman.id.au>
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
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> There is no need for this to be in asm, use the new intrrupt entry wrapper.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/interrupt.h   | 15 +++++++++
>  arch/powerpc/include/asm/processor.h   |  1 +
>  arch/powerpc/include/asm/thread_info.h |  6 ++++
>  arch/powerpc/kernel/exceptions-64s.S   | 45 --------------------------
>  arch/powerpc/kernel/idle_book3s.S      |  4 +++
>  5 files changed, 26 insertions(+), 45 deletions(-)

Something in here is making my G5 not boot.

I don't know what the problem is because that machine is in the office,
and I am not, and it has no serial console.

I tried turning on pstore but it doesn't record anything :/

cheers
