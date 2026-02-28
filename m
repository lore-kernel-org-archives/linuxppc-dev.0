Return-Path: <linuxppc-dev+bounces-17448-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C71EFEE4C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 12:39:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNPrj0MnQz30Sv;
	Sat, 28 Feb 2026 23:39:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::34a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772282340;
	cv=none; b=Qdf0n1NuG7DtKj868ICiTsGK4HIt86g+NV7bFJA5OU31bEex93+WbWai1C3PJY4A0e2WHzE7LcctHVem4QuXWAb5wEGbhTZvrPlncAfDxgq2L/tpOsnZ6yXQYAAnymzF1Sp5lLgVGTNQLdy1tujyFUYOUYd3L+unJ8yZk+tugQrgEuw1saDbSX96/m5iScNwnGb9nYuSyl0z26tZbns3PNytz5uCDz5qbSvxQEc9KtxNUY9bapxrUhXhseQbtxadNjSCgyNPBXVbSyB3BX8zKlK5SHFtUBsjIM3qb80RzdBeMNqsV4K+AmFguXJDddu1CVdlWnDOlc6bEnHkiKxvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772282340; c=relaxed/relaxed;
	bh=mOaqhQImVlbU+bIaPkzVliN+MSpqLdHsMK4C5p4HbTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b6xwvwBTOa27IoXju6Iw1pQLCCyEVn7eW0YnHFHw0Kr/R9ZOdTMJv6oeFGLSQOAmmw9oQy0HuXPBuMyOjsiQ8KWLM4ZuB6IZA/wJln87VhIrMVAykkn2i0vWYSaEurFbnKn1LacLh34sN+NK4gUByY0VdXRUNObaDqrqZToc8R9Li7oFfHfQ2GzE+baoqVvauuhvEz3aw0qHJAPeUivYDoNqOESsOgZElB8aMxMvBtQXnAAZDYmkrPs/+y56jdey1cuC21M+1w1KWtaPNWM4KO2sORbm5r4f+q5zBSuKC/q2eqfKBotX20Qaojw3/gNrwVhwsRo5YETHNFBWxc/yeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=FTc9FFEB; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=32egiaqkkdhwfqnhjw3mqlttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=FTc9FFEB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--aliceryhl.bounces.google.com (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=32egiaqkkdhwfqnhjw3mqlttlqj.htrqnsz2uuh-ij0qnxyx.t4qfgx.twl@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNPrg0b57z30BR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 23:38:58 +1100 (AEDT)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-48372facfedso26100665e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 04:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772282330; x=1772887130; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOaqhQImVlbU+bIaPkzVliN+MSpqLdHsMK4C5p4HbTE=;
        b=FTc9FFEB2oX4H2NDoo4zjztcuzQVuFjpC0b13DDAQuRkmNE8qjKetb9Zi0O8BAHC85
         EwQbOsi+aMHKYplw0rePzK/kHqNuT7UX6+dtrhYgS1b7/Yywaj7+DgLmni5gTck6sjme
         iGDSo0TeV+pQswhM+Swqvf6frMJnPf16xziUtBVSE9uVzIPsvMBL8PZp8rCvp3NZUsmU
         jtT3qFcI1+tCCpo07fuq9DGOJC+34Kp/+IsYL9B6Dgh3mw8JUKzrleWl/W/4ecqdeqoR
         9mxHOCmOnInGI9Mm/lhXymRKRKhSmwdGPJNZAKQt/5cWV/YsdsepcuT5QaxMhDvN7/o/
         yhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772282330; x=1772887130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOaqhQImVlbU+bIaPkzVliN+MSpqLdHsMK4C5p4HbTE=;
        b=TIMnJgv5yuYaxITZBeqG+Wi5/LmmnQ3HmNJXlLZ7wuBZDVDRgPFDSfcUF9+p8n6vbt
         s4vQUZZNhquJgbpR+sMZUMpWpx4Am45tx++gfHHHNw0sMBsgS9KDnHmKWPcgiNPPwfjt
         Znm31As6MM3hjDEEn5u6FKEIcmsUIrLoSWp0UUy7j/B7MwIbRVsQj/dyL8kQBFAckaFK
         TDAd6bTO9v35kIvT3aQPpDaAE655nGXnn5VooQyd5VOaoLCZdPzbKEWW1KJtUgKPz8pG
         iQzoTBfmd8LL2lrToaD7bkUdrmfm/EhBnruquUcE0WjsIgtnXTf7deXwdAzLt8duGanS
         kaTw==
X-Forwarded-Encrypted: i=1; AJvYcCUSSrI1jxbUNYU5LUv2pMrT3w63D1rf/RvbYEJG7ZYrt2DL6ZbfTQFANchApJmcdxiPyCMSqFr3Ykxg/NQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyu39Wt1G3Wj9yIU1FV3Yfzdi1q2S/8O5wqiPwMz1iCrrkAZz0v
	ENjPpqSqMUVhzKYR5s3SeigeRSu8aRJnqkmEd+qXqknUUdpOXcH8vkv2WY4VYb730fyYI6Ntqph
	6lm6OeNDzMF4RsfSrnA==
X-Received: from wmby19.prod.google.com ([2002:a05:600c:c053:b0:480:690c:88de])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b5b:b0:481:a662:b3f3 with SMTP id 5b1f17b1804b1-483c990c263mr116931775e9.7.1772282329804;
 Sat, 28 Feb 2026 04:38:49 -0800 (PST)
Date: Sat, 28 Feb 2026 12:38:48 +0000
In-Reply-To: <20260227200848.114019-3-david@kernel.org>
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
References: <20260227200848.114019-1-david@kernel.org> <20260227200848.114019-3-david@kernel.org>
Message-ID: <aaLh2BxSgC9Jl5iS@google.com>
Subject: Re: [PATCH v1 02/16] mm/memory: remove "zap_details" parameter from zap_page_range_single()
From: Alice Ryhl <aliceryhl@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	"linux-mm @ kvack . org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Dimitri Sivanich <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Feb 27, 2026 at 09:08:33PM +0100, David Hildenbrand (Arm) wrote:
> Nobody except memory.c should really set that parameter to non-NULL. So
> let's just drop it and make unmap_mapping_range_vma() use
> zap_page_range_single_batched() instead.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index da21d65ccd20..b8e59e4420f3 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs
> @@ -124,7 +124,7 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
>          // sufficient for this method call. This method has no requirements on the vma flags. The
>          // address range is checked to be within the vma.
>          unsafe {
> -            bindings::zap_page_range_single(self.as_ptr(), address, size, core::ptr::null_mut())
> +            bindings::zap_page_range_single(self.as_ptr(), address, size)
>          };

Please run rustfmt on Rust changes. Here, rustfmt leads to this being
formatted on a single line:

unsafe { bindings::zap_page_range_single(self.as_ptr(), address, size) };

with the above changed:

Acked-by: Alice Ryhl <aliceryhl@google.com> # Rust and Binder

Alice

