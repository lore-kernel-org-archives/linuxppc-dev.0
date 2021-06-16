Return-Path: <SRS0=sb+l=LK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B97EC48BE5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 01:06:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6925461350
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 01:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6925461350
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G4RpZ214Wz3bxs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 11:06:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=RtYg3+7Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=RtYg3+7Q; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G4Rp344G6z303J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jun 2021 11:06:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4G4Rp21j2zz9sWQ;
 Wed, 16 Jun 2021 11:06:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1623805562;
 bh=XIijCsOVcBmWgHE1BahMIBiHKzEKNDQ6QgvElIBRv74=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=RtYg3+7QGMoXbm7EF7n7wjDVY26xSwD0zTFD/6GaRlEKaMD4NoRA0gUQEidrKJ0NK
 VM77ZyoqSqmt09yV62o+hYP1ZAhaCvD0ZlvlitAZpA9dUg3SNkCj/PzxXixXgZrFR4
 4CPCazyahEJ4TE1hodF8hGwxcIHT8YjupqeeuOSFNyXMjwxA7fWlWdUS6Zj1/kLaRp
 p/QFQNi1R5u6MFFnV71Sq0+SElnq3cSdiEIRovH9IkbKjp9UC9otN2jkVDE+2EaFh/
 X1fg4FrSj6jg397Ljkd8GjSEloTc66Aq81Sr/Ip+Z1KeojVeipCsFlUG8rzRL+9pJ5
 vd9DAIlZQ55CQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] selftests/powerpc: Always test lmw and stmw
In-Reply-To: <20210615051009.538197-1-jniethe5@gmail.com>
References: <20210615051009.538197-1-jniethe5@gmail.com>
Date: Wed, 16 Jun 2021 11:06:01 +1000
Message-ID: <871r92ty86.fsf@mpe.ellerman.id.au>
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
Cc: Jordan Niethe <jniethe5@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jordan Niethe <jniethe5@gmail.com> writes:
> Load Multiple Word (lmw) and Store Multiple Word (stmw) will raise an
> Alignment Exception:
>   - Little Endian mode: always
>   - Big Endian mode: address not word aligned
>
> These conditions do not depend on cache inhibited memory. Test the
> alignment handler emulation of these instructions regardless of if there
> is cache inhibited memory available or not.
>
> Commit dd3a44c06f7b ("selftests/powerpc: Only test lwm/stmw on big
> endian") stopped testing lmw/stmw on little endian because newer
> binutils (>= 2.36) will not assemble them in little endian mode. The
> kernel still emulates these instructions in little endian mode so use
> macros to generate them and test them.
>
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
> v2: Use macros for lmw/stmw
> ---
>  .../powerpc/alignment/alignment_handler.c     | 101 +++++++++++++++++-
>  .../selftests/powerpc/include/instructions.h  |  10 ++
>  2 files changed, 106 insertions(+), 5 deletions(-)

Fails for me on BE?

test: test_alignment_handler_multiple
tags: git_version:v5.13-rc5-2025-g31e45305e351
        Doing lmw:      FAILED: Wrong Data
        Doing stmw:     FAILED: Wrong Data
failure: test_alignment_handler_multiple

cheers
