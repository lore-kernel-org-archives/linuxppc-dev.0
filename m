Return-Path: <SRS0=cpv1=BH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597B9C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 06:42:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054AF2065C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 06:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzOloozq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054AF2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BG6Yl1CblzDr3k
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2020 16:42:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d44;
 helo=mail-io1-xd44.google.com; envelope-from=kernelfans@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=nzOloozq; dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BG6VN73BgzDr3j
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2020 16:39:56 +1000 (AEST)
Received: by mail-io1-xd44.google.com with SMTP id a5so4385097ioa.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2020 23:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9DWgQAaUpAZbYD8DBTg0X6Ko2r5G0A0oYQsvREexwHo=;
 b=nzOloozqKQqb2u+U5WHnWHhhZ1QP5O+yUd9Rn+qw0SUZGqs4R1HWn1M2EgQRkm+Bj1
 SazTot5LFpTHb5aF9MVMkYNzaWLLMqepHJY08S3hAAUquvn62bpbYKJAN/nRbUMh+x1D
 Q4s957u5vEecF1BZoL3Tb7wPlcpXgjbBDtjMifBN8NfuJ5oH1yHH1CRt9HQlKdZeVEts
 RLEwqEov7JwtUd3C4fY+noWfS4NSPo+8h4WcmIKNSP3lua1PDP7BTaIYrNf/1B1LqzeC
 jEdxHCgwlwtWdjV1UpBltdfeSwV9qSco2EPsidgT1Px2s0gTtcTaDFeRG+VKO5P/fg7Z
 UXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9DWgQAaUpAZbYD8DBTg0X6Ko2r5G0A0oYQsvREexwHo=;
 b=TwWVkioqf3Bmhd2v7qzA5DhEg48GKz9SsvIVNtGp5cN1Ail9nGxBVJxk+htaNdh/Kz
 rJDcp9MHLg2C9+DqC2NyOUzuNS+daIJnS9P80z3JHcHdAnubs4ohJoy0fH1qg/qSusxo
 Kk69Z43UukYXID7CaWqZLKhkXGSCMKgVsC5xc/DPWLpnZWW/OerGPrLEGCpK3ZIiIIY0
 qTRZFK12SEafaFt8HWGWEiQ9b62aKdl3TeEvfIS+KCq8G/XD7rhrQuz0V4w1YEctWN/m
 vdvfKDoUlQ7jw6xofncl7TGrJeNE7EeUyboIGiHy9w5DlZpeEdyvSnGb+Dzckc6ElWB3
 FTyQ==
X-Gm-Message-State: AOAM532hnXfF5rfs/ekKXOn3SuekNANa1IUiE8O+h+u7Ks9ylsAu+0Bt
 F70KPXwxoJLA5QH252CH9JN4XQn0gLfny77t6Q==
X-Google-Smtp-Source: ABdhPJwaFdYdOqBmtQ4fnAoWBXbTlomh+sOCl4EqMF7KWVMbh2QpmM/dj97SHrsM5GL9iwexnoepKiOQhNnaWjijuOQ=
X-Received: by 2002:a6b:b215:: with SMTP id b21mr27128309iof.43.1595918391990; 
 Mon, 27 Jul 2020 23:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <1595382730-10565-1-git-send-email-kernelfans@gmail.com>
 <87ft9i1egt.fsf@linux.ibm.com>
In-Reply-To: <87ft9i1egt.fsf@linux.ibm.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 28 Jul 2020 14:39:40 +0800
Message-ID: <CAFgQCTt+oOD7Vw=UKzzWrwucyjrKQr=WWsGzAk3JX60cfXrdpQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] powerpc/pseries: group lmb operation and memblock's
To: Nathan Lynch <nathanl@linux.ibm.com>
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
Cc: Kexec Mailing List <kexec@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jul 23, 2020 at 10:41 PM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> Pingfan Liu <kernelfans@gmail.com> writes:
> > This patch prepares for the incoming patch which swaps the order of KOBJ_
> > uevent and dt's updating.
> >
> > It has no functional effect, just groups lmb operation and memblock's in
> > order to insert dt updating operation easily, and makes it easier to
> > review.
>
> ...
>
> > diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> > index 5d545b7..1a3ac3b 100644
> > --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> > +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> > @@ -355,7 +355,8 @@ static int dlpar_add_lmb(struct drmem_lmb *);
> >  static int dlpar_remove_lmb(struct drmem_lmb *lmb)
> >  {
> >       unsigned long block_sz;
> > -     int rc;
> > +     phys_addr_t base_addr;
> > +     int rc, nid;
> >
> >       if (!lmb_is_removable(lmb))
> >               return -EINVAL;
> > @@ -364,17 +365,19 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
> >       if (rc)
> >               return rc;
> >
> > +     base_addr = lmb->base_addr;
> > +     nid = lmb->nid;
> >       block_sz = pseries_memory_block_size();
> >
> > -     __remove_memory(lmb->nid, lmb->base_addr, block_sz);
> > -
> > -     /* Update memory regions for memory remove */
> > -     memblock_remove(lmb->base_addr, block_sz);
> > -
> >       invalidate_lmb_associativity_index(lmb);
> >       lmb_clear_nid(lmb);
> >       lmb->flags &= ~DRCONF_MEM_ASSIGNED;
> >
> > +     __remove_memory(nid, base_addr, block_sz);
> > +
> > +     /* Update memory regions for memory remove */
> > +     memblock_remove(base_addr, block_sz);
> > +
> >       return 0;
> >  }
>
> I don't understand; the commit message should not claim this has no
> functional effect when it changes the order of operations like
> this. Maybe this is an improvement over the current behavior, but it's
> not explained why it would be.
One group of functions, which name contains lmb, are powerpc specific,
and used to form dt.

The other group __remove_memory() and memblock_remove() are integrated
with linux mm.

And [2/2] arrange dt-updating just before __remove_memory()

Thanks,
Pingfan
