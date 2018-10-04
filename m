Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7830CC64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 15:16:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E3C2082A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 15:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFxCmYry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E3C2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QxKy3tfgzF3NN
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 01:16:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FFxCmYry";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d42; helo=mail-io1-xd42.google.com;
 envelope-from=alexander.duyck@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="FFxCmYry"; 
 dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QxH92DkYzF3LD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 01:13:40 +1000 (AEST)
Received: by mail-io1-xd42.google.com with SMTP id x26-v6so8167093iog.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Oct 2018 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aFkA/0wrykNoe/6zOrHUhGlT+Q7Jx6eOGkCxdr4cYdk=;
 b=FFxCmYry6eP1yN1ufHNzOppBREw4u/zF406X8tFxqchaGBoGVgsF/1kcm4z8ZECKAX
 4/NMUlx4kQL7yJF/BJx71swkLQt2Jp3klUwoznSDe1v3SUYbNolpwTAMiimEWxJMWp+0
 qXgpMYLrSXgroplVl33QzJbPbBr6sx6SRh5mxhqPuOqg6fLMaKiH7oFRjplEUVAIJuOy
 fb1YjqFlr7DgDgCN9hEV4e5Tw+5LFHdO0h4XpVVQ+sxJTZQzHS9e5GvsJj64IoEhZ1LU
 sXo1z6Q/OJ+BAUrt1jLWrLIxzasExlSoDjv+WYouT8MPb0osWkszYaVIwTQquAP24X9q
 PO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aFkA/0wrykNoe/6zOrHUhGlT+Q7Jx6eOGkCxdr4cYdk=;
 b=iDYXy83R7fuN+XOUlDwGSAV4012jvBtvyUWwOK8QKyUfeY5XumEGEHEpyyZM7yBw6u
 VTM5CrVN6i0nEf8dr7bh4wBxFOvhYtt6MjP4d8fV1M9W/wTrRPKN7vIpfPxkbebETeow
 Ept3TgWsOo9/0E9RHdt49S4Lv37sgg37apEQGFpDNh92JpfWuaq9GV6F+C+8jPU0K/lR
 tzz1qeRART3nAmGXb4DLZtOH8z3sCxNpot9uirMWiK8XXyruDTyNRe6+NvjhankD3prr
 0T5UjE2HB/GaHFMVcB7Ue05m1PoLtuLJYrLVK/7WPRfrQmOmG7onrYOhHgcekzoL8veQ
 tTHg==
X-Gm-Message-State: ABuFfog6FBI+2eHtdJYxIM981bcyRymtYfxsy0OGbttp5xuSZaLgDIJA
 aHZoquEoUp3lv6eKgmHd3w8NRYIS0pMUmwEQZX0=
X-Google-Smtp-Source: ACcGV62keSvva26IlRF+QlIMv5vQ6CGMfp9ODFrN7mJnnksiY+3GoRWtioauSmtovRhB6mAdu82Xj+U2yVZCAkDxl5Q=
X-Received: by 2002:a6b:e91a:: with SMTP id
 u26-v6mr4551737iof.200.1538666017780; 
 Thu, 04 Oct 2018 08:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181003234746.3586.42014.stgit@localhost.localdomain>
 <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com>
In-Reply-To: <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 4 Oct 2018 08:13:26 -0700
Message-ID: <CAKgT0UfbAokpR=-xrfNjeYMroEDH4HtPgM6qK_nWmBqK3QOf6A@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Fix return value of dma_direct_supported
To: Robin Murphy <robin.murphy@arm.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 "open list:INTEL IOMMU \(VT-d\)" <iommu@lists.linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>, alexander.h.duyck@linux.intel.com,
 "open list:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 4, 2018 at 4:25 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 04/10/18 00:48, Alexander Duyck wrote:
> > It appears that in commit 9d7a224b463e ("dma-direct: always allow dma mask
> > <= physiscal memory size") the logic of the test was changed from a "<" to
> > a ">=" however I don't see any reason for that change. I am assuming that
> > there was some additional change planned, specifically I suspect the logic
> > was intended to be reversed and possibly used for a return. Since that is
> > the case I have gone ahead and done that.
>
> Bah, seems I got hung up on the min_mask code above it and totally
> overlooked that the condition itself got flipped. It probably also can't
> help that it's an int return type, but treated as a bool by callers
> rather than "0 for success" as int tends to imply in isolation.
>
> Anyway, paying a bit more attention this time, I think this looks like
> the right fix - cheers Alex.
>
> Robin.

Thanks for the review.

- Alex

P.S. It looks like I forgot to add Christoph to the original mail
since I had just copied the To and Cc from the original submission, so
I added him to the Cc for this.

> > This addresses issues I had on my system that prevented me from booting
> > with the above mentioned commit applied on an x86_64 system w/ Intel IOMMU.
> >
> > Fixes: 9d7a224b463e ("dma-direct: always allow dma mask <= physiscal memory size")
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >   kernel/dma/direct.c |    4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 5a0806b5351b..65872f6c2e93 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -301,9 +301,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
> >
> >       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
> >
> > -     if (mask >= phys_to_dma(dev, min_mask))
> > -             return 0;
> > -     return 1;
> > +     return mask >= phys_to_dma(dev, min_mask);
> >   }
> >
> >   int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
> >
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
