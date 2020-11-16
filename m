Return-Path: <SRS0=L4jv=EW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFA0C5519F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 11:22:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4049520853
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 11:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmuBOgJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4049520853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZRWP3cGFzDqCM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 22:22:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b2d;
 helo=mail-yb1-xb2d.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=hmuBOgJM; dkim-atps=neutral
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CZRR51jWpzDqDG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2020 22:18:53 +1100 (AEDT)
Received: by mail-yb1-xb2d.google.com with SMTP id l14so11182244ybq.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2020 03:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MD9xHbpoBxI28g0y3d7aQhsOLegTugTpd8AuiJspFNs=;
 b=hmuBOgJMpbiQxGBqnGrXSn0SRmC2e/BrQz+KtWufgEXRLOpLsa1gEzPF3ryhKN3DFx
 OLb/bG4g63OMg5Z+G1vFMNjqsjuTvWF1v5n3OZ+TVC9b2R9W+ZvjzLY4nt0GD2fJRc8Q
 XMj3vIjuYhu77GI2PDZXJVmO3okeiRm+zBjp60MRe7Q86qDO6sMflPnA9wZ4nW+3ew1N
 5RuJzfHJ7SeCliEWT+dPFVqMWejHZ7DEHBtVMLtfHwEfSS71gOno3GE4zrjAzcnmWm8t
 n7U/u+EcrrANh36tYYcfQYHY84YmL1Vgx8QrVXOwE808k9O62urPXN4RjPtrBIwxSBHg
 lh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MD9xHbpoBxI28g0y3d7aQhsOLegTugTpd8AuiJspFNs=;
 b=X/hzNlagXRh2rUpgG+yUs1LjP0ec6KfHh0uFFvkPT5sxq7D6WrOMaH6PYjWal22Vxv
 KssNnedAVw2z6qyrcsw/yfjanFSbqdmceCSFZpJCb3a55Qsh2XBsdybQAA9ugbEJwC7U
 7rYjl9VlxofRCu5sP55J8DTAsADbGUU30jKl5efIXsiiE9xOa7DGf39GzPqKAecnE7Pu
 CSXUunQDRj75B5oZmAgnF9CwmLhk/0q+CZhPGZ3GbPU9fn4Ju6ST6tNBoMXHndXRc4Yx
 7lsm3OxOKl6nRD7WXCNt9x5tcJFIPw2qNHI1CgJ7sbnwv918ngiUSX0uMWuQwTdeytFF
 Ozwg==
X-Gm-Message-State: AOAM53133ynyDTufAQwKlsk7T4TKk+wZjN9y9X4fDLHPL/EVA1DQbZiY
 L/wNjwQ4sFAD4RCUKkbYqtrsGlsoTluLTuk8E3Q=
X-Google-Smtp-Source: ABdhPJzuUvalT4x4fTA5gvfWQI1Nk/liV9/MbNuQHoZJj5e5bfz8uHuoywkSfsj71fb1fzdtohQMNxW0KOe/fNhPR/0=
X-Received: by 2002:a25:5f0f:: with SMTP id t15mr16854532ybb.26.1605525529784; 
 Mon, 16 Nov 2020 03:18:49 -0800 (PST)
MIME-Version: 1.0
References: <20201116043532.4032932-1-ndesaulniers@google.com>
 <20201116043532.4032932-3-ndesaulniers@google.com>
 <20201116062639.GB7265@embeddedor>
In-Reply-To: <20201116062639.GB7265@embeddedor>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 16 Nov 2020 12:18:38 +0100
Message-ID: <CANiq72k=m1=vVaO4bfqGoLReQzQ9ywpyXF=-M6vbw3XzRe_0fQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Revert "lib: Revert use of fallthrough pseudo-keyword
 in lib/"
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Paul Mackerras <paulus@samba.org>,
 Nathan Chancellor <natechancellor@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 16, 2020 at 7:26 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.com>

.org :-)

Cheers,
Miguel
