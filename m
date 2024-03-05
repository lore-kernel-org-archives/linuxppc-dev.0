Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6F2C54798
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2024 04:41:47 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CB7NPZus;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OxaZ+Ypv;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TpjZf0tZbz3vj5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2024 15:41:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CB7NPZus;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OxaZ+Ypv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=peterx@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TpjW16bQBz3dX4
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2024 15:38:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709613514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdT2Q0TeX0+DskPh7cQ9GWjsaXoSWZfTenFAEBHiO1c=;
	b=CB7NPZusi228H5EZFCRW9B3uDX9Idaod3e2hUSZHlin1HwJ0MJQ/0+l71rcUm84IVKcxHx
	QOFmA8fY3/FtNYrqxOUuzq5k/+WGysMFls06+/6WovNSRexp79MGLEEL+L7HEHWwwBXOy7
	Qgfkh74mNcO6jVde2pwFSiT0Chw1WiA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709613515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdT2Q0TeX0+DskPh7cQ9GWjsaXoSWZfTenFAEBHiO1c=;
	b=OxaZ+Ypvdvd3gr/9EpnLgv+lOJpS0SWQyoj1K4wQLxwUx+CSnFeV+Zl8TLvgjMCgU9VHHA
	6AYAL0OYx72kaCG8Aqnp7pUXaQjaOTvoXLrgwo7ia3ho2vWYKOfOO/IM/MGHC0+Bh4tbMB
	qIjrE4VxBGKdJC0Q0k59lVNTQuvjwnY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-cAgx3rZoNfqMGBlxB6YwXw-1; Mon, 04 Mar 2024 23:38:31 -0500
X-MC-Unique: cAgx3rZoNfqMGBlxB6YwXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63FC0185AD0B;
	Tue,  5 Mar 2024 04:38:30 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.31])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 68DA5C1F086;
	Tue,  5 Mar 2024 04:38:23 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/10] mm/x86: Replace pgd_large() with pgd_leaf()
Date: Tue,  5 Mar 2024 12:37:44 +0800
Message-ID: <20240305043750.93762-5-peterx@redhat.com>
In-Reply-To: <20240305043750.93762-1-peterx@redhat.com>
References: <20240305043750.93762-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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
Cc: Muchun Song <muchun.song@linux.dev>, Yang Shi <shy828301@gmail.com>, x86@kernel.org, peterx@redhat.com, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Jason Gunthorpe <jgg@nvidia.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Peter Xu <peterx@redhat.com>

pgd_leaf() is a global API while pgd_large() is not.  Always use
the global pgd_leaf(), then drop pgd_large().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 4 ++--
 arch/x86/mm/pti.c              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 69ed0ea0641b..d6e993a5659f 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1418,8 +1418,8 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 	return (((ptr & ~PAGE_MASK) / sizeof(pgd_t)) < PGD_KERNEL_START);
 }
 
-#define pgd_leaf	pgd_large
-static inline int pgd_large(pgd_t pgd) { return 0; }
+#define pgd_leaf	pgd_leaf
+static inline int pgd_leaf(pgd_t pgd) { return 0; }
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 /*
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index dc0a81f5f60e..c17aab24c1b3 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -185,7 +185,7 @@ static p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
 
 		set_pgd(pgd, __pgd(_KERNPG_TABLE | __pa(new_p4d_page)));
 	}
-	BUILD_BUG_ON(pgd_large(*pgd) != 0);
+	BUILD_BUG_ON(pgd_leaf(*pgd) != 0);
 
 	return p4d_offset(pgd, address);
 }
-- 
2.44.0

