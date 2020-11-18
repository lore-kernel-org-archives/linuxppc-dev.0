Return-Path: <SRS0=sQnj=EY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDE2C2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 00:27:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E802223D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 00:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUG0beWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E802223D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CbNsz4BkwzDqcx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 11:27:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b42;
 helo=mail-yb1-xb42.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=VUG0beWy; dkim-atps=neutral
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CbNqc2FW2zDqYS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2020 11:24:59 +1100 (AEDT)
Received: by mail-yb1-xb42.google.com with SMTP id 10so20693040ybx.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2020 16:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0huT1R6YxHvGQqjy0+YuKw2JldEAQJIjUv13qFD6dSE=;
 b=VUG0beWyUt8t9AI5oq/YFRQwecBElOINxFbPhyy/8GofdinFclo6zu1uIepaA67qsR
 Xdu5eTDwkSe5uUpSlKtgjK0VyUtV39YYZYRjJPR/Ziqj4fulhWJpDjOZbeX6TQzmeskI
 ZftGi1itFwsOncl+z7StJOtEbHfLX8dmPt8eYyM7NemrIloKmnKydQskGZPWKLInSCRR
 vCUSnjBQOKXtUZtdVrHnYHv2ViwsBR8FWZPBeYlvygsge5OiIzAPlV9r9qhHWGPDqO7e
 oOh8ad6TuwqklUzBXAwSkO15r5Mj6PecgJc0P2X+ckwTZOKQve3wW/tM/dbsi/VpsRhh
 zZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0huT1R6YxHvGQqjy0+YuKw2JldEAQJIjUv13qFD6dSE=;
 b=ebJzwAccRZwzE5O8qKWfzEIewFeCnfIVxe5PJKuSfh0zjxqy9e91hs+pPjrbHahFcb
 x1imzTIXTvVBiGLAb8/UJG0dIcBS738+sBSXkZhcnay8a6R7YAcLx+3QSzTqeSupRkcq
 O/DFHTuoESCWuBVsEGXk5/ulL4VfrOMGtJSxqn7/QqFmMomvONCiYZTOOe2pqq2Z2O0L
 5qKB3DB80EhUG9+97CnhUEqkgDvf1LyFel+VNWIqU50XtzZF6/77rcAbFqZ8zcU4+X/k
 08SwZIyL+EKN5qd/ISRz5nu2f4gahiJP4v+mqA0R5MvEssVMIJFM+/FBsDzEzCpjPmGh
 E6RA==
X-Gm-Message-State: AOAM533CwHlQd8ZRdXBL1imcGjQdZSdrkE/sz7ifM9oeBtrAisxot+/G
 LfjRzKVmNn120eX9CL5KEZ4tK4cIgbSZT/UTt3g=
X-Google-Smtp-Source: ABdhPJyrWC2hnz0a+YpjEc/pPbGRaoxoIvPVC89x34vc5rx9dRHAKUY+BD84V8Qa6YI/dCAH4D7960lOGz/NIsdgZDw=
X-Received: by 2002:a25:61c5:: with SMTP id v188mr3618112ybb.422.1605659094582; 
 Tue, 17 Nov 2020 16:24:54 -0800 (PST)
MIME-Version: 1.0
References: <20201118000751.845172-1-ndesaulniers@google.com>
 <20201118000751.845172-2-ndesaulniers@google.com>
In-Reply-To: <20201118000751.845172-2-ndesaulniers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Nov 2020 01:24:43 +0100
Message-ID: <CANiq72=jEx5o_m72WoeRq9r74YGtedK4AE=4b=j2zS6M60ESaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] powerpc: boot: include compiler_attributes.h
To: Nick Desaulniers <ndesaulniers@google.com>, 
 "Gustavo A . R . Silva" <gustavoars@kernel.org>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Arvind Sankar <nivedita@alum.mit.edu>, Paul Mackerras <paulus@samba.org>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 18, 2020 at 1:08 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> It was also noted in 6a9dc5fd6170 that we could -D__KERNEL__ and
> -include compiler_types.h like the main kernel does, though testing that
> produces a whole sea of warnings to cleanup.

(Re; for Gustavo to consider since he took it now): I would add a
comment noting this as a reminder -- it also helps to entice a
cleanup.

Cheers,
Miguel
