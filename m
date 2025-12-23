Return-Path: <linuxppc-dev+bounces-14946-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A69E6B26B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Dec 2025 01:31:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZyCK6TqJz2xdY;
	Tue, 23 Dec 2025 12:31:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766453485;
	cv=none; b=e93X0WMW0aZCCDJk3qzDKXr6grf0KGsab8OIVa/MW63zThY9RsSn/TqQBFosVekR0nTjw7pYkxWzzZ0QFRbbyvyZFBrOkyfDbYZTAf7beOwPfcbm2lPJoDr0C4KeOI+DfyiNsx0l0o3lDCj8NEuEZNPAvEH1iwQ2ALU2SgaVtYcM+dy364RTvWM7rl+dRssOYHerpXoak+aViofHwl4qyo9Dh1M49IR8RA19Rqj3wu9tsQn2URT25iFIzPLFCBeC95Fm6DaC0vhfC4/hAAYwJEloDNX8Bnosib/f4nPc/ragAxw/DpLLs7fN524psDiIKcGouxRDDUsD0w/rSqowxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766453485; c=relaxed/relaxed;
	bh=BKmOTCnahQz8ZADEqQpJwAvY9dVZYhmtgKDELnz+lCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbkz/31SzkqIEs82yqteE5zl/ORTfGl4625rpVwVLhwewLo7rvWIvn76jzaE6MPHFeBCwwMCXcgvNdy9kH1sRKHA3cuoZHf65LSNAZs77PtKWQ0DvxlztmIEvAPIgKPUx6w7EhDMNb/uex9HUM3uhneh/HMlTi8S++bq4kVcb0Bn4XokeDcR279Pw+mqx2aBDSVZbDfInbH6NkKU1brRh/qBFnsmgePGSW/NeJAYCxSSV7/dQQ+s1l6+Ycx8W/ScT+Xv9P8nd2+V+JQfI0MoIduOE3cdDrsIja+HIi5+k+Zf/T2TQk8A503NKslwKsP3TN0X0eQK4RyehnWW9fg0Jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dO5p1eAe; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sj@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dO5p1eAe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sj@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZyCK08Ssz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2025 12:31:24 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E74CF40DD1;
	Tue, 23 Dec 2025 01:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613A2C4CEF1;
	Tue, 23 Dec 2025 01:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766453452;
	bh=j7q2987NriSlS+UGsGEBmtZisdMET3w6wHahvWlFCXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dO5p1eAeCiTmrLjfR2upqrJjMfmN+fqYqX5pLP/UpyRrXF2AUHgEYFwEMyD3r1obi
	 pEDjXWgKmiqndnrwphcQ1xmocdXiVenBgaQpH8OhamNZ4Iq/5MM1cZj8puJ14LI3RY
	 LIv+2+3bD4SBxu39wqhdoZkP8nz/qNyqFeQe02gX9CRGPAcZc59Hrq2vgSPjMPIkYw
	 UaOU0CNfN/e1qXIcM9EXSCPrhHOvAC89afJ/neG7VaxyRjcLSVrHRanYLjzuXOsJWy
	 l8K/ZNSDlGs6d4U/rrmNlDoBWYqa9kWYB4qLSlkOXTaf4oEIb8M8vGOL0VKP76nvWM
	 AiNxz4lmAEbWw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] mm/hugetlb: ignore hugepage kernel args if hugepages are unsupported
Date: Mon, 22 Dec 2025 17:30:44 -0800
Message-ID: <20251223013045.4579-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251221104907.032abf56c67f3e50c9c94e31@linux-foundation.org>
References: 
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
Content-Transfer-Encoding: 8bit

On Sun, 21 Dec 2025 10:49:07 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 21 Dec 2025 10:22:44 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:
> 
> > > 
> > > My main concern was -
> > > A fixes tag means it might get auto backported to stable kernels too,
> > 
> > Not in the MM world -- IIRC. I think there is the agreement, that we 
> > decide what should go into stable and what not.
> > 
> > Andrew can correct me if my memory is wrong.
> 
> Yes, -stable maintainers have been asked to only backport patches where
> the MM developers asked for that, with cc:stable.  There may be
> slipups, but as far as I know this is working.
> 
> I don't actually know how they determine which patches need this
> special treatment.  Pathname?  Signed-off-by:akpm?

I guess it is pathname, based on ignore_list file [1] of stable-queue repo.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list#n16


Thanks,
SJ

[...]

