Return-Path: <linuxppc-dev+bounces-25060-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C62C531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:46:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dV34WmFz2yDs;
	Thu, 30 Jul 2026 15:46:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390363;
	cv=none; b=oJHu7TXRCf7hhhah3SejIVerATeTloo8Mi04EfWrl3nLijE+45dOsgSKkUJa1j56VsFR1ka75wnk5Dc90rgNVL4F9ZsWA03bzKetlTAqMZ1cd/13vuALc2frnsXdhAVdVlj3FuypXDiem1FqnfYmWYLCu3e4Jgm/fR4hR7NXBXyUhUVgz0b359C+WJE8RPEZ/y8ig7k8p6+acd4SNQSxFrghqdSakKX5I2HstxVevEbC9DBuJNgS1upzCdq0gcvPyaWS1C+NeHaoPtoDXkmmd6a/Gel99hELiIe+5UgrXBEz4pLsoJFs6/sONgZazqH5aHTg7QYjVHl88vKEOvCcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390363; c=relaxed/relaxed;
	bh=GDPgVfCvJUVZHLi5ReYPJHcf8KbYBm6zZv41ejFPKZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZYyiK2Rf2lj2REXzX/eFTXFIxPUOMnSZMH2OK6GGZK+12yoJn+CKBAvsEyCd0oB9lqLHGzkY8o7QCAw2EoFwjPgCoS6ZtEO5a4LUY/2Ak+n3C+JNQP/sjZJwdIiRrxHdOlDsxKUL08B+g+oc6iYV3bt8nS5iF6DKhWpZXa755VVwi1xfGjCYLFmmZsKwHOUTs0TOPg6kE4sI1aBjiSX1djSDQXTde2RV3opaR+mhjb7LQUvbvLk+5SUXTjaJDc9tMNtonSjlwbAx69JKxIb6s3iAGM086Tp3amVZxtsgeOule11Brq0xtHkal4t1ZzBUwKfqQE266rNn0uaPUyEpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=liAZZRL6; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=liAZZRL6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dV20Ftjz2xwH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:46:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A84EE600AA;
	Thu, 30 Jul 2026 05:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C541F000E9;
	Thu, 30 Jul 2026 05:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785390358;
	bh=GDPgVfCvJUVZHLi5ReYPJHcf8KbYBm6zZv41ejFPKZI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=liAZZRL6qtfZiXGKKUDrxXmMAKJ9rcrjjFd6mAQWBEpuW6PxMQECqi1V/uAbjJH8O
	 k+e9Xzweyjnsiqrtki68mQdqN/0lembd5VTLhHROx2lLyPBlYONTogWxgW7iNeKwoj
	 sP5liedv6crQgVFVJePttQguwv1ug4oQInCVZZQhgxBM4oqOK/VbFN54mkjLqipksB
	 +TBuUjNyZPRHar4SxKB0iew9860CKltRk8LzfwfznvhK+llf/78Kqj/6FD+T1Xls0e
	 4+h5oybXONhG1LlvnIhdHGTWUydkjPQGZrsfI5/JgWc97h8IQxbV6jFFdX2CggdG+s
	 KxQgXI3cNGcVA==
Message-ID: <1062ee0c-cf44-479e-a442-3dfda7d7614f@kernel.org>
Date: Thu, 30 Jul 2026 07:45:53 +0200
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] powerpc/44x: Set GPIO chip parent
To: Rosen Penev <rosenp@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Linus Walleij <linusw@kernel.org>,
 open list <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
References: <20260517063754.21819-1-rosenp@gmail.com>
 <CAKxU2N-i02g0jJaiJ+GzX1iQ8_W=uX0iMpmeNw=0=u-xU7tkLg@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAKxU2N-i02g0jJaiJ+GzX1iQ8_W=uX0iMpmeNw=0=u-xU7tkLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/07/2026 à 21:05, Rosen Penev a écrit :
> On Sat, May 16, 2026 at 11:38 PM Rosen Penev <rosenp@gmail.com> wrote:
>>
>> The PPC4xx GPIO driver stopped assigning an explicit parent
>> to the gpio_chip when it moved away from of_mm_gpiochip_add_data().
>>
>> Restore that association from the platform device so OF GPIO lookup
>> can match phandles to the registered gpiochip.
>>
>> Tested on: Cisco MX60W. No more probe deferral.
>>
>> Assisted-by: Codex:GPT-5.5
>> Fixes: 1044dbaf2a77 ("powerpc/44x: Change GPIO driver to a proper platform driver")
> Did I forget to ping someone?

Probably not, but afterwards you sent your series which moves the driver 
into drivers/gpio/ and which does the same, so this one was flagged 
"superseeded" in Patchwork 
(https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20260517063754.21819-1-rosenp@gmail.com/)

I put it back to 'new'. Maddy, can you pick it up ?

Christophe


>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>>   arch/powerpc/platforms/44x/gpio.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/platforms/44x/gpio.c b/arch/powerpc/platforms/44x/gpio.c
>> index aea0d913b59d..4413a94cf7a6 100644
>> --- a/arch/powerpc/platforms/44x/gpio.c
>> +++ b/arch/powerpc/platforms/44x/gpio.c
>> @@ -169,6 +169,7 @@ static int ppc4xx_gpio_probe(struct platform_device *ofdev)
>>
>>          gc = &chip->gc;
>>
>> +       gc->parent = dev;
>>          gc->base = -1;
>>          gc->ngpio = 32;
>>          gc->direction_input = ppc4xx_gpio_dir_in;
>> --
>> 2.54.0
>>


