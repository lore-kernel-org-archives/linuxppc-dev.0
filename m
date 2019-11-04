Return-Path: <SRS0=P9+W=Y4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79E1CA9ECF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2019 08:07:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7491121744
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2019 08:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="TrDTWGfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7491121744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4765476f7pzF3Jk
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2019 19:07:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::141;
 helo=mail-lf1-x141.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="TrDTWGfM"; dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47650b6cCGzF3cw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Nov 2019 19:03:59 +1100 (AEDT)
Received: by mail-lf1-x141.google.com with SMTP id q28so11511414lfa.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Nov 2019 00:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LxAxNMBVL+dSGienin6qaCrk7en5CTrpwUxUJmlZZRg=;
 b=TrDTWGfMBfFjlWZ8uZDUT0w3BNWxwNGte+a8IpvcI6chs9MWID54loPeAyScghAAh8
 c7UhsZiHgMWlgfVzsY3JlounwUiaxX53oS0f2R2DthwMn0wijXA35T62J9fbrpjvwxSd
 vvkuLYbB2jATrla63DCyxhxyaqfj/lNl8Jy6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LxAxNMBVL+dSGienin6qaCrk7en5CTrpwUxUJmlZZRg=;
 b=dFAHpfLZPPBx63YSZnivKeDVnPeSylDa36RdOPWe1GIpncGZwFZLjsRHckhU4kcnUB
 UpiF7pl4arK7zvLSm0zktkg3STAVRgvGaVygqqq+DYq2qSWF6jLSZkoBjw+yB7ricY2U
 8l9hS04zKr6EIxJvWOkric1uVlwaeVzuIGuFoL2J2UXInsgEAMfSPZWY76ZtTJtlTqBR
 rPhilTvF6wJyfnEIwSmBpJTYc0phc7jTVS/PpUKtfVDmTs9SoaMJsiSHreT+rpOEM574
 vi82ecQ5i5BySgThoGoTIcz4poWBvMMYbszJ2wx82wkiN8na4AHefItTeVw1yE4nERIo
 9M3A==
X-Gm-Message-State: APjAAAV/gJR9QzVqrNCZRlnZza5APIEsSR2hGTqf5byUdyYx7OFem39K
 ImZgSDWAKyg6buLDU1NeyYGRaQ==
X-Google-Smtp-Source: APXvYqwZ6WMPtJAcL4H1FSM0qke7qolXLVZOH2UexXvXSedbKeL3kV7Vji/MC2YFBHtLQv0vvrHfxw==
X-Received: by 2002:ac2:4357:: with SMTP id o23mr3316354lfl.51.1572854634877; 
 Mon, 04 Nov 2019 00:03:54 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id e2sm6742553lfc.2.2019.11.04.00.03.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Nov 2019 00:03:54 -0800 (PST)
Subject: Re: [PATCH v3 31/36] serial: ucc_uart: stub out soft_uart_init for
 !CONFIG_PPC32
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-32-linux@rasmusvillemoes.dk>
 <53c1c463-53fc-2005-3b62-a6f430815b45@c-s.fr>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <6d1e4a08-4107-753f-8701-d3acb44b0104@rasmusvillemoes.dk>
Date: Mon, 4 Nov 2019 09:03:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <53c1c463-53fc-2005-3b62-a6f430815b45@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-serial@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 01/11/2019 17.27, Christophe Leroy wrote:
> 
> 
> Le 01/11/2019 à 13:42, Rasmus Villemoes a écrit :
>> The Soft UART hack is only needed for some PPC-based SOCs. To allow
>> building this driver for non-PPC, guard soft_uart_init() and its
>> helpers by CONFIG_PPC32, and use a no-op soft_uart_init() otherwise.
> 
> I don't like too much ifdefs in C files, especially arch specific ifdefs
> in generic drivers.

Me neither. However,

> How do we get the QE version on ARM ?
> 
> Wouldn't it be cleaner to create a helper for getting the QE version,
> which would be defined in an arch specific header file, calling
> mfspr(SPRN_SVR) on powerpc and whatever needed on arm ?

First, that would mean we'd have to introduce "depends on PPC32 || ARM"
rather than drop "depends on PPC32". Second, the way the SOC version is
being used to construct the name of the microcode blob seems very
ppc-specific, so I don't see how one can reasonably define an interface
that would work for all architectures. But it's also kind of moot since
the ARM SOCs don't need this workaround.

IMO, having to add qe-specific code to arch/ is a cure worse than the
disease. I'd much rather add arch-specific code to qe.

Rasmus
