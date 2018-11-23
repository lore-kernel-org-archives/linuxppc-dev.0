Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAFAC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 02:42:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFDB20820
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 02:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="hvwizNgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFDB20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431LDm31ktzDqSW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 13:42:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="hvwizNgj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.80; helo=conssluserg-01.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="hvwizNgj"; 
 dkim-atps=neutral
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431L5J246czDqSC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 13:35:31 +1100 (AEDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id wAN2ZBQ4015815
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 11:35:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wAN2ZBQ4015815
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1542940511;
 bh=RrugNZBXEysMhtL3UZ+37m+8Wd+NK/UsR7hC/dwXJf0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=hvwizNgjiAwz2FA0ew+WTSmalXBXveMEDZE/2TDxOaLsyjHhDdCBFDvCVHpDkpjrV
 q655IT+Jc1eR8CRf6t61hUOpgQy0TGZtyt26mII+/a1ZlZAigD25jT92qub9fPZm47
 yVZHgrxD2oU51PiCamHN8svZOVYvzYsmS6XMF2FjPSebW74FdZ4ovLusRGN0W/x/5r
 LvCboua3MRD989y4FlaaiJna5bLhUYaRmz8qR42/n+Uo8Cgt/nUixrt+3Xrq4YkBeZ
 /42ggr9jrCFEvg9d/HlkQ43F6mF3RcNPFYHyAelBTnTEy9ALW1WQBpLr3A2YCm/eUi
 jSRA/b1sfnf9Q==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id p74so6387844vsc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 18:35:11 -0800 (PST)
X-Gm-Message-State: AGRZ1gKfVbY8iJf5bPqH5fdNkiHldaXGofLlUqdU0ylpECux/YWWjWEC
 OAoAWh1kadR01CvArLx2KlGk9E/8+iatN7CKTJI=
X-Google-Smtp-Source: AJdET5cIw+vbbs97NyNbwhbBUn15tsgvQyNHCrBWj31uLObQRxlkco6LuTOOVkaJBTEBijL6YB6Yzgf83zElAgHI88Q=
X-Received: by 2002:a67:385a:: with SMTP id f87mr5827099vsa.179.1542940510387; 
 Thu, 22 Nov 2018 18:35:10 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de>
 <20181115190538.17016-10-hch@lst.de>
In-Reply-To: <20181115190538.17016-10-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Nov 2018 11:34:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ01oHpZHJ2Zb49o7pUU_vB5+-262MhueTLQg+t29W3nw@mail.gmail.com>
Message-ID: <CAK7LNAQ01oHpZHJ2Zb49o7pUU_vB5+-262MhueTLQg+t29W3nw@mail.gmail.com>
Subject: Re: [PATCH 9/9] eisa: consolidate EISA Kconfig entry in drivers/eisa
To: Christoph Hellwig <hch@lst.de>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linux-MIPS <linux-mips@linux-mips.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Alex Bounine <alex.bou9@gmail.com>, linux-alpha@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 16, 2018 at 4:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Let architectures opt into EISA support by selecting HAS_EISA and

I locally fixed the commit log (HAS_EISA -> HAVE_EISA)
so that it matches to the code.

Thanks.



> handle everything else in drivers/eisa.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> ---

--
Best Regards
Masahiro Yamada
