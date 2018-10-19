Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C23ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:53:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA602145D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0iIMhwfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA602145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42btp64K4nzDrMl
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 15:53:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="0iIMhwfs";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.80; helo=conssluserg-01.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="0iIMhwfs"; 
 dkim-atps=neutral
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42btk06hMYzF3YJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 15:49:28 +1100 (AEDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id w9J4mtmj023565
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 13:48:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w9J4mtmj023565
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1539924536;
 bh=FyBXPZb6jyuBzv8irLjTgnaBuu5+uDweGqVCUHokX+Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0iIMhwfspe5XKMeWAwT04VJ5MmgmULvXe3FY9yFVdIQArEwjLUeyeMAlgKadghEzd
 uNQRC3O6S+XrUE9wNM6jMvnfuNp0yMKOe6dXaSubWrMGS7auskPZbyTM9ftMc5/eFE
 GqZjgk2XISMmgyUbO/nbTT3YHMou3RXUD73G5nHoA/F4LdZ0XvZDBtKYlC0RC3FKrR
 dEsFoQ/43iK9JBPA6KQlD2s3blCXQU2ERctvViEIZnSj/enWHl5OvrSpjNBCeh0cTt
 XFM0+K4k27VcPAd1bciULI1vW7FBoI9QDmopbsQzDgJxMfy/1ekb9J6km9PtpKSS7I
 jqqcgz3LVsybw==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id l186so7206999vke.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 21:48:56 -0700 (PDT)
X-Gm-Message-State: ABuFfoimgo9Im+0KjvNzviBScgk4EwQvqgsWQZRl9h03S9dcnCEuSB3d
 bNrmhpnBalkgc8V7wSy5eKtpURZI14CKkFQGIKQ=
X-Google-Smtp-Source: ACcGV61ED3uOk4PfLYjkeDtUX81TT1OdfmxJ+WdXMJn3e2O3hj/T8Nd6sgKwrZ6bQ1llnke/KRBnWBXfL30XVLPPeqI=
X-Received: by 2002:a1f:5503:: with SMTP id
 j3-v6mr13630030vkb.34.1539924535097; 
 Thu, 18 Oct 2018 21:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de>
 <20181017080201.10866-8-hch@lst.de>
In-Reply-To: <20181017080201.10866-8-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 19 Oct 2018 13:48:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAk1oL8xbwp4RqMcZc5CtU7=YCqN2wHcSOq4RsJtJgRA@mail.gmail.com>
Message-ID: <CAK7LNATAk1oL8xbwp4RqMcZc5CtU7=YCqN2wHcSOq4RsJtJgRA@mail.gmail.com>
Subject: Re: [PATCH 7/8] eisa: consolidate EISA Kconfig entry in drivers/eisa
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
 linux-scsi <linux-scsi@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Alex Bounine <alex.bou9@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 17, 2018 at 5:03 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Let architectures opt into EISA support by selecting HAS_EISA and

Nit.

HAS_EISA -> HAVE_EISA
since you renamed it in this version.



> handle everything else in drivers/eisa.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> ---
-- 
Best Regards
Masahiro Yamada
