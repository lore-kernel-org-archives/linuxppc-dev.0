Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22504C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 06:35:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846AC20855
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 06:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/fHNake"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846AC20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43grm13QqwzDqrZ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 17:35:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43grkJ5Wn4zDqlc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 17:33:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="U/fHNake"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43grkJ4SVwz8t4h
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 17:33:44 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43grkJ3frSz9sLw; Fri, 18 Jan 2019 17:33:44 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="U/fHNake"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43grkH4K8wz9sDr
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2019 17:33:43 +1100 (AEDT)
Received: by mail-io1-xd41.google.com with SMTP id m19so9892391ioh.3
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2019 22:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RYdWynhVP3t5YhpjExMXjnqkUCky6kT76vDbQbkv6y4=;
 b=U/fHNakeOp5GFUM0fSN6gDfwobFxYGWwO7nPQ5o7GxFKESYculT7+G6jqmZ484i0a6
 hOl5UpLhj7anEWvnmjCRL5As2KAAdGLkF9HaLO+7eiiW6l9JgTrunDW9NxPAegccBR98
 r4lQjmgv0sSWAYw/iFC6a6a/MAo8eWDf/YAV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RYdWynhVP3t5YhpjExMXjnqkUCky6kT76vDbQbkv6y4=;
 b=GK6xq4PK/5G49AwPHwclYxyqiuJ3IVmKXM2ozZDVgRaZKywq2rqkDvXXaIs6X0JzLh
 7ml+3x8jFujcDUEJuUrnBy9QHPXfmFYUq2lhVx1PkJG2eovdiD+3mqV13G3l0Hw/EnKj
 wcaXxfal21RChNM7dGgij9ta73LOeGLLzkpU+nLNmOy0bjMTiqGMejugt7UNW54t+3Q+
 FbkQ2PH2tYPkLnFoL6mJX53gveMFKeku3BrywMkGB7zkKlk8fBIfU5M/CutMCWUBb/M4
 0MloyAOupeqRqPzRiqjy3mwbJhwugxZjaDbRV5w3Fn0gdKW5KgupH2/zr0CqkD6UXD8L
 /a8Q==
X-Gm-Message-State: AJcUukdP3Bd6wLq3x4JxhK52SasAqi4v+5mqYATnL/HnP4eErvh3M0WT
 6Ru63JemKn0ALlCZqcNddJB3le9o1xPrqF8EJ7dASg==
X-Google-Smtp-Source: ALg8bN6amGzJY0KZy9TgXflC5aueKHCyFeTxovXKZN2hHbkFyqjtR/Xhw/4yLRmysbiW4l9bnm6aUqn89P0/eEQneRQ=
X-Received: by 2002:a6b:4106:: with SMTP id n6mr9540720ioa.171.1547793221136; 
 Thu, 17 Jan 2019 22:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20190116132714.20094-1-mpe@ellerman.id.au>
 <20190116132714.20094-2-mpe@ellerman.id.au>
In-Reply-To: <20190116132714.20094-2-mpe@ellerman.id.au>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 18 Jan 2019 12:03:30 +0530
Message-ID: <CALxhOnig8ya+4YB+yg9b4Bqp_5KQOKBZdE7KTRvhdUYBQR9w1Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] powerpc/syscalls: Remove unused offset
 parameter
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
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

On Wed, 16 Jan 2019 at 18:57, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> We never pass a value for offset, nor do we need to, so remove the
> offset logic.

The idea behind all these effort is to come up with a common script for alpha,
ia64, m68k, microblaze, mips, parisc, powerpc, sh, sparc and xtensa. If I'm
right, ia64 and mips pass offset and rest of the architecture doesn't. Inorder
to come up with a offset logic to accommodate those 2 archs requirements.

I think x86, arm and s390 can use the same support with minor changes. So
prefix also need to use it.

I already create a patch series for powerpc with unified script. the changes u
suggested will make difficult to make unified script.

Thanks
Firoz
