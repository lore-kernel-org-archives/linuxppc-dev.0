Return-Path: <linuxppc-dev+bounces-18533-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D4E1093174
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 05:31:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd7N713Syz2yYq;
	Sat, 21 Mar 2026 16:31:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774071111;
	cv=none; b=e3GwiQBPBeA8TuYZRaG5wexNV1WK4w86LcXZOwJhAN+QkWqNSpdhBjk8SojDLuEZppJK7gp/hYY/9YS1DCmYjp/mbcmtw+RIJ2Z2mNB8diUGJpeNosgtD+ruF67aWR276oW+VPeTziNRzwY6vATADkm07WYF4GRxKifwBzrnnN7waeoSV3L0++w5HzCjVRlRRrKMaS6xEferR3W5e1Hjeye8lCWimFjO3YqpH/Hu3l/5OreJMT4fYG3I1xIGJGf6UJ37TPtjnIAzS6+QySP5y39OoqPYFdGAjF3osCNQ1mpLynsnXwdavTqhGbGQnPvj69vy3c/ZBChSVq50Ez23FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774071111; c=relaxed/relaxed;
	bh=TSrGnm4uwHURRo/Dbgx7AVRGahiZ5mij0ljFmYODkAo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=OdAQrsWbFEnykgAW4oNIio2TGPWWOe60siAuOYKnXcvZ4Vxx23C9XcF0leS5NhVfrT3fu2a0JKVHoDC+mbx6SNgLYFJoUUG89M1FE1ClYDrZOWHoxOH1Ty/rFk7IskugJja7OPrj7h4KnRQ9u+O0yCZ4TLf4FhlbMXFpjbTTn42BJJM179yV0Oa/jeq1mT8l0Z3ZaDA1F+EOSsO8bYUr7CPP4DjfXN/lv6Qe3mC0y3b9x9o+7sM2RgI7voVpDRnXg1wzn3fjWGnhBD1J0IVhZmOaK5EMzGlZ+w++BayJoABbSUfkNRc8z7RD/Cu1IPo0yqX2fMOzhNUCWVqSlKtxBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IiETmN2F; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IiETmN2F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd7N60B7pz2xP9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 16:31:48 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2b061b6cf36so9049895ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 22:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774071107; x=1774675907; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TSrGnm4uwHURRo/Dbgx7AVRGahiZ5mij0ljFmYODkAo=;
        b=IiETmN2Fqqy6PEWnpb4LokRlqa1VVCPdG6hT4bf4yszoNiO578MRMZB/PRPsM1WirY
         dO4/6+P5Thiy06mHL5V5wRm/4OVOfwqjpEJZJmhhxwzSQdcAmQY8QWkRC2f+p55dBCN9
         jsm1HUN3anjxDUfLlubQMAbH1XU4qp2LHsuJe+sXEjSZ724CScPoiAXdDk8Mg+3nXu+y
         HMDps7jxKXz6r9u8gNm6rMALEaDVFuQOiTOc8/d9xv/URSVHV0IpkuyMScpEOY3Qk0H0
         pEZyW1NSuvEYdXKgtP6fcvq13j73NJ39q+5rMxqVM781cF79oqFd2n+W+hiicaq6WzK6
         2L5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774071107; x=1774675907;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSrGnm4uwHURRo/Dbgx7AVRGahiZ5mij0ljFmYODkAo=;
        b=GhaS+yHCFGYdaw+li9JG7BbvoosmuMvSpb/a/90gWKkgXDgEd7eVRV4ytgvTLLtm/P
         g3PT774DO7/Y4SHbYjuOYGvCvcQ9Ul8hS5XSqVxx5IGqwIPilGIWSqIc8thVYZfwYIEY
         +A2gyEcLgC1j1n0zx7xiBhpkRSZbvq7eagmkHp2eUNCUxpovCeuoNKbLu2eWzEV0ajoF
         Xr146Vdo/FXtFYu2f96K63jHsfgDM5TTnzZ42Nc2AE0MHC5n9TjXjCTKvaVbV93YaAT6
         Upi95Df7LNkvlyadNs0hUZgVPwHOMDXyacypEqQ0fvLyL3Xue9IRco6GQABmfKuhRiWy
         GztQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI6AqiJUq8XUn8+Hl2iVSsOp8wdY//40R5POK+YGjApxc/XxyQ4BPbf0T+r7fpUm9O3vZeyGhpagEE0Ik=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwxaymXdB8vjxE57+bHhtCuhA9pj6R+kIYLBBbvwR8pVkgwt2aQ
	L4vps7RjiPim7FwM+f64mnVytjOeukhV/qcS7GL4qCL53tDiNH7e+P+N
X-Gm-Gg: ATEYQzyOXnxNitwFAs6WKiNLjL9qE3lsRp4tvdysx/5FTjg3tjh1+EsOue2zFMHVRDi
	Vajq6OkzrkHGwS+8I5UA+ta4OEOqHw2fuGyjLlJCa6YSSuUbR98zvtyJ7mid6bqnrrh37sf7oo7
	yOqIXRx0MxOZrRx4PyifuQE1j4b+04TuNKqFOcCWeZeV8zniGNpxgmphFSbLyt0E/CAa/8IP2nL
	7QmInI0OuwLT9yTfzifUnrIfLIFZ8eczh4mUAblPrQVw9xK3vwzBTPv/tkYCD5uxhmA+/hl//BH
	oVG2mP3Y4PlYGOANWgaA/7921tOOSg37lYDrt6X7AgXPjlhBoqNJnu10NEL+UzEVlMAVSaXHUzX
	FabjfkgF6Z26qhP9PXZgHqRXgFoy/1/LjE9X7RqjOflW2SWE1zD25bfL3kygDUphVQEPkT5Ugg9
	Bw5Ue5IzvajVdIdTRy5RZxbQ==
X-Received: by 2002:a17:903:191:b0:2ae:8272:deb0 with SMTP id d9443c01a7336-2b0826feb3dmr54931105ad.15.1774071106610;
        Fri, 20 Mar 2026 22:31:46 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516aa6sm55638395ad.9.2026.03.20.22.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:31:45 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, david@kernel.org
Cc: ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, baolin.wang@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] mm: change to return bool for pudp_test_and_clear_young()
In-Reply-To: <2711ec4bf6c30182004e34027fb31a2e8e24749e.1773890510.git.baolin.wang@linux.alibaba.com>
Date: Sat, 21 Mar 2026 11:00:45 +0530
Message-ID: <cy0xycje.ritesh.list@gmail.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com> <2711ec4bf6c30182004e34027fb31a2e8e24749e.1773890510.git.baolin.wang@linux.alibaba.com>
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

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> The pudp_test_and_clear_young() is used to clear the young flag,
> returning whether the young flag was set for this PUD entry. Change
> the return type to bool to make the intention clearer.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
>  arch/powerpc/mm/book3s64/pgtable.c           |  4 ++--
>  arch/riscv/include/asm/pgtable.h             |  4 ++--
>  arch/x86/include/asm/pgtable.h               |  4 ++--
>  arch/x86/mm/pgtable.c                        |  6 +++---
>  5 files changed, 14 insertions(+), 14 deletions(-)
>

LGTM. Please feel free to add:
(assuming you will anyway kill the unwanted externs)

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


