Return-Path: <linuxppc-dev+bounces-26865-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC09C79F82
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 01:45:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfkCR0hC1z2yDD;
	Wed, 09 Sep 2026 11:45:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788918323;
	cv=none; b=J0jGJ5Xu/18gWmJpfJkOC1kAjM8oDzKSP9akP+Ix0+k+hCUGf5X8+WXOYcMWQKCylvbccYuCVOLAM/ZBibZkgS0njLt4lCkjkoNAGo+bndxlmuZuHcwuqjMwLazQqZVJe+6zMyfuw7R/RY/LqDcmU87Z4Jl7vJgkr6wPQ5Het8fdJ9KwB4nioFponR77Zg/6FpyS5b5YVvGGBZFMaZKliulqiMUAFFOr/R/w0vW7c2I7lmhNVP1l3n5ymIRQGcb94ch1IOO6yyYczDIAshbiOE9dhRcNZ25ivMQtX/k0xw7i0qh3pxE0zasmCr+Ruugg4WU3FHNTSx5ovc+TZgRoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788918323; c=relaxed/relaxed;
	bh=tp3dXhAy5jR6y6z8B8hfuKasJOA/kRC+FrcfbplZSPw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aET8Xn725fAb7wIYDc9uB/ws/PrCJSe/PlZfYHnaRMTsVCqzr569GU2lRzJdneRmgbxJVTeCKyFhuRZJoPWFwNs5XJzkd22wRSBnqF+8KQLo+EgSsiu+bIv7qeCsa2kp2ZGHnIsNywg+p47KgFERwM7vYW6l9dEq3A+HJWeVYFOSbsuVGky9M+fXQpHfnNnunGwjVOMz7/eg9onY7GuLUzFbHnaBKSMlZdFn6dqNN7Pi2kzC0NsHlL2LCF/KqJqKlJA5qJWmGWExWS4UX1KnYFtJUT+ENVHJAqxNyPwEl73wxjDQ+385EkJyYv8qW6aYdOjjJuw/JzfIEJZ0US3tFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=IGTljDXw; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=IGTljDXw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfkCP6v9Zz2xWV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 11:45:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 993D1408C4;
	Wed,  9 Sep 2026 01:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46D71F00A3A;
	Wed,  9 Sep 2026 01:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788918317;
	bh=tp3dXhAy5jR6y6z8B8hfuKasJOA/kRC+FrcfbplZSPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IGTljDXwgWO0FriKqdwJFtPwF4QskmkLh1pQ2+3IPqHdcjNgnrUbTK/OI7mrSSwQQ
	 hx/vqsHOSMfoCqwnOJMQqb12JTW/Pczsmtdwzg/3yJc8S0UKEzUUjhUAx6q2c1x6JF
	 wQqqLdHznKYFGH7WFtTIn66xXVi5PzmW0nR/aEJ0=
Date: Tue, 8 Sep 2026 18:45:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Jonathan Corbet <corbet@lwn.net>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, Muchun Song
 <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH v2 00/11] mm: Switch device DAX to section-based vmemmap
 optimization
Message-Id: <20260908184516.c026438445ff3db78ee120fa@linux-foundation.org>
In-Reply-To: <20260908030335.96549-1-songmuchun@bytedance.com>
References: <20260908030335.96549-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 11:03:24 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> This series is split out from the earlier, larger series "mm: Generalize
> HVO for HugeTLB and device DAX" [1]. While the parent series generalizes
> vmemmap optimization across HugeTLB and device DAX, this subset addresses
> a single, self-contained step: switching device DAX to the section-based
> sparse-vmemmap optimization infrastructure introduced for HugeTLB.
> 
> ...
> 
> This is intended to be the third smaller step toward the broader HVO
> generalization. The wider HVO consolidation between HugeTLB and device
> DAX is left for follow-up series.

Thanks both, I'll add it to mm.git's mm-new branch.

