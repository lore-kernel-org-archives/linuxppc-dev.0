Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC33C433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 05:16:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C168560E09
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 05:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C168560E09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FNw631sw8z3c2B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=YEwatwHr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=YEwatwHr; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FNw5c4lQSz30GD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 15:16:19 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FNw5T5D3pz9vFF;
 Mon, 19 Apr 2021 15:16:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1618809373;
 bh=cXoy7YS4JrMayWNsMdbz6qfRJ7CAR8vlkXbrePE3yBI=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=YEwatwHr9NkiOnfnmeEsunHTBs87Pwt9oIEUTGuEpvorfu2NCON0rr5dWJ1aNtFKp
 mfawEMW57YO4RJMcFFUg6Wher41cGaviUBJJcfrRMEOl5oTlaAo8i3JGTkJ6xqLyr1
 o57tHLuCmzO2GLwZ17OdFMAlVL/yRifVRJLBhDbqAQ35gbOTsKpUo8FaAGSKev719q
 i0bJ62JNlE19QOVocYgAhwkcZQwiGAmC5oKQQ+UxFlDQzGl/FWossfYTLTvbvWClUr
 XT0rruolTajQWVVCFmdEblXeN4h5Mn0Y+98S7HRucvp/UDWrxOek6GvBSiUEkPMekz
 3BRq9G1Z3c/xQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: power4 nap fixup in C
In-Reply-To: <161806492607.1467223.7549979604946856102.b4-ty@ellerman.id.au>
References: <20210312012044.3660743-1-npiggin@gmail.com>
 <161806492607.1467223.7549979604946856102.b4-ty@ellerman.id.au>
Date: Mon, 19 Apr 2021 15:16:12 +1000
Message-ID: <87czuqetwj.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <patch-notifications@ellerman.id.au> writes:
> On Fri, 12 Mar 2021 11:20:44 +1000, Nicholas Piggin wrote:
>> There is no need for this to be in asm, use the new intrrupt entry wrapper.
>
> Applied to powerpc/next.
>
> [1/1] powerpc/64s: power4 nap fixup in C
>       https://git.kernel.org/powerpc/c/98db179a78dd8379e9d2cbfc3f00224168a9344c

Script is drunk again, v2 was applied, not this one.

cheers
