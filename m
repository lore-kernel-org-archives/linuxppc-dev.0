Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A776C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 10:54:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7318222A4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 10:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7318222A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440YDw4DmkzDqKj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 21:54:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.221.195; helo=mail-vk1-f195.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com
 [209.85.221.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440YBt4TDhzDqJK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 21:52:54 +1100 (AEDT)
Received: by mail-vk1-f195.google.com with SMTP id n126so1273642vke.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 02:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a64e/Frl3TS8foASPDEwpnLzkU/nFm2nnLXf1OkqgoM=;
 b=E4MJHu9ARqKNK9joaZp+toRfCdzXwxQpVJCRt02747O9bhGRCNzDUkEZilpD1IEGSG
 4Lqk+F58qBSjG7FqMJwGTmC3zMdf+f+mJMKieTmo17JAoPj2U7i3Ozsu5SvfB0Z9IIUR
 nNx0VCHPnNdh4NaoWVIMeeSvEylfbfkuKidvKbgu44B23o5avL8ZD+yp+6+Zp+EP3OYS
 izSZ5kPmo2VifQNrmyEM+avn3WJZrg55WU2KSojHMYOd0BFy05RvOLjbl9LWv0liwbfM
 4XyuUCXFA1WhKwV8bZ/PVy5+mZMQUcUR0k1qhD2uG+xWrd2n2gVrNCrXT0g7lg+dXj1v
 GpdQ==
X-Gm-Message-State: AHQUAubqvy2OousfK7UywsH/PGPJzfNkpiMpOmjGOIFBXFDspeao4lZn
 KX2tlnDOnKANLTrOPP8ZU0vLRi8gqoV57liHy90=
X-Google-Smtp-Source: AHgI3IbVlE+20rHo06cRQ7RaPLMWLgp7FvRlv87ciXX9EfozxsYE929izmV+u0RRZEdIlYSIsunSi7ovbHHjIm/GHUc=
X-Received: by 2002:a1f:8e49:: with SMTP id q70mr1653639vkd.40.1550141571959; 
 Thu, 14 Feb 2019 02:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-4-hch@lst.de>
In-Reply-To: <20190213174005.28785-4-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Feb 2019 11:52:38 +0100
Message-ID: <CAMuHMdW4C1McxL-e7ZSiSOiiE5D=xbBK8FZOwuJ1w0kK3CR1Hg@mail.gmail.com>
Subject: Re: [PATCH 03/11] kernel/locks: consolidate RWSEM_GENERIC_* options
To: Christoph Hellwig <hch@lst.de>, Waiman Long <longman@redhat.com>
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 14, 2019 at 12:08 AM Christoph Hellwig <hch@lst.de> wrote:
> Introduce one central definition of RWSEM_XCHGADD_ALGORITHM and
> RWSEM_GENERIC_SPINLOCK in kernel/Kconfig.locks and let architectures
> select RWSEM_XCHGADD_ALGORITHM if they want it, otherwise default to
> the spinlock version.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Note that this conflicts with "[PATCH v4 2/3] locking/rwsem: Remove
rwsem-spinlock.c & use rwsem-xadd.c for all archs"
https://lore.kernel.org/lkml/1550095217-12047-3-git-send-email-longman@redhat.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
