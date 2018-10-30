Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A53C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 12:40:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99BF20827
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 12:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99BF20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42krf344MSzF1Pl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 23:40:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42krYd5cRZzDrTy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 23:36:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42krYb3vfqz9s89;
 Tue, 30 Oct 2018 23:36:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: replace cc-name test with CONFIG_CC_IS_CLANG
In-Reply-To: <1540873293-29817-1-git-send-email-yamada.masahiro@socionext.com>
References: <1540873293-29817-1-git-send-email-yamada.masahiro@socionext.com>
Date: Tue, 30 Oct 2018 23:36:17 +1100
Message-ID: <877ehzk3we.fsf@concordia.ellerman.id.au>
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
Cc: linux-mips@linux-mips.org, Michal Marek <michal.lkml@markovi.net>,
 James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 17be664..338e827 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -96,7 +96,7 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
>  aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
>  endif
>  
> -ifneq ($(cc-name),clang)
> +ifneq ($(CONFIG_CC_IS_CLANG),y)
>    cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mno-strict-align
>  endif
>  
> @@ -175,7 +175,7 @@ endif
>  # Work around gcc code-gen bugs with -pg / -fno-omit-frame-pointer in gcc <= 4.8
>  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
>  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
> -ifneq ($(cc-name),clang)
> +ifneq ($(CONFIG_CC_IS_CLANG),y)
>  CC_FLAGS_FTRACE	+= $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
>  endif
>  endif

Does this behave like other CONFIG variables, ie. it will not be defined
when it's false?

And if so can't we use ifdef/ifndef? eg:

ifndef CONFIG_CC_IS_CLANG
  CC_FLAGS_FTRACE	+= $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)

That reads cleaner to me.

Still this patch is fine as is:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
