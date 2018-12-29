Return-Path: <SRS0=BvUY=PG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC19AC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 22:47:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37AFD20866
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 22:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AFD20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43RzHV1hvyzDqJS
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 09:47:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.196; helo=mail-qk1-f196.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43RzFH5Px9zDqFF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Dec 2018 09:45:54 +1100 (AEDT)
Received: by mail-qk1-f196.google.com with SMTP id o89so14272940qko.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2018 14:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cipite4SASv4S47KCGjGODYzIep4IrLd8iZmBANvLtM=;
 b=IbZniVyDDiAu2G25/pSj2fr4SGGhRyPwGxHjKGRJPV3xdzL4HDJRyvs5zfsHDUzSvj
 E77VHZzUAOwBunmOYVO7G0vQBeFgEF3Wbu3PNtDzh3LpY5jgpzC7lQaKFRxN/rzBD9ma
 u7WKZRIMR3aCzyPV5otujTSohpVa4VHbB7lzWHUxGVT/cZGaaUD7zhxBDyyXzf5Ju0BJ
 MLRfUaEQ5vNtzk4LMnEBmUkSAKaLOjH1ABNiSyuxdAHtqLSTzvlLqRi0Tj3LtGtu7Y+g
 Y3AyQTCsOOr2YfUjUiOdKa3seMkR9l3SLzXJNSrdFVBUMBm7dzZs7K/1crV0/wutNI+G
 uW5w==
X-Gm-Message-State: AJcUukcjInB9iBj4Jbu9V4kPaQaP95TYlSlHylxRE7H6kVAAJdBCNTTb
 kJ8jku7gc5e/v8/Nr7zr1ccMmsZxnPIb0l0wh2E=
X-Google-Smtp-Source: ALg8bN7Qa7hr2XNmtq4+tGYa+nhueZodgl0jMtR5EIShVYb6Jn/qFpQpxOm30S4ounHRU2fY5CS5KtIHH+PSevPuUIo=
X-Received: by 2002:a37:9a89:: with SMTP id
 c131mr29881024qke.173.1546123552154; 
 Sat, 29 Dec 2018 14:45:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 29 Dec 2018 23:45:36 +0100
Message-ID: <CAK8P3a3yF+CkvQS_funp4BPhi-10N4yse2oAeWAcWR+Ty5Pxmg@mail.gmail.com>
Subject: Re: [PATCH v8 00/25] Re-use nvram module
To: Finn Thain <fthain@telegraphics.com.au>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:

> This allows for removal of drivers/char/generic_nvram.c as well as some
> duplicated code in arch/powerpc/kernel/nvram_64.c. By reducing the number
> of /dev/nvram char misc device implementations, the number of bugs and
> inconsistencies is also reduced.
>
> This patch series reduces inconsistencies between PPC32 and PPC64, and
> between PPC_PMAC and MAC. A uniform API has benefits for userspace.
> For example, some error codes for some ioctl calls become consistent
> across PowerPC platforms. The uniform API can potentially benefit
> bootloaders that work across different platforms which all have XPRAM
> (e.g. Emile).
>
> I think there are two reasonable merge strategies for this patch series.
> The char misc maintainer could take the entire series. Alternatively the
> m68k maintainer could take patches 1 thru 14, and after those patches
> reach mainline the powerpc maintainer could take 15 thru 25 (even though
> patch 21 is not powerpc-related).

I had a look at the complete series now, and I think this is a great cleanup.
I replied with a couple of minor comments that you may or may not want
to address first.

The one thing I would like to see resolved (I hope this doesn't bring
back an old discussion you had already concluded) is regarding
the use of a global exported structure of function pointers, as opposed
to using either directly exported functions (with a consistent interface)
or a boot-time selectable structure like dma_map_ops or ppc_md.

    Arnd
