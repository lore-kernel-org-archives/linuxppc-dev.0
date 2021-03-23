Return-Path: <SRS0=XXYE=IV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CA9C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 09:28:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADE761963
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 09:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADE761963
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F4QzG3QxTz3bnY
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 20:28:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=AxBxRUew;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b31;
 helo=mail-yb1-xb31.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=AxBxRUew; dkim-atps=neutral
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F4Qyq4y41z303v
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 20:28:19 +1100 (AEDT)
Received: by mail-yb1-xb31.google.com with SMTP id a143so9626074ybg.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 02:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f4H0kivupb5TYJXKdAmaaH+GD+IJXaN+JMsocYW2kUY=;
 b=AxBxRUewNli2rtiqdcgNkpOd+pj8a2oITIWefNfkca6ZYPTtwwTmBmKVcOKFe13KqZ
 ZuIDbVfVL4pJUDxV5QjNL6KvhMLtlBht2TePRIY7S5dS2Po9vnraHBlQZ2XaltGI99m7
 urPrGOEBunDQ/Sr4kvNXX7sUN/UQw7ui0Exhjk1ognJGA+tiPLEW2HNovceUOduaWf35
 k9P2pnTwv1LNt5RuLneWbJC9u31Vi4Pd6t8yQfn2K8glQe7/0J6i1WhZZyfOjzffF6sb
 WCAPMml3GzOtm75j6hh2fhDKbN0OO9agtSbo4CKVliFnD6vKdfSRLbGbakdGJWDZ8mfZ
 Lgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f4H0kivupb5TYJXKdAmaaH+GD+IJXaN+JMsocYW2kUY=;
 b=rjTqQ6JXbWzDu1xJ+hpnTTcJwwqY/f8jjfYBVT9oyXTmk4b2vwQtezYm3wdcFPVwm0
 h1aKwbv/YD8O73SwmH6k/BM1TfVQWvyROmxWuEQHINaQvNt1lZLtQdDd48vEPBTLV0LU
 JddPUACu961hNslDH6d/YrN931OKi25xjmUzCXHrq+xgUaF0FOTssxZq7chrDIe2XCAw
 tzjz+FdS/QgLDqQX1Ar1tjU6XolgwXCeJqOWnuhm6HbCeqpNlM0vsVq0vuXAGUFKKzPd
 lws/rOUTmVk/eyxre74rGeFl4NwrMGsCpNOiqRvmyRadJw78R+OEIjyQZm49j4/6hVsm
 9uOg==
X-Gm-Message-State: AOAM532Dt0+DgNFaDPPezb1+Ch0nqnhXO3hfjbK3ktZ/YLU0+ta5k4U5
 5x2E3rfjI9nCy9HpbyVFf9W4kzOyizD5hlLyGHg=
X-Google-Smtp-Source: ABdhPJyWHwFyJOKdqJHyKNGZydCjCeUAiyLOFA9kYL9VdL40ys7b34QihOEAVOnXFFnisHuJUZ7kMdTs33/WqrLFeYA=
X-Received: by 2002:a25:e748:: with SMTP id e69mr3784250ybh.93.1616491695744; 
 Tue, 23 Mar 2021 02:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210323032624.1039422-1-mpe@ellerman.id.au>
 <20210323032624.1039422-4-mpe@ellerman.id.au>
In-Reply-To: <20210323032624.1039422-4-mpe@ellerman.id.au>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Mar 2021 10:28:04 +0100
Message-ID: <CANiq72=E3WrNzRG90R4c_uG-oMRpdmN+G=ddeQhhLofh2ajEkg@mail.gmail.com>
Subject: Re: [PATCH 3/4] powerpc/rust: Add target.json for ppc64le
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>,
 rust-for-linux@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 23, 2021 at 4:27 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> ppc64le only for now. We'll eventually need to come up with some way to
> change the target.json that's used based on more than just $(ARCH).

Indeed, it is one reason I didn't tackle e.g. x86 32-bit, because I
wanted to figure out how to do the whole `target.json` cleanly (i.e.
likely have a script generate them on the fly), so I thought it was
better to wait post-RFC.

Cheers,
Miguel
