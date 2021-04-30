Return-Path: <SRS0=0xlf=J3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81BBC433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 21:34:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE24261466
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 21:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE24261466
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FX5HM2VHDz30Gd
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 May 2021 07:34:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20161025 header.b=GTJlmBY1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::22e;
 helo=mail-lj1-x22e.google.com; envelope-from=ndesaulniers@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=GTJlmBY1; dkim-atps=neutral
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FX5Gs5XN1z2yhs
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 May 2021 07:34:11 +1000 (AEST)
Received: by mail-lj1-x22e.google.com with SMTP id s9so24560176ljj.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Apr 2021 14:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sJWa2KJkaLugvoGNjQoNmlranNjOBpXntuPfu2Rmhko=;
 b=GTJlmBY1FeiHNrO59CFrYFIHMu6lMx3QpHsIB/JMUmvwsI5P7xNp1MHcnIFxYHdmZY
 w3yJjo42rVPUkBev3YbjDAfWn1kSW83JpIPx5duqGLnZhn/pvreFJIqvLejgp0DSn10j
 hsvjhWwLpLbV1Q+zmPYHNG+rBrbO/26AjYueZNimeMKeX7TrcXKXe0KSazkl3neuRWL8
 dHTwrzl8qC2JR1q1IFNuBsTp9UTvI0Qzc1pHEmnNLwziVMKok8RoS5s5GgcsdtxIbEUW
 qPzesCWdFHWHL2bD7iOIGBfSRmFKNjeKsnmxA6ou2BWxOQvWbpyXgMYPV4+tMQxPvRdB
 oO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sJWa2KJkaLugvoGNjQoNmlranNjOBpXntuPfu2Rmhko=;
 b=nt2h70sGgQ4UNtBn80n/moAbGfV4rrVfmveTuNHY6BlHVvJ1ki2QtvkLQSrcz1BGuj
 xJ3DgL13BG6+3H3fQs1OrNQIVTewVZChjIPaFTfOKSfLEcbs7rqGYBKTQB3I6rvDNQ59
 eHnVMsrFoewpzTAnMa52LDhmcL4diWKBkKWEkxviU34wRGom9WXWoR1u8O9OqhEEcamZ
 LPbtzMlLEhiwBSph1TBExCyAN/7fbSq11kqCFfIaOkXjQa54N4qEgUukPTX8WbAwLwjO
 eIUZkdCz7LhHR5zKyDbcBezTQf+PVHRXZ8jW18RDkS/KXfHn7oBOwFOp/zmk1KImNy1U
 cNoQ==
X-Gm-Message-State: AOAM532lQ0TlqFlziFsm1jg19fN7hiwdgyfzpKLAf/NFoY6uJ8Mmzy/g
 IEzXshvExxzKms0EvmTUpz7FhAARTWAH5ch28WMocg==
X-Google-Smtp-Source: ABdhPJxn0XFzifOJGACO/uU/54aBBrlO9O4R5o9LDRoenla8kGPY5FW73ujH8gR6AV244jSMvpLhlanp2PET1wAI5As=
X-Received: by 2002:a2e:9211:: with SMTP id k17mr5045276ljg.495.1619818443844; 
 Fri, 30 Apr 2021 14:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210320122227.345427-1-mpe@ellerman.id.au>
 <YIcLcujmoK6Yet9d@archlinux-ax161>
 <de6fc09f-97f5-c934-6393-998ec766b48a@csgroup.eu>
 <CAKwvOd=SkPtOij0tCx=AzUsLD3RrJZBFs0WZKuQJ3c4JM3Nn6Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=SkPtOij0tCx=AzUsLD3RrJZBFs0WZKuQJ3c4JM3Nn6Q@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 30 Apr 2021 14:33:52 -0700
Message-ID: <CAKwvOd=kU=gOci7y1CjZaKw+w5H3kZ_CfzGG0=r+Fs33hLV4uw@mail.gmail.com>
Subject: Re: [PATCH v7] powerpc/irq: Inline call_do_irq() and call_do_softirq()
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
Cc: Nathan Chancellor <nathan@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 27, 2021 at 1:42 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Apr 26, 2021 at 11:39 PM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> > As you can see, CLANG doesn't save/restore 'lr' allthought 'lr' is explicitely listed in the
> > registers clobbered by the inline assembly:
>
> Ah, thanks for debugging this. Will follow up in
> https://bugs.llvm.org/show_bug.cgi?id=50147.

Looks like there's a fix posted for LLVM in: https://reviews.llvm.org/D101657

Though trying to test it in QEMU, I'm hitting some assertion failure
booting a kernel (even without that patch to LLVM):
qemu-system-ppc: ../../hw/pci/pci.c:253: pci_bus_change_irq_level:
Assertion `irq_num >= 0' failed.
That's with
QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-9)

I didn't see anything in https://bugs.launchpad.net/qemu/ about it,
but figured I'd share in case that assertion failure looked familiar
to anyone.
-- 
Thanks,
~Nick Desaulniers
