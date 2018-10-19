Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15477ECDE43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 05:22:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE0F2083A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 05:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr0CWOGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE0F2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bvSP4tNnzF3Vn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 16:22:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mr0CWOGr";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::c44; helo=mail-yw1-xc44.google.com;
 envelope-from=jcmvbkbc@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mr0CWOGr"; 
 dkim-atps=neutral
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bvPj3kwBzF3LS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 16:20:21 +1100 (AEDT)
Received: by mail-yw1-xc44.google.com with SMTP id l79-v6so12738555ywc.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 22:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eYm3Z3uHgiS50jVdrs5Ht18bNBsSRmhH1uK5LNe0tkA=;
 b=mr0CWOGrSieqzo7EDBAnWFQmPimGw2LFO3O4a70+RHWUdQHA5rst/uPLllmNC0TyZJ
 NNCCs+GxFag9biL8EpaHO4CNPx+JZZEKPC7tF640UB9evsTXu7hMJupLo1tVoECV50Tx
 ZAj1g8rq7JtGlOm9kH9R52K0zem72Zw7AVZ/026U7j69korDpjD8G9RkL2Q4yfYNwBmI
 J6a3tPWWYsf0mM8HH8Lzew3ZrhQ/oxqtfPM9OTNCZv3q83D9qoRuY8iGzhhWfOThU9Xx
 JVmpx2pZwSqo7fTRxaSFJjRCOLQp6KP/cQ2fklaGJJ1NEqNEg+U0Ry9Gt93DcdEWQ/ev
 ftuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eYm3Z3uHgiS50jVdrs5Ht18bNBsSRmhH1uK5LNe0tkA=;
 b=qoyQGpSQT8V5Y2Pnw1N14YGLSyWQdUGGZWgLKpDfs/4DaiTWjR85ogMXdH6p5clvtA
 UVLRXp4xR0XqsdG6H3YxfP6SkELj8fiJyaAdugOnc/6T4pl+adjTP0kLFkcH+maMA5DM
 Z4a1uZZYi7e9Uzm5Zv7IKsWvD5q1Fh4chiIJO+34QBksaQAUtRNtT9N3oTmldExqt9vj
 wtc8XUbKA9Ifur8oz3yuBvm+Y1jKJxup0zzFB06bIhUG+62CDxWkmElY/ZAvR6uxaqci
 RU6JzAO8643Qt458aSKX9fwR8yrq+I/vtebGAOv1DuXQh8masb7wu1Vw+ASMBsnNRZNH
 RPGA==
X-Gm-Message-State: ABuFfohtoC3+5Q7mPunSdiPLaTshnptCGxoISVxuZXxINle+UvRW2gqc
 +qoFZvMKNTYHzzW8MIY3wRKTuPhO6ihAwM0cIeg=
X-Google-Smtp-Source: ACcGV62i1f69dyUv8xKhlAiMQGv4Be0cftCBzmn2YA82A11bbaP+7sJx3cVp4K+OkAiJUU/8We1JCF16QEsfLRSUn6M=
X-Received: by 2002:a81:ee0b:: with SMTP id
 l11-v6mr21372847ywm.422.1539926419608; 
 Thu, 18 Oct 2018 22:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181017080201.10866-1-hch@lst.de>
 <20181017080201.10866-5-hch@lst.de>
In-Reply-To: <20181017080201.10866-5-hch@lst.de>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 18 Oct 2018 22:19:51 -0700
Message-ID: <CAMo8BfKOqAKLPEXatPZQ4bCAAzQLx_vAHscmxDJPC9PGsoJqtA@mail.gmail.com>
Subject: Re: [PATCH 4/8] PCI: consolidate PCI config entry in drivers/pci
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-scsi@vger.kernel.org,
 linux-kbuild <linux-kbuild@vger.kernel.org>, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
 Masahiro Yamada <yamada.masahiro@socionext.com>, alex.bou9@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christoph,

On Wed, Oct 17, 2018 at 1:03 AM Christoph Hellwig <hch@lst.de> wrote:
> diff --git a/arch/xtensa/configs/iss_defconfig b/arch/xtensa/configs/iss_defconfig
> index 4bb5b76d9524..818849bb7736 100644
> --- a/arch/xtensa/configs/iss_defconfig
> +++ b/arch/xtensa/configs/iss_defconfig
> @@ -4,7 +4,7 @@ CONFIG_EXPERT=y
>  CONFIG_SYSCTL_SYSCALL=y
>  # CONFIG_IOSCHED_DEADLINE is not set
>  # CONFIG_IOSCHED_CFQ is not set
> -# CONFIG_PCI is not set
> +CONFIG_PCI=y

This change doesn't make sense as there's no PCI hardware in the Xtensa ISS.
Otherwise for the Xtensa part:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
