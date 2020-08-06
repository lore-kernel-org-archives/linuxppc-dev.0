Return-Path: <SRS0=any3=BQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5E1C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 12:42:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194AA23104
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 12:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="kgxDjnTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194AA23104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BMp5x54mkzDqnZ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 22:41:57 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BMnwn2zsFzDqn2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2020 22:34:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=kgxDjnTb; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BMnwm3sVBz9sSG; Thu,  6 Aug 2020 22:34:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BMnwm0hNSz9sPB;
 Thu,  6 Aug 2020 22:34:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1596717240;
 bh=OK8HctNi5WIDYJjUo0nRTctkeD0orc8DEExkoW03TG0=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=kgxDjnTbplhqRZHWT0jIbpTFq/DyZacArZtR/Y204yq74L3yqN6366aMneETc2mZd
 tNXkhFjaxelC41bMRqvouue9QoI16FB5PyzIhRfbM9UdcJ6JrH1KDM6m0CJ7Wi3sih
 Uh939oBsMzj9P60/ZlDM/QRHuP8lpIUiHRc+netQXkAEPYZhXwt2bLr5pQi5oXStyi
 x5I27xlhfqCCBykX9/kG1aM3+8JMz8WRhrJLPfhet0hZfEdmrD/e4mrcaecEFE9Wsj
 yobc1Jt685AIUF1KXyda/3oNL+6xGpUmYWaYlWbjvgLMmj//8UCE8qAcz3lVqfShRY
 3BBtwLd4JgsGA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/40x: Fix assembler warning about r0
In-Reply-To: <7faebe28-07f9-b5df-6b6d-a25342e2bcad@csgroup.eu>
References: <20200722022422.825197-1-mpe@ellerman.id.au>
 <bc70ddd8-d48d-d939-dce0-5aa8b8cf87d8@csgroup.eu>
 <87o8noy0sc.fsf@mpe.ellerman.id.au>
 <7faebe28-07f9-b5df-6b6d-a25342e2bcad@csgroup.eu>
Date: Thu, 06 Aug 2020 22:33:59 +1000
Message-ID: <877ducymvc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 06/08/2020 =C3=A0 04:18, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> Le 22/07/2020 =C3=A0 04:24, Michael Ellerman a =C3=A9crit=C2=A0:
>>>> The assembler says:
>>>>     arch/powerpc/kernel/head_40x.S:623: Warning: invalid register expr=
ession
>>>
>>> I get exactly the same with head_32.S, for the exact same reason.
>>=20
>> Ah yep, I see it. I mostly build pmac32_defconfig which doesn't have
>> BDI_SWITCH enabled.
>>=20
>> Send a patch? :)
>
> Done.
>
>>=20
>> Do we still need the BDI_SWITCH code? Is it likely anyone still has one,
>> that works?
>
> I have three (One for 83xx and two for 8xx) and they work, allthough I'm=
=20
> using them only for Uboot and for very very very early Linux boot=20
> debugging (Last time I used it with Linux was when implementing KASAN)

OK, happy to keep the code around if it works and is being used, even
just a little bit.

cheers
