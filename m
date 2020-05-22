Return-Path: <SRS0=CBJl=7E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD8BC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 21:56:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071D12067B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 21:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071D12067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49TL1C44mGzDr3M
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2020 07:56:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.166.67; helo=mail-io1-f67.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49TKzB5fWTzDqwM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2020 07:54:59 +1000 (AEST)
Received: by mail-io1-f67.google.com with SMTP id f4so12976329iov.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2020 14:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n091YDxaErv8oWkQMHbQBobP632/VWNstnpimxg6/X8=;
 b=VtYK/67TefVW83FCn2CpTARw+JCSaavmtBFjiYWxZo2C/QcdgbjquytRYzT6sgA9nu
 z1a97HM2ndRsJAjRCjISklfc2cG1vcggSpMYLxi1vDF6ALf3PImpd/4ZgOwOn5Ia+sLJ
 ImolBX6ippcu7P7wsn/2HqfH7pAFSw5gu+3siInkM95z/rlejW9Tm+7JirZHungFwISQ
 DcPqYoa8JDkWc9mGtAj174+nOvSOCqtY3hZzUBH6kDlT0M+NvjjjNGUR/GMTlyCNzvQq
 S6OFWDlDalLS7EgwudeEaZY0J1+VxbGwFaP7bHKFMnLKoNIZnTevRy6w7xe8tgyzVs4N
 nTrA==
X-Gm-Message-State: AOAM533AlM3F+OlW7XNt/auMupwWTU5RvkDCMiiRYdwPxbYf8AeamvjK
 9JLZfx5E0oijialuoF8BBbiC1J8Hx0k=
X-Google-Smtp-Source: ABdhPJzezm4TcCi8azHdAbM6TUjwqSie2khe3PrcgPIiG4J86i/b0ZOttT9h8swY1LBf5FuRvUgFVQ==
X-Received: by 2002:a5d:84d4:: with SMTP id z20mr4985875ior.36.1590184497640; 
 Fri, 22 May 2020 14:54:57 -0700 (PDT)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com.
 [209.85.166.175])
 by smtp.gmail.com with ESMTPSA id g205sm4186385iof.21.2020.05.22.14.54.56
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2020 14:54:56 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id c20so12236621ilk.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2020 14:54:56 -0700 (PDT)
X-Received: by 2002:a92:5cc1:: with SMTP id d62mr14815529ilg.95.1590184496349; 
 Fri, 22 May 2020 14:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200508140846.47608-1-yuehaibing@huawei.com>
In-Reply-To: <20200508140846.47608-1-yuehaibing@huawei.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 22 May 2020 16:54:33 -0500
X-Gmail-Original-Message-ID: <CADRPPNS2Rp=_NEH8Kst=jG7Dj+z=rm=T7Nbs5_PO8nr4w4w5EQ@mail.gmail.com>
Message-ID: <CADRPPNS2Rp=_NEH8Kst=jG7Dj+z=rm=T7Nbs5_PO8nr4w4w5EQ@mail.gmail.com>
Subject: Re: [PATCH -next] soc: fsl: qbman: Remove unused inline function
 qm_eqcr_get_ci_stashing
To: YueHaibing <yuehaibing@huawei.com>
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
Cc: Roy Pledge <roy.pledge@nxp.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 8, 2020 at 9:11 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> There's no callers in-tree anymore.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied for next.  Thanks.

Regards,
Leo
> ---
>  drivers/soc/fsl/qbman/qman.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index 1e164e03410a..9888a7061873 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -449,11 +449,6 @@ static inline int qm_eqcr_init(struct qm_portal *portal,
>         return 0;
>  }
>
> -static inline unsigned int qm_eqcr_get_ci_stashing(struct qm_portal *portal)
> -{
> -       return (qm_in(portal, QM_REG_CFG) >> 28) & 0x7;
> -}
> -
>  static inline void qm_eqcr_finish(struct qm_portal *portal)
>  {
>         struct qm_eqcr *eqcr = &portal->eqcr;
> --
> 2.17.1
>
>
