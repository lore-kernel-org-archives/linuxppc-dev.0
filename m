Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D142C4338F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 13:15:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35053610A1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 13:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 35053610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gd1pg6l3Fz30BX
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 23:15:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gd1p01sDJz2yx2
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Aug 2021 23:15:04 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Gd1nr5zS0z9sWw; Sun,  1 Aug 2021 23:14:56 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210729131244.2595519-1-mpe@ellerman.id.au>
References: <20210729131244.2595519-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/vdso: Don't use r30 to avoid breaking Go lang
Message-Id: <162782364020.2951535.1863268158095209284.b4-ty@ellerman.id.au>
Date: Sun, 01 Aug 2021 23:14:00 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: pmenzel@molgen.mpg.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 29 Jul 2021 23:12:44 +1000, Michael Ellerman wrote:
> The Go runtime uses r30 for some special value called 'g'. It assumes
> that value will remain unchanged even when calling VDSO functions.
> Although r30 is non-volatile across function calls, the callee is free
> to use it, as long as the callee saves the value and restores it before
> returning.
> 
> It used to be true by accident that the VDSO didn't use r30, because the
> VDSO was hand-written asm. When we switched to building the VDSO from C
> the compiler started using r30, at least in some builds, leading to
> crashes in Go. eg:
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/vdso: Don't use r30 to avoid breaking Go lang
      https://git.kernel.org/powerpc/c/a88603f4b92ecef9e2359e40bcb99ad399d85dd7

cheers
