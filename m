Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C540606A321
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GQaGIk8f
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNRnq5Xx4z2xdb;
	Mon, 09 Nov 2026 22:07:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::32a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794222447;
	cv=pass; b=jmAZ6cLGfY5oFP6yfcIILqUvjLvq00BsKdxlgx5bmkjyfVFqqY9S0FtVf5kjWSDrhMlZELtJ9df0yCSav6KlDYRGoNTP3dwCLKQltFmpWGFHcG6Wu38Q/45/BAKOIZo6LjfrxYpIjrqWZrrjlSiHmVWClAqpHcHjsTLpf8YZop6m/Lc4sHcz4NTQ4jxCa3u3uWiX7SfwLvIrM+jCnQ8IMnZ5Qn4iRnTQj33s0PGcVdKKGtqRca2suKCHH5AzokmqRrJDw9NcTrzK0mtZiun1uLb4It4q05S1QyG7bLoVs9QHI86BlpGb8Z/ObLP5OkQQ6Hp8VgggHW2/fi9XZsnJTQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794222447; c=relaxed/relaxed;
	bh=65mXDclEWyE8ywbYwWS+OTM5iohbgv5+R25SHeg04wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaU/37Z1h1XYHh2PGqhYGLiqyxlVnW1zrIHnvEwbKcz+CMoE5ojb1ENyB4X1elK1tLVgOmPjOQB1BNIqWimZLyTIE1VK6KBnUH6+EZ5sGmKw8VKXoqAlqSFGqHK98pbOi+RmEWMPFadkJlhMUwwCVTubUSFr/wtEicB8aCarD0GlblV9UMgIDGeONyAvs/xoLSPEWdMVN7pN4TMueubA4FLLINPGuF5HCbLx28S9vRgAXoksIlnLgyQhzmVy6b7Dnl6naj0F/FY7zP/IzuUuLQeLnJ0K4TSv0TKnnYBsD+Hjt/+WqtE5TezycmwFr+E8Eyt9G76MCbuKLGhZDH0Xsg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GQaGIk8f; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GQaGIk8f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=jiangwenxiaomi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNRnp1g0cz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 22:07:25 +1100 (AEDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so5679485e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 03:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794222441; cv=none;
        d=google.com; s=arc-20260327;
        b=Z9mtERzrVXmDLuUYfhHc8eZBCK/gKmxpbj92iGgEGVgoloZy8U1Hp+/ybuz++sUrWC
         hNFbZsUirF+AfMq/jSatZF2Mv60hXRbDRxlTMavzvBotqscr5oo3h8CkfDVQOSBRyzsA
         yh9TO7OcNq11tP00tXFjEb3CYyWDcKAr95EMlqPHGRZBFmZZbfY6aVUGOBHDRId0IcsK
         I/M+G53TbRzgjiUsCO6hNV/HVvxmCkmQgmJwTOuZpjfYFLyyXJnrtut8s9tdtPFkyKEp
         ywalQyqQoqQnyOqsGbZtlGT/A6V5Y8sFkg4wgJudQyRUVeFoRPKhIXg1hWKtQsQaAuQG
         weig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=65mXDclEWyE8ywbYwWS+OTM5iohbgv5+R25SHeg04wo=;
        fh=Yn3PiQ8MiwIHX2TfPLQWg6czAo+chHWnuVYi3No1wcQ=;
        b=eonb/eFVl57JLwlUqT00v90RScobdntZROEF2qSPpT/FC+YxzFCUyD/4rPJZE4YFgA
         72pE/67jTsxbZnZu4pDPUNrn819NDzW1zfLiRcbeGeuyiWeTHPc/DJSEVScCLBwlAKjo
         ORLjdVSkZ5hSSsAncx+ih+tRtoYtiZDmAbXJ3liO4DHshjlzIWF3/2C5wPChf9dsltpA
         zKmmmgtbCr6Qx+TC9WZAWtrStw6VnmUzLNsQPVm6h4j1/nXJ1dQBEsdGcSVQtLhml4P5
         fBCy3+2xF3nKLlq6Fh4urnBhJ0CjWPgQu1v+acFtcnramHB6BSTtdFIkkFNPWGVkKGFr
         HNcQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794222441; x=1794827241; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=65mXDclEWyE8ywbYwWS+OTM5iohbgv5+R25SHeg04wo=;
        b=GQaGIk8fP0onRgsiVzAZ1Gs9WTmjqEkUG4/iSdEM3UdZLHGbw9j44ZGxOXln+L2kY6
         SNaYSwYE1HpZAiHRetdC7zpG2+UrOF8FiLIHkgzTosJhkZzDPGdeb0gisijrbe9FHqHp
         siVq2Lvi89FTDJV3qVEnxcjIZuYoeixILLAJmmxK9c9fgttEdLnk/fDGNKDT4yn9QNqC
         tWM1HmOTE+C5RBQHTm66hxPtZCav0PcYiP9edDxO8CymQ3ryXjQxuasVQ5Phn69pXQGt
         1qBdY+xyjLkCwNzxJtCVf01nsEkoYCUl2BjUHUMij9jns3HPisBT7ourgebAPJZTfGGi
         ZAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794222441; x=1794827241;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=65mXDclEWyE8ywbYwWS+OTM5iohbgv5+R25SHeg04wo=;
        b=hNmBGzPmz5cgsTnIkJvo6cm42eGmxde+n3tCiZKDEesaZC2Y/UEufygte6AQv6Pxt9
         VZ2U0LG/m9ihicD7e6ndhsQZSySOl9GQtCZx9/8wpsFJiJ694QCe2IGG7lyu3LB9GZ/l
         GhaD5EFBqpIZn4xP6WbXMDrnQnJvAtrqYyS2EGCEpAXYDs4khf2ismdNkCFHfXND8XAX
         /4cOBMkc+5K/AzajwOsTsjpBsyBNJnVIQizjnuIbySVryHuy3jidTl9yllz2EozX+JQC
         djkqxdTd04sFuE2gj3NX3JfQ/hiSWfK7M2gnSVDSABDaxKSv2zYFpt5bbiZ2FAhos9Rk
         f9xA==
X-Forwarded-Encrypted: i=1; AL+hErGBCdL9AGLSdN2IHC2sSTyI+IasuTBWM4xf09pq7xVp5tzrtkSXKeMWyjvoRsNBcA8B+K+sOhV8o0BxUcE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9arzNWNofyVbsJZW7fy34dWKLhg8vgS0/Uo3AeDv9CdBeMzToS
	F6csWJ6f5HdEEnKWkksPraB2HBBiwKLSRGEAwzXLPLrvj+YHec4En1ql8cWCd7AKKV9lnrxJbpP
	fQY2ofrDkEWWpxWXn2S5Z0pgDggpY788=
X-Gm-Gg: AYBFou0stj7zh1qRskJrircm0SUKQuqgeznvDyC1djv+l1Nsgj2eGdwFamLuBD5+7hc
	tapwUmclytW8aoVx6gm25GEWY4vNxmD5XuY9RJQvg7yJvjEjlAyqCDkapywro76an8Vu9IO4DY/
	qjA0BvcJXw2MlQHQGBW9Nw25PuQhv5pgBsDuPGAo9e/V15rLDz4B6lPyPGtocCfGfovcms+6NxU
	gG7ljgySUhn43ZdhtQ9tiiE4XQ4AyhyM7fQcM6pxRr1f9XBqvSaM2dW55FU8PJiu2cQw9QcksZG
	4svVWBuoSq35EmORqXTWvewPeIUQD5GyN7Nmu1RYMK+Q416ENiWq/2Ha8J8FoyyDFcA6wqRR4gs
	ZvvN3HHntdwfgelrFRVjv/95BphA9Xpektuwx1Q==
X-Received: by 2002:a05:600c:3b04:b0:4a2:e0c:2b0a with SMTP id
 5b1f17b1804b1-4b960e9a794mr69581505e9.16.1794222440621; Mon, 09 Nov 2026
 03:07:20 -0800 (PST)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107134953.748622-1-jiangwenxiaomi@gmail.com> <20261108230842.3a77b9fe2d4bfc2a04b355a5@linux-foundation.org>
In-Reply-To: <20261108230842.3a77b9fe2d4bfc2a04b355a5@linux-foundation.org>
From: Wen Jiang <jiangwenxiaomi@gmail.com>
Date: Mon, 9 Nov 2026 19:07:23 +0800
X-Gm-Features: AclHuK99Avp6YitNghM646M3nFfapLv4xavJ0UAfEt09SDcSvaVsVIm1DZLJeo0
Message-ID: <CAHKocdGWE9OVA5pJh33U-FYnNkUqRS0pzFt=rCwXWzY9w-QXyw@mail.gmail.com>
Subject: Re: [PATCH v12 00/10] mm/vmalloc: Speed up ioremap, vmalloc and vmap
 with contiguous memory
To: Andrew Morton <akpm@linux-foundation.org>
Cc: catalin.marinas@arm.com, will@kernel.org, urezki@gmail.com, 
	linux-mm@kvack.org, baohua@kernel.org, dev.jain@arm.com, ryan.roberts@arm.com, 
	anshuman.khandual@arm.com, david@kernel.org, rppt@kernel.org, leo.yan@arm.com, 
	xueyuan.chen21@gmail.com, chleroy@kernel.org, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, ajd@linux.ibm.com, 
	jiangwen6@xiaomi.com, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 at 15:08, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat,  7 Nov 2026 21:49:43 +0800 Wen Jiang <jiangwenxiaomi@gmail.com> wrote:
>
> > This patchset accelerates ioremap, vmalloc, and vmap when the memory is
> > physically fully or partially contiguous.
>
> Thanks.  This looks pretty mature and reviewed.  I'll add it to the
> pipeline for linux-next testing.
>
> Sashiko likes it.  I'm working on a different AI review setup which
> finds different things.  Very slowly.  I'll let you know if anything
> interesting pops out.
>
> Do we have sufficient ARM review?
>

Thanks for picking this up.

On ARM review: Dev reviewed the earlier revision in detail and
his suggestions are folded in. Leo Yan tested the large vmap() path
on TRBE/SPE. We'd welcome more ARM review from Ryan, Catalin
and others.

Wen

