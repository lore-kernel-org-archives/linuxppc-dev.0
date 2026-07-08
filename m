Return-Path: <linuxppc-dev+bounces-23838-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C193C44501
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 16:49:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwPFH6czxz2y7r;
	Thu, 09 Jul 2026 02:49:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783529347;
	cv=none; b=FWocGQNAi1ycyNfZPyjgjS0ylhG8O8E0nDcjB2J/X0XQ4BPEMCTbgf13O+t3PVmyAftrD2VwMCWvr48IZe73iGWVY8caq9TRdVI6yM1WXu/0XLmJbId/jc115fo0W50Uo3k20pXth6qqPWBDarSfGIDdXW+tLObAdJuD8IKMIeSlVnpModTuIAan8uBgrrZqTmiDdtVJYo+SwF692J19ybr7GjslBcDjNCevxUCEf2c0xo8qSGfetKTDQjUdKuJclfq5lwg3JsRbDRn9pzHVfBOJbUBIzQO56OCJP4vTWZlk6rQm02q5A/j54sNf5SKcNgVKUajB4NjSGEgS8y9vRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783529347; c=relaxed/relaxed;
	bh=qrJEykycDfWq6bCgDWXkzYQH/3VfPU7rgds3LGVzhsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+0efQdQbCzhARxnqqlU1gZCYWGqlsFSKj2xdTSzQgQyxldlwELQkpEHV7RgHvFlw+SEMbSn0/JEQRjn5SWVUXbsStUy4UvTGQugPj11Gdpe1xrBX9gL0wNE4veINN/nhulr1DO/h3a4WjJ53kTE0jYmtsWSmtROwP4XbVX6smYDgrWyqdrfhxfiI3bdV7JC5LF9BKdu9t1J1pEEipjXXcONOE4NQbm651imZYrZFVlvoiEbmFi9oQSZ/mlHWVaAFGZ1BZZiBlnhY6mj0ypsdjrZ0+rnQpFlI0bLZnGTKefzNLOksbGdjtM4YclV0YmqeN4zHvzR4SQp/yuq45RvFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=DmE5wen+; dkim-atps=neutral; spf=pass (client-ip=80.241.56.171; helo=mout-p-201.mailbox.org; envelope-from=erhard_f@mailbox.org; receiver=lists.ozlabs.org) smtp.mailfrom=mailbox.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=DmE5wen+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=80.241.56.171; helo=mout-p-201.mailbox.org; envelope-from=erhard_f@mailbox.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 163248 seconds by postgrey-1.37 at boromir; Thu, 09 Jul 2026 02:49:05 AEST
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bit raw public key) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwPFF64vgz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 02:49:04 +1000 (AEST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gwPF81CJQzMlKF;
	Wed, 08 Jul 2026 18:49:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783529340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrJEykycDfWq6bCgDWXkzYQH/3VfPU7rgds3LGVzhsA=;
	b=DmE5wen+oy5/60K95Kzug6jx4+uFJVzKy+bwTxONgHf7KEr/DpUMmLhemeg8INa3obwD0t
	G7EMyzsKyG0I3DZDiQs2fmC0HfZRpD7YSEquPbjK8iqTdW3/Geutqd5ZLRh3cLt1993Jt/
	P1p2nLRP1K8BHO6ZcQ7A3hzyZEpqk5k2i9rRS8jzIkeCT1KtMDuS7j38rL0i8t8o5fM12R
	WsynkpsLrLSivR3qdDDmdrfB53cb06tvazxzqRqJivnf2bKndasLl9iBcrXWSa0fQTsEQW
	zBFuUO+iX1vbmfD3/1ui4ZPsQfKzjk75MDBMTziMljQcqHYgLtG4A/fkKfeV0w==
Message-ID: <74b10578-1e80-427a-8888-943c26da471e@mailbox.org>
Date: Wed, 8 Jul 2026 18:48:57 +0200
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
Subject: Re: test_bitmap fails on ppc/ppc64 on kernels v7.1.3, v7.2-rc2
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org
References: <ca3547ae-8b79-43a2-a758-23ec980bfd9a@mailbox.org>
 <98d65de7-e5aa-4197-85bd-219eab01e572@kernel.org>
 <b9b762d0-cfe1-4fdb-b668-b6ef4afb0059@mailbox.org>
 <ak3_sGAnFxbmxfe8@ashevche-desk.local>
 <5430b52d-a072-41ea-ab56-9bb2f6f88849@kernel.org>
Content-Language: en-US, de-DE
From: Erhard Furtner <erhard_f@mailbox.org>
In-Reply-To: <5430b52d-a072-41ea-ab56-9bb2f6f88849@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hgwpr1jst6unneut7116fftbesftrcuw
X-MBO-RS-ID: ff2d7b8e63ed77ee5dc

>> Oh, this is nice. So, there are two (more?) options I see to mitigate
>> the issue:
>> - carefully copy the garbage from the stack to the expected values
>>    (effectively merge the whatever is on stack with the expected value)
>> - allocate buffers on heap
>>
>> The latter seems the easiest and right thing to do (since we can't really
>> predict if the stack pattern is the same or bitmap APIs scatters the bits
>> just on top of the respective set or clear ones over that pattern).
>>
>> I will send a patch, thanks for the report and analysis!
>>
>>
> 
> The following change fixes the issue for me:
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 69813c10e6c0b..448c3eb48a4a8 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -392,6 +392,7 @@ static void __init test_bitmap_sg(void)
> 
>       /* Scatter/gather relationship */
>       bitmap_zero(bmap_tmp, 100);
> +    bitmap_zero(bmap_res, 100);
>       bitmap_gather(bmap_tmp, bmap_scatter, sg_mask, nbits);
>       bitmap_scatter(bmap_res, bmap_tmp, sg_mask, nbits);
>       expect_eq_bitmap(bmap_scatter, bmap_res, 100);

Patch applied on top of v7.2-rc2.

I can confirm Christophes patch fixes the issue for me. Thanks!

Regards,
Erhard

