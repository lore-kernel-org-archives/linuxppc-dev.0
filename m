Return-Path: <linuxppc-dev+bounces-27954-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAC2C98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 04:40:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqPQY2d5Lz2xs1;
	Wed, 23 Sep 2026 14:40:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::e7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790138405;
	cv=none; b=i0CQe7oBbFHpnk0CiVePtfHK9aCbGTWylYUPu/ePDX/+L7QxaMjWo1abUnQbXCegjADU820L7TIab8H6J0Mc5unt0kgg7A/a5m+UhuV+qwJJ1soYH5hQ4n7t3KOReWMj3JIr4oEMWDPA1bLeVmvabmreKPVRn1YpnlrDZVX9+zjJvAdV8BbBMz0/yXW2Z1IXE1UCtweIW7hFxA+aE13jdgqH7jUdvT/NiomLhuKucTFNobEwyEuk4qCucaW2xwe/ivT74FmQcl5hPDa2ih0T8kr/Sz53joIDGcLYooSNb5F8w7stKU3FvXsspJC7IReqImQq9PeZ9tcVhYfOkE5kwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790138405; c=relaxed/relaxed;
	bh=iSNouMXA3RwlruRYR9UspqX4v90LzLOpRZaDkTpRMn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fi29QXeudlBCuweHxnz0fBqSHhH8MoD9swwyvpAbnPeF850Ds1HGu1IHYbY0MGAHdI3OKu0BHP/lnLd4Fw3BGi6X14mhCVeqWTmTqjyMPQLAmmXBA+JQcu3FpZhPLQUZds2bdlpungFVaZLYlP0SrJ3lqpJ+B1/kfOYFIT91d7eU8XSqEvglC7jtxHqzbE//WpE/w0tYNY9dmw2Cq+x2SlHU8+h8NWdwCIGscnkZlBhaQk6NZI7iMKxFdeINYX4NWyx3XmmCxrwu4k41Ov6VR4vH/USB3Ybdl8nMNDkwZpG+bfDIJKNbX65+oiFJl0Zl5xtcKF/x5V2aCyCnFDfqRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hgoTWDT3; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::e7; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hgoTWDT3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::e7; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 8007 seconds by postgrey-1.37 at boromir; Wed, 23 Sep 2026 14:40:00 AEST
Received: from mta0.migadu.com (out-231.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqPQS5rHzz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 14:39:58 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=iSNouMXA3RwlruRYR9UspqX4v90LzLOpRZaDkTpRMn8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790138378; v=1; x=1790743178;
 b=hgoTWDT3pScnSULYGQpx9ptjfcLNCAsGeIdJD0unN1quEcpuVr+vnfw97OQhcdnxfVo5EZMF
 UQsxat8umWyM4KwhN0Z7XPZVy4wOrNI5cwELE1/9iO5zr4VpxtZ+Qbs7Vh/VUfDR1FxNJfSKdhp
 TFa4FqeBaQNCueEL6QO3d5+M=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 8a4b30de2f7f9df3;
	Wed, 23 Sep 2026 04:39:35 +0000
X-Mizu-Trace-ID: 8a4b30de2f7f9df3
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	guoren@kernel.org,
	bcain@kernel.org,
	geert@linux-m68k.org,
	dinguyen@kernel.org,
	schuster.simon@siemens-energy.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux@armlinux.org.uk,
	vgupta@kernel.org,
	monstr@monstr.eu,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	ysato@users.sourceforge.jp,
	shakeel.butt@linux.dev,
	corbet@lwn.net,
	rdunlap@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-arch@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	hughd@google.com,
	qi.zheng@linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 02/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for most 2-level architectures
Date: Wed, 23 Sep 2026 12:39:26 +0800
Message-ID: <20260923043926.76397-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-2-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-2-fe1ad1f1e303@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Tue, Sep 22, 2026 at 04:35:33PM +0100, Lorenzo Stoakes (ARM) wrote:
>Commit e3ecf7c7d082 ("mm: pgtable: convert some architectures to use
>tlb_remove_ptdesc()") updated a number of architectures from using
>pagetable_dtor() + tlb_remove_page_ptdesc() to using tlb_remove_ptdesc() in
>__pte_free_tlb().
>
>This is meaningful as tlb_remove_ptdesc() allows for RCU page table
>freeing if CONFIG_MMU_GATHER_RCU_TABLE_FREE is specified.
>
>The csky, hexagon, nios2, openrisc, sh (except X2) and m68k-sun3
>architectures all have 2 levels of page tables, so the only page tables
>ever freed by mmu_gather are PTEs, so this update suffices to ensure that
>every page table freed by the mmu_gather mechanism is freed under RCU.
>
>Therefore, update all of these architectures to select
>CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Nothing jumped out at me,

Reviewed-by: Lance Yang <lance.yang@linux.dev>

