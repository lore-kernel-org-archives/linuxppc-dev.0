Return-Path: <linuxppc-dev+bounces-18155-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA0F106ACEE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 20:58:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fX0Ly5dSBz3cHH;
	Fri, 13 Mar 2026 07:58:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773349082;
	cv=none; b=OpWfPR3Bs7D8UPuAby3NbMWmTxtj9DeLLBol2xRamww6gnhHTDmxkb1sR64pAX7eahs6+sLh4By3N50Xn8pblnH/p8AltoLlkfF2PziVilGYWtLZZ8SLxtcX7wW+Vswi6kypIsoZBoIUKvdEKde7HLcVIYuVdp87O6xwTxHj/oyP5R54Z20hnLx0GeJuZNuQJZiSN+9F7XT61wRu3QT2MUYY/XdEaM4czqMrpLTu5Ix5AWSXjn97+iNUOHZ/Mx3b8jSbFi1NdmopiJKRSvdBtmrK/Fo302OadA0KvVGOuAnxhx/le/VH0DnfK90EG9RTe1/deVbuKkVaLyCQR38mzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773349082; c=relaxed/relaxed;
	bh=0OrgL1iQRwZHOzCyRQIk0lufG4h3ls5sHWCdkmfF4e8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Bs6iQ6IlLVEn1qjuY5AUEMYjXS7BG/izp2LCYPSLUSIHAp7U0Nkk7jfec3+5ObiCFSKaMDreKLgY3d9nhMUh1fnfF3OG8s+Ij3LCXyhtAdkguIcYufRoGs5Ts1zbff547wiyyL4w6h5tlESqDRv89hONaDvr3H+2JVEy5QWm/EgX4b4R7/1tnqetogQ0rKdIcsTZZmaq3ay+/kGwJ+rtCD+/cSXQHa6dZpWDZ2ZUJW9JQ06Rq31PIc2iAwLqgnaNF0M+HKGsumPZaXaq+YS9k/TFi0xMeHxt8Yq4cjyq2jbi+pGx79KgLy+No9/bH5Nz4sthbOuxChnCJM4py1iVXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=FLiV1etm; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=FLiV1etm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fX0Lx5nnkz3cGK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 07:58:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6134260142;
	Thu, 12 Mar 2026 20:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D739C4CEF7;
	Thu, 12 Mar 2026 20:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773349079;
	bh=K9BkTSEP4DAO1oqXkTRgIUsMciXJXXN0g3ET3zAlngE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FLiV1etmYVcSGbbdm/XWzQaxQrtcu+DjcXjI6bdWYsu841NM3z6Xw64cXI54+iaIn
	 L2BrHY9lnVUqIJ6938urwDNEtRFz9ffekCMe3lr4UZIlR45/w5t14m5ix5+hCEMOxM
	 z/hIOPZIY6kgBHdLKvnC8iu8NrktiaWhHWtId3+Y=
Date: Thu, 12 Mar 2026 13:57:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v2 1/4] mm/page_table_check: Pass mm_struct to
 pxx_user_accessible_page()
Message-Id: <20260312135757.d65e8145d9d39e1ca5bc9666@linux-foundation.org>
In-Reply-To: <ttbskgg@ub.hpns>
References: <cover.1772812343.git.agordeev@linux.ibm.com>
	<ca77f3489453c2fe01b25e50e53b778929e0dfc5.1772812343.git.agordeev@linux.ibm.com>
	<ttbskgg@ub.hpns>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Thu, 12 Mar 2026 16:02:40 +0100 Vasily Gorbik <gor@linux.ibm.com> wrote:

> On Fri, Mar 06, 2026 at 05:16:30PM +0100, Alexander Gordeev wrote:
> > From: Tobias Huschle <huschle@linux.ibm.com>
> > 
> > Unlike other architectures, s390 does not have means to
> > distinguish kernel vs user page table entries - neither
> > an entry itself, nor the address could be used for that.
> > It is only the mm_struct that indicates whether an entry
> > in question is mapped to a user space. So pass mm_struct
> > to pxx_user_accessible_page() callbacks.
> > 
> > [agordeev@linux.ibm.com: rephrased commit message, removed braces]
> > 
> > Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h             |  6 +++---
> >  arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
> >  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
> >  arch/powerpc/include/asm/nohash/pgtable.h    |  2 +-
> >  arch/powerpc/include/asm/pgtable.h           |  4 ++--
> >  arch/riscv/include/asm/pgtable.h             |  6 +++---
> >  arch/x86/include/asm/pgtable.h               |  6 +++---
> >  mm/page_table_check.c                        | 15 ++++++---------
> >  8 files changed, 24 insertions(+), 27 deletions(-)
> 
> Andrew, may I get your Reviewed-by or Ack-by for v2 so I can take it
> via the s390 tree as well?

	Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

It doesn't look like [1/4] changed significanty since v1?


