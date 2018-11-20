Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF24C43610
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 07:41:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B142820870
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 07:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwtro2Hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B142820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zd1B4H4NzF3Rf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 18:41:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kwtro2Hy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=ramon.fried@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kwtro2Hy"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zcyZ3l91zF3Qr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 18:38:45 +1100 (AEDT)
Received: by mail-ed1-x542.google.com with SMTP id b3so1051309ede.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 23:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Nl6JdscXIqHQygJYcrs/5Wj9NNPOtWK3ENP6U2mfy6k=;
 b=Kwtro2HydL6t/SdrwuIHCzG8G6jq19vnDWUsOJ84O8sNTLjkX1zj0y0hn+gn/IH40h
 b1RwWKa6UXGvavcIeOwPeuVzHY6+HskldDg/U3TAOPNi26Rkhic2Gb5PfI1Y8Sqhj2+q
 pWShfGJxmlJOOEl2IcUc2tF0qfwgOynPX1nODFRjwL+Oi2V/hptaSqkLAilUJcXD14Yj
 qV+/gGMRAqtkQM7eUqafT9+c/8o2NwsTMv248WZQYtVnxFBiPajoERDyiC+YAiypeymW
 e2k1LxDVM2BU+POIzQDQGhs7MqmMqRifTL/n9Fl6Xx/tAjfGnO3m9zqgdn49vvujH5Sk
 uV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nl6JdscXIqHQygJYcrs/5Wj9NNPOtWK3ENP6U2mfy6k=;
 b=k5iQ6UYF/Onv+xKkIe6NM0YLYziGGWeLfl1QyiNq4pypysWPFb1OIwsGCYwtLjJ2FO
 OQs0Ksae0il9PMuRe8/p7UhLjSFBkmJ8jdDD0x1kkntEG8WfdkW1Bpa8yIg56Aj3tMwN
 hlRaNS1tBn6++JUgkylHL+aMJbVIMlan9aqmJio/1uU68TZe/hoFsJagvZvhZ9tmofB9
 2a6jbAV1BmHpk8SFJ/rUyawuguqy0eBt5jrqvmVVILjfcds28ftYqa8in2MVHg4GhFjd
 sIVjTx0sEN588XaOzNtinB0vWr8bjzFZDoQeFhelg6zemee+HRxPovE+bvm32GJ6ukVb
 3nig==
X-Gm-Message-State: AGRZ1gIlEPevliajGznsI68M3Wez4azxTIIeyW9nNCCX26wEFKGcvSUr
 2LZzusi42wgHFZBAy5SgmqLCGAxrsK25zzgw+qI=
X-Google-Smtp-Source: AJdET5eCQ/QjzH0l9e2/M/GMYffhP0fEICQs4SW/wYavrSAunA3KGWLEW3+02mwZwHrPI9Y1fRNkNgIsvApf9xM8Xs4=
X-Received: by 2002:a17:906:3cea:: with SMTP id
 d10-v6mr1111691ejh.168.1542699522439; 
 Mon, 19 Nov 2018 23:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20180927223539.28449-1-hch@lst.de>
 <20180927223539.28449-6-hch@lst.de>
 <CAKgT0Ucii29i7S8eCj20D=a+=DeyKxREG0U2DBNRp3jFpgLu_A@mail.gmail.com>
 <8402ecc9c8ed9c69ad3e91eca4d07a5ab077b22d.camel@kernel.crashing.org>
 <CA+Kvs9kPtTZavq91NXs-7edVO5Fxp8gPO=FD35i9_izAdGMkKw@mail.gmail.com>
 <bb76b9a1-dc3a-2357-a871-291d68703776@arm.com>
In-Reply-To: <bb76b9a1-dc3a-2357-a871-291d68703776@arm.com>
From: Ramon Fried <ramon.fried@gmail.com>
Date: Tue, 20 Nov 2018 09:38:36 +0200
Message-ID: <CA+Kvs9=NFyrDNm1b2bMw+VKJ+Na0XuFqA2s+-pyd_avibdBhCw@mail.gmail.com>
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal memory
 size
To: robin.murphy@arm.com
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
Cc: open list <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 hch@lst.de, linux@roeck-us.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 19, 2018 at 5:50 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 19/11/2018 14:18, Ramon Fried wrote:
> > On Tue, Oct 9, 2018 at 8:02 AM Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> >>
> >> On Wed, 2018-10-03 at 16:10 -0700, Alexander Duyck wrote:
> >>>> -        * Because 32-bit DMA masks are so common we expect every architecture
> >>>> -        * to be able to satisfy them - either by not supporting more physical
> >>>> -        * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> >>>> -        * architecture needs to use an IOMMU instead of the direct mapping.
> >>>> -        */
> >>>> -       if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
> >>>> +       u64 min_mask;
> >>>> +
> >>>> +       if (IS_ENABLED(CONFIG_ZONE_DMA))
> >>>> +               min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> >>>> +       else
> >>>> +               min_mask = DMA_BIT_MASK(32);
> >>>> +
> >>>> +       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
> >>>> +
> >>>> +       if (mask >= phys_to_dma(dev, min_mask))
> >>>>                   return 0;
> >>>> -#endif
> >>>>           return 1;
> >>>>    }
> >>>
> >>> So I believe I have run into the same issue that Guenter reported. On
> >>> an x86_64 system w/ Intel IOMMU. I wasn't able to complete boot and
> >>> all probe attempts for various devices were failing with -EIO errors.
> >>>
> >>> I believe the last mask check should be "if (mask < phys_to_dma(dev,
> >>> min_mask))" not a ">=" check.
> >>
> >> Right, that test is backwards. I needed to change it here too (powermac
> >> with the rest of the powerpc series).
> >>
> >> Cheers,
> >> Ben.
> >>
> >>
> >
> > Hi, I'm working on a MIPS64 soc with PCIe root complex on it, and it
> > appears that this series of patches are causing all PCI drivers that
> > request 64bit mask to fail with -5.
> > It's broken in 4.19. However, I just checked, it working on master.
> > We may need to backport a couple of patches to 4.19. I'm not sure
> > though which patches should be backported as there were at least 10
> > patches resolving this dma_direct area recently.
> > Christoph, Robin.
> > Can we ask Greg to backport all these changes ? What do you think ?
>
> As far as I'm aware, the only real issue in 4.19 was my subtle breakage
> around setting bus_dma_mask - that's fixed by 6778be4e5209, which
> according to my inbox got picked up by autosel for 4.19 stable last week.
>
> Robin.
Yep, 6778be4e5209 fixes the issue.
Thanks a lot !
Ramon.
