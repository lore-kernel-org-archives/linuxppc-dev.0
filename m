Return-Path: <SRS0=BvUY=PG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D634C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 22:22:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8714620873
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 22:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8714620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Ryk60m1FzDqDs
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 09:22:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.193; helo=mail-qt1-f193.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Rygh6kr8zDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Dec 2018 09:20:16 +1100 (AEDT)
Received: by mail-qt1-f193.google.com with SMTP id t33so26541789qtt.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2018 14:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gEKNttcn2DuV6IUidckb9z98s4YMQSt0m/gFTL7QWxY=;
 b=Y8Qq/7wqsBRTQ7zGXJy8MtGfJi1AmazkKzhB7ngBQtDCfVKanOTLjN6bh3FBCJGd6h
 Ri/sCtGwo7RtCwlmNErAGMCpKXcH14pL+IHs/OBGXSPIs+AOvyK1LbqoZo3DJYoZbbL2
 282P26PooJm5FSkb+VwivZnU0D2VgU3AF9eyuxnQaeo33E/P5oop6Loib4//4yx7irqE
 SJtuQbhvVvW+FKMw8zQxsd8Z1oKzq2ZAT+zBuohOfZo6PLxZdBRE6Dv5N/fTC+37x6JZ
 a+335btIiWlqm8BSVEq7Yw35Z1bFmd+0AjkkzcU78Pq5Z3i5WXDmTzL56pTJ/QjUYWEU
 u8iA==
X-Gm-Message-State: AA+aEWa+rW8XnExLVQsjew+Db/SxQ2FE5geUzYUSJ938zJHQKFseF/pS
 TfVxQ+Uzqhl3f0BxvX6j1A4m70KjJc1qOWqoWGc=
X-Google-Smtp-Source: AFSGD/VP4OgqTevr0l0kgt+jsLmHm4koubyN5NQH8QXOPDhgnoDNjTdGQzAzSL0INVYSyEyZd+6OwMNuoJ/8J8lFSpM=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr30221440qtr.319.1546122013947; 
 Sat, 29 Dec 2018 14:20:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <3ba1dd965c1097e00463eafe7c7d5fd93bbed836.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <3ba1dd965c1097e00463eafe7c7d5fd93bbed836.1545784679.git.fthain@telegraphics.com.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 29 Dec 2018 23:19:57 +0100
Message-ID: <CAK8P3a0-4vGuCR4aCq0=D1Du1K=f5MtnB9fyCBnOsF+4Na5dMg@mail.gmail.com>
Subject: Re: [PATCH v8 18/25] powerpc: Implement nvram sync ioctl
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

> --- a/drivers/char/nvram.c
> +++ b/drivers/char/nvram.c
> @@ -48,6 +48,10 @@
>  #include <linux/mutex.h>
>  #include <linux/pagemap.h>
>
> +#ifdef CONFIG_PPC
> +#include <asm/nvram.h>
> +#include <asm/machdep.h>
> +#endif
>
>  static DEFINE_MUTEX(nvram_mutex);
>  static DEFINE_SPINLOCK(nvram_state_lock);
> @@ -331,6 +335,37 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
>         long ret = -ENOTTY;
>
>         switch (cmd) {
> +#ifdef CONFIG_PPC
> +       case OBSOLETE_PMAC_NVRAM_GET_OFFSET:
> +               pr_warn("nvram: Using obsolete PMAC_NVRAM_GET_OFFSET ioctl\n");
> +               /* fall through */
> +       case IOC_NVRAM_GET_OFFSET:
> +               ret = -EINVAL;
> +#ifdef CONFIG_PPC_PMAC

I think it would make be nicer here to keep the ppc bits in arch/ppc,
and instead add a .ioctl() callback to nvram_ops.

> @@ -369,12 +405,14 @@ static int nvram_misc_open(struct inode *inode, struct file *file)
>                 return -EBUSY;
>         }
>
> +#ifndef CONFIG_PPC
>         /* Prevent multiple writers if the set_checksum ioctl is implemented. */
>         if ((arch_nvram_ops.set_checksum != NULL) &&
>             (file->f_mode & FMODE_WRITE) && (nvram_open_mode & NVRAM_WRITE)) {
>                 spin_unlock(&nvram_state_lock);
>                 return -EBUSY;
>         }
> +#endif
>
> diff --git a/include/linux/nvram.h b/include/linux/nvram.h
> index b7bfaec60a43..24a57675dba1 100644
> --- a/include/linux/nvram.h
> +++ b/include/linux/nvram.h
> @@ -18,8 +18,12 @@ struct nvram_ops {
>         unsigned char   (*read_byte)(int);
>         void            (*write_byte)(unsigned char, int);
>         ssize_t         (*get_size)(void);
> +#ifdef CONFIG_PPC
> +       long            (*sync)(void);
> +#else
>         long            (*set_checksum)(void);
>         long            (*initialize)(void);
> +#endif
>  };

Maybe just leave all entries visible here, and avoid the above #ifdef checks.

       Arnd
