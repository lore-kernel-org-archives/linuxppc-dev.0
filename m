Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B97BC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:00:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5AB205C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFJysJLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5AB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4415KN0dfzzDqdm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 19:00:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=green.hu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hFJysJLW"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4415Hh1bkczDqLk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 18:58:52 +1100 (AEDT)
Received: by mail-ed1-x542.google.com with SMTP id d9so7165287edh.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 23:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9hadSi4LFcMfVTlwwQG+41oFCFy8OhnB/f4tmYYI81c=;
 b=hFJysJLWkGLtXG1O5bEgyGRtaiEsrbDgqrAmcqolx1PRFxSXlR2/gtI/gSrbU8Dtu1
 /f47WdBKnG7pGHxKRqgnqSuzk4hnwcAH63OCYSf21D2Djg/rcpibvn6gz3AhMhD5ZHRK
 +jjDWjFEYH42HrtWf1zUe83/sLVovkTFlJ8jlC5+zn+V2JKvBLDQ9K1OLut3CTfjpy9v
 uHHAl8YoQEK60thdD73+TRj2unwTfB0P5ZeyhBiVZTiLjDeanAv+SP74SEo8CCTpUrr/
 AeLVZ4wyC9695moE3AxZjltTQzeilvvms5tSoUNTAGKFt5N0mAq1YU2Yw7xfIgQDjUGQ
 lDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9hadSi4LFcMfVTlwwQG+41oFCFy8OhnB/f4tmYYI81c=;
 b=BolY8bLVn6rbj1Wsv37zwBxV/e+l9fKXr0Oh/5NolnbfKuWq0rXRx0AmFrZ1SJqRsm
 OudYpeLk3s3ZWojRXjmJ8zcv+Mbin5504yOVXaxVerut/qoebC6LpioR+aMco3jmb6Np
 zq0phkYvmvNk2Y7Wi1M5wiN/tr+U1sRz96GRMYR0tjK+rhzPzt66/vsxuWr2RE2jD2vI
 vLGWjBKegrVplo7i3mYHy7mn+8it5tYSFAQSLcBRU+vxJ2MxXc1sHC101lnVTGkNhep4
 p6LRiL8DaC3OSpW+ODAsF2Etzql3P0t+smrBhXFah0WZgd1sarOQVI50V7+vC7ajjuyC
 AWoQ==
X-Gm-Message-State: AHQUAubs3wsKpZhBoVkG3B6EQVCU6rnGvzCln4mEXYb1rnDQYDIDwgbM
 6YDAiN12mnOW2q52arfeTWlnxjxx9nf9hK6J7c0=
X-Google-Smtp-Source: AHgI3IYk+97brw7+2M2gsoq0t5Rme1jfRYz4kkvzqwCZT7uVIBuSU1MdnUBpIqQHCaGv8ygJYxBFb/p5CQiqNo7uGOE=
X-Received: by 2002:a17:906:1c4b:: with SMTP id
 l11mr5664488ejg.20.1550217529477; 
 Thu, 14 Feb 2019 23:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-7-hch@lst.de>
 <CAK7LNAQZm2TXO1gxif2LZQzwYae2AiqgZnNGJBxBjiPwoZLqig@mail.gmail.com>
In-Reply-To: <CAK7LNAQZm2TXO1gxif2LZQzwYae2AiqgZnNGJBxBjiPwoZLqig@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Fri, 15 Feb 2019 15:58:11 +0800
Message-ID: <CAEbi=3ctaYwjCxOVaCyUrvT=741keKPwXj6v8rS9bzoTZPcsOA@mail.gmail.com>
Subject: Re: [PATCH 06/11] lockdep: consolidate the LOCKDEP_SUPPORT symbol
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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
Cc: linux-xtensa@linux-xtensa.org,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Yamada,

Masahiro Yamada <yamada.masahiro@socionext.com> =E6=96=BC 2019=E5=B9=B42=E6=
=9C=8815=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:17=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> +CC Greentime Hu
> +CC Vincent Chen
>
>
> On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add one definition to lib/Kconfig.debug and let the architectures
> > select if it supported.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
>
> This changes the behavior of nds32.
>
> So please leave a note in the commit description.
> (Ideally, we want Ack of a NDS32 maintainer)
>
> Also, please do compile test for NDS32.
>
>
> -------------------------
> This commit changes CONFIG_LOCKDEP_SUPPORT to y for nds32.
>
> NDS32 selects LOCKEP_SUPPORT, but there was previously
> no config entry of LOCKDEP_SUPPORT in nds32.
>
> It is now available in lib/Kconfig.debug,
> so this commit enables LOCKDEP_SUPPORT for nds32.
> -------------------------

Thank you to let us know this change.
I think it's ok to enable LOCKDEP_SUPPORT for nds32.
I just verified it in 5.0.0-rc1.
