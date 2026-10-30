Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FD606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 00:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mHFC5fHX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jG1dN6d3Pz308H;
	Fri, 30 Oct 2026 11:07:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793318872;
	cv=none; b=KPn7ZNaYZFYV1tdv4Fai8H3MsDKD1/pwADu2DaPVPWvlV+jPXXnrIC8XVJOM0ZFuVv8kyBYCspwp9j8V6McuK+oXWSTYqwy9/PPCdCzRKTNsD61N1gc0PUdiPPXi7m5Nzv1b+1SRvck90ZMOtXq3Q32eNjJwys6IQ6hfspwlifTmKJQgoTJg7cc4KkO2CqkXKdS6mreK+uvdJxWa8e1lmELNt29lz7YJ643JYrmzgYpXx++5WTAJoR+YxTFqsB8hJCysj8cfafpKrLZsTVBp6yyjbHTwg9RTiVCnH8VakEmZuK/bbleSu/BXnKnVSTyHPvTz6axehatAI8dUFtocvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793318872; c=relaxed/relaxed;
	bh=jVUIageg/XI3VA6PRbnnsPlVRr/N3qezw2iOOgJuil4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EUIEDERRvPtqB0Q7NSO0gOifzCQ5lSvFMn2OV1IeoB4K760yWyzPBE0GRcEJP2IHKZXtb6feWte0l/beFxgi4kmTFGY+lpRpF1rji6h1vOwZS0eOQ3DABNt/O5MGSgYj/EPdkk2KTggZBfcrUxWJS/KvPJieoR5/P0LheyrCnIyijZsdXa5pymEgdBtGGWldgqBCMRg2gq3s1y3Xe+iv4FXBds51STX2WiCE4kmlsLdrwcBT4BMqE3aKCC36HKe7Szumyyf4L/cBO3gHU5GrdkuWJIATMmQi1Y+6U6I0IJ4EaqHafhT2aefN9l8Flr8zp4aTC9SDl6QqzYL1eYYbBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mHFC5fHX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mHFC5fHX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jG1dM6RKzz2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 11:07:51 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-369f33df08eso414518eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 17:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793318869; x=1793923669; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jVUIageg/XI3VA6PRbnnsPlVRr/N3qezw2iOOgJuil4=;
        b=mHFC5fHXBfEX9UdP6/sReZ3ON1Fs9rm1QksPNkKSzcTwrJKoPZzN2TqkT/Wq6HfgOc
         vf0lY1J+fsHw70HtCURXpX6cSNS1u/hj6xjCUgR51lOCYZtXw+2P4DvuJmkRLriNiy3F
         VdltHow3oxpq4+8qQv94X4ruG2Fy9y25VsKJdIx9Z+0BI/MExad5aCJ0EtP9Ic9fSj3V
         Nlt6dDtpahIPCap5uljhbQK8fbZ/6yZqkcxU3bmjK5+kydlUyAXer9HCD1H4RCeoRp4h
         axQhmJ96WLTmF4ggmn2N5GmDHihUno/2eKUXEnODzsCQpDS8+yC0nZTHc3WxLEQpAo7g
         nrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793318869; x=1793923669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jVUIageg/XI3VA6PRbnnsPlVRr/N3qezw2iOOgJuil4=;
        b=PbZBS0ZDejtHVwMz7ul9JLC0VP6xZW+jeugSgOktC+apounnFQqCGuQeyMuEFbgGdt
         12MDobmqIu4ob4whhS2krfk4pFDUjB9b8dSy3BmH8XOotAYVY0PFvh/aqqYltioe9VRa
         Xi9Fvb0b+/N3bHyVEbwCQhoIHIbpuVqfTeoSv1ZJ/hzwyZqsbS7YDtFQXVpX40zyS3dx
         36NHKD+i9bz1eCm4PBa4nmIi14yqxFFnrvtvLzFt3ebNbNqOARCqXcPnixgGVfMXpOwC
         KqTcrSSqXyw2g0+JEIS1CSfeqZYF1og/8RPrW8I9Ml6faK7bH3YoekVc78OSpA8STTWR
         4PDg==
X-Forwarded-Encrypted: i=1; AKwUvBwPC8jKLcImb5SvIZmF9tkf5pIYKE0FZySFSslgz1OxCnXZrGaY8+CJvhQLXM+4C1O/MdRJyuTnTPbHukQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKVkbE2WFMLMmBJ115rnrNjPOdo0Ce1evZQyuVJ053Lf8COAFJk
	CmG0BZVS4hp7dw4E3lhX73hSXx+OBaAhJfJrrdCKQsprlIq3JVARWiHQ
