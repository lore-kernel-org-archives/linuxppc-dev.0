Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15069C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 09:33:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510CE21925
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 09:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NQ0eGso6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510CE21925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4417N41dhxzDqd1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 20:32:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.91; helo=conssluserg-06.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="NQ0eGso6"; 
 dkim-atps=neutral
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4417L23dNvzDqcY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 20:31:05 +1100 (AEDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id x1F9UkBu018399
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 18:30:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x1F9UkBu018399
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1550223047;
 bh=v5CD2QsDxnxVejyPIDnfbiJ1pltYltlIlJJglB+jvf0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=NQ0eGso6oKLWfKf5cFvUyBYm2OHHA6KMFXxb4raGJ4xk9alAwE6b986gzBUM+NhXJ
 7DBOoEHgcydBqd66HIPfVc4IGD6owhhGMsMg7vel7aNIcFRL7kjpEJfVbrDs9CUz/l
 ysapVJjYa5w++SdewUAfTkQvgNL2YivGFbSizA5cT1adFaWjEjC4Hf9INDo2e5tswx
 FTHdhvVKRnLz/ku8BegAQSxM9MN7v/uSQkKYYitc5E6sTVTqkO17cTaxksidmNhP94
 M7rL+DFrSSgn7hVggMbmu1DQW/1/6NmVo+z79o2t0B1+hWDSFCoyHxRSXTF8rGFQ7m
 xpL2fn30+eDJA==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id b20so5396771vsl.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 01:30:46 -0800 (PST)
X-Gm-Message-State: AHQUAubf2/oqZsvbKBZWRJPaui7jwdAR3hIUG6exUIxzrcMt9OKxugMT
 gI2VeuDboiTo4GwAU5IDwSSyu8bmrXmyvm2xxn0=
X-Google-Smtp-Source: AHgI3Ia3aUMPs8A+f0S+OAOntXz63yvlxIZCcSZkHkAspWZKdCm1fRVczLmf1lM9pbiclIsGKkljQY6lvGdNXZnifOU=
X-Received: by 2002:a67:c913:: with SMTP id w19mr4362629vsk.179.1550223045823; 
 Fri, 15 Feb 2019 01:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-2-hch@lst.de>
 <e7a2efe3-f56c-7dfd-6613-dc9229556673@c-s.fr> <20190214170510.GC32441@lst.de>
 <d5451fc4-9183-702a-e9ed-4a2be1f82a11@c-s.fr>
In-Reply-To: <d5451fc4-9183-702a-e9ed-4a2be1f82a11@c-s.fr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 15 Feb 2019 18:30:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNATnsMbciyEd-1HZZmb5A66-TBtq0R3X-=JPMNT6iADo4w@mail.gmail.com>
Message-ID: <CAK7LNATnsMbciyEd-1HZZmb5A66-TBtq0R3X-=JPMNT6iADo4w@mail.gmail.com>
Subject: Re: [PATCH 01/11] powerpc: remove dead ifdefs in <asm/checksum.h>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 15, 2019 at 5:18 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 14/02/2019 =C3=A0 18:05, Christoph Hellwig a =C3=A9crit :
> > On Thu, Feb 14, 2019 at 09:26:19AM +0100, Christophe Leroy wrote:
> >> Could you also remove the 'config GENERIC_CSUM' item in
> >> arch/powerpc/Kconfig ?
> >
> > All the separate declarations go away later in this series.
> >
>
> I saw, but the purpose of the later patch is to replace arch defined
> GENERIC_CSUM by a common one that arches select. For the powerpc you are
> not in that case as the powerpc does not select GENERIC_CSUM.
>
> So I really believe that all stale bits of remaining GENERIC_CSUM in
> powerpc should go away as a single dedicated patch, as a fix of commit
> d4fde568a34a ("powerpc/64: Use optimized checksum routines on
> little-endian")
>
> Regarding the #ifdef __KERNEL__ , I think we should do a wide cleanup in
> arch/powerpc/include/asm, not only asm/checksum.h
>
> Christophe


Please send such cleanups to PowerPC ML
instead of to me (Kbuild).


Christoph,
I think this one is independent of the rest of this series.
How about separating it if you volunteer to Powerpc cleansup?


--=20
Best Regards
Masahiro Yamada
