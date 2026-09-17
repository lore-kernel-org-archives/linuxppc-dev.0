Return-Path: <linuxppc-dev+bounces-27643-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35777C88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 23:28:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmBlP55xhz2yYY;
	Fri, 18 Sep 2026 09:28:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789687713;
	cv=none; b=SW5KFG0P9Gad7OWUgWWgC657svG0nGRQQY3GjEiN1gXyjQ4RMIRALOEgQHWisUbl8lDy7LL2t1RmXsYr6jBvxEMTxTYC/1eqhZQ7T7taBd9Bgp2Hyn0bfRME1I2juh1Za8nuKt5XziywFf1eWdtkDlMI2y/9AeY0GO+zKNyHXLUGZQlyhKUJiRQTfhBzqQw5LUaOePpin/TiE02S0yrhBqbHOFJ0Ga+ndM2ZBqFR9fAJE7w0gA+lUzUFz6tzBO7IQQiCCjgWDV6d7qLVnnEoPOqgLln8V5COzFhlT5yUwFiK/oKVfn/Hvv1shnGff6lNiWHK1xAXVU+RlS55inzDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789687713; c=relaxed/relaxed;
	bh=IWJGRC9xwxNiRy963FgpQnyOwKOSfdYPf5s+6GKenIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GR238pO+SKl12LYNbfCGb7iLyIBQz5Fi/TPq772EgdkPUIICefP3yWRBs7aldBfIsU8RvyWN5IC9XCUnV1dQBIZVZnrCJ+kADCt0rPiSYOfGzHdEKWmXVHq3DeaUJlIXUZLzKfm+ErUlv9FKtSjH+zTpX+S2ojjYduxFjlvoR5M8enRHNTHNctbhIiWLgXWBozQHb2RjX4PvnUqqn7DQJ/oRz3DIn0Su3ddVkhC6oMl1TqnPy8VgPa+fuhaRCnMmZsXHU7utHyd9VjV6oc0SJ60BRgFeP/fj6Utc0JfGA2NPtNUgtvVkKbx+1Gwz2vilbFEZDn+vbZBW5fxquSxnxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMRG6GJ+; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jMRG6GJ+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmBlN45Y3z2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 09:28:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6B8AB600AA
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 23:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237451F00893
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 23:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789687709;
	bh=IWJGRC9xwxNiRy963FgpQnyOwKOSfdYPf5s+6GKenIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jMRG6GJ+jPVZWQcib59ikf8sCh9LM7ZZPeIKXq2t1Qa616NOpa2A9yZE8zyfkQsNp
	 XDywILAj2dBZCJHat9rjUD9SXiyT+FIR/P9rULMIOVe6G7mThYpyxf/+gwakDJDQ0p
	 JX+pek5ZzlealjcCSM5DFo3m1D7sEjNa0T+wq8ngURIp9C5stDPdLxz2oxFn+dftXx
	 wj0/JQU+Tdox291aHVZBLSA+nZPmtbE9wAtJqIrz+LX0DcIZUZqN7dHtBM74cZwTAl
	 YOE6AvLK3Mngyu68jQSlXiPocReBiKW2XwB/no1ZLubp2CR+4ZLiALYzxrr1ZKXypZ
	 +lcif3Qk/CfWA==
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-939109fafd6so13393585a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 16:28:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBziFjcH9NklF2fiYg8ww6SbgaF2gFvvVte0ang3KoIEM11nLEVwO+Vx6ilXNUz22bHdKBAv51aJx/rzWvM=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nHYdmzWEOKZsA+2TWEmuRkEcMlZdSK/doKnYCXpsZx5sbsXbzS
	0UI9JXiKX4LYguAMwTjtkXpGqQRYSjBfDQLyZZNmJVIqoW/yDcpGpaky8nUJBW1yd8dtKSEaKwP
	vdLIzxw/nv8k1qEa4h7RtTVVUzyaYwk4=
X-Received: by 2002:a05:620a:280b:b0:93b:d79e:1907 with SMTP id
 af79cd13be357-93bdc9fdcc8mr86080885a.74.1789687708536; Thu, 17 Sep 2026
 16:28:28 -0700 (PDT)
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
References: <20260917052933.188679-1-jiangwenxiaomi@gmail.com> <20260917052933.188679-3-jiangwenxiaomi@gmail.com>
In-Reply-To: <20260917052933.188679-3-jiangwenxiaomi@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 18 Sep 2026 07:28:17 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wDbDLv5mxfNiyraOS6tKCSV+g8xL5+SsRCyqLnN2ON7A@mail.gmail.com>
X-Gm-Features: AcwNN1W3AgFfdfDDbqU2CtZG2lqgv5Z_JbQps_-ItFYT5oYqTIYjvyQ2wpW_oIg
Message-ID: <CAGsJ_4wDbDLv5mxfNiyraOS6tKCSV+g8xL5+SsRCyqLnN2ON7A@mail.gmail.com>
Subject: Re: [PATCH v8 02/10] powerpc/8xx: add pte_set_huge()
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org, 
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com, 
	ajd@linux.ibm.com, anshuman.khandual@arm.com, chleroy@kernel.org, 
	david@kernel.org, dev.jain@arm.com, jiangwen6@xiaomi.com, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 1:30=E2=80=AFPM Wen Jiang <jiangwenxiaomi@gmail.com=
> wrote:
>
> From: Wen Jiang <jiangwen6@xiaomi.com>
>
> vmap installs PTE-level block mappings (SZ_16K/SZ_512K on powerpc/8xx)
> by reusing set_huge_pte_at(), a HugeTLB helper gated by
> CONFIG_HUGETLB_PAGE. This makes the feature silently unavailable on
> CONFIG_HUGETLB_PAGE=3Dn kernels and couples mm/vmalloc.c to HugeTLB
> internals it does not otherwise need.
>
> Add pte_set_huge() to powerpc/8xx, next to the existing
> pmd_clear_huge()/pud_clear_huge() in mm/nohash/8xx.c. It builds the huge
> PTE and writes it into the backing cells directly, without going through
> set_huge_pte_at(), so it does not depend on CONFIG_HUGETLB_PAGE.
>
> No pte_clear_huge() is needed: 8xx does not implement
> arch_vmap_pte_range_unmap_size(), so the vmap unmap path never takes the
> block-mapping branch.

I assume you mean the block-unmapping (or PTE-clearing) branch.
Please make this clear in the changelog.

>
> In practice PPC_8xx selects HUGETLBFS unconditionally, so
> CONFIG_HUGETLB_PAGE=3Dn does not occur there today; this is a decoupling
> cleanup rather than a new configuration.
>
> There is no caller yet: mm/vmalloc.c is converted later in this series,
> once the generic fallbacks are in place.
>
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> ---

BTW, this patch applies cleanly to the mm-new branch.

Best Regards
Barry

