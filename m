Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C9EC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 15:40:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC3A20851
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 15:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7qcptHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC3A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zChN317DzF3GT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 02:40:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D7qcptHP";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::141; helo=mail-it1-x141.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="D7qcptHP"; 
 dkim-atps=neutral
Received: from mail-it1-x141.google.com (mail-it1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zCds6plLzF3L3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 02:37:53 +1100 (AEDT)
Received: by mail-it1-x141.google.com with SMTP id h65so4748661ith.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 07:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HovDyLoW9JgP2dOMddyLtoMQVzEDX+zbCzhvdFpRmKg=;
 b=D7qcptHPzcuFLxZJDKf3/4DYoAkuBIC1/vhhevIzPorrX0vffSlkOwDgxtkWOJQ5at
 HawzLKIlQZPHhzcg/ht+WOn2/Bwzx35gGjNcBaHjt33qZAinytdLYzklmhvd92e87Qpx
 QdcvOzwwWfj2RygLc+IHYXpaaAK0ppUfMF4FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HovDyLoW9JgP2dOMddyLtoMQVzEDX+zbCzhvdFpRmKg=;
 b=Z8nBQiTT0JKbaVYd0Qx22nlcfezX5XB+P75KJulkSQsw3fUExEwbo6wAL5LrUSQfAV
 bcvUiVdIAsSVyh/QHmWCWBTacsnfC1C+nMc08ltESx0jbJgRuwPuikr8kYpxsXvDtfFH
 sRCssK3J+hz6lN2QUM/gGT2LOsCmVYvGQPLInQrLqhBDilPuVifF3RIC/3lEc1J9WAcB
 EcsHYztQn0F0+bE2qa69GBRH22t+mU2FpImycJx4JLeRFgm6TO24cE5yjdA19rMJVP0p
 Lgkup/v6k9ekdbfnsF+OgmEeISxxghe6AGBd+wBrFGUINaRycWaEANUSuqgw73OtZfJf
 j5mA==
X-Gm-Message-State: AA+aEWb9tlOot4xaw34LzS6Yd153EhYbyVP0pk19XdMvzGXeY/iwrPse
 4XI8YstbGEnKMpgNc1FV+Etv3Hlx9kR+GOTTmS2XZg==
X-Google-Smtp-Source: AFSGD/XYGCOxtGQjZNHVynlMGnMqP3y8k20/U+DJFyEKBYt23Zja/1TkjR662SNXidQ9wGwqBoa2EOaNRg2lDyTv3Xs=
X-Received: by 2002:a24:710:: with SMTP id f16mr1015081itf.121.1542641871167; 
 Mon, 19 Nov 2018 07:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
 <20181117185715.25198-2-ard.biesheuvel@linaro.org>
 <b37c3411-7950-dcb3-f0c3-6d9f589d36ab@iogearbox.net>
In-Reply-To: <b37c3411-7950-dcb3-f0c3-6d9f589d36ab@iogearbox.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 19 Nov 2018 07:37:39 -0800
Message-ID: <CAKv+Gu8mo+WkJ356wByidUDoA-xHrUH99od5N_yJoqtX_28_5g@mail.gmail.com>
Subject: Re: [PATCH 1/4] bpf: account for freed JIT allocations in arch code
To: Daniel Borkmann <daniel@iogearbox.net>
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips <linux-mips@linux-mips.org>,
 Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <ast@kernel.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Jann Horn <jannh@google.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 Jessica Yu <jeyu@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 19 Nov 2018 at 02:37, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 11/17/2018 07:57 PM, Ard Biesheuvel wrote:
> > Commit ede95a63b5e84 ("bpf: add bpf_jit_limit knob to restrict unpriv
> > allocations") added a call to bpf_jit_uncharge_modmem() to the routine
> > bpf_jit_binary_free() which is called from the __weak bpf_jit_free().
> > This function is overridden by arches, some of which do not call
> > bpf_jit_binary_free() to release the memory, and so the released
> > memory is not accounted for, potentially leading to spurious allocation
> > failures.
> >
> > So replace the direct calls to module_memfree() in the arch code with
> > calls to bpf_jit_binary_free().
>
> Sorry but this patch is completely buggy, and above description on the
> accounting incorrect as well. Looks like this patch was not tested at all.
>

My apologies. I went off into the weeds a bit looking at different
versions for 32-bit and 64-bit on different architectures. So indeed,
this patch should be dropped.

> The below cBPF JITs that use module_memfree() which you replace with
> bpf_jit_binary_free() are using module_alloc() internally to get the JIT
> image buffer ...
>

Indeed. So would you prefer for arm64 to override bpf_jit_free() in
its entirety, and not call bpf_jit_binary_free() but simply call
bpf_jit_uncharge_modmem() and vfree() directly? It's either that, or
we'd have to untangle this a bit, to avoid having one __weak function
on top of the other just so other arches can replace the
module_memfree() call in bpf_jit_binary_free() with vfree() (which
amount to the same thing on arm64 anyway)
