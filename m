Return-Path: <linuxppc-dev+bounces-18004-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD38FD88E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 03:02:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVwXg232Zz3bTf;
	Wed, 11 Mar 2026 14:02:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773198163;
	cv=none; b=i6CoD/rqosuDaEQictCPAPPX34L5ubb+Q24ndhTe1LMZdj3sj2fdEITgqhinFftT2rzLJqTXRmWb2PVv7oiwGLoTkIDnR15ETka+EalwoDGpnr/6F33J04MVl4ryJFBpPo3cf+VVLab192k050zF2KxWWHvl7XnRRs/tdZAKUuxK+plr3MfowY8zepS74ijE5NxHmcw6lo+Zz72eShI1Mlm7nqXZXzPWQDApbmqSSSWG2+Bz7WgJEj1f1nPKWLrFnv3EINRHt0y2fRT7T0B8R1aKzYLUSE/Xo/EJN51ZRR8HXhHfBmMZf6paUjvXRNj5ujOQpeBE7awffu5vf8/ALg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773198163; c=relaxed/relaxed;
	bh=vO8RhD7fGikYRNYtDoD/8DClVqthT19fczPJykhciJA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Ynx452Dw7P9dw1/iINNN7Fz0+g0f8SAVskCXDmXeprOczZbNulztay76XMNgZyQZvmmXVyoBMTmKiKAK6YAqY8QL9p79hTMfZJ3lciSCY7tzXn8p+FPpa7DLsQ+Yx+AKPIAhP5QU9CvM9A8G1GZKSmOL+8gYhLyfasvYJLlkFcLJS0Y56cmrGK8+BNW1Ld6SBdcHtv+Z+PP2e+9fhZrN9wqZJR4ztGGmMUkzhZ62kN7v4AOcSquAA3qdrbgzPoB094qGqLkZt203agDRAYyRlNBXk4EyFu0bggPtbWcKGmShgIc8Bzw8/vKZBRbNkgAN81XHonLHbGX0oiQfxwrASw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aNTGTaNK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aNTGTaNK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVwXf1jmbz30hq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 14:02:41 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-829a9c03780so4478007b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 20:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773198159; x=1773802959; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vO8RhD7fGikYRNYtDoD/8DClVqthT19fczPJykhciJA=;
        b=aNTGTaNK0xgpMGwEbQOyn4xZdLuopMnx1Avjj9QkzqONLuo7FEkT7xj/IdLp8cI7mj
         llHNKXY4Xcp/JyiL1lE39Ni+LnFG58JGE/ABIqtA4seJwrLq4hK64r06NPaMHblRpdgE
         3EPrDjw/WmrAd7oUTmSDCCq5CHpB/oM0l5wWtUBE40D8ymNadvZn0ObYaNM1c4LVY0Qg
         pDv2CIu2BR22VyXrqr0/XSnoWQYxiHCKJNUPkguS/LWVi+savz5LKp2lYa41LE7My9it
         Nt0g6TpW1XMGj+87bnmxm0bfGLnrJflvaTwYJfJji/LIJ3k7/20WuJyI2QbMIgP57WIk
         lg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773198159; x=1773802959;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vO8RhD7fGikYRNYtDoD/8DClVqthT19fczPJykhciJA=;
        b=rBAPxLhSFeWW5sKgxEruK6TLSb/jLuBb6mzO5BIthbyDqbzDlcT1Ub3CQP/+NGHfdu
         n97QYNQU9ClJbgq+G1d2cCKySb/0eG8g4ZVe3yTmflIfdYkk5d1UtHKhg2GzBmFwLyPe
         MS437DuekmwQxckTvED6f1iAzXPJO71szS2Z1vPX7sCE/RGpuwN7O4S+/Q1SQSgldjAh
         h48ZPsFJ8J0Kh6JZzIQTygXvYLCS3p9QtRGpLY/rB0WTjyeyQG0+ohYBKCtYRk8MZbdH
         5Ksw4Vf4H5xe8xXrH3W7MXoqc0dd0bYRlOAyC6za9rOkTU1KoPcGErmDEuB9JBu61s+B
         aqxA==
X-Forwarded-Encrypted: i=1; AJvYcCXy8xONmOHmauhb4TZh+5DujL5vjY69G+bt1bJEgO67WMgwZq2rfoWlPew+NMEaYV2kAC/Tt5ogPNCbI5A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw18oC5d8KALdPC1ucaqUgT3IB0fpb3KD+aM31NGnQuVIyVXRXJ
	enME7ls5p6PJ5fEXkuBGfGvnamh4tNa2Ggf+fAvWf2yJsxNoJhBBUqZy
X-Gm-Gg: ATEYQzxi8lkb4lY3+lJE5EY4t1FLsS25A/PpxTE7bCt7DDAsVMtNDgauO20AqWIRB4Z
	7dYPRdQ52ge5r8WqSd+WpAN7e01tVWwY6Y2yKJq2y8I4FVrYmZsgEAlH6YztU9+5mF9ew418dN8
	eOZU1TrOT7U+vdImjfqgF6Q/tdeWSifV4AXG5Qu06PqnQiPXxEto7dGkRaiJlaTag9XzjCEbv59
	2n9/QiEE5F4EA1PqvmjdXQjSjV5aYfq4tIbFNqe/zXMFYss1jtiLxryeE9XJahKcbbT8TwM1sF4
	5+300Ux5LZg1UQxRFZFHpkmOGkIP2BZPZ7a743i7FidBRapjinRPUquuF8bsQdzUz21tzIxUTJj
	s99url9bzEdsj8y+f4yciuu3+2qYN74Bwx9UFg0CvC53dqGdIXb9vE+lWTk//FNHBfU08mw+9uz
	NV4yKnN+ES3nSK19HbX6CSzQ==
X-Received: by 2002:a05:6a21:38a:b0:398:778f:6973 with SMTP id adf61e73a8af0-398c60e5857mr818593637.40.1773198159334;
        Tue, 10 Mar 2026 20:02:39 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf2725csm548196a12.13.2026.03.10.20.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 20:02:38 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Pasha Tatashin <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 1/4] mm/page_table_check: Pass mm_struct to pxx_user_accessible_page()
In-Reply-To: <ca77f3489453c2fe01b25e50e53b778929e0dfc5.1772812343.git.agordeev@linux.ibm.com>
Date: Wed, 11 Mar 2026 08:29:53 +0530
Message-ID: <zf4ft6ja.ritesh.list@gmail.com>
References: <cover.1772812343.git.agordeev@linux.ibm.com> <ca77f3489453c2fe01b25e50e53b778929e0dfc5.1772812343.git.agordeev@linux.ibm.com>
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

Alexander Gordeev <agordeev@linux.ibm.com> writes:

> From: Tobias Huschle <huschle@linux.ibm.com>
>
> Unlike other architectures, s390 does not have means to
> distinguish kernel vs user page table entries - neither
> an entry itself, nor the address could be used for that.
> It is only the mm_struct that indicates whether an entry
> in question is mapped to a user space. So pass mm_struct
> to pxx_user_accessible_page() callbacks.
>
> [agordeev@linux.ibm.com: rephrased commit message, removed braces]
>
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/arm64/include/asm/pgtable.h             |  6 +++---
>  arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
>  arch/powerpc/include/asm/nohash/pgtable.h    |  2 +-
>  arch/powerpc/include/asm/pgtable.h           |  4 ++--

straightforward change for adding mm struct param in the page table
check calls. Also verified building different powerpc configs using ci.

The changes looks good to me. Please feel free to add:

Reviewed-by Ritesh Harjani (IBM) <ritesh.list@gmail.com> #powerpc


