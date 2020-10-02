Return-Path: <SRS0=hNvT=DJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7031EC4363D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2020 16:30:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823F92085B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2020 16:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dQd4p/Gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823F92085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C2wSq54w5zDqRS
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2020 02:30:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::242;
 helo=mail-lj1-x242.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=google header.b=dQd4p/Gw; 
 dkim-atps=neutral
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C2wPy5NkyzDqR0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2020 02:27:34 +1000 (AEST)
Received: by mail-lj1-x242.google.com with SMTP id u21so1666387ljl.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2020 09:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XESAsar1PPbow9QXM6iPAt7dZfh4lXWZnIFR2ENhSp8=;
 b=dQd4p/GwRMxd2rF8gBrN78ey6p2K8zuzTy3s9sWMNAin9xHfUCuyFLi919lpEWk9Dc
 zCAWOHW6ysQaFQHfncwjPw8GtCF9mIdVDdsTyJBxdGYxPtsWb34P9+jGkQhhAkEUnrzR
 +hu0t3g2U6uMrarSu3VT/dg6iysw2VK0TvQ0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XESAsar1PPbow9QXM6iPAt7dZfh4lXWZnIFR2ENhSp8=;
 b=E0uGOmU9sLfwf2oTSxzFH4vgLwhuKL4rdl7yQzszZVi4t+gUi0K1DIb+2wLAtN/NIR
 nHaWcSfpKKWSjfP/2PhTSjUXWvzars6r+S/hAZWHfceT9vZKS1GY9Sxd3lm2HgGuPneU
 OLOrT9YyrxwzHYfYVpuHDX5QPoLhD/iJbtFPVYYjVmWbL0U/nUuJA2qDVKVnTYlW0soD
 hRtyXt0cqzHz438jiefzMFOYGqT9h+yCoJwkUwBaarUae2j3a/sQSNyHFs0nmZ2wS14Z
 qIKN0fPfyel8lscjVkx80tCpDRgDR9A+T2WsfrzjNI6/k40lO3RDhBwvfC3Qy4tovXAW
 jEOQ==
X-Gm-Message-State: AOAM530evs2/8XsYI6kusfYkZ6/M1zOzUknFFzBRC8ryJZBt7DJUnwZh
 Eqq3nkQPJi1OLggxm1prSQf0RO+7FtIshw==
X-Google-Smtp-Source: ABdhPJzfHy5ZkT9TsiBS2vCNsiicv65YV+uOlVvqyPLQCt6ccZCCOt8uRd1VTkDlU/qrTyZhDvugUA==
X-Received: by 2002:a2e:a554:: with SMTP id e20mr1030976ljn.458.1601656047915; 
 Fri, 02 Oct 2020 09:27:27 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com.
 [209.85.167.41])
 by smtp.gmail.com with ESMTPSA id v11sm375104lfg.39.2020.10.02.09.27.26
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 09:27:26 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id q8so2576921lfb.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2020 09:27:26 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr1257887lfg.344.1601656045931; 
 Fri, 02 Oct 2020 09:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142242.925828-6-hch@lst.de>
 <20201001223852.GA855@sol.localdomain>
 <20201001224051.GI3421308@ZenIV.linux.org.uk>
In-Reply-To: <20201001224051.GI3421308@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Oct 2020 09:27:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
Message-ID: <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
Subject: Re: [PATCH 05/14] fs: don't allow kernel reads and writes without
 iter ops
To: Al Viro <viro@zeniv.linux.org.uk>
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, Eric Biggers <ebiggers@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 1, 2020 at 3:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Better
>         loff_t dummy = 0;
> ...
>                 wr = __kernel_write(file, data, bytes, &dummy);

No, just fix __kernel_write() to work correctly.

The fact is, NULL _is_ the right pointer for ppos these days.

That commit by Christoph is buggy: it replaces new_sync_write() with a
buggy open-coded version.

Notice how new_sync_write does

        kiocb.ki_pos = (ppos ? *ppos : 0);
,,,
        if (ret > 0 && ppos)
                *ppos = kiocb.ki_pos;

but the open-coded version doesn't.

So just fix that in linux-next. The *last* thing we want is to have
different semantics for the "same" kernel functions.

               Linus
