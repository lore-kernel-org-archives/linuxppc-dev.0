Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C09EC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 16:19:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7248E2075B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 16:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rc7qx6n5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7248E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jYbZ1B4PzDqJ7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 02:19:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="Rc7qx6n5"; dkim-atps=neutral
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jYYq23nwzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 02:17:34 +1000 (AEST)
Received: by mail-lj1-x22d.google.com with SMTP id j89so16241823ljb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bIPBn1U+SX8uD02iY/mmWBCji2/lm4uOVe9yraoEo7o=;
 b=Rc7qx6n5VTgrZU3031/RnX2VNuY4cSqBXxxLOtf8sa4GGy81UrF6cIh23W8HCjbplk
 eei3JXRMEKl88UBMcF12ggFhbCViCFtKDRzEbath5Yr0VuirMta8TVNm5ksL/lQZkU9L
 gDNJ1M+ReVvsXKP7zNx4xxobRNztNHRC10AkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bIPBn1U+SX8uD02iY/mmWBCji2/lm4uOVe9yraoEo7o=;
 b=AJEQUpM0J0iakGOTuxozn2I4KeScgH4VDK8KMRPaZ0Ultr0A+cGCidzAuYZNUvQtwd
 GliLtrRaCi5x8h45PVOxVL/9dQo7miKE5jqZzFY7q1EzmFqIDJ1Hyq0hRN+CtrfUVr/t
 eaMX4wGKC8J9FbuKi3VjyOQCOfMg98aCzcEQriD8sBYtdJ1UKE30pW05PYRRxwT/wq5d
 2ovqAnKm4VCcIh2KrZh1FAN3+xNOBtAJf5kV4lykPAVaCEvw1D0aUEQYakCjx1Gt41i0
 aclFki9dYGEC87xt/+Wll6WHvl3v9zeYZAIkIxbGKVm2Q3ZVW3BNTRtjK8KAOzs8uvYF
 jSGA==
X-Gm-Message-State: APjAAAU2Czt4xvA8rVRqV7hJlfMYXcs4cNzZ+wk0oCbcIAVBPrV0NlLa
 Ie1A833GN7OX2Ek0P/c/9VJ1OvK5Tc0=
X-Google-Smtp-Source: APXvYqyypYZB2K2/J38X9j77rt3LYtdNgVaSDdiBVSNv9Opjf5KeRsL4TUwtYyQJidCh83a1Nl5hXg==
X-Received: by 2002:a2e:8507:: with SMTP id j7mr231583lji.85.1555345047838;
 Mon, 15 Apr 2019 09:17:27 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
 [209.85.208.176])
 by smtp.gmail.com with ESMTPSA id y17sm10928002ljd.54.2019.04.15.09.17.26
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Apr 2019 09:17:26 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q66so1138559ljq.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 09:17:26 -0700 (PDT)
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr14718777ljk.78.1555345046432; 
 Mon, 15 Apr 2019 09:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
In-Reply-To: <20190415051919.GA31481@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Apr 2019 09:17:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
Message-ID: <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
To: Christoph Hellwig <hch@infradead.org>
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
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Apr 14, 2019 at 10:19 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Can we please have the page refcount overflow fixes out on the list
> for review, even if it is after the fact?

They were actually on a list for review long before the fact, but it
was the security mailing list. The issue actually got discussed back
in January along with early versions of the patches, but then we
dropped the ball because it just wasn't on anybody's radar and it got
resurrected late March. Willy wrote a rather bigger patch-series, and
review of that is what then resulted in those commits. So they may
look recent, but that's just because the original patches got
seriously edited down and rewritten.

That said, powerpc and s390 should at least look at maybe adding a
check for the page ref in their gup paths too. Powerpc has the special
gup_hugepte() case, and s390 has its own version of gup entirely. I
was actually hoping the s390 guys would look at using the generic gup
code.

I ruthlessly also entirely ignored MIPS, SH and sparc, since they seem
largely irrelevant, partly since even theoretically this whole issue
needs a _lot_ of memory.

Michael, Martin, see commit 6b3a70773630 ("Merge branch 'page-refs'
(page ref overflow)"). You may or may not really care.

                 Linus
