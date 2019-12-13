Return-Path: <SRS0=Sd9m=2D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9355BC43603
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2019 22:03:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E904F206C3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2019 22:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OMLOqShW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E904F206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47ZPnc4k1VzDrJ1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Dec 2019 09:03:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::143;
 helo=mail-lf1-x143.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="OMLOqShW"; dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47ZPl33D1fzDqk7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Dec 2019 09:01:33 +1100 (AEDT)
Received: by mail-lf1-x143.google.com with SMTP id f15so331792lfl.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2019 14:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zfICJ6KhaPZeol1tl5aqhZNB4nOYiiQp60xAzoCt3JU=;
 b=OMLOqShWneJ3fe3UbyHRP01hVO4iIEtu+rKtip4uFYuny7eKWa9RVguRhdDXyGlazr
 Vu8irtlqDqkjSxlpxcEnR/mPZqGnWrv40jn+8NdgbI7DAtOpxmVjJ6hnmrSN7O80Gy2B
 6ZEjjOYm27LL3/V26Z0KJqLy5QPWKtyS57u7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zfICJ6KhaPZeol1tl5aqhZNB4nOYiiQp60xAzoCt3JU=;
 b=o6GC4MbmYR9LHtokU/2p4kxRgl5trKl14CmeEwNnGqrzaJ4fZdMQIZTHvNJnR8Drr2
 YIAUY/mn3dAbjPXIMjJp4Xtmi/ivV5QRBGl3JbJ/5j0rcTUpKzFnhqGsdjWGDzmsfP71
 kHN26VTJPFyyZCTxQ5Ny8g6X+EhVwabUq852pX9b8KZxROu1g3SQqBUzcv86oUQc+yGh
 W5iVlZy+Ul/uvBHIXEQ+El+Sv/nFdnfeQY++vYoqm+GgW90+Br4Pjb7pyFbzvqkvl9+m
 jFbcsUDIkp/jxY7ORqtwl44loCd2Tzz/16bipx6WQ4wFNuclktjlITqfgMMlLBcCKTRA
 V04g==
X-Gm-Message-State: APjAAAWxA4XicdSw3wxLIJ6AxpSII3sG/Mc2qXwbsGb3jFPSFImhQOrF
 tyQFu6RllWuzgIe7hoeA6T75xLkhfTg=
X-Google-Smtp-Source: APXvYqwMwBnj3vkafAZO/NpOYzArZsFg0WK1AiSZgQHvCgY8iD5qgi6UGB+HV8TIBd36DbfGHUINcQ==
X-Received: by 2002:ac2:4945:: with SMTP id o5mr9959752lfi.93.1576274489078;
 Fri, 13 Dec 2019 14:01:29 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com.
 [209.85.167.54])
 by smtp.gmail.com with ESMTPSA id g27sm5151325lfj.49.2019.12.13.14.01.26
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 14:01:27 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id m30so350803lfp.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2019 14:01:26 -0800 (PST)
X-Received: by 2002:a05:6512:1dd:: with SMTP id
 f29mr10402310lfp.106.1576274486558; 
 Fri, 13 Dec 2019 14:01:26 -0800 (PST)
MIME-Version: 1.0
References: <87blslei5o.fsf@mpe.ellerman.id.au>
 <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <CAK8P3a2QYpT_u3D7c_w+hoyeO-Stkj5MWyU_LgGOqnMtKLEudg@mail.gmail.com>
 <CAK8P3a014U76S+t3rKyPghepOT_fYHBExuMC27MoGMNffjczEw@mail.gmail.com>
In-Reply-To: <CAK8P3a014U76S+t3rKyPghepOT_fYHBExuMC27MoGMNffjczEw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Dec 2019 14:01:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsN+0i8mF_1L8zDvY0XJEkZNumT1dH0NBiSbecZZ3+HA@mail.gmail.com>
Message-ID: <CAHk-=wgsN+0i8mF_1L8zDvY0XJEkZNumT1dH0NBiSbecZZ3+HA@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To: Arnd Bergmann <arnd@arndb.de>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 13, 2019 at 1:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> A few hundred randconfig (x86, arm32 and arm64) builds later I
> still only found one other instance:

Just send me the pull request to READ_ONCE() and WRITE_ONCE() be
arithmetic types, and your two trivial fixes, and let's get this over
with.

With that, you can remove the 'volatile' with my simple
'typeof(0+*(p))' trick, and we're all good, and we don't need to worry
about compiler versions either.

I'm willing to take that after the merge window as a "sanity fix".

             Linus
