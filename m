Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C8CC4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 03:02:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1756D60F6B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 03:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1756D60F6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GZJNq1lJ3z3bYP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jul 2021 13:02:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=gzWyRti+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=gzWyRti+; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GZJNM24mpz302M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jul 2021 13:01:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GZJNC510kz9sWX;
 Wed, 28 Jul 2021 13:01:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1627441308;
 bh=zX1C16qqqIJJgzlwuK/90tstge6Gxyn/4mQmQ1LVDK4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=gzWyRti+29ip505uVfvV3iKdJR9oW88gLdQmfEQMurAc7Vij6o+50EO/i/s+D70ov
 6mPGKFbNgRkkwkRIGemoT2w4anpwTT4QbbQRZ/RCMAOw7voFbjh2kDPGSOMSA6zW2o
 2I/6G36aLnx5j1rLE/uBE3wt+QbkyBMDLJMxuefV+4CxiUJzonQUPrMBEXrBSh3JdC
 P/YSqa6IgV9tfXI/DFOsG/+GrGSvKqmFWZrde4FL6jeo53a+HO6BimsVXi1OimpjJR
 OGeQvraiW1mqbuXoTPK/Cx+7Tw13xWbLwiLog64ukvgek0DTdluDlKThLyX6zT+RQp
 HtzrrXPi/YiMg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jason Wang <wangborong@cdjrlc.com>
Subject: Re: [PATCH] powerpc/xmon: use ARRAY_SIZE
In-Reply-To: <20210725150107.27865-1-wangborong@cdjrlc.com>
References: <20210725150107.27865-1-wangborong@cdjrlc.com>
Date: Wed, 28 Jul 2021 13:01:44 +1000
Message-ID: <87bl6n16qv.fsf@mpe.ellerman.id.au>
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
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Jason Wang <wangborong@cdjrlc.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jason Wang <wangborong@cdjrlc.com> writes:
> The ARRAY_SIZE is the macro definition of sizeof(a)/sizeof(a[0]) and
> it is more compact and formal to get a array size.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/powerpc/xmon/ppc-opc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

This code is copied from binutils, please don't change it unnecessarily.

cheers
