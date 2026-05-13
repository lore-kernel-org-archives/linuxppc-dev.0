Return-Path: <linuxppc-dev+bounces-20834-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002F4CD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 08:25:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFmjr347Fz2xn3;
	Wed, 13 May 2026 18:25:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778660720;
	cv=none; b=bN+F/y/cF9d50dcSW/qEospQyueBH7f2NERiHWiZeQiAO9/ZJKPiXzOciCB/JaFRgrcQN5YO2G2kyedHPlPKoB0sthndrJHsyFGcRBb6gGo0JkvGwN8la8qTI17rmwHH7tyP3iI+TfSnvc1HzgQKVdtT1Q3M79+3rXsYG2Z4SNGvG1e/USvi4iO5J37v3om2/RlGME7UCwRAHn4Q/sxVU9HKf1Ed09ivm/sGKKSvMOxQQFqJs23RbFYzge3g6z942OsGc75thkP9qAFaqz7yxNgfmBLXZZQIgN07RYg5CBCl9Fr1ER9cD6gKfcYcI6hzBXr0AnW0BYmv2vw1r8dyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778660720; c=relaxed/relaxed;
	bh=CLD48dusxWCJfDzdS6HunkRJyZnZflRZ8b1F0quLtJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW/FVgm5PbW8XR9HGnnjPieCnE2AaxgXgOlZ/KkpdJatWd6FnUUhEIrPh4BcrCrAzHcmTrmlnU+A4GLa0a9HU4hee4md4NSgyaZH/0mwupJH7SNhyn+g+e9OiZirv+KSeHpglDjX7qCmAEiTZ2QN/CaI8cPjZ27JJ2JqqYCqJzrqgilEReG56PnYZwNnYtnJp/hPZnsKHLj4+pwra824VayLJnVSqvF2V4yYxfmCoPZLqfvyB5ng/+cKmsCKiSzdVAbaU7bRq2+Pa7tZHDo++AKx3lSYcDIO6rDpDbulr80IqQ3cZ4fgKKeUtbFveotvLbGV1Q6OXRMuRBtd1hxO3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Fqn1PthN; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Fqn1PthN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFmjq1g9Xz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 18:25:19 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D38C560120;
	Wed, 13 May 2026 08:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55645C2BCC6;
	Wed, 13 May 2026 08:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778660716;
	bh=JSyy9ALiCyMEqHUgm72Z1pM1H2TspwwKOZNdcFHkpVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fqn1PthNCmouQJxTKvEkqa49e9kMbx8ZjW0DPMaVRTHt2es57a1NHg6656ytE5Y7M
	 xfUlnTMPy3688CrHiRphacB3UnSw9Rd/FFODhWJWzedH7CbU3U9Kx833Ld2RVdf9cz
	 JdAeNf76qFa7sPqWzmlBaws5HFKZo1gM4GubR9WymUl3LEN7C5mcyiBNUsMGjw4hA1
	 GbwjDlLVEhbLhwkh418o7kDYLkTBR6AI/kuS00EOtagwohqpURrG5qoZtSTvi6IeMj
	 ssn43wPTrIaX3m/jITvdiN9ItwGAmcWM05JGrRhGJtPzNxgJnEQzdD/eROcidXtsHf
	 biRtcHBE0X85A==
Date: Wed, 13 May 2026 11:25:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/8] sparc/mm: remove register_page_bootmem_info()
Message-ID: <agQ1YS0TJciWts_V@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-1-3fb0be6fc688@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-1-3fb0be6fc688@kernel.org>

On Mon, May 11, 2026 at 04:05:29PM +0200, David Hildenbrand (Arm) wrote:
> sparc does not select CONFIG_HAVE_BOOTMEM_INFO_NODE, therefore,
> register_page_bootmem_info_node() is a nop.
> 
> Let's just get rid of register_page_bootmem_info().
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/sparc/mm/init_64.c | 20 --------------------
>  1 file changed, 20 deletions(-)

-- 
Sincerely yours,
Mike.

