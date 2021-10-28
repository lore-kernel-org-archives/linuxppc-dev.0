Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B90C433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Oct 2021 01:04:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34DC61106
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Oct 2021 01:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B34DC61106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HgPNP2cSJz3cjj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Oct 2021 12:04:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=A2gDnKnX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::234;
 helo=mail-lj1-x234.google.com; envelope-from=digetx@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=A2gDnKnX; dkim-atps=neutral
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HgKGx5HBsz2yQ9;
 Fri, 29 Oct 2021 08:59:53 +1100 (AEDT)
Received: by mail-lj1-x234.google.com with SMTP id d23so11819175ljj.10;
 Thu, 28 Oct 2021 14:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7iQ4oU5lLihLvwqt++KnGQLKBiUKhW8mB9CMlvRrAlo=;
 b=A2gDnKnXbVmAEWSfC30h5AU4KgqctGREzx+w+qi3liDGTlzRRXf3E1jZyML8gNPqGK
 Li6mIZ0lXuGBdwOE60K0G95Tgukhjr9rRKc5cXQiD0w/VxhtL95meDusnxyabh4+EWGW
 r0TYt6OWs+PjfxzqoZ6eJ3DrcMZlu658BTNljXfs4JxLykUHrLNYB1GLE4vhnXR1mGD/
 zsbBpAOKKFkkKsVx+h1bPiV6KMSfM+yc+Xd2DvoUE9RQ/ZfhiCHVvnICfk2iVe468EjX
 DSGsN20SLeM1V9+yNC6BNE7z4vvudCJzb443pi2WeFnCmYQbcFE9zeHCdAOjGieXrkv9
 /UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7iQ4oU5lLihLvwqt++KnGQLKBiUKhW8mB9CMlvRrAlo=;
 b=qdABN48AKR/UHxFdoPTxahYDaFB2X3pK/u96xGmQmkmVN2Unjg2arBSiVUi+5R7QLX
 MZ3MV+GwpURHUCNBsWj9ESS3wCZs9vy8OgtWEVQzyC1LhaxhniIB0SabR1r9va5g5T+y
 EM7rajBX3+r0Plsw1xyOTw5cYrqKhExPsh0YTot5B+BILRDNHzr5ztmdn1HKixzB1KXC
 EEtrBhqTXAvjJqt0N+uH7fBME0fZnTCnIXNp5JkkUjjCSSTWGYh6NQ+S6AbX7Kk0hEhH
 +WSgcYCjsN61bzcLwxWDpnzfKTVsunZG7l6JsiXHwg5BBU8DrSz+npEpxQ/YbHjJ/LDZ
 h7Ig==
X-Gm-Message-State: AOAM530ViSTv3QBxAo4+pxWBmtMP61SmwMJkL2EZ3SZBuDahLnPgDaNx
 JenFD3PKdwVFG3Md+7ObYoU=
X-Google-Smtp-Source: ABdhPJxS5C9pTHHcX2SeZO1OzU/OwueG01d90Y/t9QArtk4xiAh7ZBD5U7QFitj+IF+gde/bz4TCKA==
X-Received: by 2002:a2e:9d93:: with SMTP id c19mr7265789ljj.363.1635458389307; 
 Thu, 28 Oct 2021 14:59:49 -0700 (PDT)
Received: from [192.168.2.145] (46-138-44-18.dynamic.spd-mgts.ru.
 [46.138.44.18])
 by smtp.googlemail.com with ESMTPSA id e12sm398160ljp.30.2021.10.28.14.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Oct 2021 14:59:49 -0700 (PDT)
Subject: Re: [PATCH v2 08/45] kernel: Add combined power-off+restart handler
 call chain API
To: "Rafael J. Wysocki" <rafael@kernel.org>
References: <20211027211715.12671-1-digetx@gmail.com>
 <20211027211715.12671-9-digetx@gmail.com>
 <CAJZ5v0gpu2ezMhWr=grg6M8aWAx58DQozbXHoZaiPqUaZxJi4Q@mail.gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <31547403-969e-91a9-0792-6fd657b78503@gmail.com>
Date: Fri, 29 Oct 2021 00:59:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gpu2ezMhWr=grg6M8aWAx58DQozbXHoZaiPqUaZxJi4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 Oct 2021 12:02:21 +1100
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rich Felker <dalias@libc.org>,
 Thomas Gleixner <tglx@linutronix.de>, Tomer Maimon <tmaimon77@gmail.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 the arch/x86 maintainers <x86@kernel.org>, Tali Perry <tali.perry1@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Thierry Reding <thierry.reding@gmail.com>, Guo Ren <guoren@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-ia64@vger.kernel.org, linux-riscv@lists.infradead.org,
 Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>,
 Greg Ungerer <gerg@linux-m68k.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Benjamin Fair <benjaminfair@google.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Helge Deller <deller@gmx.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, Tony Lindgren <tony@atomide.com>,
 Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, xen-devel@lists.xenproject.org,
 linux-mips@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Len Brown <lenb@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
 Vladimir Zapolskiy <vz@mleia.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 linux-m68k@lists.linux-m68k.org, Mark Brown <broonie@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Greentime Hu <green.hu@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 linux-tegra <linux-tegra@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Nancy Yuen <yuenn@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Juergen Gross <jgross@suse.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Avi Fishman <avifishman70@gmail.com>, Patrick Venture <venture@google.com>,
 Linux PM <linux-pm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, openbmc@lists.ozlabs.org,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

28.10.2021 12:59, Rafael J. Wysocki пишет:
>> +/**
>> + * struct power_handler - Machine power-off + restart handler
>> + *
>> + * Describes power-off and restart handlers which are invoked by kernel
>> + * to power off or restart this machine.  Supports prioritized chaining for
>> + * both restart and power-off handlers.  Callback's priority must be unique.
>> + * Intended to be used by device drivers that are responsible for restarting
>> + * and powering off hardware which kernel is running on.
>> + *
>> + * Struct power_handler can be static.  Members of this structure must not be
>> + * altered while handler is registered.
>> + *
>> + * Fill the structure members and pass it to register_power_handler().
>> + */
>> +struct power_handler {
>> +       /**
>> +        * @cb_data:
>> +        *
>> +        * User data included in callback's argument.
>> +        */
> And here I would document the structure fields in the main kerneldoc
> comment above.
> 
> As is, it is a bit hard to grasp the whole definition.
> 

I'll move the comments in v3, thanks.
