Return-Path: <SRS0=8kzy=XS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B174C432C1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Sep 2019 21:30:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43681207FD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Sep 2019 21:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NGQHlcSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43681207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46cct36S8gzDqNf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Sep 2019 07:30:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="NGQHlcSa"; 
 dkim-atps=neutral
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ccqv5zyhzDqNV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2019 07:28:06 +1000 (AEST)
Received: by mail-oi1-x243.google.com with SMTP id k9so8941907oib.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2019 14:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XyHYr4tKJV5lm5mCsroazIfQVv/o2NZykn1ewMncF1E=;
 b=NGQHlcSav/bgAy0eYIW53+dy/MJrBGnm/wJo/dyC6cSQz2MBKGA+ojlsAtSmF+sNqx
 VDe35TDuB3eR9akecJZqu0672y6M1btk3QjNhM0W5H03Av5y2+aoRQtBIsjRU+xVE5VC
 1UBa1ee6GuKxKeg/pk+O6mETUjjJe9JhyaORgmMk7BJIEZb92MqzJMI3CY3IKgltjkcz
 RzBefvQMUpmHq5pmUTkUtc8uN3Q4s4nbbD0eHMU+35Tlhq493UsRICNmI61PMnY9yhcD
 8C9QXUMyy24XJIb9siYolXYHhgLtn3sS+fBYKxNXpq5mpgJSCZV9fkeDvNuLj0crF7Nf
 maRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XyHYr4tKJV5lm5mCsroazIfQVv/o2NZykn1ewMncF1E=;
 b=O+DlvAqRuzTqEbF708/vCP1DXDb0kh0AmcU5gBfKmRswTDlIp8x0p1gZ7ZBHRa0+u6
 QQIbVQm8Tu2is7LW29A7uKD6wgObPWrlU1zsma/jLq48/NagT2F49NDXSS7FaVMt98/P
 GzR1U3SLl5QF7pQeihwpjEUkd/rWQ6PZ+XSmzG0ICne78fzBCoQ81ehFvX4oP3J8hnP+
 gTIgfoYAXwo6l0h+VAgZh9R0AJCI+KhWeZfx3KeJufFLufweVkpg5EVMQcKC/3T9v/eY
 ylv3tarb1k06dZ5EXtV2zRfDW4Xjk52U92hSqWjJAocM5tZwY4eGLBv3G/EOJp5fynj1
 eGZA==
X-Gm-Message-State: APjAAAWrc+Hi4YI8ffR1sbSFs0NG/AXLh7ADYvXS7s+ld9BjiKr/so11
 V+u8iFPd1c/kknYRFZornzPJhKHKU4p08ahvwUcwrNJJ
X-Google-Smtp-Source: APXvYqwPptlgnNLhw8/JNeUDzZMDmvZaQh9W9r9dY79Z4Drq6xjXrXwxYv3zs9ifbmG3vIRSplJeJvadjfJHqOqkkLc=
X-Received: by 2002:aca:4b05:: with SMTP id y5mr1856981oia.70.1569274082986;
 Mon, 23 Sep 2019 14:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <1568988209.5576.199.camel@lca.pw> <87r24bhwng.fsf@linux.ibm.com>
 <1569003478.5576.202.camel@lca.pw>
 <CAPcyv4idejYpTS=ErsEJWgBxBsC1aS9=NCyvMEDO1rwqRktEmg@mail.gmail.com>
 <A619A864-511D-4782-8789-5AEC8797A111@ellerman.id.au>
In-Reply-To: <A619A864-511D-4782-8789-5AEC8797A111@ellerman.id.au>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 23 Sep 2019 14:27:52 -0700
Message-ID: <CAPcyv4hSjL+kjR1is3O5BPp8K4763SvDhuUzSTc6O6JNtfW2ew@mail.gmail.com>
Subject: Re: "Pick the right alignment default when creating dax devices"
 failed to build on powerpc
To: Michael Ellerman <michael@ellerman.id.au>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Qian Cai <cai@lca.pw>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Sep 22, 2019 at 5:04 AM Michael Ellerman <michael@ellerman.id.au> wrote:
>
>
>
> On 21 September 2019 4:31:16 am AEST, Dan Williams <dan.j.williams@intel.com> wrote:
> >On Fri, Sep 20, 2019 at 11:18 AM Qian Cai <cai@lca.pw> wrote:
> >>
> >> On Fri, 2019-09-20 at 19:55 +0530, Aneesh Kumar K.V wrote:
> >> > Qian Cai <cai@lca.pw> writes:
> >> >
> >> > > The linux-next commit "libnvdimm/dax: Pick the right alignment
> >default when
> >> > > creating dax devices" causes powerpc failed to build with this
> >config. Reverted
> >> > > it fixed the issue.
> >> > >
> >> > > ERROR: "hash__has_transparent_hugepage"
> >[drivers/nvdimm/libnvdimm.ko] undefined!
> >> > > ERROR: "radix__has_transparent_hugepage"
> >[drivers/nvdimm/libnvdimm.ko]
> >> > > undefined!
> >> > > make[1]: *** [scripts/Makefile.modpost:93: __modpost] Error 1
> >> > > make: *** [Makefile:1305: modules] Error 2
> >> > >
> >> > > [1] https://patchwork.kernel.org/patch/11133445/
> >> > > [2]
> >https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
> >> >
> >> > Sorry for breaking the build. How about?
> >>
> >> It works fine.
> >
> >Thanks, but let's delay "libnvdimm/dax: Pick the right alignment
> >default when creating dax devices" until after -rc1 to allow Michael
> >time to ack/nak this new export.
>
> Thanks Dan. It looks fine to me:
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks Michael. Aneesh, care to resend with this ack, but also reword
the changelog to say that this patch is a pre-requisite for the follow
on patch to pick dax device alignment? In other words, lets hide this
compile breakage from git-bisect by merging this export before the
consumer patch.
