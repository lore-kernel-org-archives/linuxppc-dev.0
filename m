Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3FA60784A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q6MV3T+Q
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYl1n20rsz3bbW;
	Wed, 25 Nov 2026 01:05:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795529101;
	cv=none; b=XohPQmg6l1wVeeyX3pxu6bFvhquQ2ufrER+q86Fj3q5JpAAeduzC/YhxkYlS7qGU7n2Yxpkk3hUUAqf4+3GUUktIOeyFv4Phb33G39ndYuwwUoMTMRTrFRdbdX27hVG/6N5jLZ5/fXWMoChMEkMFJg5a3EXmSrBujTg7UK30p8BuFuTt+GRVg/11eXVuSFN02IHR+vIAhn2TisYW0RBw0tDnUZADYonpHFQ6OZsNJ0C9TzJdstpnirpGIOCi7+VqDuLgcUSAXjUOsWbznfMMrEiAAThPUkLGRI5DG0nu+gfMs4P9lz1VUSMv06j1UgqQbFeZEcyGrCVQYCgIdEz1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795529101; c=relaxed/relaxed;
	bh=dyKHuWz1d2Frm11VryLe5MVhcgNxdq9OLcfJXX7QEjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NhJXI5fT7gvyXok5MfoYWqKHJ0H28MBdMjFCB+Eqy44QMfuVwf8xqdZNq7iZRL5+YNhIARLB5CjgqNAD11BYIuiim9M6kuwL1jW0mvox2ufNm4bH45600lapLsjE04mUPmb0Ymyj1ajH9qcMbA0XTtbNQObGOSLfD55M9jHIxvDGnp1TQMQaemgzc0y9TgW/Gu71CURd3WERjIYWV7jWgsMT634VSbM4fquXKIpl9mxIH1lwjI6vx/JL4NWvqugRhaBepiuN//1MVMV4uLXmzLXsA9R6+El0Mshe3KHU5Cuw6LNOgwOEKR54BucCHJ4vqaZim5geWQW1yniPa25RKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q6MV3T+Q; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q6MV3T+Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYl1m3cKvz3bb6;
	Wed, 25 Nov 2026 01:05:00 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2A2CA620C2;
	Tue, 24 Nov 2026 14:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F63E1F00ADF;
	Tue, 24 Nov 2026 14:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795529097;
	bh=dyKHuWz1d2Frm11VryLe5MVhcgNxdq9OLcfJXX7QEjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q6MV3T+QtMeFGS05JxbY86fyXxb5BpRhz2xNTl9eMNfcKfw+grBzdABfY7zkWcmhf
	 3oXmd4lIvhn6HY6OzXXCGpX3x871baxo9e2taEWdz4G5NRtFr4HIZLW/Mmej4HB25n
	 pd5Rhlwzeg+i3fuK3nnd+/5nYHtvXaH9/5nXXdyOVT9uYdK2a7c0OsQs/bVh+3Yb8D
	 8M6p5tkece9ezcQQtmoIpKbmcdZqP5JmjEIvTz5EAB0KjX1oZMDeijKf3LV7e9LjgL
	 CH5DW18DiH/zpC3bH1tBGKVdQ66YVARE97fBELOKoKVCGs4OrCADqFtuBQSEP/uZlf
	 9AljS1iLyidaw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 14:02:49 +0000
Subject: [PATCH v2 06/13] selinuxfs: convert mmap hooks to mmap_prepare
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
Message-Id: <20261124-late-2026-mmap_prepare-v2-6-0b0d99d655f9@kernel.org>
References: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
In-Reply-To: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
 Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Scott Branden <scott.branden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ljs@kernel.org, xen-devel@lists.xenproject.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
 selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, 
 op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org, 
 linux-mm@kvack.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2650; i=ljs@kernel.org;
 h=from:subject:message-id; bh=cFTcX5zX06yJZykgfJZX7vj2B6uDxu9XGGETlT23sQE=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZZ4oXBnSrzg9q6W+pOxNa5sv2mHvLOWmLDf/9bu4Ve
 ODDKszVUcrCIMbFICumyPL8i/j+IJGweZ0X/N1g5rAygQxh4OIUgIm8fMzw3/3c1MgpujcfSn5k
 2CWletNH79GRC8V1Jxk2GHx6IO3yXJmRYf13k5To5D2ZX6wtDu9wmJ724si7t5XdipY5N4On9PC
 z8AMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move from the deprecated mmap hook to the new mmap_prepare hook for the
policy and status files.

The policy file only sets VMA flags and operations. The status file remaps
a single page, so use the PFN remap mmap action to do so.

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 security/selinux/selinuxfs.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 310e19efff1d..e78c65685020 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -236,27 +236,25 @@ static ssize_t sel_read_handle_status(struct file *filp, char __user *buf,
 				       sizeof(struct selinux_kernel_status));
 }
 
-static int sel_mmap_handle_status(struct file *filp,
-				  struct vm_area_struct *vma)
+static int sel_mmap_prepare_handle_status(struct vm_area_desc *desc)
 {
-	struct page    *status = filp->private_data;
-	unsigned long	size = vma->vm_end - vma->vm_start;
+	struct page    *status = desc->file->private_data;
 
 	BUG_ON(!status);
 
 	/* only allows one page from the head */
-	if (vma->vm_pgoff > 0 || size != PAGE_SIZE)
+	if (desc->pgoff > 0 || vma_desc_size(desc) != PAGE_SIZE)
 		return -EIO;
 
-	return remap_pfn_range(vma, vma->vm_start,
-			       page_to_pfn(status),
-			       size, vma->vm_page_prot);
+	mmap_action_remap_full(desc, page_to_pfn(status));
+
+	return 0;
 }
 
 static const struct file_operations sel_handle_status_ops = {
 	.open		= sel_open_handle_status,
 	.read		= sel_read_handle_status,
-	.mmap		= sel_mmap_handle_status,
+	.mmap_prepare	= sel_mmap_prepare_handle_status,
 	.llseek		= generic_file_llseek,
 };
 
@@ -419,10 +417,10 @@ static const struct vm_operations_struct sel_mmap_policy_ops = {
 	.page_mkwrite = sel_mmap_policy_fault,
 };
 
-static int sel_mmap_policy(struct file *filp, struct vm_area_struct *vma)
+static int sel_mmap_prepare_policy(struct vm_area_desc *desc)
 {
-	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
-	vma->vm_ops = &sel_mmap_policy_ops;
+	vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT, VMA_DONTDUMP_BIT);
+	desc->vm_ops = &sel_mmap_policy_ops;
 
 	return 0;
 }
@@ -430,7 +428,7 @@ static int sel_mmap_policy(struct file *filp, struct vm_area_struct *vma)
 static const struct file_operations sel_policy_ops = {
 	.open		= sel_open_policy,
 	.read		= sel_read_policy,
-	.mmap		= sel_mmap_policy,
+	.mmap_prepare	= sel_mmap_prepare_policy,
 	.release	= sel_release_policy,
 	.llseek		= generic_file_llseek,
 };

-- 
2.56.1


