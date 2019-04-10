Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981E1C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 08:55:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C538A217D6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 08:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCS8BLMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C538A217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fHzl3C6FzDqPT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 18:55:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::a41; helo=mail-vk1-xa41.google.com;
 envelope-from=huang.ying.caritas@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KCS8BLMp"; 
 dkim-atps=neutral
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com
 [IPv6:2607:f8b0:4864:20::a41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fH6V6PxfzDqCh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 18:15:58 +1000 (AEST)
Received: by mail-vk1-xa41.google.com with SMTP id s63so359641vkg.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3KIbH7PQ/+EhCRd6dFZrUyEEKxdSCK+Tg4Azj5CZNfg=;
 b=KCS8BLMpQF7FI4UPjcgFc26LkSmUfBe3VGzCMx3ZQXdHUNJTkx5tli9AZ8r7Iv8FUv
 4UzY02RzFxJ996bZvBXBO0iy7goFr+cdhnCgxqgnVQgCu/SqOuySG5IDq7kStWJBTg+R
 iswlqAN9kH/D9/3rCVEHBTUA9eS1lOaZcrV5RUH+OeHtcsoFhSm9MRC43TfAkYKnQ76b
 XO7JK06H0lIwPGGFT0CfrvLbARQgfKH4iHbxJ7TvEo/ySpSrHMpmNYbvfCeQ9VWhkpqt
 xz/MCGxJmCm+tl4C2hM4n/O+Z0VeMYwzr1p7HlyMWvfhhjROcT0YPt6BVBTC4hmkJmS9
 PhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3KIbH7PQ/+EhCRd6dFZrUyEEKxdSCK+Tg4Azj5CZNfg=;
 b=DhzlIpZFxsQ1pGz5j+NjxIMWQv2WM00MRqrhxC3HW3BrR62vBSvzqleO/ga56TNyz7
 1sRI0FJIpEprwJdLETGrGhOgpNr15KD1XLE9fjN35UfelgoifkU8SSRaE2sEwaBrmlE9
 ss2ZXuUMzoPD/ZApzqaWKWmywLpQT0OgzinluUyDC1DqAxZ1TebviINSNr87FKUz7U2y
 iN9z6Fti70wse/kMKgVf3YC10GnDtc5QzzE6SBTdY0HHatrf6sGbcisCq8vQGWqQ/bsO
 PrtVgVzVPV1Kr1gZGNbBjcxRFemKH4mwRvRxFA+AazRJ0DjyfF1s+lpEbnp0ZJHXNR7z
 3B5w==
X-Gm-Message-State: APjAAAVoNpHC+oJcLFd6h9OrWg8QxNWk2buYv78eTL6OqXmGfpGKkdxg
 lMZGex9osa6v3HoVAQW8ZXpYncMD562hOJhWBgw=
X-Google-Smtp-Source: APXvYqyBHoxiCrzs1mlaGt3/GNDWKnHf84FEFVec4EGaNAnYFcuvsLX4ZHWlsAZtobHmu4C1atdtwsQgbgm5vIDsB6Y=
X-Received: by 2002:a1f:1185:: with SMTP id 127mr13785077vkr.6.1554884155575; 
 Wed, 10 Apr 2019 01:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <20190213091936.GA22829@shao2-debian>
 <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
From: huang ying <huang.ying.caritas@gmail.com>
Date: Wed, 10 Apr 2019 16:15:44 +0800
Message-ID: <CAC=cRTM5=e7rJX80m0vL10aQoLawK_VTnQubH8A7_sUO2VUCNA@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
To: Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 10 Apr 2019 18:53:49 +1000
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
Cc: linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-arch <linux-arch@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Chen Rong <rong.a.chen@intel.com>, linux-hexagon@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>,
 "IngoMolnar@shao2-debian" <mingo@redhat.com>, linux-xtensa@linux-xtensa.org,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi, Waiman,

What's the status of this patchset?  And its merging plan?

Best Regards,
Huang, Ying
