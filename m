Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE60C282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 16:58:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A2B420674
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 16:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N1H+13UL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2B420674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kpNZ2Q96zDqQD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 02:58:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::141; helo=mail-lf1-x141.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="N1H+13UL"; dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kpLr3n8lzDqKj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 02:57:24 +1000 (AEST)
Received: by mail-lf1-x141.google.com with SMTP id j11so19447121lfm.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e9lZbMtDKygZ2DfMvT54TFa3e24d9xoZ0epEXOcQrX0=;
 b=N1H+13ULwDC+M3GXrj0q6BqQVsZgIPGQQAt1qzjWjlIE2T3boxhwovLMZhBRInW+IS
 wGCznU07ozdKWbn2wFvSHWvS+yOaeLs4ZmJ0A9AX+Ug2O610w4Na6yKcpLJzcVB8F4aS
 GdDoIQNJE32V1sSKg5NVPyl80P4+PPTryGbw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e9lZbMtDKygZ2DfMvT54TFa3e24d9xoZ0epEXOcQrX0=;
 b=h71CUkU7w1Tmf9FCmbuyPi5kO6s9XNX8hQ5NS2l4WJRsrmeJ4SnF6uezKP0mDt+y0b
 ImaDguYYSIrQnCN9TD1sol+7gD0nzRsuxCJ9BX7AUD8PL8PzNYi9h1/hW2YINL4AowKF
 4gDfb9B9AiR9pajfW0XhfUunnNoUxFcJjJ08VDh/o9yaa7UxM2h5CVggVvxc2rxv0MVH
 f1AJSKjM4JLKv7P4pCxqm/iT+YldDtzs8auoJSeH2DPmmOTiAK+r5bw4n3FoflHwEOj0
 4MI0pZ9fJGKQPOtKFUZI32j1Y37rk+6n688MUMzOgsxbLxc7YLGEbCKWbyb0L/5fdvcB
 UWEg==
X-Gm-Message-State: APjAAAU0H5l57+E1jBjfwYdEuASblM5oKGipSX7xTQFKmIhtKbGgXyuZ
 kNDqJocn5XErK9zQs0OG4UQWGxm6r00=
X-Google-Smtp-Source: APXvYqxWmPr7WalyfgGfiI9pncepYm9VDU5i/4T8tb52w3zFjmXx2GB8zv0zxmFJ5/bt4soO69JDbQ==
X-Received: by 2002:a19:428c:: with SMTP id p134mr3279176lfa.108.1555520238936; 
 Wed, 17 Apr 2019 09:57:18 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id x6sm11361775lfe.67.2019.04.17.09.57.17
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Apr 2019 09:57:17 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id t30so19403328lfd.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 09:57:17 -0700 (PDT)
X-Received: by 2002:a19:48c9:: with SMTP id
 v192mr29389550lfa.136.1555520237474; 
 Wed, 17 Apr 2019 09:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1> <20190416140658.2cb73a3f@mschwideX1>
 <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
 <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
 <20190417094637.51ad4c67@mschwideX1> <20190417100244.42e29736@mschwideX1>
In-Reply-To: <20190417100244.42e29736@mschwideX1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Apr 2019 09:57:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com>
Message-ID: <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
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
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 17, 2019 at 1:02 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> Grumpf, that does *not* work. For gup the table entries may be read only
> once. Now I remember why I open-coded p4d_offset, pud_offset and pmd_offset
> in arch/s390/mm/gup.c, to avoid to read the table entries twice.
> It will be hard to use the common gup code after all.

Hmm. The common gup code generally should do the "read only once"
thing too (since by definition the gup-fast case is done without
locking), although it's probably the case that most architectures
simply don't care.

What would it require for the generic code to work for s390?

                    Linus
