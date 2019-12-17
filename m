Return-Path: <SRS0=7pZz=2H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E32C43603
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Dec 2019 18:14:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD6E206D7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Dec 2019 18:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FK7jv4qN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD6E206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47cmW85FwfzDqMG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 05:14:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::141;
 helo=mail-lf1-x141.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="FK7jv4qN"; dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47cmJ466bDzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2019 05:04:52 +1100 (AEDT)
Received: by mail-lf1-x141.google.com with SMTP id v201so7593371lfa.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2019 10:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lR1SiqLK9KEC99vqrA+L06g5eY9Mbqq1o4Gp42LpZMk=;
 b=FK7jv4qNRsEY58xZMc+UmIyte9eMcd0a4A+t48QkMIcc8UodbMREUJO3iZzA7AKpln
 03BKAH+vqDBR3VhNEzal6BtSu2hnn/lsLynWDxYrv66nuQYJnVSbzh2V+rbyH0fyrq1C
 njp7EPb9EhK3H7gTZQ8M3AOVEH2nTx7zrpL6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lR1SiqLK9KEC99vqrA+L06g5eY9Mbqq1o4Gp42LpZMk=;
 b=F0GMWRsZh1yKjyNNDhDoIlLV5K1Q/aE1I9s+4fjjDRQyTOaSI6LFi7Z1S1NjIjV3Kb
 N37i8580U+NXiNiVRmsuwAH0jopC87WO/Ds5wvKwiaWTlakmAFoCn8qctZsx3buFT712
 n+A83yyT179P0nL1mW9Pmx86uuV+dwfkeTeLErO3AgaHX4XNpJJOlajY9lVL4/JiR85g
 8gS4jmmKXRvOcZ4Oe1CjP+NqolV936OVUjvilT7L+6rQrj1j50KA82k5aj57JYCaqYYV
 kTb1t06zWyWSa2xxlA5g4ogwmpNmuoZX9o7Cl2jOsXpv3RlKjMUrXxqd43rFnjupeTws
 ra9A==
X-Gm-Message-State: APjAAAXoRT6v3Y8z2OkvSrvQZB2wKR6fu7FaT/f8sWDF/ibhOCQ2Owe6
 GDniiPi7Xk7cmdncrf2anD70s+RxjXU=
X-Google-Smtp-Source: APXvYqwkRedeLFVRZJAerTRyQ7QXXWwHyjrAFoEPZoZAuj7lTbk8J3UaGtaKZvMoMea0tDMjBWjzyA==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr3373467lfc.111.1576605886780; 
 Tue, 17 Dec 2019 10:04:46 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com.
 [209.85.208.178])
 by smtp.gmail.com with ESMTPSA id t29sm11112660lfg.84.2019.12.17.10.04.45
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 10:04:45 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id u17so12013006lja.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2019 10:04:45 -0800 (PST)
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr4244505ljj.1.1576605885112;
 Tue, 17 Dec 2019 10:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <20191217170719.GA869@willie-the-truck>
In-Reply-To: <20191217170719.GA869@willie-the-truck>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2019 10:04:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
Message-ID: <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To: Will Deacon <will@kernel.org>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 17, 2019 at 9:07 AM Will Deacon <will@kernel.org> wrote:
>
> However, I'm really banging my head against the compiler trying to get
> your trick above to work for pointer types when the pointed-to-type is
> not defined.

You are right, of course. The trick works fine with arithmetic types,
but since it does use arithmetic, it requires that pointer types be
not only declared, but defined. The addition wants the size of the
underlying type (even though with an addition of zero it wouldn't be
required - but that's not how C works).

Let me think about it.

             Linus
