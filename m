Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DA0C4167B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Dec 2023 10:06:16 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=eAn8nvOE;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ShTGv39C8z3ckc
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Dec 2023 21:06:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=eAn8nvOE;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ShTG03D3Lz3cQr
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2023 21:05:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1701425128;
	bh=rD0Q2JtqLmxLGcQ5kFbdo28Ztc0iDfwANN2XmR6g+3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eAn8nvOEtf4oRn0uEn73Lk/GwS3yDVGpQ8/mvs2O6nLMUYFjXH4J44FhkqXTIISV5
	 5DY8IfI56H23EQHDQHkokqXWvhfAG0S29I0jxZS6lcGzNWsAyQTV6tPzTUiQqLsFcc
	 W5N2yzELChQkUO+G9n2AOMOF93P03hsfK4Wapk1VCflPzvcfnItY6HVK807nsF5pMT
	 btEB/KSkZ4xTvfknvbw3NCD1oJLYQb1eMSUsCAyded2NwBh161gclFSwgljnblquF1
	 195cV8z8RGcoGoPlodVoAPkM9hQieU/lZVkDW/ioV++aq10LL6DxTlOWCMnqgsee62
	 /qhEL8JDoaeDw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ShTG020FJz4xVK;
	Fri,  1 Dec 2023 21:05:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/irq: Allow softirq to hardirq stack transition
In-Reply-To: <77e18f24-7f06-4d91-b57c-af8837be0420@csgroup.eu>
References: <20231130125045.3080961-1-mpe@ellerman.id.au>
 <77e18f24-7f06-4d91-b57c-af8837be0420@csgroup.eu>
Date: Fri, 01 Dec 2023 21:05:27 +1100
Message-ID: <87fs0m1bmg.fsf@mail.lhotse>
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
Cc: "npiggin@gmail.com" <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 30/11/2023 =C3=A0 13:50, Michael Ellerman a =C3=A9crit=C2=A0:
>> Allow a transition from the softirq stack to the hardirq stack when
>> handling a hardirq. Doing so means a hardirq received while deep in
>> softirq processing is less likely to cause a stack overflow of the
>> softirq stack.
>>=20
>> Previously it wasn't safe to do so because irq_exit() (which initiates
>> softirq processing) was called on the hardirq stack.
>>=20
>> That was changed in commit 1b1b6a6f4cc0 ("powerpc: handle irq_enter/
>> irq_exit in interrupt handler wrappers") and 1346d00e1bdf ("powerpc:
>> Don't select HAVE_IRQ_EXIT_ON_IRQ_STACK").
>>=20
>> The allowed transitions are now:
>>   - process stack -> hardirq stack
>>   - process stack -> softirq stack
>>   - process stack -> softirq stack -> hardirq stack
>
> It means you don't like my patch=20
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/6cd9d8bb2258d8b51=
999c2584eac74423d2b5e29.1657203774.git.christophe.leroy@csgroup.eu/=20
> ?

I did like your patch :)

But then we got reports of folks hitting stack overflow in some distro
kernels, and in at least some cases it was a hardirq coming in during
softirq handling and overflowing the softirq stack.

> I never got any feedback.

Sorry, not enough hours in the day.

cheers
