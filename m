Return-Path: <linuxppc-dev+bounces-27962-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3170C982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 06:16:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqRZ0234Vz2xs1;
	Wed, 23 Sep 2026 16:16:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::9c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790144200;
	cv=none; b=C2ltX/LNBet/Jl4/nzTN96bvL+X8ojJnCkRcKHg2KcWnU7GHV3izYp1YDEoQAshOz4enpTlL4x2KoKGH0I5yfpro3Kv16HjJdAvz2Fuvu1BhfclgCQY5O5R/KzoqfBkNj9V9XTQxuDbbYPY3sdSzAJZxzmzwJ1jU+US4ZR/h72XP1zbMX6muGty5Olp2h+kiYd9WGE6YXWTG4LVTfCx4OuEA1MZ3/nDVP+SIbJJc/S3dORuA0/5XNQ/4fOI+hw3jWpca8n+LoGyzNasE4D8s/e9sEAS0p5fFXkJMXFet9+zSPb4oJQ1rwcstqcfSA4GHxNEa4HTevjLBU1/yQC87iA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790144200; c=relaxed/relaxed;
	bh=iNN52+OjGBWKHuNTOEPyALCLpNm9HUlYo8ccDdYusP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esdwHvJljT2fNjeBTmpa+nVqX0nwHelk9wxjvS94hOqxJPUhK567JWbHQQ2XKgKluMQdPp7OyqPUnGVCmV4efiDOfxMGFZVgiTHmZm7ZnyPgoCK8VPhn0HfTuuRFBFB92zCzQVWhoGGmZVEZ8pNw0efel1m40cA9f7XDX9nmHIDnRIJYCJLt0gXt3ExLyP0EyCrc8RnvYfbexuHd3k90roRN+rDHlpn4y1R4BlyY8IbAxaeJhf+1jlI46Oyz7QKrXVm2mHruBMPR3GGlmmt0Z7Qt5zUetaopj2G9O7MeyOgryDQ9WSQjAeZUIGd3odiaXNms7jU0kEKMuuakG+2Lew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WhTApNSH; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::9c; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WhTApNSH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::9c; helo=mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-156.mta0.migadu.com [IPv6:2001:41d0:1004:224b::9c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqRYv5b23z2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 16:16:34 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=iNN52+OjGBWKHuNTOEPyALCLpNm9HUlYo8ccDdYusP4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790144175; v=1; x=1790748975;
 b=WhTApNSHN5zXwJw/xCbLprF3BdPpfqNC4ITv9k2syZnbCr+WML014vxLCW8Kt+FnXhlptHES
 GvzrbM03yjMZtMDxICT+dbMqRuFRLc21JzAwR0bUHe555xb+VX3124EzzPKxcLD5GvS8qE/CfEN
 y/wkjO5cz6N26SW7JH0VxSPY=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 4b4ce70d101944f5;
	Wed, 23 Sep 2026 06:16:01 +0000
X-Mizu-Trace-ID: 4b4ce70d101944f5
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
Subject: Re: [PATCH v4 03/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU riscv
Date: Wed, 23 Sep 2026 14:15:51 +0800
Message-ID: <20260923061551.84398-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-3-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-3-fe1ad1f1e303@kernel.org>
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


On Tue, Sep 22, 2026 at 04:35:34PM +0100, Lorenzo Stoakes (ARM) wrote:
>Currently riscv gates MMU_GATHER_RCU_TABLE_FREE on CONFIG_SMP and
>CONFIG_MMU.
>
>Commit 69be3fb111e7 ("riscv: enable MMU_GATHER_RCU_TABLE_FREE for SMP &&
>MMU") enabled CONFIG_MMU_GATHER_RCU_TABLE_FREE for CONFIG_SMP, CONFIG_MMU
>riscv builds.
>
>This is expressly for the safety of GUP-fast walkers (CONFIG_HAVE_GUP_FAST
>is enabled if CONFIG_MMU is enabled).
>
>Naturally a single core system does not encounter issues with software page
>table walkers being correctly synchronised across cores, as there is only a
>single core.
>
>However, CONFIG_PREEMPT_RCU is still available on a riscv UP system, so for
>a future RCU-only page table walker, this guarantee is required to prevent
>concurrent page table teardown.
>
>All page table freeing is already done via tlb_remove_ptdesc() so the
>conditions of CONFIG_MMU_GATHER_RCU_TABLE_FREE are already met.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Yeah, for RISC-V, page-table freeing already goes through
tlb_remove_ptdesc() :) Tested on QEMU, no issues seen :)

Tested-by: Lance Yang <lance.yang@linux.dev>

