Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89333C10F13
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 00:51:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C460121850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 00:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxG5Lfvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C460121850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gK8g0qjgzDqTR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 10:51:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::e41; helo=mail-vs1-xe41.google.com;
 envelope-from=huang.ying.caritas@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="rxG5Lfvm"; 
 dkim-atps=neutral
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com
 [IPv6:2607:f8b0:4864:20::e41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gK6W1h5hzDqSm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 10:49:37 +1000 (AEST)
Received: by mail-vs1-xe41.google.com with SMTP id j184so4578769vsd.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 17:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aWBpR9dyC+xLnfEFgXj9tuZsVDw3WOnEHHAmffrI+OI=;
 b=rxG5LfvmG1C32HozkkLevSvbpCrrv685/jmZpjprMmyNxtE2Q31fL6G9UOlE4AIO3h
 NrV1UtIwHzrDNoSm9wNa54wKqjSKHrlb0DovQGCQ87iw+Al7LUaZidbJHwF8rRpx3oue
 xTdo6CXkjvHkapqQtTAVywV3eZS+iUgyK3IhBCmyRJd9RW6papq6LEn0RyqBlYnp2j8/
 +/3GqT4QR0cF3gWvmGWA5DC9pILZPFqeC2PilE9b+aVAesqUS7aCXbRqokBYBRQc4bKx
 7DQafVtU8z2UkkIDUFuK5khaHkMOxSZzvHYXlROdjoMJIvWj0qfHvj/gEDzLQvfxDu7V
 Fg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aWBpR9dyC+xLnfEFgXj9tuZsVDw3WOnEHHAmffrI+OI=;
 b=U2J4bUQaoy2zSFXHp7r54Hq/tUELB8qnKZ+jwGtFTFCgNHZUKbI35VKlNhIn4UDR0Z
 DFQq5lT0B5pmpNKClLrbcZUHqErqCUaYhLSn4mmUje01F+bDfTLCtHDyTpLXJvK6IjpL
 wQRHBVf2F8yfb1kThohC3owjPqsTA2qLmDYHaXoSSo9zIctZKblnF0vGa31t3Ui6+ZN0
 U5OvSGPDYqSGYbzjwjeICoIpfZnGYQEk8PbePvsp8x2yadaYEksS5bHjL7l6W8ogZ8ai
 Qm+HFSIarsB7rt99AZKbOqlrbJHk+8BraT0aKw5hYVJmEVy2w64p5DxlAB3G1pnf2OWa
 0MZg==
X-Gm-Message-State: APjAAAVVvAnIX5LRDdv/bZfbsIx0q/WRyQEmF9C9kzWYc4STqT7/PL3X
 TblTM/XzKVVuvC0W6dEEamSj8xqL2c+IG/9lGZw=
X-Google-Smtp-Source: APXvYqyJYVcb+/w0X0buIFBGIPHkKGOSh2HGwtbXkVBvxd/Bn2yJI3+LXBSdxM/cuDO+GUiEgeLRt9DWYAM/7TVnp8A=
X-Received: by 2002:a67:b106:: with SMTP id w6mr30490948vsl.16.1555030172978; 
 Thu, 11 Apr 2019 17:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <20190213091936.GA22829@shao2-debian>
 <CAHk-=wiF2qv4TdKOTaTYeMnmsn4h6z9ot+MRj1=s7dm5y1FUwQ@mail.gmail.com>
 <CAC=cRTM5=e7rJX80m0vL10aQoLawK_VTnQubH8A7_sUO2VUCNA@mail.gmail.com>
 <cc8af095-50e0-cd3e-e498-8c3350d314b7@redhat.com>
In-Reply-To: <cc8af095-50e0-cd3e-e498-8c3350d314b7@redhat.com>
From: huang ying <huang.ying.caritas@gmail.com>
Date: Fri, 12 Apr 2019 08:49:21 +0800
Message-ID: <CAC=cRTP38JmFWe8C=y6ew_m1Lswb8DghnqLtdiMc0EW_fyPH7g@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
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

On Thu, Apr 11, 2019 at 12:08 AM Waiman Long <longman@redhat.com> wrote:
>
> On 04/10/2019 04:15 AM, huang ying wrote:
> > Hi, Waiman,
> >
> > What's the status of this patchset?  And its merging plan?
> >
> > Best Regards,
> > Huang, Ying
>
> I have broken the patch into 3 parts (0/1/2) and rewritten some of them.
> Part 0 has been merged into tip. Parts 1 and 2 are still under testing.

Thanks!  Please keep me updated!

Best Regards,
Huang, Ying

> Cheers,
> Longman
>
