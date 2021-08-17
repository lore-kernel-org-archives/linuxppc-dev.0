Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46893C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 02:32:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D4B60C3F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 02:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89D4B60C3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GpZnL1Jt5z3bPV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 12:32:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=QafEecHq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=QafEecHq; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GpZmZ3kKBz2yN6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2021 12:31:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GpZmT47K3z9sSn;
 Tue, 17 Aug 2021 12:31:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1629167514;
 bh=Sbl7iwvidphWnlv72t22to+YRD61jI5SCh+FcuNJUFM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=QafEecHqTiJwnBHFAhE4KNbK4unc7vdxNF3JYrk7TU2aWcr5wMtoj9RVescaB1JjO
 A5EcWq54ayhgKKpWHmhb/4lhHOMrbsgpG1JKMvkFN9gSG2OhXfEd2jA1QsyShzvObO
 obhMO4uE216rUaQ74r0ch32pC2LoJoIAsyxlW2yNSOEbAcRLN8KzXgpT8yv2IjEoOH
 LKEO9QLnYx7hh9tegE8e3tS5D118mxoJIqRKiVu7tKrpNM1lTiU6XDAUN++jPP9xNz
 A9wXHJTdKfbvohdi+QBoxPzNQ9vpzlCxAct8ValJrwdByQIicIhNPpjBUC+XaWx//6
 s6wyz9WCuc7Ig==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nick Desaulniers <ndesaulniers@google.com>, Masahiro Yamada
 <masahiroy@kernel.org>
Subject: Re: [PATCH 3/7] powerpc: replace cc-option-yn uses with cc-option
In-Reply-To: <20210817002109.2736222-4-ndesaulniers@google.com>
References: <20210817002109.2736222-1-ndesaulniers@google.com>
 <20210817002109.2736222-4-ndesaulniers@google.com>
Date: Tue, 17 Aug 2021 12:31:52 +1000
Message-ID: <87a6lghkdj.fsf@mpe.ellerman.id.au>
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
Cc: linux-kbuild@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
 clang-built-linux@googlegroups.com, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nick Desaulniers <ndesaulniers@google.com> writes:
> cc-option-yn can be replaced with cc-option. ie.
> Checking for support:
> ifeq ($(call cc-option-yn,$(FLAG)),y)
> becomes:
> ifneq ($(call cc-option,$(FLAG)),)
>
> Checking for lack of support:
> ifeq ($(call cc-option-yn,$(FLAG)),n)
> becomes:
> ifeq ($(call cc-option,$(FLAG)),)
>
> This allows us to pursue removing cc-option-yn.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/powerpc/Makefile      | 12 ++++++------
>  arch/powerpc/boot/Makefile |  5 +----
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 9aaf1abbc641..85e224536cf7 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -12,12 +12,12 @@
>  # Rewritten by Cort Dougan and Paul Mackerras
>  #
>  
> -HAS_BIARCH	:= $(call cc-option-yn, -m32)
> +HAS_BIARCH	:= $(call cc-option,-m32)
>  
>  # Set default 32 bits cross compilers for vdso and boot wrapper
>  CROSS32_COMPILE ?=
>  
> -ifeq ($(HAS_BIARCH),y)
> +ifeq ($(HAS_BIARCH),-m32)

I don't love that we have to repeat "-m32" in each check.

I'm pretty sure you can use ifdef here, because HAS_BIARCH is a simple
variable (assigned with ":=").

ie, this can be:

  ifdef HAS_BIARCH


And that avoids having to spell out "-m32" everywhere.

cheers
