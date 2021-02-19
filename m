Return-Path: <SRS0=ha2k=HV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38818C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Feb 2021 02:55:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8247164ECD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Feb 2021 02:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8247164ECD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dhbmg5Y6gz30NY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Feb 2021 13:55:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=T9m4M0v6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::835;
 helo=mail-qt1-x835.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=T9m4M0v6; dkim-atps=neutral
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DhbmB5hsQz30HM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2021 13:55:21 +1100 (AEDT)
Received: by mail-qt1-x835.google.com with SMTP id o30so2691397qtd.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2021 18:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SXsmOxSrWmXM0bUxFvRmWQLOnN33ooEOiTdg5Q4odMY=;
 b=T9m4M0v6mgpazSKltohLQcr/rW2NVMDggJ9g7GjsFF5db/b/UD8GTSpkyyiUTiYHFx
 294r5LAPbTZq+k5w2AzHMYawZNdI5UNoCHjqQW8megt0Tgf5wJCkMZUPUwVM3T9uaMGx
 DtI3QmKYKSwNJd352lPSW977nrZ2/+dorI+oqXKNaptw8XyAPC6HH76AFNX2HPTCDhXs
 ISPjUsKmFmutcOAW7lLwuyTNVY29gw48KKcIDz5knGxq/KqmnNQrV1OPRQOJXHW5lIL2
 ueN7CATQXXhsPk5lmwrIN8c26laAoBrvMjoNh7onl9BDiH9JXMUaS00AlheL6dBowevE
 nl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SXsmOxSrWmXM0bUxFvRmWQLOnN33ooEOiTdg5Q4odMY=;
 b=He2DMJ8sAht/d8tU3Du3Df2KfI4R+1YEAxV+1CL5qN0AGPeABu/hwZ1z1zrvRw9ggK
 XnqDd30588jSQ4RCrpQVoyTxvlOCby4gQv6/xVH1avznhWw6tMSdTaA1aSyeq+YKwThI
 r4/Pp3PdO2F6XTikBkmprEwUzAQjR46yTFwEdxEyeyJWB0i0TJUVORsKQYe5aeFQvm/+
 xxj0Oh5RbHjVSq2VmimTaes1oQMPN7cPAMA13/vNxuPVhnNjZu7k0Lk9qDX437xRTCIN
 +dlY1QJykJCKHhBdNPC5P0jRCnFbG55EXzpBrE17eBSxHg3+mKC+sZuV6z6H+IwhUjR9
 WdOw==
X-Gm-Message-State: AOAM530/gDXCRPZwAsBpiUU6JWD/YqG/TmjMdkN7bcz4/k42IaQteKsU
 rQgqvtl/6DU2brMMWtILpdhK6x7TGXaeRpYxgo4=
X-Google-Smtp-Source: ABdhPJxnUPVrdQEXZoI7sU2dVS1zAsmq96FAtT1sSw/T4+c3+v+d1GNYLgBwSnlkydQR6I+VIEWLFIKtHhXMcLeaJ2A=
X-Received: by 2002:ac8:6f06:: with SMTP id g6mr7127305qtv.360.1613703318340; 
 Thu, 18 Feb 2021 18:55:18 -0800 (PST)
MIME-Version: 1.0
References: <1612756287-4601-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1612756287-4601-1-git-send-email-tiantao6@hisilicon.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 19 Feb 2021 10:55:07 +0800
Message-ID: <CAA+D8AOcKx0k355DhV5jYGhLAoQyG31u+ezz0zDqZQnJHKj84Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: imx-hdmi: no need to set .owner when using
 module_platform_driver
To: Tian Tao <tiantao6@hisilicon.com>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 s.hauer@pengutronix.de, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 11, 2021 at 5:21 PM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> the module_platform_driver will call platform_driver_register.
> and It will set the .owner to THIS_MODULE
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
