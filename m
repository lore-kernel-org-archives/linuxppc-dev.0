Return-Path: <linuxppc-dev+bounces-25737-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8227C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 10:40:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK7Rg3BKsz2yyJ;
	Tue, 11 Aug 2026 20:39:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::546"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786444799;
	cv=none; b=VUsJ6Qzif5dbYmNZd7YVy4hQqYgca0BB5Gzm53dNqzmrx9e3KNx9u0CSS1zIdTTX17iAuitCMAIJU1cV0cOCDlYOPBKLfYENkeMUVLmzU2aOEJLSFwGSbtCe80Dj79HbeR6voatpKM96LOYIE9vuPdySihpTBkdmGk/7FCTHKSVegd4E4/PahB3EWCVXTbh5c6bRb1+C89FTiiMsYd0Mi2bfmhdivkuXqsEN5zwLg8Pu7oU+YOQhwnhfExFmImp03OTWpS4OQMBY8PLgYO8R8MfW6YIIUH1shOWQXATxjJiw2jMGB0SClR0fJSi8NHpKggkiFa/qathnrOgX8ii39g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786444799; c=relaxed/relaxed;
	bh=VGMemQkEC5pRlM4gYZJhKb5X+L3Mgf2+8jXep9XZ59M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TjV/Bg2bN8wpxA9M7oWLr4+v+F1n/zTJh9TEkWU122WbGWrkUJjigrd6rlMs9Vhf85/VDZpLopbHmS6VKuKHoSfW+Dvk7EW1WpzIaJVNgcoQP5DEpkicFDXhAAZxYPFqY5werTmSmO7adJWAmPG0jS1UO3oJKht2mMQS0FlFRM/5eXd4B9dB3lFSiyamZFgPjKGlWrfLyzy95YUNV8jtBC/WnQC9OSqv9EXBj7vi7unzTSuBULO2Dpg0wAM6g85D2dqbETClu3rKKi3ypLy+0dZSVgf7DHmeJTVDDZfzrtcCVVfno0oRsDm55nAuE9bMNLWBQvbxvPWUCiF+aziiow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oGPgY5/p; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::546; helo=mail-ed1-x546.google.com; envelope-from=38_t6agkkddihofibgoviuccuzs.qcazwbilddq-rsjzwghg.cnzopg.cfu@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=oGPgY5/p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::546; helo=mail-ed1-x546.google.com; envelope-from=38_t6agkkddihofibgoviuccuzs.qcazwbilddq-rsjzwghg.cnzopg.cfu@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x546.google.com (mail-ed1-x546.google.com [IPv6:2a00:1450:4864:20::546])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hK7Rd2lNbz2yvM
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 20:39:56 +1000 (AEST)
Received: by mail-ed1-x546.google.com with SMTP id 4fb4d7f45d1cf-698557ec1e9so2022425a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 03:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786444788; x=1787049588; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VGMemQkEC5pRlM4gYZJhKb5X+L3Mgf2+8jXep9XZ59M=;
        b=oGPgY5/pc60lRYpGZZi60xjmd7f46JX+ZIN6BYZGzWUPf5MVE7rDeSYzfPSz9zkFw/
         sBxJoEnpkTxgUixCyhiUaoAqt88fykfUiGm4NJOtEo/INe/rkqZ0FSfkast9lkA1zN9L
         CtJE2/C1rFz/Vkoc6Kn2YhJKpXiD/y9yNDcNRIAHfQ5gw09yM/+FYms31ZltpjJZ1S9Q
         1ANL1Io6wcOMxOaDDJfyvjOVzD2dy85chJw+21IVa3bSnxy3FQVPR/IuNwMdgyx/oHu7
         3QBOrvUsW/bKsWJOm/qe8bC/gnyvmGpudYGFPWAVl8PRyyW5X5vLD5It25G9Ywcg8NKt
         xYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786444788; x=1787049588;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VGMemQkEC5pRlM4gYZJhKb5X+L3Mgf2+8jXep9XZ59M=;
        b=MTypCf9WXTlshA4wrrQI3RojF6zPjIIA3vMUvFXWEEPW1r+6CadIbVwzyej9eshz1B
         ffx+TnOMzqABhituhiep+ykyZPdao9H+Znbyzafsz2Cd5CSWuwc4sZX/xsGmvMbuy6/y
         /DawXjwDwFKHGFnEyk8tm0a7NKirs8VVfjjrfozYTsO476VvzUTkaJmyzRAifTzV1NjE
         M0P/9r//LOtAi3kqzWIET7mQclzN5xbJ4dK+AjRoRzTTMeQEKy8D/W3Va69D6JHTPVBh
         vlyZcW1bGI/mo5kep/Ph5bEAGxCE5JXgtfFSVci06BL6isOReqZgnHndrX+Vr2SHsjuD
         fTAw==
