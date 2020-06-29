Return-Path: <SRS0=PIrw=AK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE93C433E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2020 21:51:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73C4206A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2020 21:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73C4206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49wh5d1fMBzDqTP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 07:51:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.67; helo=mail-ot1-f67.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49wh1L22mCzDqLp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2020 07:47:49 +1000 (AEST)
Received: by mail-ot1-f67.google.com with SMTP id m2so16816320otr.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2020 14:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Bg/8+MNYJDDCvPfevV5MmVW6eomjiYjuKJdPS9BuKRc=;
 b=bge8U1ZJqV1h3HtsNOuNRgeoCvqtW8GpdCI8XiJADiOTrSfn9kqbFOVgQZIfarH1Yd
 4MJ8WZR/clwwg+sigc5OPJ5LJgRfhPYwBCl6VK6c0BsM7t90icrEp5sz54lg4VuwOmk/
 ZZO0xGdHKeAjymtaDPUtso2UAG+g1MxvbwCNsbNqb+yNaX3UT2Q6Ry2M3HxdF832qhiJ
 Jz5ft/3/ymT5UyY4gfeNoO4G/ZMkCCnIACCWIFCZanjp13Pbe/Fz1QlEWCs3eF2WiZcj
 X4DMo5HG+bzkQl7Y0edlvG3qvu3SYEqVtjWTyEIDzI0spO98O5HYAI+AlsqphRg/OkOQ
 xDyg==
X-Gm-Message-State: AOAM531j08YSxDZMlbCyCs7ZAQxtfagYT1Q/56XvmIws01c78V1lvgxa
 M47utuf7hJjWVqSutFjTtMT8b2VKmxn3BHl9gQ0=
X-Google-Smtp-Source: ABdhPJyLaroA0htJgp6XAeP34onG9mo2tlAy+lOvoV/8lvJ36fwjwGDczPcQeW26SHMu76Ngn9P5yzkiLg9cpAETRvQ=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr14223999otb.107.1593467266175; 
 Mon, 29 Jun 2020 14:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200629193947.2705954-1-hch@lst.de>
 <20200629193947.2705954-2-hch@lst.de>
In-Reply-To: <20200629193947.2705954-2-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2020 23:47:35 +0200
Message-ID: <CAMuHMdXXORM_yD4bqk+MQ1yEA1jmOjO9eyfnsjxY1a5E5isEcg@mail.gmail.com>
Subject: Re: [PATCH 01/20] nfblock: stop using ->queuedata
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
Cc: Jens Axboe <axboe@kernel.dk>, "open list:TENSILICA XTENSA PORT \(xtensa\)"
 <linux-xtensa@linux-xtensa.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-nvme@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-raid@vger.kernel.org, dm-devel@redhat.com, linux-bcache@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Lars Ellenberg <drbd-dev@lists.linbit.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jun 29, 2020 at 9:40 PM Christoph Hellwig <hch@lst.de> wrote:
> Instead of setting up the queuedata as well just use one private data
> field.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
