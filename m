Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA673C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:45:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE3420850
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE3420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4399jm0F3NzDqVf
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:45:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4399fk19DSzDqvD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 07:43:09 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id e12so19974355otl.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 12:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WtfdFOrHLEdBRRSKnZ3mtxk3yR28RHuLiNsARcqEx70=;
 b=MB8yCIvlqoUvO+3E7XDOv1vIHlGzIp5hS62qeXqTy/Bacrv9LKPU8EEtNwml/MM7gc
 +/LJiyUIJXcSRbedynIr0C5A/Pon10thjMgt6yYwZf8K9vIPYBS32vq7EcGhwipGVJK5
 OR09hXwyTIMQyhVEBuO1SHpIJ+o6EO5LOUyrSx60Qj7wrE751mQ7BhctD+8ELP+fBitH
 8FHT9wjxR3gmaVzLcv+Wzwy2l+YzarFFU21Z0BJbnmMrr0tDAnwhxXBOY1WZfQVZX2wv
 8b68XkFD10XEdfCu9hCHi6MhUi2sU6JEs9FaDvJOtKxSj4eB3RguaXOg9AlRSDnerSH4
 r6UA==
X-Gm-Message-State: AA+aEWZHPa5BHcgGAbNwLJagN6CvBKKwj/qfAkP+hWonxUS3fNQpL1Od
 JjaxKEUIc7Feyxfv+s5yPdxYeHl4deE=
X-Google-Smtp-Source: AFSGD/WiE4ACxJLBZpDzdXZQem8+jgaSrInkEfdnzUGcg2H6p2FUJpM9lki52o3c0sutUq2yQTiqeg==
X-Received: by 2002:a9d:bf7:: with SMTP id 110mr16980381oth.201.1544042587682; 
 Wed, 05 Dec 2018 12:43:07 -0800 (PST)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com.
 [209.85.167.171])
 by smtp.gmail.com with ESMTPSA id t21sm8504187otq.67.2018.12.05.12.43.06
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 12:43:07 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id x202so18732562oif.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Dec 2018 12:43:06 -0800 (PST)
X-Received: by 2002:aca:654a:: with SMTP id j10mr15212756oiw.301.1544042586603; 
 Wed, 05 Dec 2018 12:43:06 -0800 (PST)
MIME-Version: 1.0
References: <1543741258-17433-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1543741258-17433-1-git-send-email-hofrat@osadl.org>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 5 Dec 2018 14:42:55 -0600
X-Gmail-Original-Message-ID: <CADRPPNSZ18XhgojYgw-KJHHCS=7XnGa_6rYvXw8E0_UUwb+p7Q@mail.gmail.com>
Message-ID: <CADRPPNSZ18XhgojYgw-KJHHCS=7XnGa_6rYvXw8E0_UUwb+p7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] soc: fsl: guts: handle devm_kstrdup() failure
To: hofrat@osadl.org
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Dec 2, 2018 at 3:07 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> devm_kstrdup() may return NULL if internal allocation failed.
> soc_dev_attr.machine  should be checked (although its only use
> in pr_info() would be safe even with a NULL). Therefor
> in the unlikely case of allocation failure, fsl_guts_probe() returns
> -ENOMEM as this allocating failing is an indication of something
> more serious going wrong at system level.
>
> As  machine  is from the device tree which I assume to be RO - if
> that assumption is always correct - a better alternative would be
> to use devm_kstrdup_const() here. That would then simply copy the
> reference to the RO data and not perform any allocation at all.

I think your assumption is correct.  Do you want to send a new and
better version?  :)

>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: a6fc3b698130 ("soc: fsl: add GUTS driver for QorIQ platforms")
> ---
>
> Problem located by experimental coccinelle script
>
> Patch was compile tested with: multi_v7_defconfig (implies FSL_GUTS=y)
>
> Patch is against 4.20-rc4 (localversion-next is next-20181130)
>
>  drivers/soc/fsl/guts.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 302e0c8..a0c751b 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -156,8 +156,11 @@ static int fsl_guts_probe(struct platform_device *pdev)
>         if (of_property_read_string(root, "model", &machine))
>                 of_property_read_string_index(root, "compatible", 0, &machine);
>         of_node_put(root);
> -       if (machine)
> +       if (machine) {
>                 soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
> +               if (!soc_dev_attr.machine)
> +                       return -ENOMEM;
> +       }
>
>         svr = fsl_guts_get_svr();
>         soc_die = fsl_soc_die_match(svr, fsl_soc_die);
> --
> 2.1.4
>
