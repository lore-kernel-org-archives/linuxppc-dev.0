Return-Path: <SRS0=xfaR=NB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E426C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Aug 2021 18:39:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508A760E76
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Aug 2021 18:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 508A760E76
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GkhYh3B5hz3cKq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Aug 2021 04:39:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx1.molgen.mpg.de;
 envelope-from=pmenzel@molgen.mpg.de; receiver=<UNKNOWN>)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GkhY91YYdz309w
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Aug 2021 04:38:34 +1000 (AEST)
Received: from [192.168.0.2] (ip5f5aedeb.dynamic.kabel-deutschland.de
 [95.90.237.235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0C78261E64760;
 Tue, 10 Aug 2021 20:38:27 +0200 (CEST)
Subject: Re: clang/ld.lld build fails with `can't create dynamic relocation
 R_PPC64_ADDR64 against local symbol in readonly segment`
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <b647b710-7ae0-3c7e-6996-92ac974b3b2a@molgen.mpg.de>
Message-ID: <77a69755-5291-285c-45be-c1e42423fddc@molgen.mpg.de>
Date: Tue, 10 Aug 2021 20:38:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <b647b710-7ae0-3c7e-6996-92ac974b3b2a@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Derek Parker <parkerderek86@gmail.com>, Dmitrii Okunev <xaionaro@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dear Linux folks,


Am 29.07.21 um 10:23 schrieb Paul Menzel:

> I just wanted to make you aware that building Linux for ppc64le with 
> clang/lld.ld fails with [1]:
> 
>      ld.lld: error: can't create dynamic relocation R_PPC64_ADDR64 
> against symbol: empty_zero_page in readonly segment; recompile object 
> files with -fPIC or pass '-Wl,-z,notext' to allow text relocations in 
> the output
>      >>> defined in arch/powerpc/kernel/head_64.o
>      >>> referenced by 
> arch/powerpc/kernel/head_64.o:(___ksymtab+empty_zero_page+0x0)
> 
> The patch below from one of the comments [2] fixes it.
> 
> --- i/arch/powerpc/Makefile
> +++ w/arch/powerpc/Makefile
> @@ -122,7 +122,7 @@ cflags-$(CONFIG_STACKPROTECTOR)     += 
> -mstack-protector-guard-reg=r2
>   endif
> 
>   LDFLAGS_vmlinux-y := -Bstatic
> -LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
> +LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie -z notext
>   LDFLAGS_vmlinux        := $(LDFLAGS_vmlinux-y)
>   LDFLAGS_vmlinux += $(call ld-option,--orphan-handling=warn)

Any comments, if this is the right fix? Current Linux master branch 
still fails to build with `LLVM=1` on Ubuntu 21.04 without this change.


Kind regards,

Paul


> [1]: https://github.com/ClangBuiltLinux/linux/issues/811
> [2]: https://github.com/ClangBuiltLinux/linux/issues/811#issuecomment-568316320
