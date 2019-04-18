Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69150C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 15:51:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B92321479
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 15:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b+i+BhJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B92321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lNrh3zHnzDqSx
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 01:51:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="b+i+BhJe"; dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lNpb15Z5zDqS7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 01:49:56 +1000 (AEST)
Received: by mail-lf1-x143.google.com with SMTP id j20so2008360lfh.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 08:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q3aXbW/8DQW79hhHpCT8m/hV2hycpbj+kUy1/X2/AUI=;
 b=b+i+BhJe93MaypvGfbqiHpFPfPoYO2L3LME38H627HLcuvOmeR8rABcBpC8sFzqKvJ
 TBvEYbogeiTQzUd7M3b+pFIWQ9sh7J5DZi3hLAu44P+IW/8nZSj57OAXzNk0yxYc0qWu
 3h3eqnLHWJHX9GL+hJS44OY8Mw7n4RA9Rqa/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q3aXbW/8DQW79hhHpCT8m/hV2hycpbj+kUy1/X2/AUI=;
 b=I5dbOevQvC53f1Y8vmdacpvm+/lp7962N0snZBtJLAWdj6Z5CjN5e7t+mF2WBfnx5m
 GKPKxdduN2ravukoFkdP3usHRCminWqTSMZKvVZ7AEVNW95wHX2y26N+So6ryoaX4Cx0
 gwsFLVKbptTjG79F2dAgBAx5omUejyRa0rYkQIGd/nNI9nE/zsP0aftAYYnD7R/Nnbd4
 ebyruAWZ/c655dpeprdr6n3EMABJ+cFRlyKBObYHhrvx1ngsr5XYKjlOvfR/VYnufSTb
 C/J3IMPVmw5kYDY31t9OedhsDq+7t03QN02rneHd6yzGjq6hRySRFHY9beEtXqyOGIif
 091g==
X-Gm-Message-State: APjAAAXm2kQJypfJ+TL9A+UaZcGfqeJ4UfBP26VMh4YaLZ7ELkTq35TA
 pRWT1bVsDWWsiN7Ju6Ksn680GuwUEdE=
X-Google-Smtp-Source: APXvYqxuJpJR8ElBHa78UTCeZmuM806weguYfio0uTwOgVbpTQ8IzUk9zYnUzfylo/SgmcxOiiFkJw==
X-Received: by 2002:ac2:4186:: with SMTP id z6mr25657514lfh.50.1555602590266; 
 Thu, 18 Apr 2019 08:49:50 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com.
 [209.85.167.50])
 by smtp.gmail.com with ESMTPSA id c7sm499650lja.90.2019.04.18.08.49.49
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Apr 2019 08:49:49 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id u17so2013028lfi.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 08:49:49 -0700 (PDT)
X-Received: by 2002:ac2:547a:: with SMTP id e26mr11547187lfn.148.1555602588563; 
 Thu, 18 Apr 2019 08:49:48 -0700 (PDT)
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
In-Reply-To: <20190418100218.0a4afd51@mschwideX1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Apr 2019 08:49:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whajv8Fw2VcBqZUs0hfx1Dq4fYj3TEEx4yfR3E8+rLS1A@mail.gmail.com>
Message-ID: <CAHk-=whajv8Fw2VcBqZUs0hfx1Dq4fYj3TEEx4yfR3E8+rLS1A@mail.gmail.com>
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

On Thu, Apr 18, 2019 at 1:02 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> The problematic lines in the generic gup code are these three:
>
> 1845:   pmdp = pmd_offset(&pud, addr);
> 1888:   pudp = pud_offset(&p4d, addr);
> 1916:   p4dp = p4d_offset(&pgd, addr);
>
> Passing the pointer of a *copy* of a page table entry to pxd_offset() does
> not work with the page table folding on s390.

Hmm. I wonder why. x86 too does the folding thing for the p4d and pud case.

The folding works with the local copy just the same way it works with
the orignal value.

But I see that s390 does some other kind of folding and does that
addition of the p*d_index() unconditionally.

I guess that does mean that s390 will just have to have its own walker.

For the issue of the page refcount overflow it really isn't a huge
deal. Adding the refcount checking is simple (see the example patch I
gave for powerpc - you'll just have a couple of extra cases since you
do it all, rather than just the special hugetlb cases).

Obviously in general it would have been nicer to share as much code as
possible, but let's not make things unnecessarily complex if s390 is
just fundamentally different..

                   Linus
