Return-Path: <linuxppc-dev+bounces-28812-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FB9CA5FC1
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 06:32:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxbRg1kq9z2y1W;
	Sat, 03 Oct 2026 16:32:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791009151;
	cv=none; b=MwHhl1T/xnYtLVMK8dKPiu+WWPPx1IoznCLieQwXuDWk/Mqagr79K5irdOxZIQVzfsoXENTT6CAW8P347w+lFV01xvsMkh+ZoFed4D7lC4i/vqfs/wMc36NVKax35tnlRIYPAYPrWxEs+mnbKMvvrvRSX/a2gIGN3W8+L+5zCoYpt9k4ePsUHOfxxGcCV4VMezzIXj9MR/XQkynpOyYBImaHmOcXu0fXvT9f2ZlBK6m6YbhL7EXn0xduVB8cOP3J6TwS4vUIW0Ax7LkRi/2jOkmEtNZy9CwzzkHsVK2OdLIoUYaDdG+5KrbdHrH3nIp7Xe4QhVUr/O6byajYqq34ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791009151; c=relaxed/relaxed;
	bh=vr5KVZoPR0cul9dM0w9bT4mgxCHNEHDqUMfTuf7KfX8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=exSwvJ97DLB/cIaCcW3z7x6QK7sC9hha7JDyyI4OEsYwzNo6P/y1fT1nLmh6XsINq6BkQYMcv9qVaaZGtqBmDQC1gn0hi1ZIfbhvk7AsEHMcaedGZXOatHz3mOLPpessSCqL/t8scYDXNiKN/KleyCu9V7mmVqk+LaOM29U+Ne+1+pPncWS4t581B8g3IKIQwtSoCTKfYOHOiIZL40YP2v2oJq35pBkfyPQXGBKWNMkHm0ror+8gR9RZANHOwqa94wLch7OnaUnIIn0xRSKs5zvqj0sMU3S8oNQpZPyNAtSFJ6MxN4WO0kIhzTxEncXI6SmdRk2av917jp1Ah7M5aA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lwHngS7w; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::c; helo=mail-pj2-x0c.google.com; envelope-from=alexei.starovoitov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lwHngS7w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::c; helo=mail-pj2-x0c.google.com; envelope-from=alexei.starovoitov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0c.google.com (mail-pj2-x0c.google.com [IPv6:2607:f8b0:4864:39::c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxbRc5n6dz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 16:32:26 +1000 (AEST)
Received: by mail-pj2-x0c.google.com with SMTP id 98e67ed59e1d1-3a0d31bda43so77538a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 23:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791009144; x=1791613944; darn=lists.ozlabs.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vr5KVZoPR0cul9dM0w9bT4mgxCHNEHDqUMfTuf7KfX8=;
        b=lwHngS7wpqXHMifA1vQk2gjhhdc488oh6gmyBlNn2qJMYIKgrv6p6SbCXu9Pdzff69
         f7v7AqMhLxEp+09Pe45evo4cUT7PQZO00fp2n3h0oHi76gxI9JDP7vje/ag4rAlhgLhn
         uBDu9PpJK5sZvmpJ8TrbFdeK3aqibvIPiZpH1JIBOHptnEocL0EnGdNXG3bkvc8I3zQY
         DuJJPaloPW+1Fk4FF7WlUQ4SObdb9ztmEuVFe5dBS+4bYPdZcigKAn3txJ2IBnsAOBZF
         hDA0ZBAZQPJRVk5ImmJE14O2EhsCvnTuX4JV19IWS0cppWaq7libyYFPjBmOa1d9k4N8
         6MLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791009144; x=1791613944;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vr5KVZoPR0cul9dM0w9bT4mgxCHNEHDqUMfTuf7KfX8=;
        b=WpgrEykOb8eT9LxFyLTpF7f/RwpeCZ/K8MLBax2lxyDNBgTJusTIVcyt1fT4XDt6FG
         eqHWkU+Y2Kp337OCmt+UF08eDxSXSAMmWGYtDetRY17UMSK/2t9/6m4iFFpLIlYb40je
         pWswLJiY8+2c+m1nzCGFfJDkzirWzQmj7cCbscZ6U435YcGPdsi517HA+2kPmx4nmdUI
         6QEtroAhbueQrdhIu+KyF2JfB8VS88rv85wSg6DMLL5UEeHqW/8//RPsR4FPw98Of60p
         jAq/W7uGg+LrtuBqm+VJtNmpJGQLeMnl4aM9b8PlKYttN5nyIlyYZso2ID0niI0ouCec
         sg+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxX538/9GLszjzBdvQjSotLSb1HABuH1mCaBjaVOCXieMSh2sf59PkHbhwYqL3cen0tyf/n/A7uwZY3BbU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIkxEns6qAHXBkwGrgS5eyipnrv3Va/+Yg4W1zvPbYQQFWxyZHI
	3xHzBN7X6sL3F2OE3/Xmff2XNLL0qNQN77hjuFwJTxBnRzvzQGgjArIX
X-Gm-Gg: AYBFou29zJgf9zTLrzqnsEbo/nbYRtN+bplTCXaTPgrs/thN+VzPVc61D9S83VAT2cz
	QXG6d7TgF3KZum+SYgjq4mxpLCwBGGG5y5O40pHNk/sfWpUVJiFDe+c+IJly8UDv2ie+6nFULKR
	A9ETUe+TRhn6DTVISjH2ClqJ47E9RjVVANeSKoOwUl6t7n2soTSHuAgPBbdBciM8eSrH81x/f6f
	zTRwMjc4KzcphwoqV4PXuEiYy6hL492Gk+yzrtNs5AiDAyb7eLazgexycCotSSQdY6n84R9RzoH
	q9U3cy8Qr8zOwWQff1FjyxiVX//y/WlBiCRYfbjXJVAOqt9aKe4TV8b0/o0ZLc3C2uvbI/BEdua
	K+fxffyYGv1WstONuY+ip5xRGIKAyUTExxe7OyTlZomJXHggrJbnXaowXGwYeQL09VNQPyeUtGG
	21dCufRhhHout6fQ/CPf2+87fOdMT4qqPKyB1Ll5TSnc6ReLRpo4rHZdXdDSeEqEkLax4xkgB3a
	OE4Oa9MU8SaPQeAlme/COW4aXcSLbv+MDjIUuHChJTlls51w+v1jpi+Z2gSUnj/+o5rxPY/BS+K
	ft+M/KnbZieHMg==
X-Received: by 2002:a17:90a:1650:b0:3a0:7261:d58e with SMTP id 98e67ed59e1d1-3a6e622a50cmr2049092a91.22.1791009143685;
        Fri, 02 Oct 2026 23:32:23 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d6b5c3dsm1823004a91.13.2026.10.02.23.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 23:32:22 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 06:32:21 +0000
Message-Id: <DLUZR540Z45R.3RTC4COS2IW2V@gmail.com>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Gow" <david@davidgow.net>, "Petr
 Mladek" <pmladek@suse.com>, "Sergey Senozhatsky"
 <senozhatsky@chromium.org>, "Shuvam Pandey" <shuvampandey1@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, =?utf-8?q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Jiri Kosina" <jikos@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Shivaprasad G Bhat" <sbhat@linux.ibm.com>,
 "Thorsten Blum" <blum@kernel.org>, "Alison Schofield"
 <alison.schofield@intel.com>, "Dave Jiang" <dave.jiang@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Guangshuo Li"
 <lgs201920130244@gmail.com>, "Ira Weiny" <iweiny@kernel.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "Vishal
 Verma" <vishal.l.verma@intel.com>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Shuah Khan" <skhan@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <nvdimm@lists.linux.dev>, <linux-doc@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 00/11] seq_buf: Add seq_buf_strlen()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kees Cook" <kees@kernel.org>, "Bill Wendling" <morbo@google.com>
In-Reply-To: <20261003035906.too.263-kees@kernel.org>
References: <20261003035906.too.263-kees@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
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

On Fri, Oct 02, 2026 at 08:59 PM Kees Cook <kees@kernel.org> wrote:
>   seq_buf: Add seq_buf_terminate()
>   bpf: Remove dead newline stripping from format_disasm_line()

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>

