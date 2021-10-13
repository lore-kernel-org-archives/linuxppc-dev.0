Return-Path: <SRS0=X2ql=PB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EC4C4332F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Oct 2021 07:01:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFB461027
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Oct 2021 07:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5FFB461027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HTk2l0bbDz2ypn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Oct 2021 18:01:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Aj4KOWPH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::102a;
 helo=mail-pj1-x102a.google.com; envelope-from=keescook@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Aj4KOWPH; dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HTk157350z301F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2021 17:59:37 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id
 pf6-20020a17090b1d8600b0019fa884ab85so3673939pjb.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Oct 2021 23:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EtO4v1hmknoQ9CC5pTvq/sjyHsZmxJYafaGuFh9dADA=;
 b=Aj4KOWPH1k1PgbvL+pTY/xACU9Pwn9MUiqpjhM6IVuirnFFqehXtyynR0cRL2JC99T
 X2BS5sniIcL0i7UDJuPo3mr7cogBrx2R6mTJAooH9lgbXGgOBqhKd622U9AX9BlAOHRw
 9KG1Rg/hzG7yZQgql7BR3km2UfZPusbGWwkVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EtO4v1hmknoQ9CC5pTvq/sjyHsZmxJYafaGuFh9dADA=;
 b=EZ+f87tU0t6poUpL8m4FBMlFIuKuEn0udeDQt+YDXdh1jCkE4asVSnA1v6b0OlZQUS
 5DJAtQ3A/dRO4zChZsBx2V5MsRS5xmw8miBoKGMwj0tLAITjDgkjjmTj7a9q848/aLwy
 iWi/KU2yKkBaprxs9+KnXUDWYM2ts8+KG9J1RK/arL4k31YAkF2tBwUn3UvUJH3iebMh
 0OGlmko1JJM/C3el7WIRlk4VEPCMbatv5zK2ufNKfm9KvWChT9mAWGoMdnFNb8s6pS2J
 SJ3gfxSJjEiB+IuRtkV8r19EpOip2qpx28IRa1pPFDtr9xlBpHVxluL1fA6jkz1VnmJt
 Z51g==
X-Gm-Message-State: AOAM533LO15OSOgE7+QjZqKEkJ9IZFLN/gkaFa/s6/mGBVrT6ip+eeeq
 5MxYPY0oLc5SBHvOaUN6v1GswA==
X-Google-Smtp-Source: ABdhPJyxiDFdmaS1K7BtHQLBKPUYqjjdyZfqGoeYI4TMfzgjIuLL/822k5Q++d2NaSjkZUCum4PHbw==
X-Received: by 2002:a17:90b:2248:: with SMTP id
 hk8mr11473279pjb.102.1634108375787; 
 Tue, 12 Oct 2021 23:59:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id m22sm13283364pfo.176.2021.10.12.23.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 23:59:35 -0700 (PDT)
Date: Tue, 12 Oct 2021 23:59:34 -0700
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 03/10] ia64: Rename 'ip' to 'addr' in 'struct fdesc'
Message-ID: <202110122359.4FF2BA38@keescook>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <a2443adcd006cb8004fe0602e2f8c43c30a7c504.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2443adcd006cb8004fe0602e2f8c43c30a7c504.1633964380.git.christophe.leroy@csgroup.eu>
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
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helge Deller <deller@gmx.de>,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 11, 2021 at 05:25:30PM +0200, Christophe Leroy wrote:
> There are three architectures with function descriptors, try to
> have common names for the address they contain in order to
> refactor some functions into generic functions later.
> 
> powerpc has 'funcaddr'
> ia64 has 'ip'
> parisc has 'addr'
> 
> Vote for 'addr' and update 'struct fdesc' accordingly.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
