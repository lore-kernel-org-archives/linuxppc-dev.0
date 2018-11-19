Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085B3C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 20:47:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E222080C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 20:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b88b62M+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E222080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zLW02cQ6zF3Q2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 07:47:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b88b62M+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=ramon.fried@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="b88b62M+"; 
 dkim-atps=neutral
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42z9t45Jv1zF3LM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 01:18:17 +1100 (AEDT)
Received: by mail-ed1-x541.google.com with SMTP id d3so24936768edx.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 06:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T2jd1BqXFqFZ3SG+Q8h9Z9F9RW51tXlkmLap4eUJhzE=;
 b=b88b62M+cMz3PK6aR3TIxKqoGjKIiRJiXEbdT4WqYL+kwyKv4WWmKlni3/wsSAKN8U
 SxfKoZWIv/RMcPHXECSJVGlq/v5DrPshPTQnW1fUTWNZSHjgYISgEfN5flcwWpJdIws/
 mFZYf+SJBRDFSvEOFquSgn2EJMxd9gDra77gQxjpmQwhtiFux/8iNy59h6vIzDzmXFqj
 +Ct1IYC+2k1Ahn/exqyLZquBri0Im8egiUYQ50WAuRSls2wkR0cL/yKyPcA+LeIMkytm
 A8UvgdiQU8MhMevmGp/Awy6ZSe3GMIRb5bDflxR/26DMR0FnDpfofR/ZO/P6/GWPxqbF
 /l8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T2jd1BqXFqFZ3SG+Q8h9Z9F9RW51tXlkmLap4eUJhzE=;
 b=BzeRT0sEINdwGDLgHbzsQe+mDr1XLdgmZJK9AIqpExZIOFuCavXuGMi4rWdjxetHhp
 1h0d0q3Jpc7TcbESl73R2s9UHcNfDm7QhTpLSQT31igoqRaEAXxvdyM1uuIKSLczoWmg
 9WQRzpH5lenHP+qFPZgbW1IzMXQx3p+jckckyLFgV6S6kZ9eaDC/YdkQNtr0Q5PCsOBO
 f/Mdjgci5bN1o6Lm1hOiVJL8Yk3x53h3tK9ib5diSThmQiCK1A7q/1IdDjvCYckM2CkV
 H+g8N7ubrfwQfV3z9p3bmzyrJSEM13wbFTiqsicXTKr/Hf5hKBp2v5Af32DKc6L0dzV1
 gOog==
X-Gm-Message-State: AA+aEWbxH647rPDXbcpMH3zSqplUX8RFEDJTGl07YI3wPDxnM7Yasiwr
 iy4M/99RuIf65q7B6vX9MbxyuCmcRguPoFy8Uos=
X-Google-Smtp-Source: AFSGD/VS7mVvHebfFtOPFUfQ3RkYMTGfBYntxcPnt4zfge+s9oURNgu4W/9LxZO1hHKhAp6/pQpOf/dwrsR2/QiMa/Y=
X-Received: by 2002:a50:b8e5:: with SMTP id l92mr5313298ede.294.1542637093877; 
 Mon, 19 Nov 2018 06:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20180927223539.28449-1-hch@lst.de>
 <20180927223539.28449-6-hch@lst.de>
 <CAKgT0Ucii29i7S8eCj20D=a+=DeyKxREG0U2DBNRp3jFpgLu_A@mail.gmail.com>
 <8402ecc9c8ed9c69ad3e91eca4d07a5ab077b22d.camel@kernel.crashing.org>
In-Reply-To: <8402ecc9c8ed9c69ad3e91eca4d07a5ab077b22d.camel@kernel.crashing.org>
From: Ramon Fried <ramon.fried@gmail.com>
Date: Mon, 19 Nov 2018 16:18:02 +0200
Message-ID: <CA+Kvs9kPtTZavq91NXs-7edVO5Fxp8gPO=FD35i9_izAdGMkKw@mail.gmail.com>
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal memory
 size
To: benh@kernel.crashing.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 20 Nov 2018 07:45:07 +1100
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, open list <linux-kernel@vger.kernel.org>,
 alexander.duyck@gmail.com, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, hch@lst.de, linux@roeck-us.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 9, 2018 at 8:02 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2018-10-03 at 16:10 -0700, Alexander Duyck wrote:
> > > -        * Because 32-bit DMA masks are so common we expect every architecture
> > > -        * to be able to satisfy them - either by not supporting more physical
> > > -        * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> > > -        * architecture needs to use an IOMMU instead of the direct mapping.
> > > -        */
> > > -       if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
> > > +       u64 min_mask;
> > > +
> > > +       if (IS_ENABLED(CONFIG_ZONE_DMA))
> > > +               min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> > > +       else
> > > +               min_mask = DMA_BIT_MASK(32);
> > > +
> > > +       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
> > > +
> > > +       if (mask >= phys_to_dma(dev, min_mask))
> > >                  return 0;
> > > -#endif
> > >          return 1;
> > >   }
> >
> > So I believe I have run into the same issue that Guenter reported. On
> > an x86_64 system w/ Intel IOMMU. I wasn't able to complete boot and
> > all probe attempts for various devices were failing with -EIO errors.
> >
> > I believe the last mask check should be "if (mask < phys_to_dma(dev,
> > min_mask))" not a ">=" check.
>
> Right, that test is backwards. I needed to change it here too (powermac
> with the rest of the powerpc series).
>
> Cheers,
> Ben.
>
>

Hi, I'm working on a MIPS64 soc with PCIe root complex on it, and it
appears that this series of patches are causing all PCI drivers that
request 64bit mask to fail with -5.
It's broken in 4.19. However, I just checked, it working on master.
We may need to backport a couple of patches to 4.19. I'm not sure
though which patches should be backported as there were at least 10
patches resolving this dma_direct area recently.
Christoph, Robin.
Can we ask Greg to backport all these changes ? What do you think ?

Thanks,
Ramon.
