Return-Path: <linuxppc-dev+bounces-24044-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06530C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 12:57:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gy7y63F8vz2y8F;
	Sat, 11 Jul 2026 22:57:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1034" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783774622;
	cv=pass; b=VJQ77jwGC+amLjU+EZapvWGpuiQItut+uU/1NicbjQEjEFwGGv8kOVKI/PlQvigkzogbwxwnhrQw+cZHb++1BpjS/MYZWB1IIi1k2UuhJRSWc0aSlKjCXFSxcQokoPewSSl0PID9aLg0GZ9jvcWQWXQZFyKTWOJFhzjOj9I6Cxbp7SL/Tb7/CHVh6XrIZc1nhMhVUzdLPvcSxtnhgpLbkCxxqGBQ4JJFWzoqNqSuSEeAHOE8Tz57lzhUg7anyQREKyvQim5fQ/zvdSUsgiJ+fDprZ60kv6DvPLpa8m+rptLmlm5NdTWf7oppp+b/6VR4P2SYQdvuKja5K1m8frXeHA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783774622; c=relaxed/relaxed;
	bh=j6tjRunywnAeib7tZl4T028gbRZoamS1yIZMH8Mrn+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+jvvMJq7bxm7MbEFLqMuZzT2msIjrx7kiq/DWU+uhuLqj04ZkMrjw/ZEj6mB0ydVkmZAnPP7uefHxE8Sj2r8nqXTiVxHrWtKAyrLlR9YIiRp83Rx6rPOigZ6lg+DzRsRcGpo0kJvUCcbqK5fuHb5Cs3mTJvjMpcoGlQbb0/IMRjEYc/dwd8XnSbcGbaUS07Th7futNcmQ9j6vJzyuMecqEJXMvViDms7zg89b0uCZwTjnwaZ6w8hk/3hefUx25rp3bbQE1XZ8eQQlV/D8FnuD/o5UgDb2zw7JQ/I4ZIwL6kF092Wo1v4VOtz0JaOZbFSS92ZBK78Mdh59aEijgETA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K/fX9eFx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K/fX9eFx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gy7y56gXFz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 22:57:01 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-38cfcb507a3so168383a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jul 2026 05:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783774614; cv=none;
        d=google.com; s=arc-20260327;
        b=LXaGzS4SCnZveNs8TroQ5ZwPfsjOTTpvfcGI5GO0CQhOix/mxgpmYmXO0/P6kqjPea
         U9co9D87BfLEXHmMCFoQxYP586J6rvW/nOLYi5rb+74zZRe+mIbZbNcxdBYlmxdy+KEh
         71qr0kC2RQSPTmVBVOs/yPxXEERp4ST+qSY+XbMKsYAEwmHHcwtP93EBLReqvfG13urK
         NM0NLqXFu1Ni7UJuOjCVdfbvvWm0i0AbZgWFgdbZkXHG3jhSqJBmpEJSyUcjQcAw4pbB
         IOfPTKKjvjq3y7rfKjLI4kHEJhfUeosLqJM7Ks3xDHKHOSUTVNxcD1JasgSGIKxOoAod
         Otpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j6tjRunywnAeib7tZl4T028gbRZoamS1yIZMH8Mrn+c=;
        fh=iOP7o3nhasDbQ5wxH64y6YTwZW+Wt9ATkeR3dMEyoM0=;
        b=mJoM5q6JziczgVxw2OVwBlFTQBBejRRy1MUf24VwZv6Ct/u4p+KA6aTJ5EKtA9PjSK
         JTQxF+L2TRZ5KpMBzk/XOzifNtk6guqvuMWRHPLe51J57Hnj+UWJrkzSW4daVejTzDYe
         8xDub/t9PDVm5D8mZRLuLj/YU+dSLP/GSXBlgVqEMNWg4r+p2qox9q9oQSHjWRe31dMA
         LSpj9SrPOGcLjoounWkV83cFgmYdRLvO9dTXc0eiKfRU2X2o1gvHXwCEumZV0AeLFpDX
         n0JI0BJI6U7hmjbEjCXj62a53XfQxpE7jxN+JyTJyxmAFjBZ8zWFdZgPjM5frHMDNbzZ
         xIzw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783774614; x=1784379414; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j6tjRunywnAeib7tZl4T028gbRZoamS1yIZMH8Mrn+c=;
        b=K/fX9eFxai7gaDQBK2664iLyu2dTnU7ZXtf7xOjD7OXHjVj+SiaXqlx7OllqBem29X
         Sge65FowPU5E+aXcNFeIy4EXZ/u6BYXjlHxS+ei+7H8yj+Kb81hSkaNjCKxRPqWbdF1d
         elY7SqgEByX4wobkKz66nVCbO1GmuFz5ID2SKLkbV/LsJu3KDwru33NvFqi5HMWcE78N
         LCqqLDiKiP/iirGnbCa3/TppWgdjDkwx7xRDM5ZQI9wU7FmApVsS+CBn/9iaCBdgSy8B
         5WVOXPJyHD3MPjTlUGKLJTAw/ER22+L7HWPH3bEIuoJeNobHugMCqWJiUnqg+36ITMGS
         yEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783774614; x=1784379414;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j6tjRunywnAeib7tZl4T028gbRZoamS1yIZMH8Mrn+c=;
        b=Iu3SQ+OuIdNGZPmQrMe7EZgETzzrr+UGvBEz5ZRYBiBQczMWp/ja7Ltta4Q3P+7bDK
         hAkDnGbazHtbn7jJasp/xYSRBM3tRZNhRT35XX33Gtk0yULn5MbVh2kEYxG+rOxbj35q
         N46JreAoUQOZ6Y6UJMQRkzrBhxYihK7nnZyuHwypGqJQRXdb77lppvCdyRjrsAAubgRK
         uCNgz0SOU3ECJnLfvFPxez6AfGZgOzCVmHWc8dEFQfgP8lAcdxw2YBoFZYam89x/VJ0z
         VQG7uZzMmmIlkpLcwYeL5ntdwTqC4vmzcSYCXqVkKUYqhRKrI7f9ZlpunrsFMYR9RzYG
         Q20A==
