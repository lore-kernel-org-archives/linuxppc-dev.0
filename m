Return-Path: <linuxppc-dev+bounces-28012-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A32C98309
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 11:54:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqb4K6Lwcz2yr0;
	Wed, 23 Sep 2026 21:54:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.127
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790164497;
	cv=none; b=mLAo2obLe9oXXU99CnrVXglFl56IjKnhChX7hSwV0IxXQyetM0lrPz71xnyQUwfC2ALssdbmNyggVFGt/3Jl/e4/2ztx04N9YpJkd7Pbf91tkrS0RKBNCo0FK4jiNT8XOc0QoF3jbMy7CKSasbFuW/cxuzTewzje3B/Qc/v8hHNDS8/NDnYUJT7uG8tXHPxGJxXmZnHxHvsy2GS6l5A4b8/HxqDLd2Hl3gcpybyGTpoTsR5EAWGfi60hHWajpXNq8oCxnqH/VlgtAx1rmAfQQCq846bROcXuKBnTCPZy+gi8gftZ/X8E4oQuoVN+7NcD5fHbL3Z2xF4+cN8R4AQfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790164497; c=relaxed/relaxed;
	bh=FyI8OIcx4NePB4wjfBisQg331Da0UMxOk3af3KkO/oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2Y5xciwHMN+V2rTT7Qvk2MhDkyoYlpjwBfhaUFzt3PHZn/TI7c+fB4F8KL2rI9srvh+yrJQHC7D1Y8NikyRDkTICg4Cyfc3ItE3iqwEJ5es4RfHqMEcfZFppOiaJRW5nMaOXxbvTClfR9YdfWFOKze+byWsFBuXXPboYeBhW0ySt37R7LZ2SMrM4UvH4LMTDKhH/i+M5PGwH1l1q5hGWwCn/TrG8IQpJPB/niseYtt3vw/Sj6QjsTAHBeU/AyXMVpXIpOF+Xneb0XdBFgeEffUs6bxHP/GP0zPFL+iKi9yIlb/C1uwSfYT9YF2Q9LPgJbBcYCfcSV1Nsjf3vAiunw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U2DboQPN; dkim-atps=neutral; spf=pass (client-ip=95.215.58.127; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U2DboQPN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.127; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-127.mta1.migadu.com [95.215.58.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqb4F0Fg0z2yqq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 21:54:51 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=FyI8OIcx4NePB4wjfBisQg331Da0UMxOk3af3KkO/oU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790164472; v=1; x=1790769272;
 b=U2DboQPNIjvb2cOm0nacFt0QBeGe8TjL7XpFPIz+5E2kYswIyReQbL7jqNDNz9DcM3Orz8F+
 W6fzl8esDkc5aMr66ApbHQXst9JieOWAEQZoJ7sjl6qqH8zP+5H/zTrBXDE+rvjtQQbtgNWt/Sh
 m91k96WZFVQ4NX60LoJrtSOw=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id b457f4ea14dabe32;
	Wed, 23 Sep 2026 11:54:26 +0000
X-Mizu-Trace-ID: b457f4ea14dabe32
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
Subject: Re: [PATCH v4 08/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sh-X2
Date: Wed, 23 Sep 2026 19:54:17 +0800
Message-ID: <20260923115417.34112-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-8-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-8-fe1ad1f1e303@kernel.org>
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


On Tue, Sep 22, 2026 at 04:35:39PM +0100, Lorenzo Stoakes (ARM) wrote:
>Currently, non-x2 sh specifies CONFIG_MMU_GATHER_RCU_TABLE_FREE allowing
>RCU page table freeing.
>
>sh-X2 is problematic because it utilises slab-allocated PMD page tables,
>and thus tlb_remove_ptdesc() cannot be used in these cases.
>
>All other sh variants are fine as commit e3ecf7c7d082 ("mm: pgtable:
>convert some architectures to use tlb_remove_ptdesc()") already converted
>page table freeing to use tlb_remove_ptdesc(), which does so after an RCU
>grace period when CONFIG_MMU_GATHER_RCU_TABLE_FREE is specified.
>
>Resolve this issue by firstly specifying CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE
>for sh-X2, so the arch can provide its own __tlb_remove_table()
>implementation (called after the RCU grace period).
>
>Then, convert __pmd_free_tlb() to tag the pointer to the PMD, and have
>__tlb_remove_table() check this tag to determine whether to free via the
>slab or to use pagetable_dtor_free().

Makes sense to me, so RCU callback won't mistake a slab PMD for a PTE
page :)

>This follows the pattern used by sparc64 as implemented in commit
>4a0100f7546f ("sparc64: use RCU page table freeing").
>
>Previously __pmd_free_tlb() freed PMD page tables immediately, before any
>TLB flush IPI. This seems to be a pre-existing bug, which this change also
>resolves.
>
>CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE is only specified for sh-X2, as setting
>it disables CONFIG_PT_RECLAIM and causes __tlb_remove_table_one() to call
>tlb_remove_table_sync_rcu() and synchronize_rcu() in turn, and this is not
>necessary for other sh variants.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

LGTM, feel free to add:

Acked-by: Lance Yang <lance.yang@linux.dev>

