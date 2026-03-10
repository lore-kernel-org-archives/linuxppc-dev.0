Return-Path: <linuxppc-dev+bounces-17974-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93B5FD4F04
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:30:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVfWR0ZvZz3bjb;
	Wed, 11 Mar 2026 03:30:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773160243;
	cv=none; b=OQskhMgScsGNDGRsz4aGm0ooYPVbIiqC8iIkpvanM/IUbU83uTM4qbrIMFKkBG33UaixKKlS9d9y1TIoJIh1aVEhn9ac/1KALF/LXWUi1IrD0YnDzofCrTTxlpES8tmGvEZpgg5pc5GjEHRhhBAySn+P0QD4KXKL04TEZ1ys3FyyPP7GY2IRdqX9qXX4JS++7qLvQOxlHr3bdDY6HU2hDS3J6gpI2Ym2XkTWdtu79X+bcC/wiP2j0NSa0V6maLAH735PnH8HpTcK0F2EJr/5RysTVqefh1ERRpGt2GQbrqg2SdZFdG8vM8Nqcnpri23dvuf3IJT+VbFoqeGkxS9YtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773160243; c=relaxed/relaxed;
	bh=lKuZ7sCTA23O6UMLzwIK0nZOTeVT/y7oS3+4wC3Dplg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JGmgF4qRvv7BGHFLkgh3bL+W06MIhAWRe2fC0gAmtX1lZ184qGvjCV0NyOpnXQWOCGtr8xIxjTATY6GRxMUT6DPFP0ZsyB5mw/vMHpikN88DH4Ymvb45Z6Au6EiGa56ShIotjNwelO3oA1L75J7QKpAb+49avYlXbPsQn4TZGJv+l7Nvfh5Y83uIoN67pUxHBIkuaM6OD+hALVFHhVnF2tKbgUZtAbITR0t4i8TxojaZeVHQg8FO9lW476opaLvuWC6Az2Gt4x4kkrs5rT4KAaYQq69n0xtXeZ1soCrfxQDcGdKTib++siTtAbV2jIKBmYQaUAKFfhpvZ1JavlYUsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YqpYPpuU; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::; helo=out-171.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YqpYPpuU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::; helo=out-171.mta1.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-171.mta1.migadu.com (mta1.migadu.com [IPv6:2001:41d0:203:375::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVfWK1dnYz30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 03:30:35 +1100 (AEDT)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773160211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKuZ7sCTA23O6UMLzwIK0nZOTeVT/y7oS3+4wC3Dplg=;
	b=YqpYPpuUFMvPakjiAl1Q2H5dZcCDlq0qYcNktSN2LvQlC4RB/QAnT6gNg63ahA2npf0g59
	6427GcmRJjCT8rIgSWoMCgyMok2yhenK7NLlKF9o57DVwAMLJNSuqzid6jbgnrhT12yv8Q
	OaeCQbkBNT19blXwzAhCxMTUhnd3h08=
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
Subject: Re: [PATCH v2] ALSA: aoa: Skip devices with no codecs in
 i2sbus_resume()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <878qbzradt.wl-tiwai@suse.de>
Date: Tue, 10 Mar 2026 17:30:01 +0100
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Kees Cook <kees@kernel.org>,
 stable@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <933E291B-23F2-4144-80F0-EC5730F65B75@linux.dev>
References: <20260310102921.210109-3-thorsten.blum@linux.dev>
 <878qbzradt.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Migadu-Flow: FLOW_OUT

On 10. Mar 2026, at 16:07, Takashi Iwai wrote:
> On Tue, 10 Mar 2026 11:29:20 +0100, Thorsten Blum wrote:
>> --- a/sound/aoa/soundbus/i2sbus/core.c
>> +++ b/sound/aoa/soundbus/i2sbus/core.c
>> @@ -405,6 +405,9 @@ static int i2sbus_resume(struct macio_dev* dev)
>> 	int err, ret = 0;
>> 
>> 	list_for_each_entry(i2sdev, &control->list, item) {
>> +		if (list_empty(&i2sdev->sound.codec_list))
>> +			continue;
> 
> This can be even outside the loop and immediately return 0, as the
> remaining part is also the loop of codec_list.

The i2sdev pointer is only assigned by the outer list_for_each_entry(),
which iterates the controller's device list. Since each device has its
own codec list, list_empty(&i2sdev->sound.codec_list) must be checked
inside the loop; before the loop i2sdev is uninitialized.

Thanks,
Thorsten


