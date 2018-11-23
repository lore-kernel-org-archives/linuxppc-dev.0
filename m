Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26571C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 03:53:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18ED720672
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 03:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="m4/YNoiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ED720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431Mqh4gPlzDqSp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 14:53:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="m4/YNoiA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.91; helo=conssluserg-06.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="m4/YNoiA"; 
 dkim-atps=neutral
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431L7Q560wzDqSJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 13:37:21 +1100 (AEDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id wAN2ahvo028784
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 11:36:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wAN2ahvo028784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1542940604;
 bh=Grkalro82XcZftrUmZQ9Uk6Q9M7QC4TvdZzw2JwHwGE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=m4/YNoiAWV2v+sVOr1fHL7xqC8GWiY8Vsf1Zh/Te7GtZA5n3DT+2PCGjPDWOyBiI5
 VDMkFN9xt471NqfL9TeLNSf5rMsiz2m9eX5uHzQWq1v91OzJqHgjI7jOKMJWSWGbZd
 9zxF+XIcf0OpzCBzmFgn40r/HGHy/lbtAWfS/28bhjHBfRUcyqAsAT8ByPrCKlT2so
 VEq+8z7jIfRkdqj/4ytGmuNF35qiArHgXpvMKLmrYGTyN0Mlkp3SdheV41Kpl8g3V6
 okWinZX5ZZw6Dcwx5HR1Gfvs6Dtmj79rb2pTHqHelZAiglvY/97E7vefBb3I9UJwM0
 s6819/ft24nwg==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id g68so6353315vsd.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 18:36:44 -0800 (PST)
X-Gm-Message-State: AGRZ1gJktToSjxHprtV1Wg1FEL7ZrWIYs0CMpvEeCouaupvkIwZ4Da6v
 jsyt9rNwsu5osYq36lIatQygvFeaLbixheThmH8=
X-Google-Smtp-Source: AJdET5cvDS4SzyKrkGSSYigRcVPdU3u9wSG0ScXvHCVHXLUFXKqmyJ6YAXR/wfz8J0hWT/0RlTy9yMtfPTbMsNHvyDU=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr5688953vsm.181.1542940603144; 
 Thu, 22 Nov 2018 18:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de>
 <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
In-Reply-To: <CAK7LNARL8yZexzXiEaT77U_rdwhr5uENXbSaSTGHU33HbSmW6g@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Nov 2018 11:36:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNARA-wbDDh_T2HghAUGizY-bF28O_8cjLmp9DMHaoxZPNw@mail.gmail.com>
Message-ID: <CAK7LNARA-wbDDh_T2HghAUGizY-bF28O_8cjLmp9DMHaoxZPNw@mail.gmail.com>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/ v4
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

On Fri, Nov 23, 2018 at 11:32 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Christoph,
>
>
> On Fri, Nov 16, 2018 at 4:08 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hi all,
> >
> > currently every architecture that wants to provide on of the common
> > periphal busses needs to add some boilerplate code and include the
> > right Kconfig files.   This series instead just selects the presence
> > (when needed) and then handles everything in the bus-specific
> > Kconfig file under drivers/.
>
>
> Thanks for this work!
>
>
> I applied this series, and it is available at
>
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> kconfig2


BTW, if you find questionable parts,
please let me know.

We still have plenty of time by the next MW.

Thanks.



-- 
Best Regards
Masahiro Yamada
