Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1109C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 16:08:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BAFB20693
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 16:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CZonqEvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAFB20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pSzH72YqzDqRs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 02:08:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::133; helo=mail-lf1-x133.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="CZonqEvK"; dkim-atps=neutral
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pSxW4lKVzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:06:37 +1000 (AEST)
Received: by mail-lf1-x133.google.com with SMTP id o16so1395676lfl.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FhckMePRJRIMKUNlCIkx3VHe63IXH0bZ3S6Gwqv5tdM=;
 b=CZonqEvKRryr7I9kZkzaMOwuQF50UFC0DuXrN+A5A6rDj20MPF13Loj640HKBDdB/S
 wli9FxRhQ1OX9jSEjTEapHcc+guN8oU7kWxmO0cu6zjBUv5QhZecKO1iE405PwB0TBDs
 hqJUvZk6OvySvehOwaartA/mM+abp7YvVEyVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FhckMePRJRIMKUNlCIkx3VHe63IXH0bZ3S6Gwqv5tdM=;
 b=ujJe4gIIdY28WWxXrNGSLZh5NDEXreSp7nRwMQfLT/CSXqUrOKKj9HW2rFgqOfiwfS
 Dsw09HPUjS9leyI1kKqvSVcrGLCdrU/wrhVAn/s485XxZvthQSotag/jxiyvGL+bqlNc
 Wk2BT/dswkA0NnoHTifVu8n/kFsSA2EI+QdCotJaYKMAzQG5oJjpO42mImW7ZQ6Y6HWV
 nXiS12rOa8ZwM8PLfdlHxm35djR3m/qnNtOAIhDLm72YIz6lkryCr/mX0+t65wzWvxI7
 djuxSq4IwB7mlFexMUclhX9Bb9rrciC8WRFkbhN/vBNG0Elss+YZDQQR6tmnfZnWlskb
 vLaA==
X-Gm-Message-State: APjAAAWjkZh8n64kGZQHIEGXBwIULZsT7z2Q32li7UznWmbWeaAxuqDs
 fYYRylyPs3KslFUm5TlT5GesLtPF5DI=
X-Google-Smtp-Source: APXvYqzhzbFTlKsPN5KYL/Bgqt2YvyKe0QDL01DL7nQrdNuBdMZH40B8VT8H6GsJ/m7ruCkqCO2XSQ==
X-Received: by 2002:ac2:51d9:: with SMTP id u25mr3133038lfm.91.1556035592328; 
 Tue, 23 Apr 2019 09:06:32 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172])
 by smtp.gmail.com with ESMTPSA id c17sm1665914lff.84.2019.04.23.09.06.30
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:06:31 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id l7so14039762ljg.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:06:30 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr12853071ljj.79.1556035590337; 
 Tue, 23 Apr 2019 09:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1> <20190416140658.2cb73a3f@mschwideX1>
 <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
 <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
 <20190417094637.51ad4c67@mschwideX1> <20190417100244.42e29736@mschwideX1>
 <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com>
 <20190418100218.0a4afd51@mschwideX1>
 <CAHk-=whajv8Fw2VcBqZUs0hfx1Dq4fYj3TEEx4yfR3E8+rLS1A@mail.gmail.com>
 <20190418204144.16adf2a0@mschwideX1> <20190419153307.4f2911b5@mschwideX1>
 <CAHk-=wj6yp7hkJ_wR38dhdDRkAHQaEx28v2FkVT9hDFXX_qfjA@mail.gmail.com>
 <20190423173859.42d5ba8b@mschwideX1>
In-Reply-To: <20190423173859.42d5ba8b@mschwideX1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Apr 2019 09:06:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCwe7Uk0P6zJnTPqz_BvkELBbnocS-0qdWxVgq9qebjg@mail.gmail.com>
Message-ID: <CAHk-=wiCwe7Uk0P6zJnTPqz_BvkELBbnocS-0qdWxVgq9qebjg@mail.gmail.com>
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

On Tue, Apr 23, 2019 at 8:39 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> Ok, I added two patches for my s390/linux:features branch
>
> Martin Schwidefsky (2):
>       s390/mm: make the pxd_offset functions more robust
>       s390/mm: convert to the generic get_user_pages_fast code
>
> All code changes are inside arch/s390, I plan to include these patches with
> the next merge window. That gives us a little bit of time to run our tests.

Sounds good. Thanks for looking into this all.

Now I slightly wonder about all the other random architectures that
don't use the HAVE_GENERIC_GUP config option, but at least we'll have
all of arm, powerpc, x86 and s390 using the generic code..

                    Linus
