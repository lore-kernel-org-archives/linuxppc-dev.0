Return-Path: <SRS0=BvUY=PG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A620DC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 22:29:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA1020869
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 22:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA1020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Rytg1GqkzDqGh
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 09:29:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.194; helo=mail-qk1-f194.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43RyrL4hnXzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Dec 2018 09:27:46 +1100 (AEDT)
Received: by mail-qk1-f194.google.com with SMTP id y16so14240400qki.7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2018 14:27:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o0oBUkqD5p4j+xffeWUiyhsv44vkKiTcEHnXCi5uSdo=;
 b=eD0ZdGy8Fr8ag9NRgXuH+FlQed/15s0tbf+0qDyTv2YrvfhrWCBhKT96fH7eXS94Tw
 2Lyfc66KxaE62g+xcwmIGvLWT6tG4Y2w+74xp86F7oUjiIUGnxEKAxrAH31uLBiJgGY2
 v7km/bfUc/hEyFicmvnEdjNWNEA+RWqjXDHztUOZ2kPiaTwJoXg4j6uem051vubwKYWe
 EBCcIpvBjYbWqT2KeHYRZFwIPMUwgl2FCo9UecqjWfPU9mIcY178X2vNYpgi/6b3q1I7
 TNK5BKGVdcdOUy7tXG8y6oOrNPqILY4IfiT7pNZptUxZHpKcSuN2eUKYbYdr3FyPPtV7
 wtGg==
X-Gm-Message-State: AJcUukdwZc73unq5Wspj6Aqav/fwKxjg0D3+LbBi1w7YqxscpYo1Ic+k
 Ia60mSep5S6JjW7rj5mFBoMmmPmUmefJ911g7aGLMYDY
X-Google-Smtp-Source: ALg8bN6dhuNcs0QnWtoULV5zjryQxDeGrpo3N8kjItS1pnbJjUmy+wHGeE18YJWU6kA2rS73ItoSySk42fhqWqWBPIw=
X-Received: by 2002:a37:bdc6:: with SMTP id
 n189mr29013373qkf.330.1546122463680; 
 Sat, 29 Dec 2018 14:27:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <505240b144f1666acf26a3c1e93c8e6868fe1408.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <505240b144f1666acf26a3c1e93c8e6868fe1408.1545784679.git.fthain@telegraphics.com.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 29 Dec 2018 23:27:27 +0100
Message-ID: <CAK8P3a0P7r+PCykB1cHq3HBrpHagfJ5WhDV7JR-wu0tGTMSFMA@mail.gmail.com>
Subject: Re: [PATCH v8 13/25] m68k: Dispatch nvram_ops calls to Atari or Mac
 functions
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:

> +
> +static ssize_t m68k_nvram_get_size(void)
> +{
> +       if (MACH_IS_ATARI)
> +               return atari_nvram_get_size();
> +       else if (MACH_IS_MAC)
> +               return mac_pram_get_size();
> +       return -ENODEV;
> +}
> +
> +/* Atari device drivers call .read (to get checksum validation) whereas
> + * Mac and PowerMac device drivers just use .read_byte.
> + */
> +const struct nvram_ops arch_nvram_ops = {
> +#ifdef CONFIG_MAC
> +       .read_byte      = m68k_nvram_read_byte,
> +       .write_byte     = m68k_nvram_write_byte,
> +#endif
> +#ifdef CONFIG_ATARI
> +       .read           = m68k_nvram_read,
> +       .write          = m68k_nvram_write,
> +       .set_checksum   = m68k_nvram_set_checksum,
> +       .initialize     = m68k_nvram_initialize,
> +#endif
> +       .get_size       = m68k_nvram_get_size,
> +};
> +EXPORT_SYMBOL(arch_nvram_ops);

Since the operations are almost entirely distinct, why not have two
separate 'nvram_ops' instances here that each refer to just
the set they actually need?

I was actually expecting one more patch here that would make the
arch_nvram_ops a pointer to one of multiple structures, which would
be easier to do with multiple copies, but I suppose there is no need
for that here (there might be on ppc, I have to look again).

       Arnd
