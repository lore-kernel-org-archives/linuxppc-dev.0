Return-Path: <SRS0=r+Zg=KM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CC5C433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 13:40:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3625610E9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 13:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3625610E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FkKxp1hfRz3bwb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 23:39:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=kmO+qJKs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f31;
 helo=mail-qv1-xf31.google.com; envelope-from=groeck7@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kmO+qJKs; dkim-atps=neutral
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FkKxG0DV6z2xvZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 May 2021 23:39:29 +1000 (AEST)
Received: by mail-qv1-xf31.google.com with SMTP id ee9so3057734qvb.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 May 2021 06:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A3NxUbNLMPXTjkL8u55YMZmOt8zksMxOha2crYcJLBA=;
 b=kmO+qJKsZcLoOF7PGkm7L32EvjE7uvAOFNYHvxVYs+HohMpY3FgbtRFNwYIxunRfy3
 QF6nFYW+Q1rX8DcIqD/0A1aPDtX8Lc8C6bNEocA1mPYbW0ydnWBkQ2UEE96b7Ptcqmt6
 rz7+Nf2fSE3WvA5jeNY8Xepddza2/Huo7nU/zH8TgkESOpyqvnDOaYqGiN4snhz+YlDf
 IoedFzl45I0+r2fcyvlu9EeAA9FBaRLnofRhDy/Cz7yoxKtA9w6BMvXqrccsz8gbts3M
 doukWLr7clciHBmHFe0/3oJkERLs+GvBkiSCaYnNTvpPVjdLF3R6MWglbb7AUWtlfk/G
 ambQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A3NxUbNLMPXTjkL8u55YMZmOt8zksMxOha2crYcJLBA=;
 b=mkMKHZkRJBvvk6mXoVWlN14XROD8NhmW/EojQsVfCMAbYh28DPTH9oHU01U+vr2CU7
 OzPzDqnmyekrm0wEqbn870XwNe4l2GXyNPVL1viug5bPTpJINc8TxqDsuy+tZdDNPeF5
 aUZImnUJzmQwFPfuIe5/q1GHjZqFkza/JvqRuIVVbbczmKOE6W5WymmOugZfaitslVgV
 tx6Q9Gn/3jUtt5OLv6Y/ZRL4Or0DCJ2pWdA7lXUN81ZIu7gO/+yn13l+tZ5XN0syONRC
 WxLiBO+KzgceW5NwO2USm1GmmGvzz6PzzEjobPNW7Yj0/XJm3pSrBOxQUo/XDrMzE/vx
 rvgg==
X-Gm-Message-State: AOAM533p3zc3kbmTJVaLRYDT4yWACJS20j3l4eUY2MorbctqFtZmo9cP
 ALRn5myJ+n7AB4jPejG9O+s=
X-Google-Smtp-Source: ABdhPJyFpQWas9TnjR3tLUfuTcCLS2v5FkqsbUjFFDtmU1mcdGY0L3TTuO36o/huwbr37WjGdc0i0Q==
X-Received: by 2002:a0c:9b83:: with SMTP id o3mr32661074qve.4.1621258767420;
 Mon, 17 May 2021 06:39:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 j10sm10127053qtn.89.2021.05.17.06.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 06:39:26 -0700 (PDT)
Subject: Re: [PATCH] watchdog: Remove MV64x60 watchdog driver
To: Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
References: <9c2952bcfaec3b1789909eaa36bbce2afbfab7ab.1616085654.git.christophe.leroy@csgroup.eu>
 <31d702e5-22d1-1766-76dd-e24860e5b1a4@roeck-us.net>
 <87im3hk3t2.fsf@mpe.ellerman.id.au>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e2a33fc1-f519-653d-9230-b06506b961c5@roeck-us.net>
Date: Mon, 17 May 2021 06:39:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87im3hk3t2.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5/17/21 4:17 AM, Michael Ellerman wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
>> On 3/18/21 10:25 AM, Christophe Leroy wrote:
>>> Commit 92c8c16f3457 ("powerpc/embedded6xx: Remove C2K board support")
>>> removed the last selector of CONFIG_MV64X60.
>>>
>>> Therefore CONFIG_MV64X60_WDT cannot be selected anymore and
>>> can be removed.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>>> ---
>>>   drivers/watchdog/Kconfig       |   4 -
>>>   drivers/watchdog/Makefile      |   1 -
>>>   drivers/watchdog/mv64x60_wdt.c | 324 ---------------------------------
>>>   include/linux/mv643xx.h        |   8 -
>>>   4 files changed, 337 deletions(-)
>>>   delete mode 100644 drivers/watchdog/mv64x60_wdt.c
> 
> I assumed this would go via the watchdog tree, but seems like I
> misinterpreted.
> 

Wim didn't send a pull request this time around.

Guenter

> Should I take this via the powerpc tree for v5.14 ?
> 
> cheers
> 

