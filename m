Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81903C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 11:44:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0F5205C9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 11:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="h0qggWdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0F5205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435G0B3r8wzDqTX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 22:44:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.b="h0qggWdR";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="h0qggWdR"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435FxD1kX7zDqfM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 22:42:07 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id b85so894019pfc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=QYGC0gxURL36EZCtHXEr09RP/iRqbuit9claNuHz69g=;
 b=h0qggWdRnRl0CHUq2HMuRGfRT2csXCQFrw1/BzKORvPLGAGkw24CLE9BeXZBIM3zZx
 cQ4ak/s8+WI0rYJ4y62MgtEwFgeHmNd/ae3FKnH9aZhFxn7JhJFFE5glIU2WrmOnUOCH
 Jjy6XPMwqRilSykdJmnrZS+unvsAO3envgqaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=QYGC0gxURL36EZCtHXEr09RP/iRqbuit9claNuHz69g=;
 b=sE49uxot9lEOVL0UAfcSTGzBVJLX56ekaM1lMFAqvnv+GhYtDW8pCcsmg+lrw5wEOz
 Nflz4KttW7dY/Y6pglMjy6OghCXxqnx/ui2vMNMyDhxicxic3FCYs7aihjIrV+aMZaLb
 M1/wMZOYnoq/Jr6jKQAViucTu95Ri5hLAzLOWarP/J1tJx14/y6sVwVsoWyExUn74xEj
 QA+H/xKX1YawPID8FvdpB3JSPOStzkFazGYzXZSwU2i+0xmYk+JKT5tCqA7aTWgPuMuZ
 Z30y3xIl6UzAfmn83AhPZcpAcmmC/u/e5mDANUDSwI0KN7Bh9Ns0HCiUvSzBZwHhos5x
 JNYA==
X-Gm-Message-State: AA+aEWZcoO3scIn5nlUqmWBSiBi3N8Onmb570otyNPmmPDmA/JNBMykg
 SvSDx2+T3S5l63Aru32sCAaHetfIWMg=
X-Google-Smtp-Source: AFSGD/V/JW1ue2LtX3J3tEgchMjvAEOyffX2JmPBe2ldad8sgG+FDWtg7cI9p81dPMOqG27ckhJN9Q==
X-Received: by 2002:a63:2b01:: with SMTP id r1mr935694pgr.432.1543491725802;
 Thu, 29 Nov 2018 03:42:05 -0800 (PST)
Received: from localhost (114-198-118-47.dyn.iinet.net.au. [114.198.118.47])
 by smtp.gmail.com with ESMTPSA id o1sm3936760pgn.63.2018.11.29.03.42.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 29 Nov 2018 03:42:04 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/boot: Copy serial.c in Makefile
In-Reply-To: <87zhts2lgy.fsf@concordia.ellerman.id.au>
References: <20181128043417.24784-1-dja@axtens.net>
 <87woow7apx.fsf@linkitivity.dja.id.au>
 <87zhts2lgy.fsf@concordia.ellerman.id.au>
Date: Thu, 29 Nov 2018 22:42:01 +1100
Message-ID: <87tvk06rg6.fsf@linkitivity.dja.id.au>
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
Cc: Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi mpe,

>> Further analysis suggests that making with -j1 triggers the issue, but
>> everything works with -j2 and above. That would make sense with the
>> timeline of when I discovered the issue because I changed my build
>> script to not build in parallel.
>
> I don't get why -j makes a difference, but that does explain why we
> haven't seen it, none of my tests use -j 1 :)

I don't understand either - only that with -j1 V=1 I get

  powerpc64le-linux-gnu-gcc ... -c -o arch/powerpc/boot/serial.o arch/powerpc/boot/serial.c

and with -j2 I get:

  powerpc64le-linux-gnu-gcc ... -c -o arch/powerpc/boot/serial.o /home/dja/dev/linux/linux/arch/powerpc/boot/serial.c

So for some reason j2 is getting the absolute path and j1 is getting a
relative path. I have absolutely no idea why this would be.

> I don't think we actually want to copy serial.c, we just want to specify
> a dependency, does this work for you?

Yeah I think you're right, I misunderstood the boot wrapper.

That patch works for me - it causes the full path to be used.

Thanks heaps!

Regards,
Daniel

> cheers
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 39354365f54a..ed9883169190 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -197,7 +197,7 @@ $(addprefix $(obj)/,$(libfdt) $(libfdtheader)): $(obj)/%: $(srctree)/scripts/dtc
>  $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
>  	$(Q)cp $< $@
>  
> -$(obj)/serial.c: $(obj)/autoconf.h
> +$(srctree)/$(src)/serial.c: $(obj)/autoconf.h
>  
>  $(obj)/autoconf.h: $(obj)/%: $(objtree)/include/generated/%
>  	$(Q)cp $< $@
