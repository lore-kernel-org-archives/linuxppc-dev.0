Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE99C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 21:17:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0454320664
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 21:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="merO8jjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0454320664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42l46M6vhszDrCQ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 08:16:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="merO8jjf";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="merO8jjf"; 
 dkim-atps=neutral
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42l4076ZWzzF1QT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 08:11:35 +1100 (AEDT)
Received: by mail-qk1-x741.google.com with SMTP id p3-v6so8240075qkb.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 14:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Geo1F+rcWiR1yH6tDsVfLVgB6tNCnOzh06qBDUj6Wpw=;
 b=merO8jjfclSY449GGyNc6gtmZYe754ISceV1K31uiUFYlIxBKsX4XOzF/ieVUOw6EC
 uyClrdDEs5K3WWkxEm7oOwwBgPEt3pGbSYH9Pb0Ok/Jdn6mjb7vMza/JdKwvoFLonvM0
 2KEZ2rzsKPpGjrDQ8uczOHylITpy9YxSp8K58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Geo1F+rcWiR1yH6tDsVfLVgB6tNCnOzh06qBDUj6Wpw=;
 b=YyIOi9tKn91Mvg2WnSRx7sxmtJ2CNGaHhmBRPVzanEe4x9g/WXmCuHH+rx4WSrnyXJ
 Mqw9CokyAyRDu+0s9gxlFz1BNz4Rw7ChWnQkmUrd6l+cElPi5j+XcYkmkNRcCM6AiCrm
 4CcA2iDHDnILyVPgwIuvbZxC8rqdrY3XK4D9Ib5PdOFt1WhruSW8YJx7McmuE/cXefor
 r0RZX+3G4Z0C6LqwTV5l9daD6v4lsQSGX/aL5UAk72NWDWofaR1jOloEfBOiAPgV0pjg
 riEUm3CuEBbe4ySvoxLwYcz8MKUJ0lRlJrqlVdql+VaXfHWo151HNHcXVK522H4CW7/W
 jW9Q==
X-Gm-Message-State: AGRZ1gLg06Gq4lsHzJ5zeV7hXFUcvCXTSljgNbikbdX8eQqMPztLguZj
 4cGAVOiFLP0PeuOutvkM0TtlRwj9oTfsGuIUDOk=
X-Google-Smtp-Source: AJdET5fq9zBHJ2GMvSSou9qc8qDiQ88IpkB04UUhK5+9PcLbHPJxQrdFkeqWWLTSVgzxPmVRDzWsFfWLZfpY/nwV/rU=
X-Received: by 2002:ae9:ef8a:: with SMTP id d132mr306114qkg.11.1540933893205; 
 Tue, 30 Oct 2018 14:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <1540905994-6073-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1540905994-6073-1-git-send-email-yamada.masahiro@socionext.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 31 Oct 2018 07:41:21 +1030
Message-ID: <CACPK8Xf4+M9Q1zC5GBC0PBJBZnim14m_s5HoQJQOn5Dc-uCDag@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: replace cc-name test with
 CONFIG_CC_IS_CLANG
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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
Cc: linux-mips@linux-mips.org, Michal Marek <michal.lkml@markovi.net>,
 linux-kbuild@vger.kernel.org, jhogan@kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ralf@linux-mips.org,
 paul.burton@mips.com, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 30 Oct 2018 at 23:58, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Evaluating cc-name invokes the compiler every time even when you are
> not compiling anything, like 'make help'. This is not efficient.
>
> The compiler type has been already detected in the Kconfig stage.
> Use CONFIG_CC_IS_CLANG, instead.

Thanks, I didn't know about this.

>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
