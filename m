Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1AA606A31B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 04:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ryBg0vv/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDHLB10Cwz2yPG;
	Tue, 27 Oct 2026 15:18:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793071390;
	cv=none; b=NwphNzBZa5hzRxU+8z0CPNc2xwZM0vpXQLuBIRDmmlWDLxT0u2MVxXPzv3mLyPdE86odeVzrIPWLdcBWhFnPXvV/KgkOGaS5QepbMNpdm3g/yQJOwF+xhbfdYRIi60Ss3r1rr98AvurjugI6Fg47BHcMdZ8yPOQD+YVKNw5+ZzUFwEksNTfKJUfZW7coH9O/8mLjJGfUaR9DvlSNQ0XXpYG1dcUHugPNwuB7Gh9LfkY2canw3xkl0vP4zq1ObTjOBevyxQ6EtBMQLl7IWoluftoOIMKO4eUulcdBK16STPpI02DhBuqjPIvNcNjQQjmjTjlG3fBe6S2XfUl+Sqf1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793071390; c=relaxed/relaxed;
	bh=4O96wME59YozreVoXYue1ZzVmrJOWE9hKphAow+pyRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VD7oJ0oQEP50enFO74GXWnU5Znp21PVUBbyA90ep7PCh7mdrdQ78reQ+i5BuMgah+iJLJKIlZfrjR/mwIj+7UJsALXFbPL0o/QdTsYzQX8DSe4Rw28M3oLsCuTAGwbRTqLOSwaODEXdWDU0ujFv6OT3LrWZyfWt3D6wKqG2A5/seWL7vMw0jCL0cfwmSQmToZDLVXQNxCzl19Zmcwst/uTtG3VjvFB616Mf0PCcMrdtsqBYFYwZCnrEimcb824v+DtqmZs3I+9FuOxV/0rVgoLzgLySPCk+l3TbpqiXITJbGu722moSzM43vC4ABmk6ISIMiES+sEzWnxxWLejKFfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ryBg0vv/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ryBg0vv/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDG655p4cz2xQs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 14:23:09 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso5962518eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 20:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793071388; x=1793676188; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4O96wME59YozreVoXYue1ZzVmrJOWE9hKphAow+pyRk=;
        b=ryBg0vv/onfISJQ/f33rukhVzbz8zrwhPy6PiGXwPq7njZWxTBz1r7ogs810Zmpzli
         +QCKFQGPSjl1i904MOF5kJUwnSg5AdacwNQce0eie6Lo43z92ILxyXoqn6wgGkrTvqfM
         15qca7TN29gZcCFEZKnbLAvqvTsRf3GVzMTMmllj+QJVznSX/n8iLv+9X69EmK9UQVTK
         lbrMq4Mp5L98Mk1Vk9EhaO8Jdr1GzqZTFDyq2V10R6jEem+RLJqkQCA/n8BvXVrZl2ja
         6GeHmB7RD6I0m1WBnAriT6EsMq9D8lDvuYAEXlkwMpF/4C0vsVB9kxTR2wlozKSvPX8H
         IrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793071388; x=1793676188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4O96wME59YozreVoXYue1ZzVmrJOWE9hKphAow+pyRk=;
        b=NnUOJkuONp/BTiPKISdYxc2vzvHedVR57+MI694wm8B6lklPWD0s2AQHNUVWzRpPvA
         be+rqc9WkJ+/dTb/aGH8MKv5WUjT40lKhF+PJPeyQk6ONggVm7yRNSfePuqkpBRRcaLl
         p2vmnDWF70Dgj0zWIuyQSMuFUOm7D1Kq6RhPHFBSni5MwCpx2999Dkjq+O8aej9RGmvH
         Ju1YYPRipm3/rXe9RllF84NmqwW5yK2tVMDPvg3YqVLyqOojfA3hvVNSAQp/YCWywsE9
         V88hbNIrfJqDYIpOnDr5KabWSjpOkfGTq7Ct9H7WOYCxyYbnqfRY+mywdy/10lOxZs6A
         LgSw==
X-Forwarded-Encrypted: i=1; AKwUvByWBI0FuFkyVRF9PzROnjdRMzfFapGgNvn/udYCUfoCDzp6R5MZozrVYTsVwaFb5fuRw/811f5EUhas+oQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYICgVhoPP5ldmJoZl21vvmx+lCJkZ/puPj+GJhq1hEOduNsXIh/
	BMYhZ5sJkDnbJ+UDrHz1zM8R/OB61YBUqsab0vqG1wyqP9tTGwH7SVxE
X-Gm-Gg: AYBFou2LhbHrjN4YC2whcHPs2w+W0z3bj+/g2s4k7R2GkdXGbkPUehp3/PPsKFa3UU2
	gLl0uxoDTdQ4c9wOSsyAi+OrAVtCYlSivk0uwz8ifgrIqz6S1bgWd77aGJRuKWh8psB69E+HhUf
	s6CxUpwtwHs2HgaKXaUCwinpWYoQeX8peB/X0iQnQrAhnkUMs4ymfa59mPkiSfzwYmCozfKD0sv
	7RxjWDx5eher0tOKeOG9iOzhrCouTdZ3DjnWR9+WGB4Q/kSeeF50L3I7Xh8XSKEq2Lea8HjjeF3
	l4cLpM3IS2LWZhkSYhYotSdJLNR7ua+ACTTEZo1u7SQnIzAoMPVmFIFYrsL+3nACh2JR3gTb+R2
	Ru4myeJrRe5Ep96i029b9jmA6I5GiFRceAO+1ddjGv0mPBT5KPXfzs9Sanvf4LzRknEq0UMrSb0
	Ry6v+MMWmL+mTtfxsrkPpAjIm+w3/6SYpswABH1+XtdAR+1ZQH9JAQ/WbDHCLzTu2WmuZo0GzwP
	s52F2g7x0RySELHqQhBWTKZA9cZ7PPSMXK5iNqiNRgEetmP99S6dIpRyNUh
X-Received: by 2002:a05:7301:f09:b0:35f:b0f:d15c with SMTP id 5a478bee46e88-369e867f95emr11035597eec.39.1793071387520;
        Mon, 26 Oct 2026 20:23:07 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec9276sm49373826eec.25.2026.10.26.20.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:23:06 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Pavithra <pavrampu@linux.ibm.com>
Subject: [PATCH 2/2] mm/huge_memory: set the mmu_gather page size in zap_huge_pud()
Date: Tue, 27 Oct 2026 08:52:49 +0530
Message-Id: <c872f6fdbabe92c1171f3b25448e15247ec34a21.1793070429.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com>
References: <97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com>
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

Fix this in the same way like how other similar paths does.

Fixes: dbe54153296d0 ("mm/huge_memory: add vmf_insert_folio_pud()")
Reported-by: Pavithra <pavrampu@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
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


