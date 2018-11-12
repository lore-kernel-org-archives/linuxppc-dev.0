Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB0DC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 03:04:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E3A208A3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 03:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsVqv87D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E3A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tbFH4nK9zF1pY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 14:04:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EsVqv87D";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=mingo.kernel.org@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="EsVqv87D"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tbBc2RjczF35K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 14:01:41 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id b13so7614507wrx.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 19:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=L3kQxmTjk6MTKkX1IlspIEH2m0wUz6jvpIqfoir3s/M=;
 b=EsVqv87DO1yLpbZKf24AfI6aZwswyBibHj2+7AVj3zSWvH3Ysuz8NxsoxhD/8tuUeW
 PkB9GK5yJWETg8Nww20f9qp0nw4QZGQsdvqMSOK+KRPO/eNYLjxccpbejwoREEah9BAb
 OBfw2QyD8RdxqR8COib/vjl6skeh2uBwLq1SkHWd0LW2Xjy8AaqnkOLaYDBxRV6yXl2A
 hwUfUB0DPGYF4g6ZNATI/07m/kEwPW1dGWcxGFYB38vx7suoO378vL0q2BTMF9kkYKKs
 dELtp0VZWhL2PoYICbGkgBPQkeoKOLvl135UCb6PAS0rvj8gzWQ+OsO9AEg9Lj9mLThc
 FAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=L3kQxmTjk6MTKkX1IlspIEH2m0wUz6jvpIqfoir3s/M=;
 b=gXMAlSQPXf+yNX6XV40Umlxpmu5cUkE3uNMatmJu4ZGBaCzQhmx36AiwfipHQxBc5C
 SSFbHnwT5vv22IsGdLOBhjnb6qJP3Dj8aDgmy5bNm1OOBAENbGJbZjmsqn8OnS2mr8dE
 I06bXi5pqDT7Pzbu8Yleu4Terw3LRXNDER0c4RUFCXT/9I0iv+t8IMw2kA4DTtLZppE6
 88kszh/S16GwFfeE60KZT9unn+Q+t6rrK4B7egzScqosN944RGh+Mkeir4INtUBrTqXY
 pf3boaPd3/a0rfaGLcyrEV04An6S3JN6zVW/6DR31k/qk7n2V9x0GbgpTDar0++JxKYw
 ToKw==
X-Gm-Message-State: AGRZ1gI4EmzfIiMEL70vr+QHdmFDkq1Qa3kmmOC4RMGJDgfpf4FCq9QM
 42EL4hszdVs7TElYh3PcLDc=
X-Google-Smtp-Source: AJdET5dGTfhXafaxyeMGnVIsWWNWFNko16IRBA/4D/NtegVWG4sjScnVlw9ZyMDj/tBU9vYWwFEe7g==
X-Received: by 2002:adf:c90e:: with SMTP id
 m14-v6mr15869007wrh.6.1541991697649; 
 Sun, 11 Nov 2018 19:01:37 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id v10-v6sm24139995wrq.4.2018.11.11.19.01.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 11 Nov 2018 19:01:36 -0800 (PST)
Date: Mon, 12 Nov 2018 04:01:34 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 2/2] x86, powerpc: remove -funit-at-a-time compiler
 option entirely
Message-ID: <20181112030134.GA39035@gmail.com>
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
 <1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Richard Weinberger <richard@sigma-star.at>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> GCC 4.6 manual says:
> 
> -funit-at-a-time
>   This option is left for compatibility reasons. -funit-at-a-time has
>   no effect, while -fno-unit-at-a-time implies -fno-toplevel-reorder
>   and -fno-section-anchors.
>   Enabled by default.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/powerpc/Makefile | 4 ----
>  arch/x86/Makefile     | 4 ----
>  arch/x86/Makefile.um  | 5 -----
>  3 files changed, 13 deletions(-)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 88398fd..3508049 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -130,10 +130,6 @@ else
>  
>          KBUILD_CFLAGS += -mno-red-zone
>          KBUILD_CFLAGS += -mcmodel=kernel
> -
> -        # -funit-at-a-time shrinks the kernel .text considerably
> -        # unfortunately it makes reading oopses harder.
> -        KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
>  endif
>  
>  ifdef CONFIG_X86_X32
> diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
> index 577976b..1db7913 100644
> --- a/arch/x86/Makefile.um
> +++ b/arch/x86/Makefile.um
> @@ -26,9 +26,6 @@ cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
>  # an unresolved reference.
>  cflags-y += -ffreestanding
>  
> -# gcc 4.3.0 needs -funit-at-a-time for extern inline functions.
> -KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
> -
>  KBUILD_CFLAGS += $(cflags-y)
>  
>  else
> @@ -50,6 +47,4 @@ ELF_FORMAT := elf64-x86-64
>  LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
>  LINK-y += -m64
>  
> -# Do unit-at-a-time unconditionally on x86_64, following the host
> -KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
>  endif

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
