Return-Path: <SRS0=m4lh=I6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DACC433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 13:39:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CC161243
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 13:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CC161243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FB46x2Vbkz3bny
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Apr 2021 00:39:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=gpkNgdEw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=gpkNgdEw; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FB46W0zCQz2yy9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Apr 2021 00:39:30 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FB46T6lg0z9sPf;
 Fri,  2 Apr 2021 00:39:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1617284370;
 bh=3UFyOMr/N79zPJhGgFBgLjINxgxxMdiEeiBz/BaK4Dg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=gpkNgdEwTsBeYbeIKszvSgQkoF+kOjfiTi7RX9LEICYxmD+ldU4II7MkIBRlSXb8h
 koCgp8lwM4l85M7wlkMP1vWFBU7LKnSTdjt6/PKxhNYA2gT3c2sNIeN0kBojHr2dBc
 1CSAsIYIH09Ufnbnw0utJsO3aFtfy0jy6cQPh9qVdhnxsoe3beSJC4UGvNm/lpWuPG
 M6DUuOkzaVlgMbjwuRAMgFis5CcEKhg0FG6p69uI0AWp5Notugmr5iBnrrx0ZaWViJ
 L5N2wfmMDtacLRpDV0tdt8Dx2l1nBgYncpsu03WfaR9I0X9PpoJmiHeoPG5Fm3Rm06
 tSiBiVEVdGyPA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] powerpc/sstep: Always test lmw and stmw
In-Reply-To: <20210225032108.1458352-3-jniethe5@gmail.com>
References: <20210225032108.1458352-1-jniethe5@gmail.com>
 <20210225032108.1458352-3-jniethe5@gmail.com>
Date: Fri, 02 Apr 2021 00:39:26 +1100
Message-ID: <87czve15v5.fsf@mpe.ellerman.id.au>
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

Hi Jordan,

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
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
>  .../powerpc/alignment/alignment_handler.c     | 96 ++++++++++++++++++-
>  1 file changed, 94 insertions(+), 2 deletions(-)

Because of dd3a44c06f7b ("selftests/powerpc: Only test lwm/stmw on big endian")
this will need a respin sorry.

You'll need to add macros to generate lmw/stmw using .long, to avoid the
bug fixed in that commit.

cheers
