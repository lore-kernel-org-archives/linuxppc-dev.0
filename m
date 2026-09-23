Return-Path: <linuxppc-dev+bounces-28021-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715C2C9830B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 13:17:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqcvB2kp6z2xs1;
	Wed, 23 Sep 2026 23:17:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::df"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790169430;
	cv=none; b=YktriMWqisTW7nu6PLhaNj+dPNm/yKZhj79vlsDuX3zSkDkhYOcyE7rdnMTXTyYNq69Bn5aQZvVojC0I5qRPnpuW/HFd6Q6IueuE53DpP95/+QcxWwqNZPQ+6njfZeIYjyXA4wXKvS8F/WreiKfsr/5wXavqay0XiCG5dyaC5APg1QJ29Nd1DOCRcTs5sL7QYLkg1XiW84mFEm2YtmlW5LvSDDS/Pv186YS3RAqb3EEuescn2qEPwNqXRTdNYnkSd00QMfrl9tpsMGBEDBRU9hArIo0zln5EUGQuJqpPvx44LDdH19OfnEHAw/KjuVLi/eud3VVKZcalS43YZcWgUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790169430; c=relaxed/relaxed;
	bh=Oo904kmsf5S8wAGGf7/FG6FAeaEtExRT7Jk7mDgjtow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFtbIeHFEkx14exfo1oHgnD5amLKez6pTuAG5QigVKNxM2QoYo5nWIrDFc3NxyiQe0NTmsHChuGro2XTCObVwiL0M3mH+HcSh5CZGwXaFSFcHfhq2QbLT7BaFP/k/SS4XaRpfyQCfqq1plVT/11wtGz35s3iGQsuu2K22axtyr2J5c4e29gEcVVgFZpVHo34dZESLM8jgy13OxDHDh9BhhLAWD+58LAA2d6i+vxg/ruIylIuocVw1X4qBE1i7mL2WOOiI9bKxDIGF2CGs7Aq0eIRDQl2EcLDujKv/EvbS4kteiUVWVlS1BpRU7CxsVpKkYrvTkF6I6Bli4gPyiswWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=R+Vt7VKY; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::df; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=R+Vt7VKY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::df; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-223.mta0.migadu.com [IPv6:2001:41d0:1004:224b::df])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqcv65fW3z2xjM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 23:17:04 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=Oo904kmsf5S8wAGGf7/FG6FAeaEtExRT7Jk7mDgjtow=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790169404; v=1; x=1790774204;
 b=R+Vt7VKYQ6Z6CnIF0Eghz5I7R/+ugag7Aunz3sd2gZveys399bQFeSb1YCVCCXeuNz7jxa37
 fR+ZJBx2QZ4T6EQAoywLElJG7bK8WPX5c2c7ag3JVpTGS3iEoDuR3IwCKjQhRx0Yl/5NhF5zp4m
 lAlRbSUtpkfWnXHknys8Ra4A=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id acd8da373ac6bf50;
	Wed, 23 Sep 2026 13:16:40 +0000
X-Mizu-Trace-ID: acd8da373ac6bf50
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
Subject: Re: [PATCH v4 09/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for m68k-motorola
Date: Wed, 23 Sep 2026 21:16:34 +0800
Message-ID: <20260923131634.47896-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-9-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-9-fe1ad1f1e303@kernel.org>
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


On Tue, Sep 22, 2026 at 04:35:40PM +0100, Lorenzo Stoakes (ARM) wrote:
>sun3 and coldfire are already supported, however motorola requires a little
>more care.
>
>Here, custom table removal logic is required, so
>CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE is enabled for m68k-motorola.
>
>Firstly as part of this change, the page table level must be communicated
>to the underlying __tlb_remove_table() implementation.
>
>Take advantage of the fact that page tables are aligned by more than enough
>to permit setting TABLE_PTE or TABLE_PMD in the low bits of the pointer,
>and store this there.
>
>Then update __pte_free_tlb() and __pmd_free_tlb() to pass this through,
>then have __tlb_remove_table() decode this and pass it to
>free_pointer_table().
>
>The page table freeing is performed via call_rcu(), so free_pointer_table()
>now will be invoked from softirq context, and as such may be re-entrant.
>
>Introduce an irq save/restore spinlock to handle this, and hold it over the
>time a given ptable entry is being referenced in both get_pointer_table()
>and free_pointer_table().
>
>In order to make things a little easier in this respect, separate out the
>logic for adding a new ptable entry into add_pointer_table() and only hold
>the lock during ptable entry insertion in this case.
>
>Note that original list_add_tail(new, dp) added new prior to dp, which is
>ptable_list[type].next, i.e. after ptable_list[type].
>
>The equivalent therefore is list_add(new, &ptable_list[type]), which adds
>new after ptable_list[type], only without needing to make reference to dp.
>
>Note that, as m68k-motorola specifies CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE, it
>does not enable CONFIG_PT_RECLAIM. This isn't meaningfully impactful.
>
>With this applied, all of m68k implements CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

I wondered about slot reuse during the RCU wait, but that can't happen :)

The slot stays marked busy until free_pointer_table() runs after RCU, and
the last free unlinks the page under ptable_lock.

Also ran page-table teardown stress and fork/exec churn on
qemu-system-m68k (virt, m68040, CONFIG_MMU_MOTOROLA=y). All 40 rounds ran
cleanly :D

Acked-by: Lance Yang <lance.yang@linux.dev>

Tested-by: Lance Yang <lance.yang@linux.dev>

