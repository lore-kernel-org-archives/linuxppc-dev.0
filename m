Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61335C4360F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 08:15:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00672229F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 08:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00672229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440Tjc0WK1zDqLV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 19:15:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.66; helo=mail-ua1-f66.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com
 [209.85.222.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440Tdd2QZVzDqV1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 19:12:21 +1100 (AEDT)
Received: by mail-ua1-f66.google.com with SMTP id z24so1721168ual.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2019 00:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gyhVZT2cvH02qo+0nGpWrG/zXh7SGwoDkx6XeIiXPzo=;
 b=DtTAm2ATbj7w/bLHeCj/SAFybVeFPqtvLtflGyhcUoBSSBm/74u86S1pgDfiIOMSsc
 55zZxOw1RFLt714mOwuuPu5D4W6POTX/eGkVL6NRrN1j5jOjtILvelbGqrM5z3O/sQ4X
 cNWI23fwlYQyLZX9NPTiUVjCq1h1dUfJ9HGss6VeAxhgrcJUkty6q9Y25wHzHp/26Fkf
 lFldRiHQpPPIRTntDXJ+nIdLkkxg5fki8KjmY1jUYMLsuKeeLeiytVjxg9frVTDZ6qz+
 vPZoAA0rZaBQBm9mHBKUiSl9JQT7C4018BNuqObrIxFUF2tXrelyKTtMI6K7NHvP2/Dh
 z5KA==
X-Gm-Message-State: AHQUAuYNO4eHFEGhs10KhJHLcAoUB9qhbs8e6d5uJ6NApe/it8Wvw2y2
 LpVdS2KST31ZK26GxvY1DyPlVb6FwHWerk+PCcc=
X-Google-Smtp-Source: AHgI3IZarNBxgZqVSOHbG6fu5WSACF5VlsCI/qxhQmwcEzw1zAysB+AexGAtBhb6oMJQSg01PbRqjo2LsHbPzEA6iy4=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr1341942ual.20.1550131938902; 
 Thu, 14 Feb 2019 00:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-10-hch@lst.de>
In-Reply-To: <20190213174005.28785-10-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Feb 2019 09:12:07 +0100
Message-ID: <CAMuHMdUX=dq49b08UUxkLCn+HikUBOEs29314fYbwregfrSEqg@mail.gmail.com>
Subject: Re: [PATCH 09/11] lib: consolidate the GENERIC_CSUM symbol
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
Cc: linux-xtensa@linux-xtensa.org, linux-s390 <linux-s390@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 14, 2019 at 3:25 AM Christoph Hellwig <hch@lst.de> wrote:
> Add one definition to lib/Kconfig and let the architectures
> select if it supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/m68k/Kconfig       | 3 ---

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
