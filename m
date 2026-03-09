Return-Path: <linuxppc-dev+bounces-17896-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FEFF3C241
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 12:55:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTxnf5SV0z309P;
	Mon, 09 Mar 2026 23:55:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.189
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773060934;
	cv=none; b=Se0dNfP5KJwgDXV1DxZr4inS1AFnyJg2uF4cPnXohOvmJ0CspBmAaEBkr4apv3PRksjK/j3IGt6EbZ4xYNSsBc3491vegBCxKOrKj5HDG6nKbMxJYrbyl8PjpH8Z9ZrcGrZS3H3xlDUPUJFIg/phn7QNS5iwJCe7xWqJ9q7bgbXFpSw+szYrr3U+2dRGi0/kE8czanrqVjb29Bt56y4LgbcYKsF79ckiaHwQsHI+HYewCvnxXwSA7Gkwq6ImGDvSRHLmiLXlEwyRKb1NRGGRNv0755Q1GxV2tLPP4RNWKDJ/2lyntNaxicgGsv1wJbqQOvtLqx1fN3B948O+hSpc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773060934; c=relaxed/relaxed;
	bh=+RwK8RR51qXeZ71e+SyZvIcyWk9REBek1JHzsr0gp2E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=luVmHNoupbmc04+8sdogdOQscRX2YVmAyRRM+9jl7zbYfygJxPSGRSiI8w1FrU9ufE0iKZulQz+QvluMVkiwGpH7d/hpuvyJHmmA3Ag0iw8wIagKzhWY/qW5pGbzY99vsiNQJffxvPBOM9vh+y1tONTy9VHH7m6EJR3B/sHG4d6EqbKn7psLUB36o+DJcEgsHX74rRzIxUaEffWRNLDRu2LUzjjsacPj/HvmaNDOp7TO/1UuQ1Nn1UBfRTQ6JVZqrlSTYz7aEDrVxe07xYnCcjKrBzbl1zAgyl+HsGsdhVfuR8Tgj4eIkBvtT9yYMENeJQ60nQsF8/O5yzA3SqNJwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p8qmf8wM; dkim-atps=neutral; spf=pass (client-ip=95.215.58.189; helo=out-189.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p8qmf8wM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.189; helo=out-189.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 4293 seconds by postgrey-1.37 at boromir; Mon, 09 Mar 2026 23:55:31 AEDT
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTxnb5kZhz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Mar 2026 23:55:28 +1100 (AEDT)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773060908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+RwK8RR51qXeZ71e+SyZvIcyWk9REBek1JHzsr0gp2E=;
	b=p8qmf8wMnjquqbtDjCeFlkv0g/rwvbNPeTR18zkEYenETkIXumccUggucGa0zgF6GLFLib
	djNVfvGk4X/ruI12bGeiJmIWq/w/TeASL0uz2CUP4SvuXjw4HSrvbgcBOJSUbD//EuWvQm
	6+dP7/V+lRP4TfPb+t+51d5aiGXV3nY=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] ALSA: aoa: Handle empty codec list in
 i2sbus_pcm_prepare()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <87zf4hmcw4.wl-tiwai@suse.de>
Date: Mon, 9 Mar 2026 13:55:02 +0100
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Kees Cook <kees@kernel.org>,
 stable@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CFB7A246-8C9D-4F49-8143-2883030C1135@linux.dev>
References: <20260309114159.765304-3-thorsten.blum@linux.dev>
 <87zf4hmcw4.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Migadu-Flow: FLOW_OUT

On 9. Mar 2026, at 12:59, Takashi Iwai wrote:
> On Mon, 09 Mar 2026 12:41:59 +0100, Thorsten Blum wrote:
>> Replace two list_for_each_entry() loops with list_first_entry_or_null()
>> in i2sbus_pcm_prepare().
> 
> Hmm, I guess both can be simply list_first_entry(), as the codec list
> in this code path is guaranteed to be non-empty (it's called after
> i2sbus_pcm_open() which has the check of the valid codecs).

That guarantee only holds for open/prepare, not for i2sbus_resume() via
i2sbus_pcm_prepare_both(). It's probably uncommon in practice, but
i2sbus_pcm_prepare() should still handle it safely.

>> Handle an empty codec list explicitly by returning -ENODEV, which avoids
>> using uninitialized 'bi.sysclock_factor' in the 32-bit code path.
> 
> Which 32bit code path are you referring to...?

The SNDRV_PCM_FORMAT_S32_BE/SNDRV_PCM_FORMAT_U32_BE branch.

Thanks,
Thorsten


