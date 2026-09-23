Return-Path: <linuxppc-dev+bounces-27989-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE3BC982FA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 08:43:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqVqv3jfRz2ySj;
	Wed, 23 Sep 2026 18:43:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::d4"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790153035;
	cv=none; b=SOI+l0R2XDyY+AhRj+WGhewZL+TFXRoPMXgjhpuTE2eaVowT6wd+sqXeFqXMeTqlo/ViM6DBua5I7rlCkOf0mBCaX8PgGxR58oO2RQgjZJKpz4K9gNfe6UdmwU610f/u+Z50kpZjD4tFmbRTZdf9YHcBdH/2MObr4jV4oKTKgeBjobMXW5pJZIucammxeDjGLpMdzile18yoJtp6lyah6+dUoaCxst/QjCGaBHrg6BkRF9JDiFYAmUshrQnBoDabp8sI9Cn3afOfpZKZ4BQvMLYZtLVEoIJoGFwaz4CbKpgrNzZ9P+W8JOarM1Ty4pG2MTO0uoqzOZpo2HHH6DicFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790153035; c=relaxed/relaxed;
	bh=99+UKhu23KDHlR6Muc20Ly3uTrswjM+UPnqZD8Rdr68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4zIiGeRIHXO70EUT+8jSHe3xsm4cyBh8+swmbkBp+M0TBBho7lRqpb7DGyHzFDy5H8oPHDnpub7Jy5qftjNeRuD7U8oEvDNvzqwZG+HQjKk4fUh65dAZDc57bgW+hSvJPI3MenzS66rIo1BArGIV/Th3yUBR9dwBmrJ6zSAJn+YWCX/EEt9iDvRZxrtSElzCsG/uaRcqrClnIpcvzVrevrGrSL3XWwc6ZsIKamxdgCafKkzJMXR26vR0RcskT36usOMbTPp1Ul141sOUVcuGmkrte8zD8cJ7clxrdskFKacU/n/F+s3rxD/BBHifqoBSwW/WaSd3gZYAfVPoKQNew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MXSkb2Dp; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::d4; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MXSkb2Dp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::d4; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-212.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqVqn6r6Nz2xs1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 18:43:47 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=99+UKhu23KDHlR6Muc20Ly3uTrswjM+UPnqZD8Rdr68=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790153004; v=1; x=1790757804;
 b=MXSkb2DpclhOBsFPPNOlk7p7Q+fP/OJU25EHZdH6R7uu1CUXGTPOe7gA2aSznMPd5exGUhkg
 DdrO3WZAhRx0tnIfOfHn6zlnAr5LcJOcca74Ol5KsNdsny7aRsBHhg2Jvq/wzzd7baAJ61BnWQ5
 GM2W5Uf1FiRwZd5z2cDu0Qr0=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id c8a1201785675537;
	Wed, 23 Sep 2026 08:43:18 +0000
X-Mizu-Trace-ID: c8a1201785675537
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
Subject: Re: [PATCH v4 05/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for arc, microblaze, xtensa
Date: Wed, 23 Sep 2026 16:43:11 +0800
Message-ID: <20260923084311.15570-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-5-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-5-fe1ad1f1e303@kernel.org>
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


On Tue, Sep 22, 2026 at 04:35:36PM +0100, Lorenzo Stoakes (ARM) wrote:
>Each of these architectures directly free page tables without routing these
>changes through tlb_remove_ptdesc().
>
>The use of tlb_remove_ptdesc() is required for
>CONFIG_MMU_GATHER_RCU_TABLE_FREE to correctly free page tables under RCU,
>so simply update these architectures to use these functions.
>
>Since none of the architectures share page tables or do anything unusual,
>nothing complicated is required here.
>
>Therefore this is simply a mechanical change - convert __pud_free_tlb(),
>__pmd_free_tlb() and __pte_free_tlb() to use tlb_remove_ptdesc() as
>required.
>
>At the point this is in place, all mmu_gather page table freeing is
>performed under RCU, and thus MMU_GATHER_RCU_TABLE_FREE is selected for
>each architecture.
>
>Note that CONFIG_MMU_GATHER_RCU_TABLE_FREE is dependent on CONFIG_MMU for
>xtensa to reflect the fact that nommu does not implement page table
>gathering.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Right, the old frees already end up in pagetable_dtor_free(). With
tlb_remove_ptdesc(), the same cleanup happens after an RCU grace period.

Makes sense to me, feel free to add:

Acked-by: Lance Yang <lance.yang@linux.dev>

