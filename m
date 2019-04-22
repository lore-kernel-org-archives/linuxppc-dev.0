Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E04FC10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 10:16:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7370C206A3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 10:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="sWma/h1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7370C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44njCp1fBjzDqRS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 20:16:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=alien8.de
 (client-ip=5.9.137.197; helo=mail.skyhub.de; envelope-from=bp@alien8.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=alien8.de header.i=@alien8.de header.b="sWma/h1F"; 
 dkim-atps=neutral
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nj9m74zkzDqMM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 20:14:32 +1000 (AEST)
Received: from zn.tnic (p200300EC2F07AE00CC11E6C5A9980264.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f07:ae00:cc11:e6c5:a998:264])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1EAA81EC082D;
 Mon, 22 Apr 2019 12:14:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1555928067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=sz3E4pgdldPIX/SlGCWVkujUtXQ0huwXgSgApTywR/Y=;
 b=sWma/h1F7e6UVTopq1w9LG7G7cMAoJT6cxRkYHGw5ZeuYoWcR9kGCDOMy+Tr9msUZrPVG7
 Vt5CfoFUZ0DRtijdvo/zaa4UO/AJpqKXbGr/zO1vduQxWjlxU0EhyVukdEEPoCe8QyUhO5
 goRUd3FSGJHbd34nC/yvDhfNBJAZq14=
Date: Mon, 22 Apr 2019 12:14:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 11/11] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
Message-ID: <20190422101420.GA21457@zn.tnic>
References: <20190419094754.24667-1-yamada.masahiro@socionext.com>
 <20190419094754.24667-12-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190419094754.24667-12-yamada.masahiro@socionext.com>
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
 Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-mtd@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 19, 2019 at 06:47:54PM +0900, Masahiro Yamada wrote:
> Commit 60a3cdd06394 ("x86: add optimized inlining") introduced
> CONFIG_OPTIMIZE_INLINING, but it has been available only for x86.
> 
> The idea is obviously arch-agnostic. This commit moves the config
> entry from arch/x86/Kconfig.debug to lib/Kconfig.debug so that all
> architectures can benefit from it.
> 
> This can make a huge difference in kernel image size especially when
> CONFIG_OPTIMIZE_FOR_SIZE is enabled.
> 
> For example, I got 3.5% smaller arm64 kernel for v5.1-rc1.
> 
>   dec       file
>   18983424  arch/arm64/boot/Image.before
>   18321920  arch/arm64/boot/Image.after
> 
> This also slightly improves the "Kernel hacking" Kconfig menu as
> e61aca5158a8 ("Merge branch 'kconfig-diet' from Dave Hansen') suggested;
> this config option would be a good fit in the "compiler option" menu.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - split into a separate patch
> 
>  arch/x86/Kconfig               |  3 ---
>  arch/x86/Kconfig.debug         | 14 --------------
>  include/linux/compiler_types.h |  3 +--
>  lib/Kconfig.debug              | 14 ++++++++++++++
>  4 files changed, 15 insertions(+), 19 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
