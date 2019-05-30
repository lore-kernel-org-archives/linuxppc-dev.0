Return-Path: <SRS0=Y6lA=T6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0ECC28CC0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 13:10:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DAF25952
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 13:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DAF25952
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45F7Gz0bjqzDqVj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 23:10:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.85.167.65; helo=mail-lf1-f65.google.com;
 envelope-from=bhsharma@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45F7DQ6x9NzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2019 23:08:04 +1000 (AEST)
Received: by mail-lf1-f65.google.com with SMTP id r15so4951359lfm.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2019 06:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lo8Pf5qQPzDgv3LbnRe5hAmhzj8l8zc5AuLXNn3lbXo=;
 b=NwP8+P8DP1X4h6VHDhQwIvIaNIytcQLn8iFED/JmkC2oouB5YRMjzT08Z5HDraF1rl
 AngFTle25jkxPznjaZVidpkcmslK1nMkv0bDyo5VRXq7ZvQn2ezBt7YAI54uG9xjr38m
 PmH7+hcrCqcqoQFD01AP1DvFGTY3quYDITKHJSyHYF0GfYpJmGwwxqdugE817iQ/fnaL
 2VCeOmdge62/QXWknvN0W5bGt6XqLZ+bTehHyRGJ6vB4WBoPGSN/G2HrAQljbhYwZ3lt
 V/mCEEKJT0VLb6aC+HnypLcpYK+82/Zr9SYwxQXHiDq6YwXmWblpsUFg5YFw2DS85id3
 AxWw==
X-Gm-Message-State: APjAAAVPD6Nm9ctwHStORSNH+oSgdiGpCMG0sm/mA+LOmxCl2ZRkRSCm
 ZCYIB3p4cRe9qMorP62tPvo/dabqQEFgXc60JoKQ0g==
X-Google-Smtp-Source: APXvYqyavwnJULw4Wz7Yg0S3xURZgWHWuSrHKVYFeYqBmDka5ggDKKE/RR5194S1GfsiIfocaRV06vuTWRje8VGjYSQ=
X-Received: by 2002:a19:ec12:: with SMTP id b18mr2020933lfa.149.1559221680444; 
 Thu, 30 May 2019 06:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <1559212177-7072-1-git-send-email-bhsharma@redhat.com>
 <87v9xsnlu9.fsf@concordia.ellerman.id.au>
In-Reply-To: <87v9xsnlu9.fsf@concordia.ellerman.id.au>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Thu, 30 May 2019 18:37:46 +0530
Message-ID: <CACi5LpM9v1YC_6HhA-uKghawzkEu=TTPVkomMmv2i-LGi8X7+g@mail.gmail.com>
Subject: Re: [PATCH] Documentation/stackprotector: powerpc supports stack
 protector
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
Cc: Arnd Bergmann <arnd@arndb.de>, corbet@lwn.net, linux-doc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 30, 2019 at 6:25 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Bhupesh Sharma <bhsharma@redhat.com> writes:
> > powerpc architecture (both 64-bit and 32-bit) supports stack protector
> > mechanism since some time now [see commit 06ec27aea9fc ("powerpc/64:
> > add stack protector support")].
> >
> > Update stackprotector arch support documentation to reflect the same.
> >
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> >  Documentation/features/debug/stackprotector/arch-support.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
> > index 9999ea521f3e..32bbdfc64c32 100644
> > --- a/Documentation/features/debug/stackprotector/arch-support.txt
> > +++ b/Documentation/features/debug/stackprotector/arch-support.txt
> > @@ -22,7 +22,7 @@
> >      |       nios2: | TODO |
> >      |    openrisc: | TODO |
> >      |      parisc: | TODO |
> > -    |     powerpc: | TODO |
> > +    |     powerpc: |  ok  |
> >      |       riscv: | TODO |
> >      |        s390: | TODO |
> >      |          sh: |  ok  |
> > --
> > 2.7.4
>
> Thanks.
>
> This should probably go via the documentation tree?
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks for the review Michael.
I am ok with this going through the documentation tree as well.

Regards,
Bhupesh
