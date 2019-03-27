Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45376C10F00
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 18:07:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90F821734
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 18:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bn9CB8uQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90F821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Twvc2Jq7zDqBZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 05:07:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="bn9CB8uQ"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Twnb59KjzDqPj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 05:02:27 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CB1A52146F;
 Wed, 27 Mar 2019 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553709745;
 bh=hOyhfl2oQp9beaVEdiXpd/rNdZl7HVN7AZx/JZPGlhI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bn9CB8uQTyuorEN8f+aOAe1Szm8Ck4wwzvHTCusv1mSK24/7AXgrPpNDaoswKU+8G
 ygZ4WKaNUbXK/ZwNXY90G2GBJvSSIJ45DI1/iiOBgqyv7rUzwHb5bvBNrfGaHQ3+Cl
 T7m7TJpkoxAOW4KsvrK0r19PzW28WD7bqkqossIM=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 015/262] memblock: memblock_phys_alloc_try_nid():
 don't panic
Date: Wed, 27 Mar 2019 13:57:50 -0400
Message-Id: <20190327180158.10245-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Rich Felker <dalias@libc.org>, Petr Mladek <pmladek@suse.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Guo Ren <ren_guo@c-sky.com>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 Juergen Gross <jgross@suse.com>, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Paul Burton <paul.burton@mips.com>, Vineet Gupta <vgupta@synopsys.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Mike Rapoport <rppt@linux.ibm.com>

[ Upstream commit 337555744e6e39dd1d87698c6084dd88a606d60a ]

The memblock_phys_alloc_try_nid() function tries to allocate memory from
the requested node and then falls back to allocation from any node in
the system.  The memblock_alloc_base() fallback used by this function
panics if the allocation fails.

Replace the memblock_alloc_base() fallback with the direct call to
memblock_alloc_range_nid() and update the memblock_phys_alloc_try_nid()
callers to check the returned value and panic in case of error.

Link: http://lkml.kernel.org/r/1548057848-15136-7-git-send-email-rppt@linux.ibm.com
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>		[powerpc]
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guan Xuetao <gxt@pku.edu.cn>
Cc: Guo Ren <guoren@kernel.org>
Cc: Guo Ren <ren_guo@c-sky.com>				[c-sky]
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Juergen Gross <jgross@suse.com>			[Xen]
Cc: Mark Salter <msalter@redhat.com>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Rich Felker <dalias@libc.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/numa.c   | 4 ++++
 arch/powerpc/mm/numa.c | 4 ++++
 mm/memblock.c          | 4 +++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index ae34e3a1cef1..2c61ea4e290b 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -237,6 +237,10 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 		pr_info("Initmem setup node %d [<memory-less node>]\n", nid);
 
 	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
+	if (!nd_pa)
+		panic("Cannot allocate %zu bytes for node %d data\n",
+		      nd_size, nid);
+
 	nd = __va(nd_pa);
 
 	/* report and initialize */
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 87f0dd004295..8ec2ed30d44c 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -788,6 +788,10 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
 	int tnid;
 
 	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
+	if (!nd_pa)
+		panic("Cannot allocate %zu bytes for node %d data\n",
+		      nd_size, nid);
+
 	nd = __va(nd_pa);
 
 	/* report and initialize */
diff --git a/mm/memblock.c b/mm/memblock.c
index ea31045ba704..d5923df56acc 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1342,7 +1342,9 @@ phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t ali
 
 	if (res)
 		return res;
-	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
+	return memblock_alloc_range_nid(size, align, 0,
+					MEMBLOCK_ALLOC_ACCESSIBLE,
+					NUMA_NO_NODE, MEMBLOCK_NONE);
 }
 
 /**
-- 
2.19.1

