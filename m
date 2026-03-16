Return-Path: <linuxppc-dev+bounces-18220-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AEBF013F0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 09:09:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ8Rb1sbPz2ygh;
	Mon, 16 Mar 2026 20:09:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773650551;
	cv=none; b=VwZOCTccNEifmjAB5Q4S2LXtl4k9uJVSS5GJqCjNiAD6nM1i4bBFsJtyC4tfNH//2iQ9qQnfDeKIOI8HS/x9hQp71q/LTfdYXd+OqTR/5NDapBrrmfq6WAqIHEfov/gLSWCnUzzpuiIIs7lgQBUjs9+ZqShS2nhozMavrp6rFOpWN91qdrk20ncp0LD+lr0NlKBIuQDcHWVkFYjKaRP8W0rR1rGd8sy56oqFf/UGfxMrQAAmD922MVL8gyOa997pYGwzubdJT9cKEg1YRDz3a9U1GiodMHxdN/lW94xhxMOUkHS+0qFOZRj3Qid0VjKEBUN8K39l0oX0cvhBEfNOig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773650551; c=relaxed/relaxed;
	bh=y5rdKYHLZKcPCs+PuT8wvrz6Hsqg7tEiKjR4+wYLNiY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aQjSyx4cZR2o2fuk6nb+52wEkn0IWEeQFwFjgFcZHga042SoBTDZsivzOuCumeEy0iZtefrfjLRRBEJDTb6OEf6RAkNA2rfrVvdJx2w4qF9IJ+eN1krw1qsQ1maBPsLEiN0WcI0NcKZjh8DkJEzwobq7XlyqBGnpHYaxJNSZj0gAWSBtH6OzcybaNYxBNMiPwuLBi6bMHrNT9ShyYre3iz5iqRLMw+9MJWfC1cg+EL+x89T/pf/6Z8AenIhI7SvKd8qW/LdvXfTIhsNd56br6WldPYVfbxNrq7kRSM13Sw49s2C/9KIJGq4KV+rtc+qY8cbIZ8y1YJMHQ+cXVZ0M6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HueAbbgb; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=hverkuil+cisco@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HueAbbgb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=hverkuil+cisco@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ7rR1Y7tz2xlP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 19:42:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F2BF8600CB;
	Mon, 16 Mar 2026 08:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1B3C19421;
	Mon, 16 Mar 2026 08:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773650548;
	bh=9LJ2+2SgK7w+NRyNaEGoZkSKWLsSd19na5lnCcCLdDA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=HueAbbgbhxKEaBW7w0dzIcNXgtAE9iyH0WnDtPEOzjPRgM71uZliWj8r0Mz7sQCrS
	 9SwYtorMTIo0o4AfIeBdDWSRXF5TlvCphV36rMWzFcoLZaVnQH4SPhLc3M5TlZqb0L
	 vBkdB79aBc76zAUt2+11fObdKcjBUIqAF0qYW/h354DhJbLj4D4ByTZjqswWFutVFE
	 Sbp+n19NLxxsFope55qDW3egNxCb48nf/BiUjaHT9Gj/TFwXInqNlsxLvnow3vHZrZ
	 05ThNtgMvOZ0L8xV7rj4yEbEmu+rSSb2eDyuLBCyh0Ehst/lK8lGR+IyiVfrES+pTh
	 ffgqQGNEIQF7w==
Message-ID: <2d879c2a-aded-444c-a54f-cb0e8acd89b1@kernel.org>
Date: Mon, 16 Mar 2026 09:42:21 +0100
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
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v2 01/13] media: saa7134: rename i2c_dbg() to
 saa7134_i2c_dbg()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Andi Shyti <andi.shyti@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Khalil Blaiech <kblaiech@nvidia.com>,
 Asmaa Mnebhi <asmaa@nvidia.com>, Jean Delvare <jdelvare@suse.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-actions@lists.infradead.org, Bartosz Golaszewski <brgl@kernel.org>,
 linux-media@vger.kernel.org
References: <20260223-i2c-printk-helpers-v2-0-13b2a97762af@oss.qualcomm.com>
 <20260223-i2c-printk-helpers-v2-1-13b2a97762af@oss.qualcomm.com>
 <76fd11b2-7789-47c1-a832-12907155ead1@kernel.org> <abfBkg8YpDKIlOVu@shikoro>
Content-Language: en-US, nl
In-Reply-To: <abfBkg8YpDKIlOVu@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/03/2026 09:38, Wolfram Sang wrote:
> Hi Hans,
> 
>> Do you want to merge this through the i2c subsystem? Or do you want me to
>> merge this patch through the media subsystem?
> 
> The rest of this series has been dropped in favor of a different
> approach. I still think this single patch here is useful, so if you
> could pick it up, that would make a potential future change easier.

OK! The patch makes sense, so I'll pick it up.

Regards,

	Hans

> 
> Thanks and happy hacking,
> 
>    Wolfram
> 


