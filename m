Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4ECC282DD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 04:15:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0172B21773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 04:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f5LPUMyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0172B21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kTRG4P34zDqKP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 14:15:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="f5LPUMyd"; dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kTPg3KkszDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 14:13:41 +1000 (AEST)
Received: by mail-lf1-x143.google.com with SMTP id u17so17752295lfi.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 21:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Scd0mxLNvddMA/EuL7KgAfLfPq4A2d2A+jt31P9MYwQ=;
 b=f5LPUMydRgoieOXcslgprAzTIXLGrkdJ4t2S8woBSwJXvjjtlVT8iDFx/1ghkcZUGh
 TZTtsQjCJGNB//d2GFXCDvOKk5h8AXP8fCW1qGx8gml+SB2p8iffhIOQtqwHfr/8Ndxv
 Z0QzY8plk8LPA73p03U7k1H7fhKlySUGyOuzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Scd0mxLNvddMA/EuL7KgAfLfPq4A2d2A+jt31P9MYwQ=;
 b=ZRSfdDWk6SpduRWsRJbAjQjKKf1xzzotIozInfxYqvZxSQ9IDc2aEl84sXzAH+nAZa
 GQfoIGBo6hHJs259nr7tCATpEVZO3T+xcqARxJpr1ngOJ6i9wlHWV9e5DykSr7+DM/ZA
 Ylw6/L0/ihmgZNGrNNuQOj2EbMGrWE0RLPS6j7sBFX52LgQaWvUT/DDisSbpqF2g57gV
 oCziiZUoRM8SFPXe1eUDbmS4vszfq6DSiboF8jDx80wzgLvBwz7pyvJDt38HjmailFrY
 yTkmMRR/NiwPNqbYfDhixauObloPE1dJqH6beXaByeGogcwWKyOlod2iQEEJncQ8LYFs
 SNUQ==
X-Gm-Message-State: APjAAAUgI+uTaMRxGimRRbUWLWn2D3cogSHozbN8g/NetEsOKpUt8W8F
 +KRMQYlztSKLwdzP+n1Il3X0j0FWjqc=
X-Google-Smtp-Source: APXvYqws03EX6arUH0clyqBbkc/60A1S+nW9Wk3z+VCy1C55v3QPWveUH4GR3eOKo3EwaSsuay/FJw==
X-Received: by 2002:ac2:4a86:: with SMTP id l6mr35291278lfp.51.1555474415480; 
 Tue, 16 Apr 2019 21:13:35 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com.
 [209.85.167.43])
 by smtp.gmail.com with ESMTPSA id s26sm10783417ljj.52.2019.04.16.21.13.33
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Apr 2019 21:13:34 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id t30so17712417lfd.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 21:13:33 -0700 (PDT)
X-Received: by 2002:ac2:495e:: with SMTP id o30mr24639187lfi.35.1555474413536; 
 Tue, 16 Apr 2019 21:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <87sguhti6e.fsf@concordia.ellerman.id.au>
In-Reply-To: <87sguhti6e.fsf@concordia.ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Apr 2019 21:13:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2HxyJoH3xhr_ytM3gf1mkvq8Dq9Do+EdNZrm8KjV_6w@mail.gmail.com>
Message-ID: <CAHk-=wi2HxyJoH3xhr_ytM3gf1mkvq8Dq9Do+EdNZrm8KjV_6w@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 16, 2019 at 8:38 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> > That said, powerpc and s390 should at least look at maybe adding a
> > check for the page ref in their gup paths too. Powerpc has the special
> > gup_hugepte() case
>
> Which uses page_cache_add_speculative(), which handles the case of the
> refcount being zero but not overflow. So that looks like it needs
> fixing.

Note that unlike the zero check, the "too many refs" check does _not_
need to be atomic.

Because it's not a correctness issue right at some magical exact
point, it's a much more ambiguous a "the refcount is now so large that
I'm not going to do GUP on this page any more". Being off by a number
of pages in case there's a race is just fine.

So you could do something like this (TOTALLY UNTESTED, and
whitespace-damaged on purpose - I don't want you to apply it blindly)
appended patch.

> And we have a few uses of bare get_page() in KVM code which might be
> subject to the same attack.

Note that you really have to have not just a get_page(), but some way
of lining up *billions* of them. Which really tends to be pretty hard.

            Linus

----

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 9e732bb2c84a..52db7ff7c756 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -523,7 +523,8 @@ struct page *follow_huge_pd(struct vm_area_struct *vma,
                page = pte_page(*ptep);
                page += ((address & mask) >> PAGE_SHIFT);
                if (flags & FOLL_GET)
-                       get_page(page);
+                       if (!try_get_page(page))
+                               page = NULL;
        } else {
                if (is_hugetlb_entry_migration(*ptep)) {
                        spin_unlock(ptl);
@@ -883,6 +884,8 @@ int gup_hugepte(pte_t *ptep, unsigned long sz,
unsigned long addr,

        refs = 0;
        head = pte_page(pte);
+       if (page_ref_count(head) < 0)
+               return 0;

        page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
        do {