X-Gm-Gg: AYBFou3plQOrsrhcZo/W6kw9x27gUzE5tgKvI66c8tD25G0umgrNysQwDK55Q+aztgk
	f0634h78FJ0x5dBDRg8LVZ2Y3g0nDWba8J1s8NtTq0AsGf0wCMate1P+z9SPWQjN8mq4bwaB2Ym
	UMq1h4IVR83IJm4qEAevR1QFXb07SgQJiO9hQ8Cp8SPyjMXfzJLgSm104N3V8+tA39ImT9kFDNc
	h8VYjflyvoJqiKfBK375EU30G7BGcdfkYgSHxIsDXiPrZkdMXTgw6+XcirVtO/285Qdm2hh1nBC
	nTQUnuTyjqa9fm6astxaZSMm2x/8ac2zB7x+WZJCJ7Z626uhB6LETPODN8IBh+Nb4N1eiV5VrrH
	Ulf7gOokSGDLubOIuJZozAYktHOZDYta4WJnriPakoAetW65YbdEoVYanJqVfV4MMKr3fCdeJ67
	v/JyqzpN7NWaKHLnHg+GocTKTvqsIpZiWPy8uEhX4Fu9N6DLG2KZbCM6nrI1j7d76vkpdTXnzs0
	uXkdLxy125cyr4nisZkxp3yiVlPJkL8cGfnPXtDPO4OyFnejyqwtWuqO6PvC0XRvBxeX+wGwX/B
	RwNRMFblmU4OpmlYRGBBGx+URg+43VPsAg==
X-Received: by 2002:a05:693c:880d:10b0:34e:9923:e372 with SMTP id 5a478bee46e88-36a4241a810mr1410914eec.29.1793318868940;
        Thu, 29 Oct 2026 17:07:48 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm2111682eec.3.2026.10.29.17.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:07:48 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Pavithra <pavrampu@linux.ibm.com>
Subject: [PATCHv2] mm/huge_memory: set the mmu_gather page size in zap_huge_pud()
Date: Fri, 30 Oct 2026 05:37:36 +0530
Message-Id: <8b853e5f9f16145859407b28af654b0f79e12642.1793318297.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Unmapping a device-dax mapping with 1G alignment on powerpc radix kernel
built with CONFIG_DEBUG_VM triggers this warning on every munmap:

    WARNING: mm/mmu_gather.c:176 at __tlb_remove_folio_pages_size+0x38/0x230
    NIP [c00000000063d508] __tlb_remove_folio_pages_size+0x38/0x230
    LR [c0000000006fb688] zap_huge_pud+0x1b8/0x2d0
    Call Trace:
     zap_huge_pud+0x170/0x2d0 (unreliable)
     __zap_vma_range+0x1604/0x1e20
     unmap_vmas+0xa0/0x1f0
     unmap_region+0xb0/0x130
     vms_complete_munmap_vmas+0x120/0x310
     do_vmi_align_munmap+0x1ec/0x240
     __vm_munmap+0x148/0x220
     sys_munmap+0x28/0x40

To trigger this - it is enough to mmap() /dev/dax0.0, touch the first
byte so that the whole 1G is mapped by a single PUD and then munmap()
it.

PowerPC needs MMU_GATHER_PAGE_SIZE in which mmu_gather needs to record
the page size for which tlb flush is needed. zap_huge_pmd(),
zap_pte_range(), change_huge_pud() etc all do this already. However,
since commit:
  dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")

a device-dax PUD maps a real folio and zap_huge_pud() now hands it to
tlb_remove_page_size(tlb, page, HPAGE_PUD_SIZE). At that point
tlb->page_size is still whatever the previous user left behind, which is
0 for the fresh gather set up by munmap() and so the check fires.

Fix this in the same way like how other similar paths do.

Fixes: dbe54153296d0 ("mm/huge_memory: add vmf_insert_folio_pud()")
Reported-by: Pavithra <pavrampu@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
[v1]->v2:
=========
- Split the 2 part patch series. Patch-1 is now superseded by a different patch
  from Muchun which he already posted [2].
- No difference in this patch from v1.

[v1]: https://lore.kernel.org/all/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com/
[2]: https://lore.kernel.org/all/20261029063601.1961415-1-songmuchun@bytedance.com/

 mm/huge_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bd44d58e8684..7e589a2fb02d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3040,6 +3040,8 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	spinlock_t *ptl;
 	pud_t orig_pud;

+	tlb_change_page_size(tlb, HPAGE_PUD_SIZE);
+
 	ptl = __pud_trans_huge_lock(pud, vma);
 	if (!ptl)
 		return 0;
--
2.39.5