X-Forwarded-Encrypted: i=1; AHgh+RpvdW6yGTxe+NzBMn/kq2uyd+3rb+cpHQf58OOVwZ/74Uf8oprv3Gnhwe9G0Yx9oT/pyV2RhwVZy7lRJ30=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy3RFR7YfuuKezSKowTX+SSufalSvt5h7K/sa8Fzws88AZNkDva
	7AA9mczZVbu1tr+AWd1MIG7fbZUKwTjAKjh1Kh4Izu0qNr1IimgwBwyGIeMZZr5B6rV5wCAIwQm
	RE6pAjaJRiAofQilx0sy3uTPJtgOLdpQ=
X-Gm-Gg: AfdE7clU1uqWWk/QAg5vVB8vrJ8R3r2d3ubhqyxgB92OcqwzEU3Zk8fHayy81BoH8tt
	8TjyMHszRrdVzkJ+rMG+GW3EO14IydbF2DUORhy80KajeWHyvyWAOMCzTmdefUiiX/Fn1v6EdS/
	Zud+2kyJqH2LYIL+p1xWvxmEUayJmGROAI7QWqxlECl95Z9xhLkGBYiaqzv75m+CZxi+K0NrNno
	XvsUx+RucImZgggvlwGyEAgCTovQlCUV2DXQS1yXuFiKGzje5n066pESSWzeLG21cFTIZbLjqxo
	gdW6qKdYfWVbpNrzcJJf1cCCBK2Nmv57urWqy436KHaGcNiiKP73Y65cJd3QqAPj/Z5rIUfp9ug
	cQIcrjUMbyt3V
X-Received: by 2002:a17:90a:dfc4:b0:37f:ea8e:ab79 with SMTP id
 98e67ed59e1d1-38dc78226dbmr2320021a91.2.1783774614151; Sat, 11 Jul 2026
 05:56:54 -0700 (PDT)
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
MIME-Version: 1.0
References: <20260708082454.1254320-1-mkchauras@gmail.com> <20260708082454.1254320-3-mkchauras@gmail.com>
In-Reply-To: <20260708082454.1254320-3-mkchauras@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 11 Jul 2026 14:56:40 +0200
X-Gm-Features: AUfX_myT4Cl9iDVoRO-w6Sfw5_PJOQ6oQg6JiFlTfoXu1j8VbTkYVMyuZ_7giAk
Message-ID: <CANiq72nw6SM21M3y=xXd81kT+bPbctnpPVi4QGL4K2XUS6bUzg@mail.gmail.com>
Subject: Re: [PATCH V17 2/7] dma-resv: Fix undefined symbol when
 CONFIG_DMA_SHARED_BUFFER is disabled
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu, 
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, nathan@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	fujita.tomonori@gmail.com, joelagnelf@nvidia.com, gregkh@linuxfoundation.org, 
	prafulrai522@gmail.com, nsc@kernel.org, japo@linux.ibm.com, 
	lina+kernel@asahilina.net, j@jannau.net, airlied@gmail.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 10:25=E2=80=AFAM Mukesh Kumar Chaurasiya (IBM)
<mkchauras@gmail.com> wrote:
>
> When building with LLVM=3D1 for architectures like powerpc where
> CONFIG_DMA_SHARED_BUFFER is not enabled, the build fails with:
>
>   ld.lld: error: undefined symbol: dma_resv_reset_max_fences
>   >>> referenced by helpers.c
>   >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock)
>
> The issue occurs because:
> 1. CONFIG_DEBUG_MUTEXES=3Dy is enabled
> 2. CONFIG_DMA_SHARED_BUFFER is not enabled
> 3. dma_resv_reset_max_fences() is declared in the header when
>    CONFIG_DEBUG_MUTEXES is set
> 4. But the function is only compiled in drivers/dma-buf/dma-resv.c,
>    which is only built when CONFIG_DMA_SHARED_BUFFER is enabled
> 5. Rust helpers call dma_resv_unlock() which calls
>    dma_resv_reset_max_fences(), causing an undefined symbol
>
> Fix this by compiling `dma-resv.c` file only when CONFIG_DMA_SHARED_BUFFE=
R
> is enabled.
>
> Fixes: 9b836641d3bf ("rust: helpers: Add bindings/wrappers for dma_resv_l=
ock")
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Andreas sent a similar one to:

  https://lore.kernel.org/rust-for-linux/20260708-dma-shared-buffer-config-=
v1-1-8c1571000855@kernel.org/

This is earlier, but please see his approach & Sashiko's note.

Backlinking here for reference.

Cheers,
Miguel

