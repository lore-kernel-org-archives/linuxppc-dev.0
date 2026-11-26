Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81BF606A68E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNX3cDEN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZvJJ2yZ5z3bpM;
	Thu, 26 Nov 2026 22:21:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795692096;
	cv=none; b=Sn/DGUk9kVOroOqq1boygBFkg4uVkSa1ww975uXvG6D9+R4svJ+csWdW4KLgTt/16WZE+5zfqIBOI/ZDNugno/m9HWi2dP3mmNbf6yqcXQEHs9OhJcL0qLm+vTrkLgvFujonmNUqNIcjWRfBApoFaoSl2zIpb1AZtGzTD4CBLz9+fTI6g7+ncsGV8tYPVOybrVpUvpH5hDAVZncNqyRq6I6WabO7dKjrRamkxuedJTM+gekPAehVxvKoE46qzoTrVzr35osMeYMKyRUCB6ycV/96UoG9kOmtj8Cbg0OSHyjcRxqduETQQoQfrhAonPFrdP77yaYy2Tk4Y2pKEQRMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795692096; c=relaxed/relaxed;
	bh=vigwkAWRONvzPByx/zhPfJ9SVHH2ehEcBxoq+qTMC8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3Rqo/g2Gplt7qhS4tHVMq9XWtiEDcv/ZuSbIDVOcJdcyASAvwFW6c+qt81ukm1IHHYZOH93FrMRFYaoxbdEUtFmS5PtEOjvzpccZa2Ce6iLgB2zWSO+y/gEOkZL5iZxWRKE/YzQPlA3IqgilNLL6mWaisPu9edjBeUONvS7vMDaCOQHO2Wc6MliLw5eBWTzGQvSZRpKgraQ+Q3gIqxRnlF/wIN2+bT2LZwdACv13e98qfzkFMIR/4k7gFApT9GDuMcqReIf98+ZU+jVVURpWOI1+E97owGWcy6H+B4WjtsQdZhNhZyv/AdOfpfjuL4v5fhJcB2oBAf1kO3X+qOR6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNX3cDEN; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNX3cDEN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZvJH3zJsz3bpH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 22:21:35 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A569C6338F;
	Thu, 26 Nov 2026 11:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734441F00AD4;
	Thu, 26 Nov 2026 11:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795692092;
	bh=vigwkAWRONvzPByx/zhPfJ9SVHH2ehEcBxoq+qTMC8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SNX3cDENiO5DzlG2beALu6yElwtfAJXpHrvTqpxO60LzbbVU27yDaIgMMSFUrC3qK
	 +gif9ob2GHrwxtQZ2uGiKiYmg7Dy16SvDHGHzdFUsr1dSx+qMH8iVYn8rJD5ozxCDu
	 ZLenCOZbN2Wt7s8cZ1jwGUELsfeht4miRfQl7N/J1msWxoJt4085AIm4mT+Ff3Hjww
	 0rvY138mhTHgAPV+UhUHEzrCijrGWuVoJt3D8ag2qDG35f5eTy1vTkHDWY+1GMsIhv
	 Z/IC6JEKsjS2y2gDXBkm1BfHhyIJPZCVGsNCbFMHzeqMQhFUU9ScTYCUcWKZiWuLGQ
	 jEz1spOt2dAIA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 26 Nov 2026 13:14:57 +0200
Subject: [PATCH RFC v2 44/54] mm/pageattr: derive direct map counter
 updates from the level sizes
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-generic-set-memory-v0-1-v2-44-723f1e33c3d8@kernel.org>
References: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
In-Reply-To: <20261126-generic-set-memory-v0-1-v2-0-723f1e33c3d8@kernel.org>
To: linux-mm@kvack.org
Cc: =?utf-8?q?Adrian_Barna=C5=9B?= <abarnas@google.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Borislav Petkov <bp@alien8.de>, Brendan Jackman <brendan.jackman@linux.dev>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 David Hildenbrand <david@kernel.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Paul Walmsley <pjw@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, x86@kernel.org
X-Mailer: b4 0.16.1-dev
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The direct map counters add PTRS_PER_PTE entries at the next level for
every split.

That is right on x86, riscv and arm64, where all levels have the same
number of entries and PTRS_PER_PTE is the same as PTRS_PER_PMD.

This is not the case on s390.

An s390 segment table has 2048 entries and a page table has 256, i.e.
PTRS_PER_PMD is 2048 and PTRS_PER_PTE is 256.

A split of a PUD mapping on s390 would add 2048 entries to the PMD
counters.

Replace the hard-coded PTRS_PER_PTE in the counter update with a helper
that derives the number of entries from the sizes of the two levels.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/pageattr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/pageattr.c b/mm/pageattr.c
index e05281a2b169..555e55e7ecea 100644
--- a/mm/pageattr.c
+++ b/mm/pageattr.c
@@ -48,6 +48,11 @@ void direct_map_count_update(enum pgtable_level level, long pages)
 	atomic_long_add(pages, &cpa_direct_map_pages[level]);
 }
 
+static long nr_entries(enum pgtable_level level)
+{
+	return pgtable_level_size(level) / pgtable_level_size(level - 1);
+}
+
 void direct_map_count_split(enum pgtable_level level)
 {
 	if (atomic_long_dec_if_positive(&cpa_direct_map_pages[level]) < 0)
@@ -59,7 +64,7 @@ void direct_map_count_split(enum pgtable_level level)
 		else if (level == PGTABLE_LEVEL_PUD)
 			count_vm_event(DIRECT_MAP_LEVEL3_SPLIT);
 	}
-	atomic_long_add(PTRS_PER_PTE, &cpa_direct_map_pages[level - 1]);
+	atomic_long_add(nr_entries(level), &cpa_direct_map_pages[level - 1]);
 }
 
 void direct_map_count_collapse(enum pgtable_level level)
@@ -71,7 +76,7 @@ void direct_map_count_collapse(enum pgtable_level level)
 		else if (level == PGTABLE_LEVEL_PUD)
 			count_vm_event(DIRECT_MAP_LEVEL3_COLLAPSE);
 	}
-	atomic_long_sub(PTRS_PER_PTE, &cpa_direct_map_pages[level - 1]);
+	atomic_long_sub(nr_entries(level), &cpa_direct_map_pages[level - 1]);
 }
 
 void cpa_report_meminfo(struct seq_file *m, unsigned long levels)

-- 
2.53.0


