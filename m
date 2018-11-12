Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC50AC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 11:25:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D5A22419
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 11:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D5A22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tpND3cCrzF3XW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 22:25:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tpJp38hNzF3CZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 22:22:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42tpJl6h4rz9s1x;
 Mon, 12 Nov 2018 22:22:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org
Subject: Re: [PATCH 2/2] x86,
 powerpc: remove -funit-at-a-time compiler option entirely
In-Reply-To: <1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com>
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
 <1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com>
Date: Mon, 12 Nov 2018 22:22:46 +1100
Message-ID: <87k1lia6bd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Paul Mackerras <paulus@samba.org>, Richard Weinberger <richard@sigma-star.at>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

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
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 8a2ce14..854199c 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -228,10 +228,6 @@ KBUILD_CFLAGS += $(call cc-option,-mno-vsx)
>  KBUILD_CFLAGS += $(call cc-option,-mno-spe)
>  KBUILD_CFLAGS += $(call cc-option,-mspe=no)
>  
> -# Enable unit-at-a-time mode when possible. It shrinks the
> -# kernel considerably.
> -KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
> -

Thanks for cleaning it up.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
