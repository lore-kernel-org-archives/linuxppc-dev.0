Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF5606A323
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yDo1IjBd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRYpW1Ntvz30HB;
	Sat, 14 Nov 2026 23:48:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794660531;
	cv=none; b=XnGt0TqYlJZ+3HDNouhot13ogGVRtCRkuD0ltwkdArHrM1I+GXcTYTbzvq+/++HblvF4pZ2VRkZGOasiv7oAGqlN7KGvFhmEUWXZROCdWjTl1qDKqsrOO4P8NnUDNsVWAdiHfDPx0NkBzykxvrv9zGD3Ql8FaCoChcSiexIii5b7E3vTBGkGKyo6/D/B3UJQJYcIBUB1AZEM3EgbhqulfDkV7O0rygEbPX62OHdd/74XCw7KkJ6JbzexJC/etGiNjVblKlwujTCTwn8PYgakakT17eKsKzakOPvA3Qca9pNz8KS/nITKwo7vNikHGUoAA/nr+QyFu91z6gahhkMwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794660531; c=relaxed/relaxed;
	bh=oj9na0DVBDJtudsZfLncNdoZFNBIlfRdys75ekuhQE0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ml48mq9FXH0ulzVxbmYxDuxQNvK6RNANgwifErXcxnIwRHN7eBYj1leJNR1MOpGVdXcWtyoREDJO4BCwOYWJZn7Ip+2MmJuxDMCU2U7isd4oFwUKckTJl9qy0nozqQyaOfvhB5EzD7rFvr/l3AW67OMet9m0Z2sqYpualGJ5HicxDSlRVlvDL5NFKTRtNRPQoadeOK6QO9LMyB4nWW4iJviG7yPOytzDwEfJGe2DaaDJw1fACDNmZhIpDm5vGuG9xL8WPh6uG6/f2p6zrTqhBXaVuO4wfbSlhzl4ZMj9Y5eVXChyGHAFhSJCji9TmvvCXaj0PP0OQmRtu+5gFid6zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yDo1IjBd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yDo1IjBd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com [IPv6:2607:f8b0:4864:20::1334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRYpV115yz30DY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 23:48:49 +1100 (AEDT)
Received: by mail-dy1-x1334.google.com with SMTP id 5a478bee46e88-37628596783so3330303eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 04:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794660527; x=1795265327; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oj9na0DVBDJtudsZfLncNdoZFNBIlfRdys75ekuhQE0=;
        b=yDo1IjBdO8RHVAdB0NeCXVVHX31+v5idRK/fRt9TrvWbvakiMW0dDH1haUkYQAzdDl
         TPN8C3BZEH2mvZczOTRxuVM/tMl8p/wdRURctP+anb6jq4/SbwEcLl1/SHBzHx0PCtXb
         v97/0ekhJtsXJlUt/v8gCRJCfDhg4oaRM3MW5gDwP6hIzdpvOWwJALvzqck/Z3eBCkRB
         Zo4Y8XkCTBzyPGZ3/VUPHsPC90G6qm+rc6t3O4H+ujh4dfrsNpGcCr99mqQ9qeGvVOjc
         nh1vvBk6jfHbXBX6LGlF1MyeULTtYQDR1xAFkJ4ntvuSpDKwkrQEqYn/2xyorSl/j9kd
         2SQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794660527; x=1795265327;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oj9na0DVBDJtudsZfLncNdoZFNBIlfRdys75ekuhQE0=;
        b=YS254eSt90q57Ofx0lWzFeKzWkoZnUlCn9eQb0xBBUH5GvF5U4IpwcGbUtAxiNQVUo
         +SnEl8qvHnhZEsHFCY/PBHe8dSUch+0VAdg7Gds5dX4AFXqalvoIhe3FfRWDnWuLfwjQ
         zQQ3xqNndxaMYKU7iqSvVtd5DajlAgqpLfn8uBUZBEMkY8ulIXMI/AZ26W1SVLjUoV+t
         wLjUPPxdhqS7dSe/HcIMo1zzJbYf1qNVg+GhNolkz7v4VXcljteXSqR+Zp11ChoF2Fyo
         59bNlFzeE2ZTax7/w7di4JeQzc7zgB9Pi5Fp3kSWY3F+F+iwnb+xYlQy1dnWSNEcjxy6
         VA+Q==
X-Forwarded-Encrypted: i=1; AL+hErHG/jGma1KyhjTYCDwInZba8m9msi8MOx17cxCzKs596jcNJ5LajZWF4U/YzJixPoBBOWTcHbUW9yrtyQ8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9VVTY4PNaMW/aXMA23J1/24SILHF1KBs6MXXOj0mm3+icgQXaO
	TsGv1gds5O6UAjPP3McI3nMIBIYFDjbWNKmkgdIgz1rUvB71zxk+oQo/
X-Gm-Gg: AYBFou0E1TAISHqwXy9hfo97Jkstk0DyPXd0WN2zd81P+zdYNYQ+axigoCgTRLaFTEN
	tBhYARQ3YfwO2MfZrQz1hmOvRcbAicSiUN2qHAe5VPCfTQZIyG9G67v0h9gWaGTVK6m66zbe77R
	ciYZt5Q1KxdbjEbCZjGqWjrDzC6rCzlO5Nu3PsaKTbwRq1C8FdmEcwGWVk7GPP5L/Br0UZSkiMD
	h9ndQE4n+Yp37vjYovBrtXNUtjZxZ+ZoZBJKVaLzMJAIB6SLu3IQHxAnUawaWGCYAUFoJ70Nrcn
	rHtTfVohe49cuwvQHIyHG7yr6xe0VZYPkfG0f+WVC91US5nnY2dxM8Jcjzb/Ghjn2BMyuDl4PLy
	HgI3NkyMKM4gu16CVTlK1cMvmtMaKZiDEXW0mjYvX/Ch03myMqueIkRxZl2mUi/oih9QfAv12Eh
	LhbQtMqQhwMGtdj40Z6pbRNQPFw/0LYIYRAQQMBluHY16E9O/10s5vbjQxOpLPZ+GjJGBZGrH4j
	eP0lyvYTD6d9pXcl26vVaylD0KoIK+Su9qMikks+KO0GHrK3yNCdlGlDjHMyIr8VYhc0qpCDITy
	hIa6nFqJ1mkKl2b3YVJ/K4O/jAI=
X-Received: by 2002:a05:7301:da0f:b0:36c:a42d:9bc9 with SMTP id 5a478bee46e88-37966961442mr5196237eec.25.1794660526823;
        Sat, 14 Nov 2026 04:48:46 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379569b8389sm28530823eec.25.2026.11.14.04.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:48:46 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Karl Mehltretter <kmehltretter@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Naveen N Rao <naveen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Abhishek Dubey <adubey@linux.ibm.com>, Dan Carpenter <error27@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] powerpc32/bpf: return false from bpf_jit_supports_fsession() on ppc32
In-Reply-To: <20261003184226.76740-1-kmehltretter@gmail.com>
Date: Sat, 14 Nov 2026 18:06:33 +0530
Message-ID: <cxs78u9a.ritesh.list@gmail.com>
References: <20261003184226.76740-1-kmehltretter@gmail.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

Karl Mehltretter <kmehltretter@gmail.com> writes:

> bpf_jit_supports_fsession() returns bool. Commit 92258b5bf1ec
> ("powerpc32/bpf: Add fsession support") made it return -EOPNOTSUPP on
> ppc32 until fsession is validated there. The negative value converts to
> true, so the verifier does not reject fsession programs on ppc32. Such a
> program loads, and only attaching it fails because
> __arch_prepare_bpf_trampoline() returns -EOPNOTSUPP on ppc32.
>
> Return false instead. The load then fails with "JIT does not support
> fsession". Tested with a ppc32 kernel on QEMU g3beige.
>

Fair enough.

> Fixes: 92258b5bf1ec ("powerpc32/bpf: Add fsession support")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202608010958.cYfBCQAC-lkp@intel.com/
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  arch/powerpc/net/bpf_jit_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sorry, I guess, this must have falled through the cracks.
Should mostly get queued for next -rc release.

LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


