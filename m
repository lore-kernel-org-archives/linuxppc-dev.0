Return-Path: <SRS0=ePRe=5K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F17C1975A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 10:24:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7AD20714
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 10:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="r4ccyl6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7AD20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nPPN3JKXzDqjd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 21:24:40 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48nPLk4t3bzDqWw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2020 21:22:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=r4ccyl6U; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48nPLk01K9z9sR4;
 Wed, 25 Mar 2020 21:22:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1585131742;
 bh=h5Vz9jZG3mRLJBK/442MEWiwrL0sm+QQV6Q9zKhPR4c=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=r4ccyl6U2aLYtjIHFH6hL8rKstByfOWJlsMhhhgsUTpL/Cb9U5E/2CY6mFUWGS0er
 An8i62X9qMtAUZcQW4sz4VAB1KarFfTWYsgamqOc7yG0QFrcBhFs55yGLmjv5JK/i2
 m3H/tdNvBk4mV5VWDZ3jMeGQaf8BfV7HDyjGByiorLe/pRjmdfJrMMX8U2tZ+Jceax
 GH/gvmrO1Y9O1xFvBEOcIcejfqRm6ojnfk4kS7h+wnz/2kmWzOGR/bKQLbmdzpdLAf
 5pGP4RKKBg6yFB2iO8v86iLIVWimfyb28KIln0P+XCWqvKwoNElBodQx1l10pRs7ya
 H8XI5UXiUIAUg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: afzal mohammed <afzal.mohd.ma@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4] powerpc: Replace setup_irq() by request_irq()
In-Reply-To: <20200324110637.GA5836@afzalpc>
References: <20200304004746.4557-1-afzal.mohd.ma@gmail.com>
 <20200312064256.18735-1-afzal.mohd.ma@gmail.com>
 <20200324110637.GA5836@afzalpc>
Date: Wed, 25 Mar 2020 21:22:29 +1100
Message-ID: <87wo78wx7e.fsf@mpe.ellerman.id.au>
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
Cc: linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

afzal mohammed <afzal.mohd.ma@gmail.com> writes:
> Hi Michael Ellerman,
> On Thu, Mar 12, 2020 at 12:12:55PM +0530, afzal mohammed wrote:
>> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
>> occur after memory allocators are ready.
>> 
>> Per tglx[1], setup_irq() existed in olden days when allocators were not
>> ready by the time early interrupts were initialized.
>> 
>> Hence replace setup_irq() by request_irq().
>> 
>> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
>> 
>> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
>
> This patch is seen in next-test branch for last 4-5 days, i don't know
> exactly how powerpc workflow happens, so a question - this would be
> appear in linux-next soon right ? (for last 4-5 days i had been daily
> checking -next, but not appearing there).

Yeah it will appear in next "soon".

It's been stuck behind a big series that has hit some bugs during
testing, so that has delayed me pushing the whole branch.

> Sorry for the query for this trivial patch, i am asking because Thomas
> had mentioned [1] to get setup_irq() cleanup thr' respective
> maintainers (earlier it was part of tree-wide series), check -next after
> -rc6 & resubmit ignored ones to him, this patch is neither in -next,
> neither ignored, so i am at a loss what to do :(

That's OK. I will take this one, you can stop worrying about it.

It should appear in next tomorrow or Friday.

cheers
