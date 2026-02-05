Return-Path: <linuxppc-dev+bounces-16613-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD74E91290
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Feb 2026 08:24:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f69HX2bVtz2xrk;
	Thu, 05 Feb 2026 19:24:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::34a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770279864;
	cv=none; b=Ml949N5PnjbpZlBoRpyb2Ds3ZdGlbjhMX+N+flTkMDKFi5luKh87z9p8DIyU3WI9D+y0DjpD2gkKIP7A6paS1P0hGWrQ52gVvadRTwHlva0Z1Hu9ucrqBuDk22rnpj93AG5SzDWjsfTvQX04AEQ9jEJH0LytReoc5V9G8HUgCYqVY4+w7v34LRtRj2jmKn21ebN+rdcwV0dnCi2O2yTOamn9ZCmQduEbN5FlSYq3wOhRX8JO2hbQTJhQkscC+JE8W7RvHlNa2Q3zZFWqaP9o0eWWswzc3UrCfnNnegt41dfUP76S6Qh9oB/12rSDxOjuysGL9jNSDPJvk0dfUJo5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770279864; c=relaxed/relaxed;
	bh=dKMEdNQFuTrvbn5AhEjrTHLTqyukv+S/YU3zyRF55AQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AWDxrJn6IpK1zMDKfnzloTcGHL8MRM05V4xJZegAOY2BCJ+3ihR9vAJr1roRG7NuSKHW9PzWDR0Ni8/hu8z4CUiwvX5cQt+uliSwuWOehzIvthoLVjRG0JxcmtIWnwW9F4KrIpACvMojgsopgfFoifhL5Z/qBfWiyTlwa4Oa7/iIdWwl7i+IfE5TLrUr9Jg2s342WnSTFljClWJRTXShriktJJftKdMRq8kqhZSBlByMe2+EwlMjK3VpeyzG1DO/rKhhy/LKmhTwoJ6OAauFafFc/u4tjy17Y1iU/sHrljFSOczRMU5hpm+pxcT9/npX9Gr9AYJsh6M+tEkRqo49LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=n34RGp/W; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3s1oeaqkkdl4epmgiv2lpksskpi.gsqpmry1ttg-hizpmwxw.s3pefw.svk@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=n34RGp/W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--aliceryhl.bounces.google.com (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3s1oeaqkkdl4epmgiv2lpksskpi.gsqpmry1ttg-hizpmwxw.s3pefw.svk@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f69HV65nBz2xg9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 19:24:22 +1100 (AEDT)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so8729055e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 00:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770279859; x=1770884659; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dKMEdNQFuTrvbn5AhEjrTHLTqyukv+S/YU3zyRF55AQ=;
        b=n34RGp/WnmBeNhrWju6LnppYXUURfXNaC4EQ3REb8flYFYzduqWvAch6L/yefXQD11
         SOpYXKl/PSIo2E5hTNvvy/Mhq9/gqFGiUkqDy5t8RC/VLKlQTHCeyc2PpYwvs6W1ssbD
         SSy6hfyLyVz3WCvpy70DuhwnrdtuioQ/ja5aYWE2TkgzuZq8zGJuotVvsRVqX6dniA+4
         PRIPnXHzQ87mGWn6q1bRqaDc2VYSSgormxhTH+EJMQ24jhmeFvszV7eJQtUOoVD2K1TL
         dBRj3smZgGwPiKxu0E+0nJQBULwGGR01rzPj1i3bbZ576lHVJwGjVt472nCiaEhXeZXj
         vBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770279859; x=1770884659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKMEdNQFuTrvbn5AhEjrTHLTqyukv+S/YU3zyRF55AQ=;
        b=gikM0HohOvJd6ntMmtDmFPL5oVV3uejPiFatx2Rf5BRG5ps5FfSkOgJyBNkwGJU17M
         BuZT40nlfdzPTp9iNSvLpj9RdMvOhO0bIxTyvGOKh4eLJZSLQSTpeKzX/o18IEI5qEMR
         acY4gQplxjSzOm2N3YTHmtAXwutqsKMOpPvF/t3EJmoQAIW0oFa1wQ0csC1Z+xVpQS5R
         gVphTCie7rCRRuKOHsBdSPrGxz/WhXk4FBu/Sw6VcV+xN0twa+25U6JLU0qiPyii8S6u
         iIdNbQ94vowfcqjYEPfGsYCti0n3dGY0cZEkCe3QabcaD469NQfx/Ztwz3UsP3Y+U4VK
         DuvA==
X-Forwarded-Encrypted: i=1; AJvYcCWBkhKSpkFeULcKJKZpwCmf4aAf5HDAIXXgPgvxvxQQ7F/f2eecQmPxnfwu+2vb5HsDrWxFtt2b8fxBIQs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwdgudJmAQLyxTperq/d3mipUQLkSiFX3jfSHc5GSxjkv6mojmz
	/uJAqASqgHTLmnfGMFE4etN0k6uvnrWESEXWI95hRd9MaR+PMmKAavcYTowM7n8E0Mgp7Cech/1
	Eua9xRcU3NjukE4oYyA==
X-Received: from wmjq15.prod.google.com ([2002:a7b:ce8f:0:b0:47e:dc0c:276f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8715:b0:47e:e2ec:995b with SMTP id 5b1f17b1804b1-4830e93033cmr80990595e9.9.1770279859237;
 Thu, 05 Feb 2026 00:24:19 -0800 (PST)
Date: Thu, 5 Feb 2026 08:24:18 +0000
In-Reply-To: <20260204210125.613350-2-mkchauras@gmail.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
References: <20260204210125.613350-1-mkchauras@gmail.com> <20260204210125.613350-2-mkchauras@gmail.com>
Message-ID: <aYRTsvEBIxc4ru2F@google.com>
Subject: Re: [PATCH V2 1/3] powerpc/jump_label: adjust inline asm to be consistent
From: Alice Ryhl <aliceryhl@google.com>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: linkmauve@linkmauve.fr, ojeda@kernel.org, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, corbet@lwn.net, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="utf-8"

On Thu, Feb 05, 2026 at 02:31:23AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> Added support for a new macro ARCH_STATIC_BRANCH_ASM in powerpc
> to avoid duplication of inline asm between C and Rust. This is
> inline with commit aecaf181651c '("jump_label: adjust inline asm to be consistent")'
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


