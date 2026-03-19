Return-Path: <linuxppc-dev+bounces-18438-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC84108E1E9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 11:20:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc3CN2ZYpz2ynW;
	Thu, 19 Mar 2026 22:20:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.176.79.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773919232;
	cv=none; b=k6X0JY4fJKQc698jA4FuJjNvikeyK6o7IB1YGzLapDcGNt+xWmPxNPwoPrGMBFtTm/A0QL6mSh2fuKTpuDP/KPEXmuTAygGLmbsYRa4qFyFVyMRR8mWevf+COoctbSZVaSnmTwzqQ4RMzfezleqskU6fTLEgtMg6s0pScTzwdkdU/Lhp2OYRv0um3PB26jfFumtbpRCHsM/ty7X5Vzfnv3XYt/8V+bzLDuDE4ePwUHSSW2Wx6PzmOfZlurxB1NHFBZDb5c6H50nzwoR1yNtD+/Vu1uSOhsHx0vMwXaHsyFnjipfuWQO9+6Y1LL0ek/trZ1eFySxvudvwKlD93PENtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773919232; c=relaxed/relaxed;
	bh=YifErqMt+itpLBDIu2BIswknjpV1SuqoYtwD8GJqUn4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c60epE7x4vK1QaiIE7/GB3sQFTLQrSJSh5qc/+DEesdWNuWNIBc1pS+QcEY3M7sf4zYiHZpBdiHCen40ezIamztNeSFwpquzQwMkjivC8kHu2+3odfSxwV0Cqma5m80vzwh7dSaDnIQVgULd6TOkOt3EkeMhor5ac7b1rcb+JBjMYX8mTCAJoeZyAyd/Hk6qIdktozboGLX48/9ld79CDX1dAFvfa8JY4bLunKwVhYAOqJh7yIZlch79MP6Eu82lFNzEcCD/f/cpEouyf/OcZ/JIx76irraHQZLRCMkfj30nBlZZ+yCGmFrvipbIAFRsYC8kpT073l9FWFOgw4kNrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 994 seconds by postgrey-1.37 at boromir; Thu, 19 Mar 2026 22:20:30 AEDT
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc3CL5bvGz2ySj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 22:20:28 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fc2py5dyzzJ46Dn;
	Thu, 19 Mar 2026 19:02:50 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A71A40086;
	Thu, 19 Mar 2026 19:03:50 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Mar
 2026 11:03:48 +0000
Date: Thu, 19 Mar 2026 11:03:46 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, "WANG
 Xuerui" <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, "Thomas Gleixner" <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes
	<ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Zi Yan
	<ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, Joshua Hahn
	<joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
	<byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
	<ying.huang@linux.alibaba.com>, "Alistair Popple" <apopple@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH 0/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE and
 cleanup CONFIG_MIGRATION
Message-ID: <20260319110346.000034a5@huawei.com>
In-Reply-To: <20260319-config_migration-v1-0-42270124966f@kernel.org>
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
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
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 19 Mar 2026 09:19:39 +0100
"David Hildenbrand (Arm)" <david@kernel.org> wrote:

> While working on memory hotplug code cleanups, I realized that
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE is not really required anymore.
> 
> Changing that revealed some rather nasty looking CONFIG_MIGRATION
> handling.
> 
> Let's clean that up by introducing a dedicated CONFIG_NUMA_MIGRATION
> option and reducing the dependencies that CONFIG_MIGRATION has.
> 
> Heavily cross compiled. I assume these changes are fine, but messing
> with kconfig sometimes feels like playing with fire :)
Seems fine to me, but I agree it always feels a bit like playing with fire.
So more eyes good!

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> David Hildenbrand (Arm) (2):
>       mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
>       mm: introduce CONFIG_NUMA_MIGRATION and simplify CONFIG_MIGRATION
> 
>  arch/arm64/Kconfig           |  1 -
>  arch/loongarch/Kconfig       |  1 -
>  arch/powerpc/Kconfig         |  1 -
>  arch/riscv/Kconfig           |  1 -
>  arch/s390/Kconfig            |  1 -
>  arch/x86/Kconfig             |  1 -
>  include/linux/memory-tiers.h |  2 +-
>  init/Kconfig                 |  2 +-
>  mm/Kconfig                   | 33 +++++++++++++++------------------
>  mm/memory-tiers.c            | 12 ++++++------
>  mm/mempolicy.c               |  2 +-
>  mm/migrate.c                 |  5 ++---
>  12 files changed, 26 insertions(+), 36 deletions(-)
> ---
> base-commit: fbf55982f31ae6aa11f890c36bccc130ce70a312
> change-id: 20260317-config_migration-463e20400499
> 
> Best regards,


