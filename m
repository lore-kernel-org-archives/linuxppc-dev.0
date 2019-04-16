Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB4FC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 16:28:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D65C20821
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 16:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XzbrhfFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D65C20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k9mP1MLgzDqMq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 02:28:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="XzbrhfFZ"; dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k9W13zXPzDqNJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 02:17:16 +1000 (AEST)
Received: by mail-lf1-x143.google.com with SMTP id i68so5564522lfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V2Gvpl6BGIA50/J1TX+cezdKN7xZ09Bpr+WtIIhOiv4=;
 b=XzbrhfFZ8OS7iWU4+Ot2qCi8GDzOl8LZ+PFEFwbbzp+ZEfUBCTsRIpNXElHDgsIV2L
 /GZceDRcsSgDdjbXqwKZCKwqhqI6RM1jNizxdsPnFcPXot7htZ3epCEvP28wpbOGCkjM
 nPkDoXjHG1od/d361Iu2znwwPWcNKfzjg4IFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V2Gvpl6BGIA50/J1TX+cezdKN7xZ09Bpr+WtIIhOiv4=;
 b=SaMAuuBFFENQxNv4YKu2/hnOz0q8efjKphmLJPYOAi9/vRmJhWP/NbwiZKouFX/a9l
 th3pP6ilAcAwAQsXiRNu6XPYzawPhZ7P5eCkkOGHHqmkNQgJZY5UUXbyUI8xKI6/YqRt
 DLowpft292qOiv2vWGIrkN4CtAi3KcIZUqPy37WVmsIO7fQHfxlTDnJo9CSFpxjes7zD
 43n/oxNdJ6nRlinsU+TGCFGhF5iL7YzblWz/nt/CKh/tlnIWHLJzat301X7OFTe6zGkb
 Rg3w0Ttc2f8qK5GznvpWjJY+AFe2+N9vwXh5JNpdnIr2gzLd1hhXcUiXm8w9s3nVd3cn
 M2RA==
X-Gm-Message-State: APjAAAU2eL2frvzh9vZYJuJikXKcIhZLzaqbatgUhs1R/AA3yLjWBpUA
 0R2eAVqytkGOKv+y+ERLFznO4BdPLsk=
X-Google-Smtp-Source: APXvYqyxpBZWrMO3zwXYnLztnp6krq9M86oIV2uK4FywN1x9vblTFhCY8ml0x0RZ6nJpNhB5Kt61tQ==
X-Received: by 2002:a19:6619:: with SMTP id a25mr45375363lfc.21.1555431433407; 
 Tue, 16 Apr 2019 09:17:13 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com.
 [209.85.208.175])
 by smtp.gmail.com with ESMTPSA id n4sm1420958lfe.15.2019.04.16.09.17.11
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Apr 2019 09:17:12 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id p14so19652128ljg.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 09:17:11 -0700 (PDT)
X-Received: by 2002:a2e:8108:: with SMTP id d8mr18152714ljg.57.1555431431532; 
 Tue, 16 Apr 2019 09:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1> <20190416140658.2cb73a3f@mschwideX1>
In-Reply-To: <20190416140658.2cb73a3f@mschwideX1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Apr 2019 09:16:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
Message-ID: <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
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

On Tue, Apr 16, 2019 at 5:08 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> This is not nice, would a patch like the following be acceptable?

Umm.

We actually already *have* this function.

It's called "gup_fast_permitted()" and it's used by x86-64 to verify
the proper address range. Exactly like s390 needs..

Could you please use that instead?

            Linus