X-Gm-Message-State: AOJu0YwpfW3KUD9xQf1v4aQu1EtS4eDdiKTwn6Y3Xn+3UAhj77y2LVHp
	MHTsPhGRqfpxemoNp+K9WNulrDErvfRe5BESlXxczhjw13BWI8WjgxHoTK6MWTLUq8+K2EVMmCd
	rr/VwgJzddCppSw0VBA==
X-Received: from edbdm24.prod.google.com ([2002:a05:6402:22d8:b0:6a3:6510:8ace])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2417:b0:6a1:ffc4:e4b9 with SMTP id 4fb4d7f45d1cf-6a3644aeb16mr1321144a12.9.1786444787939;
 Tue, 11 Aug 2026 03:39:47 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:39:47 +0000
In-Reply-To: <9e189214-1274-491b-97dc-1b943c6c5cea@amd.com>
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
Mime-Version: 1.0
References: <20260810162814.1398016-1-tarunsahu@google.com>
 <20260810162814.1398016-4-tarunsahu@google.com> <9e189214-1274-491b-97dc-1b943c6c5cea@amd.com>
Message-ID: <9huzbjb9hrf0.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH 3/4] EDAC/versalnet: use put_device() on device_register() failure
From: tarunsahu@google.com
To: "Pandey, Radhey Shyam" <radheys@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geoff Levand <geoff@infradead.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, dmatlack@google.com, 
	Borislav Petkov <bp@alien8.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, djeffery@redhat.com, 
	Tony Luck <tony.luck@intel.com>, skhawaja@google.com, 
	Russell King <linux@armlinux.org.uk>, stuart.w.hayes@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Pandey, Radhey Shyam" <radheys@amd.com> writes:

> On 8/10/2026 9:58 PM, Tarun Sahu wrote:
>> When device_register() fails, calling kfree(dev) directly bypasses the
>> device_release() callback (versal_edac_release) and leaks the allocated
>> driver core structures.
>> 
>> Fix this by calling put_device(dev) when device_register() returns an
>> error, ensuring proper refcount decrement and release cleanup.
>> 
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>
> Thanks for the patch. FYI, this issue is already being addressed in an
> ongoing series.
> https://lore.kernel.org/all/20260724171945.2812749-5-shubhrajyoti.datta@amd.com/
>

That is good. Should it go as saperate patch or it fits very well with
the above series. I will drop it incase of later. WDYT?

~Tarun

> -Radhey
>
>> ---
>>   drivers/edac/versalnet_edac.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
>> index 97ec05d68bbb..2912b3658915 100644
>> --- a/drivers/edac/versalnet_edac.c
>> +++ b/drivers/edac/versalnet_edac.c
>> @@ -829,8 +829,10 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
>>   	dev->release = versal_edac_release;
>>   
>>   	rc = device_register(dev);
>> -	if (rc)
>> +	if (rc) {
>> +		put_device(dev);
>>   		goto err_mc_free;
>> +	}
>>   
>>   	mci->pdev = dev;
>>   	mc_init(mci, dev);
>> @@ -852,9 +854,9 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
>>   	device_unregister(mci->pdev);
>>   err_mc_free:
>>   	edac_mc_free(mci);
>> +	return rc;
>>   err_dev_free:
>>   	kfree(dev);
>> -
>>   	return rc;
>>   }
>>   

