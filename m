Return-Path: <linuxppc-dev+bounces-22182-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA62DCD8C8E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 08:50:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYm3N45cKz2yCM;
	Mon, 08 Jun 2026 18:50:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780908656;
	cv=none; b=jBbyOwenSDV1Y/TbEYPnTRbQ2NJe0CIivm6crwiXKzW92tAQr7XpccLiWnvQQutM/R5PHxdKc0e9BIwu+VaU1ehaQuDCdYaw6Gbm15Gomr0SjviSRRKmi0RZz6hPgK6G/OezFDoBSPBNslLsbOx3yjMPTUqWwP4T7tfvl30xBi7/qiHZVXJzxKrRbt/AUiqqphyn2OSOVV3hVUq83szUHVIrstEq1aV+ViEozdBbyZ+uBuZk0/xs8FEPDZHQJmUFAu3tp1fpiH6aN9jJl+TjSeztqWzG/pTdYqa7bHrWe6ODjbobquCbBeTotJB+yPFZs0RdVTGb1qkwSVEKKqhEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780908656; c=relaxed/relaxed;
	bh=dluz+I3N22ywYzoz/gAwyyxGhCLB7ATDVpgZxGTd1Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U13zClUnesOHeRgRIQhz8OVslwyzdCUqRM6XHYrJeZLqJSfG04s9vj5ZpzWguHfSO8Xuo+Dw3FsAjtmcH7atxC+OYveeFLCdY4xl2c31+EzQwcmkjrf2TUB8ZluQ4UOYVhrKNFQlKlILmHx80hBHgGe9cXxBHNjW0E+onu5C0natmeMq3sj5u6RFydqZNVbX5mziU/qxGivIpO1yBajoL+jtIzE2CrC0xKFRZ/v3hP6d6VBqj3587gtV7SL5GqvXtTzZr95Vza6IW+4kmUUPqhQ9ZERwB9/ykW5NNFstSoYl2ZO/nhgaE2758eX4+/2VEMWHVvSjiCf+HNm2rBZmVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org; dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=vejwWx6V; dkim-atps=neutral; spf=pass (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org) smtp.mailfrom=debian.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=vejwWx6V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=debian.org (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org)
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYm3M4n7qz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 18:50:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dluz+I3N22ywYzoz/gAwyyxGhCLB7ATDVpgZxGTd1Hg=; b=vejwWx6VMa39pTZib49M1u2r0C
	Mrn0/A5J9513XAgHtk8Kc1CYh3TI47gau+fhR5slOP8jFMeLmvBEkCNn+19iNKIFPdFa6WE8c/gMz
	t99Ie63OWcvhMhtDDCnkve8QzJTAG4GOsX2xkBYXCKc6Q5v0qsFAbaF2hKBz8hrhVx12IhVGRRlWw
	/fSo+694x+90ee0pNT1hAtVxcLtMYrqb6l8/0GAl9mOeoYjSxWYQgsLPdtK3SnuYybkJanG8qaQaT
	ylzuIsGC80K9maerJAYZM7CdzO20xRUnZQqGLQPiWDxuQ1wpIcGbXE0U4+rbWltECyITWI9vcAHM2
	p5vwQpHQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWVfH-007VKw-26;
	Mon, 08 Jun 2026 08:48:59 +0000
Date: Mon, 8 Jun 2026 01:48:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	ruirui.yang@linux.dev, rdunlap@infradead.org, peterz@infradead.org, 
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com, kees@kernel.org, elver@google.com, 
	kuba@kernel.org, lirongqing@baidu.com, ebiggers@kernel.org, paulmck@kernel.org, 
	coxu@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, osandov@fb.com, 
	jbohac@suse.cz, cfsworks@gmail.com, tangyouling@kylinos.cn, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, adityag@linux.ibm.com, 
	liaoyuanhong@vivo.com, seanjc@google.com, fuqiang.wang@easystack.cn, ardb@kernel.org, 
	chenjiahao16@huawei.com, guoren@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [PATCH v16 08/10] powerpc/kexec_file: Use
 crash_exclude_core_ranges() helper
Message-ID: <aiaB45VXyCv4pUBW@gmail.com>
References: <20260608073459.3119290-1-ruanjinjie@huawei.com>
 <20260608073459.3119290-9-ruanjinjie@huawei.com>
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
In-Reply-To: <20260608073459.3119290-9-ruanjinjie@huawei.com>
X-Debian-User: leitao

On Mon, Jun 08, 2026 at 03:34:57PM +0800, Jinjie Ruan wrote:
> The crash memory exclude of crashk_res and crashk_cma memory on powerpc
> are almost identical to the generic crash_exclude_core_ranges().
> 
> By introducing the architecture-specific arch_crash_exclude_mem_range()
> function with a default implementation of crash_exclude_mem_range(),
> and using crash_exclude_mem_range_guarded as powerpc's separate
> implementation, the generic crash_exclude_core_ranges() helper function
> can be reused.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Acked-by: Breno leitao <leitao@debian.org>

