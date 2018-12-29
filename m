Return-Path: <SRS0=BvUY=PG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8E1C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 22:39:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC8A20869
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 22:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC8A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Rz5S5hcZzDqHX
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 09:39:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.195; helo=mail-qk1-f195.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Rz385hmVzDqFF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Dec 2018 09:37:08 +1100 (AEDT)
Received: by mail-qk1-f195.google.com with SMTP id g125so14246492qke.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2018 14:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sWodW4m2le/vPs28+pio7unZZk61wUo/y9VehQhAy9Q=;
 b=bin56UtFq0nKfMsINl3jkjfcZVDqLxuGjcpYQvbM78yqfP5DvqCA1Y7I4rRzIAHrAJ
 /txEVhgUmpQB4apIuApegdE2b3cH3xEFDCaZzFBd4ff88qYFXfoMLiCTbWB0THxFIQ4B
 oSBFqrgGUeal87ajnWHyJn6AEImUEQBn2w/J90Q8g8tnYbH89wCU4Y8D9u6tTbaXQKW+
 o81WgtAvsIzszwdl2qUZbJh0ZQ/aSaXxLVSSMmctNy/IvyT869GWc9gQRtQPIOcJfqWc
 7xTE0zOHsXjT+6M7T6vPCouviBOY+8V6HdkLVLaiZO9W4LKkVWZ46WQHE4UVgeADxVvx
 uKLA==
X-Gm-Message-State: AJcUukcXIv56MdazdVAiilyf5Lk7K+Gj44wy07SclJpWOm+g9sJbvpgg
 vmTMuilHX97QnFqVbarW5PBGzix3AiLb+jal2yA=
X-Google-Smtp-Source: ALg8bN5Ka4ZPtc7cyLPrB5ESs81qsypqdT3JLKIWF5u6XU+Lk2Lzxt8eH0yte00FtXFLRVUfviv8sQGYYOjAp9Aafjo=
X-Received: by 2002:a37:324a:: with SMTP id y71mr30094684qky.291.1546123026112; 
 Sat, 29 Dec 2018 14:37:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <2fe2b8e6395aeacfafcbde590a50922d4e632189.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <2fe2b8e6395aeacfafcbde590a50922d4e632189.1545784679.git.fthain@telegraphics.com.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 29 Dec 2018 23:36:49 +0100
Message-ID: <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com>
Subject: Re: [PATCH v8 24/25] powerpc: Adopt nvram module for PPC64
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
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:

> +static ssize_t ppc_nvram_get_size(void)
> +{
> +       if (ppc_md.nvram_size)
> +               return ppc_md.nvram_size();
> +       return -ENODEV;
> +}

> +const struct nvram_ops arch_nvram_ops = {
> +       .read           = ppc_nvram_read,
> +       .write          = ppc_nvram_write,
> +       .get_size       = ppc_nvram_get_size,
> +       .sync           = ppc_nvram_sync,
> +};

Coming back to this after my comment on the m68k side, I notice that
there is now a double indirection through function pointers. Have you
considered completely removing the operations from ppc_md instead
by having multiple copies of nvram_ops?

With the current method, it does seem odd to have a single
per-architecture instance of the exported structure containing
function pointers. This doesn't give us the flexibility of having
multiple copies in the kernel the way that ppc_md does, but it adds
overhead compared to simply exporting the functions directly.

       Arnd
