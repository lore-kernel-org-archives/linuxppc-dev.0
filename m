Return-Path: <SRS0=sSB4=5S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDCBC2BA15
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 20:49:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D6C20719
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 20:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dq1Xt42z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D6C20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48tZty1xbvzDqnx
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 07:49:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::142;
 helo=mail-lf1-x142.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=google header.b=dq1Xt42z; 
 dkim-atps=neutral
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48tZrl0zg4zDqB0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2020 07:47:48 +1100 (AEDT)
Received: by mail-lf1-x142.google.com with SMTP id w145so3941792lff.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2020 13:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YR/nUD2Z88aJr6Pg6Jbj/uRmXq5/iJdtBPPDjhYxa08=;
 b=dq1Xt42zOdAJ9Qswqhw3DC5ZWJPx708kVOLPio6Z4i5kSkx4SK5PaEo/6koIh9QTi0
 yfOTVpLmbl4n8jtyb/2WcDEO7fuXO+AAVPX7mMUJ0v/+lRQnPhNsNuau5SsaccYONsWw
 LhoxKSxXEV20XpXwx2ctLh7uQXRBDSE3iznhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YR/nUD2Z88aJr6Pg6Jbj/uRmXq5/iJdtBPPDjhYxa08=;
 b=LiMVT9htWSpniBd6u7ZvJRbkkg9l/dD91lEhrG95Lva564DPtIEB9Wt3WNFRi2Zr+6
 plBG1l666mY+CEga06aI0XSyhrv7wIvsaHh2oFU8cyRkXHUO2cNrvfJGKjQSaYMQZ+rI
 XZEJho4r1c6GdIv4DEo8nMjbW8Fezu8Y8p/+jOTZOubBkC4iR+6oC0zofdaltdBlefRJ
 JZN8zl6VpDEYyLtG2iKwniybOjkDLm1FGZowJQLxX6tCGk4V1GTAymK9NI+LTUGUlBlz
 dcRPOFW4mzgBwB5lPnakPqIpFfMuuhPSnMB8DwjPB+aKU0WXoiGMvyQ/bMFhR3F/fbEK
 m5PA==
X-Gm-Message-State: AGi0PuZWn6XgFjclhTzAgyFny/TKGNrf73TdzcLWf72lCWp/Mm3VGQFZ
 X2t0u2Mx8rBZth5V1STBrQwTOGa8W24=
X-Google-Smtp-Source: APiQypK5Csoy097/15QmxZGVhBepVsmRHhb8bPvqz95YSJoGkEXJJHf8nAxZ4spUhNQRZdlzQreWjQ==
X-Received: by 2002:a19:2d15:: with SMTP id k21mr3295065lfj.137.1585860462354; 
 Thu, 02 Apr 2020 13:47:42 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com.
 [209.85.167.41])
 by smtp.gmail.com with ESMTPSA id g5sm3896138ljl.106.2020.04.02.13.47.40
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 13:47:41 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id f8so2566385lfe.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2020 13:47:40 -0700 (PDT)
X-Received: by 2002:ac2:5e70:: with SMTP id a16mr3290368lfr.152.1585860460299; 
 Thu, 02 Apr 2020 13:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk> <202004021132.813F8E88@keescook>
 <CAHk-=wg9cSm=AjPmkasNHBDwuW4D10jszjv6EeCKp8V9Qbx2hg@mail.gmail.com>
 <202004021322.5F80467@keescook>
In-Reply-To: <202004021322.5F80467@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Apr 2020 13:47:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUfAsepavvy2vsnyOv06yeYBMumSeb+dzDSnJXkX7qPQ@mail.gmail.com>
Message-ID: <CAHk-=wjUfAsepavvy2vsnyOv06yeYBMumSeb+dzDSnJXkX7qPQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
To: Kees Cook <keescook@chromium.org>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Dave Airlie <airlied@linux.ie>,
 Peter Anvin <hpa@zytor.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>, Linux-MM <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 2, 2020 at 1:27 PM Kees Cook <keescook@chromium.org> wrote:
>
> I was just speaking to design principles in this area: if the "enable"
> is called when already enabled, Something Is Wrong. :)

Well, the "something is wrong" could easily be "the hardware does not
support this".

I'm not at all interested in the crazy code to do this in software.
Nobody sane should ever do that.

Yes, I realize that PaX did software emulation of things like that,
and it was one of the reasons why it was never useful to any normal
use.

Security is not an end goal in itself, it's always secondary to "can I
use this".

Security that means "normal people can't use this, it's only for the
special l33t users" is not security, it's garbage. That "do page
tables in software" was a prime example of garbage.

               Linus
