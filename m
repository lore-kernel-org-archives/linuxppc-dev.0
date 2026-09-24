Return-Path: <linuxppc-dev+bounces-28086-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D2CC98312
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 06:09:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr3Ly0By0z30T6;
	Thu, 24 Sep 2026 16:09:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790230153;
	cv=none; b=NwBwD+znjYtDWd8136BYzFU0rmdei4IaumfGs/jtR2SBV3sy0wz/y6gapO6nmh+PTNqxurTifyjrsoLqjylZvnVfRkbXnZsq2xUFdAqm1nKVtZLO9lENhyc4Czu5jFkzGzZOHL9WJ4eoHF54I21WiouQnQQamvyTzozSCDkGmTpTXHVY9+lOnmAZsTAfMkzTpIei2dzHKB+evMW/YRrxvwqOenY9Z3+Byc5jqVQJr8hit3taJgIgS30LvCX7vcrc36KwC/QthGMdOtnOeOOEzjX0d+QKuYw22D444dU/QLQKAUwrcDSmqDgBdiTMsw2HtTMWpjdAPuGgqgpcbHUCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790230153; c=relaxed/relaxed;
	bh=scK31GWR2h/dTmEm9pgXi3rZWUkl7hz/7+eEu9rpbOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNBLWpyEWuwTGJ0NbI5jIjHbQBMrAzDjAWjqPGRVckWn2q+N+QK1acQXZsUKLY3Hv/jTAkMXrA4lMOS3blbzC9DrQJhf5h9RT1hE830knD1Fp3TZnLwRo0HoKCOiy6413HsZdhKQGcqyf7dn9j5RqLA78pQ3la7YlVUjZ4z2U4WC+Rr+T/Q712+YQvoPNe/+09/AduWob+jYyWgoWEqm4IztvU85mHCYmdx1jmpckHb6eiu3LE5EiuBbnkmXXQBTpbC194KPsijYT5xVRSEQOWqOY09xJmdVzAhm4Mr2/XDdEKl8ngJzywl/XNNPMCK/C1Afme1XE3Si+57Y8GwSaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MPNqW2n3; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MPNqW2n3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr3Lx19dlz30Sx
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 16:09:13 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0E8D66021E;
	Thu, 24 Sep 2026 06:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8231F000FF;
	Thu, 24 Sep 2026 06:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230149;
	bh=scK31GWR2h/dTmEm9pgXi3rZWUkl7hz/7+eEu9rpbOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MPNqW2n3xQPMHb3zk4FZ6ncKB0hS41jziOySyXRP85orS2goMtQH2mm/0L9yaZxJ7
	 uyfxEYDfSKu8jV+fdC4+eGcFWr353MFkOwEd70Y7yLG+AbSEyBgtn2ckcyeoRzGBD+
	 I2tflAOZ4Q1fn7RbuaEgmuUo+/QGXFno6TJ+hS3dXjCIRl3cw4GGfgWF+2qH69vs2P
	 MwZo6Xz45RCXfRm9huH6Y7sEvvHmd8YWAtVSH/kZU0DX+sGsu33lFAv7L2p9isA4MW
	 5TroSKQNx8yklWoYeiNZ44FrEEEF8XAaphtrhBdD4Jpm+EP38YK8c58oQMes/CsBtO
	 qlrJqSzruzYKg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v6 3/8] dma: swiotlb: Track whether the pool size was explicitly set
Date: Thu, 24 Sep 2026 11:37:51 +0530
Message-ID: <20260924060756.1325156-4-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
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
Content-Transfer-Encoding: 8bit

swiotlb_adjust_size() must not override a pool size supplied through the
swiotlb= command-line parameter.

Currently, it determines whether a size was supplied by comparing
default_nslabs with IO_TLB_DEFAULT_SIZE. This fails when the user
explicitly requests the compiled-in default size, allowing the request
to be overwritten by automatic pool sizing.

Record whether swiotlb= supplied a numeric size in swiotlb_cmdline_size_set
and check that flag directly before adjusting the pool size.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/swiotlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b59dd2a5984e..61efa3244daa 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -100,6 +100,7 @@ static struct io_tlb_mem io_tlb_default_mem;
 
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 static unsigned long default_nareas;
+static bool swiotlb_cmdline_size_set __initdata;
 
 /**
  * struct io_tlb_area - IO TLB memory area descriptor
@@ -253,6 +254,7 @@ setup_io_tlb_npages(char *str)
 		/* avoid tail segment of size < IO_TLB_SEGSIZE */
 		default_nslabs =
 			ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
+		swiotlb_cmdline_size_set = true;
 	}
 	if (*str == ',')
 		++str;
@@ -295,7 +297,7 @@ void __init swiotlb_adjust_size(unsigned long size)
 	 * architectures such as those supporting memory encryption to
 	 * adjust/expand SWIOTLB size for their use.
 	 */
-	if (default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
+	if (swiotlb_cmdline_size_set)
 		return;
 
 	default_nslabs = swiotlb_calc_nslabs(size, default_nareas);
-- 
2.43.0


