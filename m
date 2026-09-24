Return-Path: <linuxppc-dev+bounces-28079-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DD0C9830D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 02:56:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqz4X2PNdz2yft;
	Thu, 24 Sep 2026 12:56:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.146
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790218588;
	cv=none; b=PTbLnKBz0/uDJBNmJ6GuoQ1a2Xxohug6+nxFzirhobcYtEYv9AuywxMqXrRqXmEZonOqeMNf1s+JlrEl79xwR5CsFyfHaRfZMrEw9KFbuEt9dzrbICiU8rQSmYyHUv0GF+eP8aHRMZlvZwpy7RUDiiAQYOR3vCZO0wugNwKhskF6zSNLREpeU/lOfhnwYTQqVLORDG3LKEKfjUcL9zWMH3wBKWuO0gHm1htSDpx93uAeoTbcVglfmp6/whbbL7BCAYWmsWOJqksnwzmJX8zu/LsezUsH0sLYS6rX0Vo1Z3g7CvEkPB8u+cMu7p6UhY/bhgVNQyCUd03mIl/crQXpfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790218588; c=relaxed/relaxed;
	bh=i3rUJrOssAsIlzaIbpG4p7ewG7Kkt+KPljgikjsMoRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJviDIpZJNf5xu0jvgNs3E3s9kMSOIoOCdp3eV0aUaYPtEm4oJI2T3RcBP2PPS16zUSY+JwXcjBRPn40DBJWHFzaG36mTIF0SIj3G9gVfeONAtdKaOTHfDa214O4OAUYCli2vJ5ibbk7uiWNqJos+D/T4UZoGwZuEb8Tb/wLgwEasUN1ltZtmbFKegjwMZxc0cluaI4nOrW9aaWvb6v6Qd3K+4/TmXcXYDOQJmSE6KJYvy7g/HbB68SYysWIQssPuW/849Ej/Oiex8tPAMocjFTuZ8n1kWGN69TmqxrnqzKmmdpiDIWfuLXJV9kk1v65i7yHE7iA8EQkNUrqXJpn0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FJ7/xF8o; dkim-atps=neutral; spf=pass (client-ip=95.215.58.146; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FJ7/xF8o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.146; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqz4T3Kktz2yMm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 12:56:23 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=i3rUJrOssAsIlzaIbpG4p7ewG7Kkt+KPljgikjsMoRc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790218565; v=1; x=1790823365;
 b=FJ7/xF8oprsisbwcodDJLWAHP7xU6j8AVwzm+rHeNENGuQgZQfzLB248rjSRMet32gjO3bH4
 zNIpSHuNGIwiwTY6eWVZZZBJaea/kA8QAGJicBdT52+8hp9Q97WWSAToBoK7MTW9xJn7KF7hBH4
 cJk4yUvxnIRZ3vhwrVwt5+iE=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 9cade30b803883cf;
	Thu, 24 Sep 2026 02:56:02 +0000
X-Mizu-Trace-ID: 9cade30b803883cf
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
Subject: Re: [PATCH v4 11/12] mm: make userland page table freeing RCU-safe
Date: Thu, 24 Sep 2026 10:55:56 +0800
Message-ID: <20260924025556.18719-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-11-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-11-fe1ad1f1e303@kernel.org>
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


On Tue, Sep 22, 2026 at 04:35:42PM +0100, Lorenzo Stoakes (ARM) wrote:
>Now every architecture has been converted to support
>CONFIG_MMU_GATHER_RCU_TABLE_FREE, this configuration option no longer makes
>any sense to keep around.
>
>Therefore remove it, and remove all the dead code that existed for
>!CONFIG_MMU_GATHER_RCU_TABLE_FREE architectures previously.
>
>Additionally, CONFIG_MMU_GATHER_TABLE_FREE is no longer necessary, as all
>architectures instead use CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE when a custom
>__tlb_remove_table() is required, so remove this too.
>
>A number of architectures only enabled CONFIG_MMU_GATHER_RCU_TABLE_FREE if
>CONFIG_MMU was set, however the mmu_gather logic only actually does
>something meaningful if CONFIG_MMU is set (mmu_gather.c is only compiled in
>this case, for instance).
>
>As a result, there's no need to gate any of this logic on CONFIG_MMU
>explicitly.
>
>CONFIG_PT_RECLAIM however does have a strict dependency on CONFIG_MMU, so
>make this dependency explicit.
>
>Additionally, correct comments to remove references to non-RCU page table
>gathering and make it clear that this is not 'semi-RCU', nor has it been
>since commit 1fb3d8c20bfa ("mm/mmu_gather: replace IPI with
>synchronize_rcu() when batch allocation fails").
>
>With this change in place the kernel policy is now that userspace page
>tables are freed after an RCU grace period, and thus it is now safe to
>unconditionally perform page table walks under RCU, safe in the knowledge
>that page tables will not be freed underneath the walker.
>
>This is all that is guaranteed, however, so naturally it is still incumbent
>upon page table walkers to ensure that the page table entries are as
>expected.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

with David's feedback folded in, LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

