Return-Path: <linuxppc-dev+bounces-25064-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432BAC531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:49:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dYY5qSVz2yMn;
	Thu, 30 Jul 2026 15:49:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390545;
	cv=none; b=Vy1lIYCfodktEtVtrvvE8bBJ8JYzGRkxOv2QqZvMkvXnUrxzoMEcYx0JElfD1kb35EotQd+7UacImFFG1511Jm/Kh6GIa4kZkgkAbdQB4lCvsoCPO83+L8Imrn7LT8lu/xR2x1IFs3iLLGHiDVrsZ7dEm1y6IFAhX0agk5AvLP209nTiCn4Aiu/NCZamplvkx9jEwyCsDYUfM1MFfe6rJRQIQLRdAMnlQNF9kgnOOqm3CJLzuGNTqU+ls4+ssGqYfO4133Dc99lEx6RHFROZZws/ASQUMN/QFCuyZ2WeOhyJfE+/iEbmEMaMji+CSRIMqLkUZKAt4vezjWxFji5SDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390545; c=relaxed/relaxed;
	bh=m6Whuwkaw0RMATD5xLRXxrJWIUNWAR2RTwUf7nBvDK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2lImrgt5YZkVDMTwgXszZH4WMJUUoiWL6A3xdOdAwPyb1gC1D+c3jh25mpDEpCy9Zjjkp0d16x9HPb4ZWZIQWznt4JHXey/RIg1L1jUkrjxK74ZyzQQil0YXemDakE3a3iXhOATVG+OI3xBeNraQlPVAZ6EW30obcbPO6o83s7b4E/QZnIOFraG6kjmbWaSKIOoVnVyImqlfE6qAKRFcerDsLafZ6m71/9gm+orncxD9jAfWowHi3uQKySXPYW/M/G5E/1jmh7tpu7126KXJsQ1KSloHlvMOjphAQ3tJPyMgK2ygu79+m6PTPhbHH8vpLH4lkXwqlBYH+JtuQl9Rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1jCs3Wk; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1jCs3Wk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dYX6mCmz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:49:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0E7EC600AA;
	Thu, 30 Jul 2026 05:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAA71F000E9;
	Thu, 30 Jul 2026 05:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785390541;
	bh=m6Whuwkaw0RMATD5xLRXxrJWIUNWAR2RTwUf7nBvDK0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R1jCs3WkxZakz7d2DfJ2xUgxDINXMa99cqAADObqGxUlDCecDoeEKImz+v/VF5TQ7
	 iUM3rZamNOPDQk83PlEvny/EH1zgX+p9KgL9cJpWOE2g1iXL0hMFtRLtYvCfCUIrd2
	 NCSJW1NiDxQMq0JV2LIbAg3o72DMTxkyF2mUPfldaZJqMDUnGzx3tuFvNcc8FaO59x
	 nYQg4AZJKgsGCFMwYNB+jC4rwUaTaVFj2s+8fSsSPorJ0ocSffk4178hshTo36TFS2
	 +D4YVpJGu70IhPkZZgekucuUq4PRsOFkqOJeDJIvwCChLkuPwqAN7yGefxL3EE2e1F
	 zUjV6D4ZVC3lQ==
Message-ID: <880aae3c-a552-4d3f-8ed1-e3dc3911ee1a@kernel.org>
Date: Thu, 30 Jul 2026 07:48:57 +0200
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
Subject: Re: [PATCH 5/7] gpio: ppc44x: Convert GPIO to generic MMIO
To: Rosen Penev <rosenp@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Linus Walleij <linusw@kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>,
 linux-gpio@vger.kernel.org
References: <20260602050131.856789-1-rosenp@gmail.com>
 <20260602050131.856789-6-rosenp@gmail.com>
 <CAMRc=Me0rqs8nxrp95X-2Bjw059ahRxwKrg-NtmEt025w2m9bw@mail.gmail.com>
 <DIYGFNLIFBW7.21W9J6SUGYF72@gmail.com>
 <7ee42722-f7f9-40cc-a576-5f85e3955537@linux.ibm.com>
 <CAKxU2N8n4iHrr-+NxL6D9WZ4EgH_XVJ7yfPa4P6ZyFNJTir60w@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAKxU2N8n4iHrr-+NxL6D9WZ4EgH_XVJ7yfPa4P6ZyFNJTir60w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/07/2026 à 20:32, Rosen Penev a écrit :
> On Wed, Jul 29, 2026 at 3:55 AM Madhavan Srinivasan <maddy@linux.ibm.com> wrote:
>>
>>
>> On 6/2/26 2:56 PM, Rosen Penev wrote:
>>> On Tue Jun 2, 2026 at 12:51 AM PDT, Bartosz Golaszewski wrote:
>>>> On Tue, 2 Jun 2026 07:01:29 +0200, Rosen Penev <rosenp@gmail.com> said:
>>>>> Use gpio_generic_chip_init() to set up the PPC44x GPIO chip
>>>>> instead of open-coding the basic get, set, locking and state handling.
>>>>>
>>>>> Keep the PPC44x-specific direction callbacks because they still need to
>>>>> program ODR and the OSR/TSR registers around the generic data and
>>>>> direction registers.
>>>>>
>>>>> Assisted-by: Codex:GPT-5.5
>>>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>>>> ---
>>>> ...
>>>>
>>>>> @@ -124,10 +102,11 @@ static int
>>>>>    ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>>>>>    {
>>>>>      struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
>>>>> +   struct gpio_generic_chip *gen_gc = &chip->chip;
>>>>>      struct ppc4xx_gpio __iomem *regs = chip->regs;
>>>>>      unsigned long flags;
>>>>>
>>>>> -   spin_lock_irqsave(&chip->lock, flags);
>>>>> +   gpio_generic_chip_lock_irqsave(gen_gc, flags);
>>>> If you're already doing it, can you use lock guards too?
>>> Sure. btw, I avoided placing
>>
>> Do you have plan to address this comment in v2
> Yeah I have it fixed locally.

You should probably put patch 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20260517063754.21819-1-rosenp@gmail.com/ 
as first patch in this series in order to enable applying the fix to 
6.18 without applying the entire series and to avoid any future conflict.

Christophe


> 
> I'm not sure if this has to do through the PPC or GPIO tree.
>>
>> Maddy
>>>
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20260517063754.21819-1-rosenp%40gmail.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C2ac0ec525c7045cd969508deed9fc7e0%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639209467691381845%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=iqGebSy%2BbKMBFZz%2FZwZ9N2Jf8v63FkGPNhrdUf864fE%3D&reserved=0
>>>
>>> in the beginning of the series. My thinking is that's for older kernels.
>>> I believe either the generic API or devm_gpiochip_add_data fixes this.
>>>> Bart
>>>


