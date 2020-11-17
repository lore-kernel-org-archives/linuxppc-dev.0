Return-Path: <SRS0=3gej=EX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACCFC2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 21:53:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8792E241A7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2020 21:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dZSJWDKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8792E241A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CbKSw63HrzDqZ2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2020 08:53:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::441;
 helo=mail-pf1-x441.google.com; envelope-from=keescook@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dZSJWDKn; dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CbKQw2rG7zDqW8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2020 08:51:48 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id v12so16527pfm.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2020 13:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ky/CMCEHw6W83Pli0RSEtI4judjYnXP8NLTqyncoiBE=;
 b=dZSJWDKnArBdBXCgAIPNiaxvh5LCZwCDL6Ymkj44p0R8yL+KgQAfKZKf1lt2KfdnvV
 bLD1xeFdcoEmB+Z3tmSxV7RnFUrRITgkpS48Ri05VZa2xyqn5gWggufKXfTSH6J5m6de
 NMkUQrd2oc7jz3d1V4DoMoucn5sXNnsH3BN6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ky/CMCEHw6W83Pli0RSEtI4judjYnXP8NLTqyncoiBE=;
 b=BCU3T6HQQGET2rBntqCt+hwlbbVbHM2RVTxHkg58ncap/f6r1uWp8ExqHeeXUEvtgk
 Ax+RPqDL5rcx8i7eopXTzoUEuxfcoZmacdEOXUAK1TEsPAyPIgxZJRp6brEqi4R6Gs/S
 pUetngcias5UndXDrCCgOUtjIGzqVB0ma2GwIfa1YvU30KPUo20LzYMn5TmlrRJZzy2N
 TrlwsLuyPSpcs/fyuKcmjVJt1i0o6ZNiVnoZgHFdymaMavw5Bs1GR/aFfanhDlvtl9oX
 cOontt4f4HgOjpUPn5zw9YA/0m/I6goWCBTqi+OuFfMF2DNVEDulvmhFH4vLAm7A38o2
 3LiQ==
X-Gm-Message-State: AOAM532GGZHGT/uXjqZyqhzEoN0Izi2ka1wOxy3Hw1EC2XzSYUwD7Y9y
 xxDItFQ8JoqrlL1F/gTGO55q4w==
X-Google-Smtp-Source: ABdhPJxqggVKuH8HMTgHzwSVLvkZKhOmwN0EoIzciqR8uEi7NDnZHbJFTVTL+MdWrPbHDgwOP+UNwA==
X-Received: by 2002:a63:7847:: with SMTP id t68mr5290408pgc.422.1605649905676; 
 Tue, 17 Nov 2020 13:51:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id m9sm42912pjf.20.2020.11.17.13.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 13:51:44 -0800 (PST)
Date: Tue, 17 Nov 2020 13:51:43 -0800
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 2/2] kbuild: Disable CONFIG_LD_ORPHAN_WARN for ld.lld
 10.0.1
Message-ID: <202011171350.F95127F@keescook>
References: <20201113195553.1487659-1-natechancellor@gmail.com>
 <20201113195553.1487659-2-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113195553.1487659-2-natechancellor@gmail.com>
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 "kernelci . org bot" <bot@kernelci.org>, linux-kbuild@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Arvind Sankar <nivedita@alum.mit.edu>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 clang-built-linux@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 13, 2020 at 12:55:53PM -0700, Nathan Chancellor wrote:
>  config LD_ORPHAN_WARN
> -	def_bool ARCH_WANT_LD_ORPHAN_WARN && $(ld-option,--orphan-handling=warn)
> +	def_bool ARCH_WANT_LD_ORPHAN_WARN && $(ld-option,--orphan-handling=warn) && (!LD_IS_LLD || LLD_VERSION >= 110000)

Readability nit-pick... I prefer separate "depends" lines to make things
a little easier to parse, change, etc:

config LD_ORPHAN_WARN
	def_bool y
	depends on ARCH_WANT_LD_ORPHAN_WARN
	depends on !LD_IS_LLD || LLD_VERSION >= 110000
	depends on $(ld-option,--orphan-handling=warn)

Otherwise, yeah, looks good to me. With this and the other suggestions,
please consider it:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
