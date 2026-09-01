Return-Path: <linuxppc-dev+bounces-26403-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F40C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 15:33:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ8yL6SlKz2xmh;
	Wed, 02 Sep 2026 01:33:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788276794;
	cv=none; b=asI8RHx3NxzV65/n7j0FSrzxtBEJhFqbVmHz3CHEof4IEkQlf/qsQ7LG/faA5JNljZ2QijiF6zhfdK8jujVYe0YQGbsNaAbhbXZ1FzuXI5pjfSF7/wrMzL92ABR+CdEPA1tEC9EBe+M2+o6+JW/dnOspLLgmx+u+ZFpAQaRSBca46K19RNIN2D16PcHJVQfDVRPJHrUhRA6CbZNc6Hl2WYJYo1egyh7YzB2iSUE+7x9UDx9D4uotFqD0s9AKD4cqV3vH5Kk0c5+aU6+l5+Eqm58Zj7YMC2j8liaZc/JX0gk7KvV5PW1jomUbENpynwpTocXnVJV9eAfYFVGb0omm7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788276794; c=relaxed/relaxed;
	bh=V/qu2uva2bUx60SUUY+PGcI9I5si8eMEKV73xpdWKew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1umxE+89xU0vKV/U83yhEMULyewsPkUIgPCUzJAokfObPO/QcrlHieCieqWJpkNpZhr37zEEWBchdozvjVX2E/Lh6I9z9/yprd2NAONViN+X+thGa7IG3hK85+OYbaPnmBhYEY/l2Zpb3Gv+Q+jumltWUNx13MGCGxmkpCK2iuAcpdQzjWA/buq+1bb/qaJm9tTbCiK5eR0f+MQS7IZIZorIN4hWLXzVBznbemyObu+xfMmGNDzVVMz4G5SDtH/e9CcCCf1uobxUeaZal/bi6G9fbqNVtmjAUSthosx1noJJu5oP3reqEah0Io0k2PJI+K3uwoP/oQnzphC+aqAoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=as0bOG1H; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=as0bOG1H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=julianbraha@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ8yL035Bz2xGt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 01:33:13 +1000 (AEST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-495590dde14so49775045e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788276790; x=1788881590; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/qu2uva2bUx60SUUY+PGcI9I5si8eMEKV73xpdWKew=;
        b=as0bOG1HwvyARENhvVAbh2J2d899y4hgFYhcAtS9tA8Q+5PL4OtDahCvL/4oXEB9bP
         d6i2ilYAuLjHW4xnoerof9mkRRp3tEYFe8bfDV5rpUoTpsHwTr5lRRjISSgTbiTjubFr
         ZhItZndNGiRI407DZECariP48jy+TLfteh1+Zbd8RAajqkGmhBUcTNAeM94tDh6HudeT
         sKfYqe2njnhXIZOItZs9KaZUxDXTIrAXFs9EONkVAEr2BfRWhkd3STTJ2RsJ7AA43CII
         A9MnhFQMi6zHQD9apHpYuz15C4GnMX5olqmiUlMR39HlGaDHMeMuvALEiWWwum5Ua1Yz
         E5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788276790; x=1788881590;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V/qu2uva2bUx60SUUY+PGcI9I5si8eMEKV73xpdWKew=;
        b=e7KKJDRja5+YTqhdLasdTIWBZh95tY6xLYyyrooSQKHYUJ2ywHJCvM0uAf9JdI1naT
         vBSUP/KAgVbTwJnJIErT01Z/XJqm9W/ZTGCxbYLMaTmZM2CrjLe0lTGwB0tnm7+V64ji
         gW61iOsjodCLh0r6Sa5Uk+MU2qCXWc8dWhv+KDoVfryhI6EK67q9y47Z4XOfX+wKH6U6
         KQUGXVABTT7N8+lQV74/FzJM5OZrnI4kNiFcpB58hCpWzDRJT82QgERF1qzqIKfUYDS1
         Sx1+f/cCYceeLFZh2AEG2l3oPY7oE3nyWC0w+SdHl6g7o3dlGo2Azt5yUtL80XwBmuJr
         oNGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rovb3bVFHef+Rtp+Emw1L3giEoQ+YaXoSc0BhRvwoRnOAt5F1KsauB6KQ4oYTcXdpZhUEtaoQiq0pnJdrk=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kOvql+1buMbHFRHogMOXHu2Kx/OePAl5PbAasvWvKgfluCecGV
	SEgYFTrFUBZglOebemxaWepyRzlZOSNl8vFF9fFN2E1fV0S04O7HtJzi
X-Gm-Gg: AR+sD13BouJpWKO00NHfVoiT27Qzvyjaqc2pdRCIcbtlmWObLPgrZlipoU0/TNmgJW0
	E9ckFcs+VgX8XibkjJdtaWPLUFWvuRDQWi9E6AWFaKC2r2qT4KY2e3Yikwnk8wrIBygHhakxZEb
	Esrk6Lluqn9nSf5VG82GJb3MbAYSmhur1beuNhyq/jOMOwLBMns3Ki5QeA4/9hAFmUN5L62cG26
	S1bj4E9DwUemtoPnaCdn9G42mx2ymGWmpVzeosP2pOeKNQ/t/tarb0tHmTRkQDVVB1T0q+8Hm7o
	c5KZ/3bo5T7o1PLgLzIO/2gCUnbejRNp/6VbxwkPVF+jy0QQGtMlz+FFhjHjzaCTeN8pzYj4U9F
	N6eWWEl46APDhJzsNp3FhvwlpYUYq4Bm6iG49qD3Op4tIGHYaqKmxGQM0n0+TgcytU0k/mPlmuW
	4hTNjpbov99+z4PqK0W500ZzszwTzRdM48EeRdFxyg696TRGmkq4GkmiFWIOqhmOQGUPpinctIU
	OFFwi15rP0guaVLE8Uc3VKTXvk6Aca2FyuY3n3hF3B8/y9BYaYIITRW
X-Received: by 2002:a05:600c:4f4f:b0:49c:dca4:94c with SMTP id 5b1f17b1804b1-49cdca4097dmr190627635e9.13.1788276790183;
        Tue, 01 Sep 2026 08:33:10 -0700 (PDT)
Received: from [10.128.10.232] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c510c9sm235087465e9.0.2026.09.01.08.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 08:33:09 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <ad0b9721-9528-4c59-b75e-bb52ae24211e@gmail.com>
Date: Tue, 1 Sep 2026 16:33:07 +0100
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
Subject: Re: [PATCH v2] powerpc: remove dead 440SP code
To: Frank Li <Frank.li@oss.nxp.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, Frank.Li@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kernel-janitors@vger.kernel.org, linusw@kernel.org,
 kees@kernel.org, colin.i.king@gmail.com, rosenp@gmail.com, joao@joaoff.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org
References: <20260901150645.1199097-1-julianbraha@gmail.com>
 <apbvL6_WqojjOeRA@SMW015318>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <apbvL6_WqojjOeRA@SMW015318>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/26 16:28, Frank Li wrote:
> On Tue, Sep 01, 2026 at 04:06:45PM +0100, Julian Braha wrote:
>> The 440SP config option can never be enabled, making all references to it
>> dead code.
>>
>> The only board using CONFIG_440SP was IBM LUAN, which was commented out by
>> commit f65573314e4e ("[POWERPC] Re-organize Kconfig code for 4xx in
>> arch/powerpc") then removed by commit ff5f483f3091 ("powerpc: 4xx: remove
>> commented out Kconfig entries").
>>
>> Let's remove support for 440SP, since nobody can be using it anyway.
>>
>> This dead code was found by kconfirm, a static analysis tool for Kconfig.
>>
>> Signed-off-by: Julian Braha <julianbraha@gmail.com>
>> ---
>> Changes since v1:
>> - cleaned up preprocessor condition
>> - added historic details to description
>>
>> Link to v1:
>> https://lore.kernel.org/all/20260816125615.985387-1-julianbraha@gmail.com/
>> ---
>>  arch/powerpc/boot/cuboot-katmai.c   |  2 +-
>>  arch/powerpc/include/asm/async_tx.h |  2 +-
>>  arch/powerpc/include/asm/dcr-regs.h | 10 +++++-----
>>  arch/powerpc/kernel/cpu_specs_44x.h | 12 ------------
>>  arch/powerpc/platforms/44x/Kconfig  |  3 ---
>>  drivers/dma/Kconfig                 |  2 +-
>>  drivers/dma/ppc4xx/adma.c           |  9 ---------
>>  drivers/dma/ppc4xx/adma.h           |  2 +-
>>  drivers/dma/ppc4xx/dma.h            |  9 ---------
> 
> Please split for difference subsystem.
Will do in v4, thanks! (v3 was already sent because of a dumb mistake in
amending the commit.)

- Julian Braha

