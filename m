Return-Path: <linuxppc-dev+bounces-27992-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F8BC982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 08:54:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqW4R5VMgz30T2;
	Wed, 23 Sep 2026 18:54:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.206
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790153687;
	cv=none; b=D41Vs3B4zQ91hmafx5U7F4bPh6AwE+mBnYD/9t38uRGVO2pKgscDAd6HDOC8bmMIB3ABsNJUGOpCd6QDUYK73S25HCJU38x1Wix9Gj4wT4njwHBzKqF69s4DfhiX+bJV8jO9ydv9w/MKBN8NA0bKhKv2ZcSar/2MmJG7CkJYCzkA2aupBZqqXSEtI7Al3v0wXyLBxX7VL/HjzuB9v241ShPzcKBhn/cn0piNYtIHwcXuX1r0fWizQTtEbiKAM+GU8IENkuOmNKOy4jJtZtfcIqhPINhffiIA2A1fUrrWFZMQCZFomn1ETkxbIuQRz2erD6uirEtZtMbyugPuYkh8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790153687; c=relaxed/relaxed;
	bh=mKKXd8n2HOhU5Q0gLVPMEbhCsXKgHbRUMQtENSwBdyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPvLFSR7XmmLgeaIjmFeqXwyba30aPWvHjf1Qw7fTAfq7kdFjG6pjH8jRMNLP1//K4ZcZpl0ukpbazVe6Vu+F4NU9SFCnoyetCEm8gwH+V+UZZo1obdgPRz20pC6ozVHiZICjxKi+ysD8rS7xofLJx1URJ175TolCDeJHiqqskCoZXoA7Pw7fqOK9khzXSsRAnP0GykFQ+2rGIwHh/Qeq57H+fXQhqfYvAayGE+QTWzfEzT533VoU2w4cs+PVAhGw7k8eGTupc8eYCMwvUrQ8EqHYXYf+c2qLn236ftO1Jw5iqsHF6HyMjpT3FjVExGyIAKwRXogSoaCPyuPX+ZeDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q2U6Ii9j; dkim-atps=neutral; spf=pass (client-ip=95.215.58.206; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q2U6Ii9j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.206; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqW4N51Hyz2xs1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 18:54:43 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=mKKXd8n2HOhU5Q0gLVPMEbhCsXKgHbRUMQtENSwBdyw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790153663; v=1; x=1790758463;
 b=q2U6Ii9jHxSmnMAb4/cJhp2lT+EetHSthVFGr+IV6LfUtkJK0bakdOYZvX9SnC+nxE4nWfpr
 Y5haYi1VXFhIcYYcbfjd5rEqSeYKNxWue9RK/G0fIdQjlrRNS51B9/8e9/3CCIDp6MJgNfssiVE
 Hv9ADu5lvnKiZ7iVTksdEBbw=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id c56b50517945abbe;
	Wed, 23 Sep 2026 08:54:20 +0000
X-Mizu-Trace-ID: c56b50517945abbe
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
Subject: Re: [PATCH v4 06/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sparc64
Date: Wed, 23 Sep 2026 16:54:14 +0800
Message-ID: <20260923085414.17309-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-6-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-6-fe1ad1f1e303@kernel.org>
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


On Tue, Sep 22, 2026 at 04:35:37PM +0100, Lorenzo Stoakes (ARM) wrote:
>Commit 4a0100f7546f ("sparc64: use RCU page table freeing") enabled
>CONFIG_MMU_GATHER_RCU_TABLE_FREE for SMP sparc64 architectures, expressly
>for GUP-fast page table walkers.
>
>Naturally, UP systems do not have to worry about concurrent GUP fast
>operations.
>
>However, CONFIG_PREEMPT_RCU is also available even on a UP system, so a
>future pure-RCU page table walker requires MMU_GATHER_RCU_TABLE_FREE to be
>enabled on UP, even if concurrent GUP fast is not possible there.
>
>To enable future pure-RCU page table walkers, enable
>MMU_GATHER_RCU_TABLE_FREE unconditionally.
>
>With this change, it is no longer necessary to have !CONFIG_SMP
>pgtable_free_tlb(), so also remove this now dead code.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Also ran page-table teardown stress on qemu-system-sparc64 (sun4u, UP).
That ran cleanly too ;) Feel free to add:

Tested-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Lance Yang <lance.yang@linux.dev>

