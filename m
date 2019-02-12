Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7607C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:38:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5F4218A1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ScNql/zi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5F4218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z4zj5GjPzDqMf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 12:38:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::841; helo=mail-qt1-x841.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="ScNql/zi"; 
 dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z4xw5yR9zDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 12:36:36 +1100 (AEDT)
Received: by mail-qt1-x841.google.com with SMTP id r9so1173416qtt.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 17:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yUuKGpbeZ87G6YqygEGqI3ghOzEoqQ0kqnasFqx+5cE=;
 b=ScNql/zi4m7Z6Gpph58yKfJ9xqEuxUjSbzOFqjHKpXfQreuf6nfs/fY7TLVhJZoml7
 +FX3e3KyRRNHQMQxMI1ioL+DBqaA8vdnLgsNl0v7wGh2OBRT8PIx/G+onwWUzMDf8+ep
 YElWVVIsTT/U8S1zAoEIa3SUDBC90GNsBV8p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yUuKGpbeZ87G6YqygEGqI3ghOzEoqQ0kqnasFqx+5cE=;
 b=joHO/dSYxd17JRu9OMlXUyOPUbeJ55obX5Q0mOfaejKeuPYvjAXg78sNXPAr5KncUc
 tg/SdKIHDJBo56CX5VOBeuEC90g1/mEhUPl/qcjNXJ3nzoqvjAqht8zjw5b84WOAily4
 sLZrzVAQaO7nTckUs7Uk3Jo5h01SfKJ1DsS7iy1RYJZSgyRCzajq7MXRgAYKkY4r7wD+
 E830aLCahuaZlDiGSZDdIm3a0jAfw8Yuu0h/qjG4mbQh9Mb1eQM+NiUiNcIR1a38jcGa
 n+36Hy3GdNuoDW85Mcph8c0FO1UFg7JHjrtHGPtUPbM++sCvX+hb78VLmnE0LACUcqQl
 vzJA==
X-Gm-Message-State: AHQUAua/EaQ8jaVLNk/qnRRgvjL2m8N0ZFXXY6U2Q0Ou+lJDEnx/bTW/
 iT3H3sOnKy9mWeABMCBa4k3e6bVJaKyAxL+PmB4=
X-Google-Smtp-Source: AHgI3IbQN8QcAMMUe7SFw1k+NHnBhnP5VbGINf4ZHsg14jGFzwPvt96wwSp0VqQZoq0r7xMq8Rg75KtdaZO9zv8/4As=
X-Received: by 2002:a0c:806f:: with SMTP id 102mr819627qva.89.1549935393934;
 Mon, 11 Feb 2019 17:36:33 -0800 (PST)
MIME-Version: 1.0
References: <1549885032-15702-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1549885032-15702-1-git-send-email-thuth@redhat.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 12 Feb 2019 12:06:21 +1030
Message-ID: <CACPK8XfyJKUnJ4aAxRP403T9cE2iv7KSS0rWXqQ50NYYzMq1Aw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/configs: Enable CONFIG_USB_XHCI_HCD by default
To: Thomas Huth <thuth@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <dgibson@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 11 Feb 2019 at 22:07, Thomas Huth <thuth@redhat.com> wrote:
>
> Recent versions of QEMU provide a XHCI device by default these
> days instead of an old-fashioned OHCI device:
>
>  https://git.qemu.org/?p=qemu.git;a=commitdiff;h=57040d451315320b7d27

"recent" :D

> So to get the keyboard working in the graphical console there again,
> we should now include XHCI support in the kernel by default, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/powerpc/configs/pseries_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
> index ea79c51..62e12f6 100644
> --- a/arch/powerpc/configs/pseries_defconfig
> +++ b/arch/powerpc/configs/pseries_defconfig
> @@ -217,6 +217,7 @@ CONFIG_USB_MON=m
>  CONFIG_USB_EHCI_HCD=y
>  # CONFIG_USB_EHCI_HCD_PPC_OF is not set
>  CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_STORAGE=m
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=m
> --
> 1.8.3.1
>
