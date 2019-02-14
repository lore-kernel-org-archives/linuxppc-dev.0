Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A74C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 18:12:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B1B20836
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 18:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZPnbWkIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B1B20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440kxX0w2czDqGW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 05:12:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="ZPnbWkIa"; dkim-atps=neutral
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440kvM72L9zDqVD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 05:10:07 +1100 (AEDT)
Received: by mail-lj1-x241.google.com with SMTP id q128so6045572ljb.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 10:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D9Vj6+WeVlYF1H2fg9mql/6oMEXHu/mgsv8BNTVZHx0=;
 b=ZPnbWkIaLF1fPpbhVu5fqt9VoWAh7zq9mqH5LmbreMaS/dFp/ga9ADBd1bUPfLNZVt
 9cmIVEyoT/T8O5y3yiREHXO6gcW+3HJveD69ZJigOCRdO+OvsnNK66RwV3oR7F6BHY0m
 nx+fInfaHOtcGNGfeA3vdOANp4vbwtRzlSmX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D9Vj6+WeVlYF1H2fg9mql/6oMEXHu/mgsv8BNTVZHx0=;
 b=ZjEuIVzOKzWyuwfbCzph0ICZs9UXnwrCNDMm199v85xixeu4Jdtym3PflmfpK75FVF
 Kb5Igf74ZP0j0cIRFtZiiJQhze+BEGWkTALCmop525M6errjJIPpiYkX+25F0jYPIa5L
 WGwgYIqZoZ2J/bhtSP9SASL4asidBYCdeGDcXFTwr32sKFc+AlB6nU1iJNUUK+rHk5Sl
 J+Vz5VUBiiqkSOjJITrxL1YK3EEMOY+MI13/HnsNZm3dRGai0b+ZwAvzot16/8uatGty
 BJh1Gd3dw7bnjxoWwsNHWeFM7gej/Ad0r7S55KvehhD+axm21y2kYy4zPOeoxZHD7iH/
 ZvlA==
X-Gm-Message-State: AHQUAuYEDX2M163in14rVgVJeFlR9EnvvpND8snqt1hN8XwiLrThuavz
 D92LtTeIu0iDo70g7vJzD9TShqVXiJY=
X-Google-Smtp-Source: AHgI3Ia+KkA5OmcdUth1riB6dPu1XSr3k4hAAbD27Sn1IeMpQI43bkHKunlQ845ruaKLB1WQftT4AQ==
X-Received: by 2002:a2e:89d7:: with SMTP id c23-v6mr3386002ljk.0.1550167802776; 
 Thu, 14 Feb 2019 10:10:02 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172])
 by smtp.gmail.com with ESMTPSA id d15-v6sm569758lja.38.2019.02.14.10.10.00
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 10:10:01 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id g11-v6so6079735ljk.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 10:10:00 -0800 (PST)
X-Received: by 2002:a2e:91c8:: with SMTP id u8mr2287389ljg.185.1550167800344; 
 Thu, 14 Feb 2019 10:10:00 -0800 (PST)
MIME-Version: 1.0
References: <1550089932-6888-1-git-send-email-longman@redhat.com>
 <1550089932-6888-3-git-send-email-longman@redhat.com>
 <20190214103333.GH32494@hirez.programming.kicks-ass.net>
 <9e01d4ef-56df-7af8-a0f5-b49644e298bf@redhat.com>
 <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
In-Reply-To: <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Feb 2019 10:09:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi03J1jurebJNHPxGCVss7ARAN+2JuVthEGoEx=qkT4dQ@mail.gmail.com>
Message-ID: <CAHk-=wi03J1jurebJNHPxGCVss7ARAN+2JuVthEGoEx=qkT4dQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] locking/rwsem: Optimize down_read_trylock()
To: Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org,
 Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 14, 2019 at 9:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The arm64 numbers scaled horribly even before, and that's because
> there is too much ping-pong, and it's probably because there is no
> "stickiness" to the cacheline to the core, and thus adding the extra
> loop can make the ping-pong issue even worse because now there is more
> of it.

Actually, if it's using the ll/sc, then I don't see why arm64 should
even change. It doesn't really even change the pattern: the initial
load of the value is just replaced with a "ll" that gets a non-zero
value, and then we re-try without even doing the "sc" part.

End result: exact same "load once, then do ll/sc to update". Just
using a slightly different instruction pattern.

But maybe "ll" does something different to the cacheline than a regular "ld"?

Alternatively, the machine you used is using LSE, and the "swp" thing
has some horrid behavior when it fails.

So I take it back. I'm actually surprised that arm64 performs worse. I
don't think it should. But numbers walk, bullshit talks, and it
clearly does make for worse numbers on arm64.

               Linus
