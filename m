Return-Path: <SRS0=lwUg=B7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03096C433E1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 18:57:41 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C5520714
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 18:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="kKx/x1By"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C5520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=anastas.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BY9kT1HCqzDrJ1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Aug 2020 04:57:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=anastas.io (client-ip=104.248.188.109; helo=alpha.anastas.io;
 envelope-from=shawn@anastas.io; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=anastas.io
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=anastas.io header.i=@anastas.io header.a=rsa-sha256
 header.s=mail header.b=kKx/x1By; dkim-atps=neutral
Received: from alpha.anastas.io (alpha.anastas.io [104.248.188.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BY9hH5ZTvzDrGG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2020 04:55:43 +1000 (AEST)
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alpha.anastas.io (Postfix) with ESMTPSA id 657117EC09;
 Fri, 21 Aug 2020 13:55:09 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
 t=1598036109; bh=qIKOyPROSSDdUsVcB1TzciIICsDp1KA2FydQYVPEzCs=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=kKx/x1Byr8hCGJccss1DKAgsrX7crmubkmyGjbStYo+FJwfpC/jpv4Ubw79jALlKN
 T+izSX7DPcImHsgTaRFDnknke8K+XJvxJhquz6klusYbYmIbyGWGQ+lokk1QRmRhqT
 GK3+kH5zmiwKCCHOX2lYe+nZc7LQBa+4k2KBvz5oOfiB7jyntrp6OofSsk1Df5esML
 vYSeKtchOYq75Z2WYkh6eZghrKX/mCEjKSy46quEbR2uef370aDL/wS0xbrORo/TNI
 Nd1Pym44o5vA1Mz6s71zpxTtWu5IBII3qnrPH+1HEAshgqNDEKlJuXeEzZIS36Abtc
 bT6k26ECm4gbA==
Subject: Re: [PATCH 2/2] powerpc/64s: Disallow PROT_SAO in LPARs by default
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20200821010837.4079-1-shawn@anastas.io>
 <20200821010837.4079-3-shawn@anastas.io>
 <1598006106.5gm5wgd52s.astroid@bobo.none>
From: Shawn Anastasio <shawn@anastas.io>
Message-ID: <089988d4-43d5-324f-34d8-638b3770c7dd@anastas.io>
Date: Fri, 21 Aug 2020 13:55:08 -0500
MIME-Version: 1.0
In-Reply-To: <1598006106.5gm5wgd52s.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 8/21/20 5:37 AM, Nicholas Piggin wrote:> I think this should be okay. 
Could you also update the selftest to skip
> if we have PPC_FEATURE2_ARCH_3_1 set?

Sure. I'll send out a v2 shortly with another patch for this.

> Thanks,
> Nick

Thanks,
Shawn
