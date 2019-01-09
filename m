Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED714C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 01:16:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A143206B6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 01:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n8oWMglI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A143206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZB6S5r31zDqXm
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 12:16:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::944; helo=mail-ua1-x944.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="n8oWMglI";
 dkim-atps=neutral
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com
 [IPv6:2607:f8b0:4864:20::944])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZB4Y3R2wzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 12:14:53 +1100 (AEDT)
Received: by mail-ua1-x944.google.com with SMTP id v24so1898017uap.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2019 17:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2A/fwvQAV6lsXaJ6k3wt6YiW60CG0GvpiajItkhBSKM=;
 b=n8oWMglITuixTL1tZ9wTM2CGYxHozKdsRA5lE8adSfWGH4WWtOUV5ObEIZnZhA2oi1
 pnoDbf0G5Bc1gM97+cqY8nkA2OsL8uerocE7ZMJNIXWVT5rO4zyazNiPmAi+KHBTHwo7
 4Cgo+YWbK1/DZXziu1DQhgZ4Dx0r2iIvHRd4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2A/fwvQAV6lsXaJ6k3wt6YiW60CG0GvpiajItkhBSKM=;
 b=CCY7lMVEnsxvz9OiiKmVS/R/8xgD1D4Ygy+IQ23ukwjcUvAJt4BtylEKQ98rzqNCMw
 OP9x6qvxWmIQLddf+Ff9xeL0Dhr9KML8JgS1g8mKyEOj0D912g2Z/2Rh+Uu+hFMtEQ+K
 Oq6O2hdp2CToeEZE7lat52jZLV0tYQuylFkRzvFgssec1LDbwRIH5rkWzLsABeX6gwoJ
 dMHNCDyQT9q+V5Bozv1sKV76U3XuzcgalWjtq5ERKfxNybtrJViVCq5WlLLYadeYQc/t
 4swB/gEdTsWnoH6oG6cV0AR+VrQ0KIFu8yAuEA449DTGKS7tWaFvYPjmVUGw7bw2rYxy
 PuRw==
X-Gm-Message-State: AJcUukeYF4nackcyXA5I7poaaTF/kr8jt/5PkyUZGy9AzmhOOclWvyPv
 ZRdNbwjxrMEuJNxTG6OZoRWXxi73O0c=
X-Google-Smtp-Source: ALg8bN5hBg2bqRRRJ/NeYiOHw2QnfeJ1G0Bl+twAj5cQ5+sv25G+Sx9gzSeitdEs8OlTH2dKtZ1sRw==
X-Received: by 2002:a9f:2622:: with SMTP id 31mr1479509uag.90.1546996490606;
 Tue, 08 Jan 2019 17:14:50 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com.
 [209.85.217.53])
 by smtp.gmail.com with ESMTPSA id p8sm31158051vke.27.2019.01.08.17.14.49
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 17:14:49 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id z23so3731567vsj.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2019 17:14:49 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr1681649vsl.188.1546996488909; 
 Tue, 08 Jan 2019 17:14:48 -0800 (PST)
MIME-Version: 1.0
References: <8593f7faf89812a9987d44d9ae615d64dca4d77f.1544800744.git.christophe.leroy@c-s.fr>
In-Reply-To: <8593f7faf89812a9987d44d9ae615d64dca4d77f.1544800744.git.christophe.leroy@c-s.fr>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 8 Jan 2019 17:14:36 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKeGp_z_69SybtkSaE381Ui7aXCxp9yBxv=TS0=hSsm-A@mail.gmail.com>
Message-ID: <CAGXu5jKeGp_z_69SybtkSaE381Ui7aXCxp9yBxv=TS0=hSsm-A@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: Add a tests for NULL pointer dereference
To: Christophe Leroy <christophe.leroy@c-s.fr>
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
 PowerPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 14, 2018 at 7:26 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> Introduce lkdtm tests for NULL pointer dereference: check
> access or exec at NULL address.

Why is this not already covered by the existing tests? (Is there
something special about NULL that is being missed?) I'd expect SMAP
and SMEP to cover NULL as well.

-Kees

>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  drivers/misc/lkdtm/core.c  |  2 ++
>  drivers/misc/lkdtm/lkdtm.h |  2 ++
>  drivers/misc/lkdtm/perms.c | 18 ++++++++++++++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index bc76756b7eda..36910e1d5c09 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -157,7 +157,9 @@ static const struct crashtype crashtypes[] = {
>         CRASHTYPE(EXEC_VMALLOC),
>         CRASHTYPE(EXEC_RODATA),
>         CRASHTYPE(EXEC_USERSPACE),
> +       CRASHTYPE(EXEC_NULL),
>         CRASHTYPE(ACCESS_USERSPACE),
> +       CRASHTYPE(ACCESS_NULL),
>         CRASHTYPE(WRITE_RO),
>         CRASHTYPE(WRITE_RO_AFTER_INIT),
>         CRASHTYPE(WRITE_KERN),
> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> index 3c6fd327e166..b69ee004a3f7 100644
> --- a/drivers/misc/lkdtm/lkdtm.h
> +++ b/drivers/misc/lkdtm/lkdtm.h
> @@ -45,7 +45,9 @@ void lkdtm_EXEC_KMALLOC(void);
>  void lkdtm_EXEC_VMALLOC(void);
>  void lkdtm_EXEC_RODATA(void);
>  void lkdtm_EXEC_USERSPACE(void);
> +void lkdtm_EXEC_NULL(void);
>  void lkdtm_ACCESS_USERSPACE(void);
> +void lkdtm_ACCESS_NULL(void);
>
>  /* lkdtm_refcount.c */
>  void lkdtm_REFCOUNT_INC_OVERFLOW(void);
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index fa54add6375a..62f76d506f04 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -164,6 +164,11 @@ void lkdtm_EXEC_USERSPACE(void)
>         vm_munmap(user_addr, PAGE_SIZE);
>  }
>
> +void lkdtm_EXEC_NULL(void)
> +{
> +       execute_location(NULL, CODE_AS_IS);
> +}
> +
>  void lkdtm_ACCESS_USERSPACE(void)
>  {
>         unsigned long user_addr, tmp = 0;
> @@ -195,6 +200,19 @@ void lkdtm_ACCESS_USERSPACE(void)
>         vm_munmap(user_addr, PAGE_SIZE);
>  }
>
> +void lkdtm_ACCESS_NULL(void)
> +{
> +       unsigned long tmp;
> +       unsigned long *ptr = (unsigned long *)NULL;
> +
> +       pr_info("attempting bad read at %px\n", ptr);
> +       tmp = *ptr;
> +       tmp += 0xc0dec0de;
> +
> +       pr_info("attempting bad write at %px\n", ptr);
> +       *ptr = tmp;
> +}
> +
>  void __init lkdtm_perms_init(void)
>  {
>         /* Make sure we can write to __ro_after_init values during __init */
> --
> 2.13.3
>


-- 
Kees Cook
