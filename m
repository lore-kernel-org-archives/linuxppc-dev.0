Return-Path: <SRS0=L4jv=EW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FE8C4742C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 11:38:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0AA221F8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 11:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHsS+MRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0AA221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CZRs33n0xzDqG0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2020 22:37:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b41;
 helo=mail-yb1-xb41.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=XHsS+MRq; dkim-atps=neutral
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CZRlc1SkyzDqDc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2020 22:33:15 +1100 (AEDT)
Received: by mail-yb1-xb41.google.com with SMTP id g15so15339650ybq.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2020 03:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NGE/8zZSbrMYM1BfuDIYlYWu/KQaD7nuUUEC61XDj5g=;
 b=XHsS+MRqQF7/ddTQTacN4pm7PHH4Krd4KnI7MEHyyNDvd1NVVU39XWuGhqPjBt/FhR
 CGJ6lq2+B20s2uW+B/mC6jj1mqFVaddyiyzNVA7ZOgFHQ1FU+gULjDPkgqeQeIJ9ZQ8K
 gN8O1i6/InM4D/QpNBM+t0f1WsmTLUMD2mbVeeUV7dx9jySxYSw6OSam7ueewWWyj/ud
 kHwkl83D9HFWayss20Adjwg+RKCJY1zC2opGqdbaxgWBeUNdZ1QPZvJvFUwZvGaCjVRa
 dk8SvNYYmajFok3avNPpcPvJbFwPBGcM8LjIhsoWZeIbIbud8esTTfUyN5dFLRfkuAIz
 hzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NGE/8zZSbrMYM1BfuDIYlYWu/KQaD7nuUUEC61XDj5g=;
 b=JqPXVogkJ2cvoWbLasQNItfsactlxFmxYhrOBRUHNqmp37XHkDHhWrzZybYxqMpmM9
 a7BKIN1RGHX+w7ySfXC8TdkvWA1Wjz417t+DQpgjT6vSyrJ4hxt8zhQAD+DPkYdHL4C/
 B0s6aT3cVPtudOAt0mVTsGmopn0gb5y2xxUJdu9dX+22tSlqUqCx2bd9kjXsW1d8nNl2
 JdXw3QRkGW9nqkzMlL11fExBqAleNIrmqIm0cmG71oW0u5sTprRQ0BRoyuzsEfXYdb1g
 IHImqf85OKFCmxwdiEP3rU9dGqnNXTWIbATktm3z4/VGlzmE4WMWTYkMuhZzvlh5ZpwS
 867A==
X-Gm-Message-State: AOAM532zof3GItwmhLZZsHT3Pyul1/UE5d0S0mKn/irveSNVcTbcUits
 oJxqkEFXZNnxeqpg8Jq138BFh05lg+EYrV7Pbm4=
X-Google-Smtp-Source: ABdhPJyi8dQ0hwCdbQgZlwbfhe98B1Ei/rMrpJkSgiik4CIVzXdGxmHNcANXDVSHrI0ev71EzKrRfRyA3NHmZKCzDi4=
X-Received: by 2002:a25:2e0d:: with SMTP id u13mr11676325ybu.247.1605526391609; 
 Mon, 16 Nov 2020 03:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20201116043532.4032932-1-ndesaulniers@google.com>
 <20201116043532.4032932-4-ndesaulniers@google.com>
In-Reply-To: <20201116043532.4032932-4-ndesaulniers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 16 Nov 2020 12:33:00 +0100
Message-ID: <CANiq72=nTM9enY2pTm8aoR8grPiiODCif5d7DDnOLkivaY2fsg@mail.gmail.com>
Subject: Re: [PATCH 3/3] powerpc: fix -Wimplicit-fallthrough
To: Nick Desaulniers <ndesaulniers@google.com>
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
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Paul Mackerras <paulus@samba.org>,
 Nathan Chancellor <natechancellor@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 16, 2020 at 5:35 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> The "fallthrough" pseudo-keyword was added as a portable way to denote
> intentional fallthrough. Clang will still warn on cases where there is a
> fallthrough to an immediate break. Add explicit breaks for those cases.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/236
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

It makes things clearer having a `break` added, so I like that warning.

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
