Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEDFC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 13:23:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DC2217D7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 13:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBVI3mxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DC2217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lKYm5kxTzDqSB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 23:23:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=mingo.kernel.org@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="OBVI3mxB"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lKVf2jN4zDqQH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 23:20:54 +1000 (AEST)
Received: by mail-wr1-x444.google.com with SMTP id t17so2923620wrw.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 06:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XQCHoAAFT5Z9bDRSYOBbJEBinvShFFVBSkUMOBYi/Tc=;
 b=OBVI3mxBq7hJJ7GMq63UZAs5eDSNSQHVMQhmsRcAzOUlEvQybBl1shmYvk0PdKKK5/
 0AT3aJ9peUWu6DDE2+uo/dmc7PEUAwXzlwkLRi6iJQAHlOzIPupYPzVxLR6BgJ1aoE8/
 PaA7Uf6uU6WdoZEbRyIT6Bl8wnNCRk7UlthLWf1af5Bs/hdbglOXeyfrugNoRNZbu+ve
 K6oedra3Ss9p/ADCD3fv4vNKJ1x2sNjXk8UGfrCFuaZT7pQkl/USfphp6YQaSoQn1qZZ
 OJjlYQjkhJvXBlSdRxhmEm7YT/CUd/7rFK/KQcjGeGoFbZTeIJoWsQ6fLUy7H1fnUd8s
 b6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=XQCHoAAFT5Z9bDRSYOBbJEBinvShFFVBSkUMOBYi/Tc=;
 b=JDGr6a0r1qausaksWl0Qw5RAj1RwZfFvyxlCIzhMJBau33s4gRyDZGdenn/LffVYue
 T5siNf973Lk2+bZNCyC2sOJLlEzQ/hIptzvNDy9RnwbMU+xdWSVVCMrSZY5d8v8S8QbL
 8WjKkC8rUHldBDGxW4xpmWXIPl8SyNSGzhZT5jjMTkdUHOvxGRiWA7/H49g5ZKytS0Wx
 HuurD5GYGe9i4ZiVk12Hosigfehf+k23ByUEhY1IEhUIe9oAAlwyAhmou0yeVjCK2uFO
 r49x75xyR5w0y9jMzaqQLKTVsx/85NkeMosdQYr/lOZiqcBc10/zMVLfgrBqQ4NLYdP/
 vCtQ==
X-Gm-Message-State: APjAAAWj0PVBbjc6A5R1GNJ5f9uRPSaN9w4HcsPcWfLo7cOF3ddePB1M
 yGpOhEbBk1chgAqTG/+LpOA=
X-Google-Smtp-Source: APXvYqzJ/ySJ+z0VjPKhlTQyMQFU1iuU9BCAPDw4iU0TqindWFDaAlZ0lD4Q/VA3V2aWhbWS1mn+aA==
X-Received: by 2002:a05:6000:1111:: with SMTP id
 z17mr282634wrw.103.1555593650693; 
 Thu, 18 Apr 2019 06:20:50 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id r18sm3417736wme.18.2019.04.18.06.20.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 18 Apr 2019 06:20:49 -0700 (PDT)
Date: Thu, 18 Apr 2019 15:20:47 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
Message-ID: <20190418132047.GA21430@gmail.com>
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 Dave Hansen <dave@sr71.net>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>,
 linux-mtd@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Commit 60a3cdd06394 ("x86: add optimized inlining") introduced
> CONFIG_OPTIMIZE_INLINING, but it has been available only for x86.
> 
> The idea is obviously arch-agnostic although we need some code fixups.
> This commit moves the config entry from arch/x86/Kconfig.debug to
> lib/Kconfig.debug so that all architectures (except MIPS for now) can
> benefit from it.
> 
> At this moment, I added "depends on !MIPS" because fixing 0day bot reports
> for MIPS was complex to me.
> 
> I tested this patch on my arm/arm64 boards.
> 
> This can make a huge difference in kernel image size especially when
> CONFIG_OPTIMIZE_FOR_SIZE is enabled.
> 
> For example, I got 3.5% smaller arm64 kernel image for v5.1-rc1.
> 
>   dec       file
>   18983424  arch/arm64/boot/Image.before
>   18321920  arch/arm64/boot/Image.after
> 
> This also slightly improves the "Kernel hacking" Kconfig menu.
> Commit e61aca5158a8 ("Merge branch 'kconfig-diet' from Dave Hansen')
> mentioned this config option would be a good fit in the "compiler option"
> menu. I did so.

No objections against moving it from x86 code to generic code.

Thanks,

	Ingo
