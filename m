Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B19C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 06:38:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3118217D7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 06:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="LOAAxD1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3118217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443WJf4WrXzDq5t
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 17:38:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="LOAAxD1J"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443WG64FjYzDq5t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 17:35:57 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id r14so9904816pls.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 22:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=iZ4X/qyWHDHNBj37v+JWguFgkZRmmQ1sgV7vuxHIxzQ=;
 b=LOAAxD1JIXNm3A0cRnZEMHiKitOooHXDYIEGqsn/ADjNT1RqSKzIs4gvqdr8xAoDbf
 XL1Fm+x1XP9tiMtwFW2dOThhkjFfquci/S9usLAsTOYgYCpBE622IAM1rJoEIgfEoKSK
 SpSqcBZqFJVAwMYMyXytHtCW6kHTUpxkQTCXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=iZ4X/qyWHDHNBj37v+JWguFgkZRmmQ1sgV7vuxHIxzQ=;
 b=FMEFNZ4vTsrH+WrZMP4m1D2lRP/J8YbP/Xo8jD8vLp7olsumsvI1prGS5OAC3Ry1md
 x4TbYszj5tVyrOgesddAMnOQYtvJRt3tgYsXBqZrj4dvqQPxDs//A1B0a9U3xUcfCLzO
 BbA5qxeJTOdo/wl2JUO8U+MbGvM0BG2JhS332hWjkH2KMJfUL76MYRF46XgA2iRdpNEv
 gFbQ18HYAD7uxTs0pxgw5L9bmRrfq/Qs0C+ZNB5c9V3ectuhu/7Bh6kzVZgaWavTgBOw
 trq055igUNEDTunuh3uCGwRQlWDl9fmjdP6EYY2ujkeyUIzrrCZRMGw13WeczK4fUSS5
 pcAA==
X-Gm-Message-State: AHQUAuaNCL+V4/E2Dk7aAMSs39dEMUK6GJxEuJJfI2BR/hsMHg9ffa70
 ZNFEWe8iRqR1fz9WmnqoNc1wkQ==
X-Google-Smtp-Source: AHgI3IYS/I+IKjRHnZv7FjnpdFoLO8oJl4Jjldqyodb7HQugUuUbMp7xYyz//bOxyDGDnib2wfuJZQ==
X-Received: by 2002:a17:902:9a81:: with SMTP id
 w1mr28427843plp.19.1550558155846; 
 Mon, 18 Feb 2019 22:35:55 -0800 (PST)
Received: from localhost (ppp121-45-196-25.bras1.cbr1.internode.on.net.
 [121.45.196.25])
 by smtp.gmail.com with ESMTPSA id e6sm28533396pfe.59.2019.02.18.22.35.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 22:35:54 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [RFC PATCH 0/5] powerpc: KASAN for 64-bit Book3E
In-Reply-To: <20190217063454.GD31125@350D>
References: <20190215000441.14323-1-dja@axtens.net>
 <20190217063454.GD31125@350D>
Date: Tue, 19 Feb 2019 17:35:51 +1100
Message-ID: <87tvh02sl4.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Balbir,


> Thanks for following through with this, could you please share details on
> how you've been testing this?
>
> I know qemu supports qemu -cpu e6500, but beyond that what does the machine
> look like?

I've been using a T4240RDB, so real hardware. It boots both the QorIQ
Yocto-based distro and Debian ppc64. I have run parts of kselftest and
am currently running LTP - so far no errors have triggered.

Regards,
Daniel

>
> Balbir Singh. 
