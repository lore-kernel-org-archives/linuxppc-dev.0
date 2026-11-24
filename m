Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B3606A33D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4vHYK3h
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYl183Gkhz2yPq;
	Wed, 25 Nov 2026 01:04:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795529068;
	cv=none; b=ZDL1lv2WSZ/X0gUMO3E1WG5X1fhiHcXbFM9kTObzvhGKdAag2LsxThq3bOg8peApzj957uF5V7LzcGdn4OyNyNl6W2gDSWkhM7+i/8UlJhst3fFTEWQlAzaT78x50OnjCO2LXnpX8XFAuAFDk9qu5elVUqS+37O4I5spHQHIkOlCEXY806/1k49Azp8crrZCK/LXAnZBt+WEu7vulMd3z/Q3c+V0R4HAzBSkQGQlNtksBZAPYPqiKy47ir5Jhm9y2OciOsTvvvQNOd534+W0hEXZvMoYgcOGmbOi2k5OWD2p1oBWR+dbGdmQmAo4JOVa82VDZJrUfbHZ/9IW/uhG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795529068; c=relaxed/relaxed;
	bh=uFq9iZYwqLr+1Gr6UEwgMrMnckIbLB1v4c17MlJoT5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X78dY5C3l8mm+m7KWzTqmH0iP1+y+rzlzeuvg2NR9KUifdnYX24vgNy3wVHz66eyP4f6PMQqGBGmoCHZVU/RodROm3qvfpCqo7+KiqdsI9f/wX2SlDUFc+tMnYxQ+UYzKO780RCz7hMfk+Lxga+ogusKEUXSFtyqZ2/ZfMK8j5dR6GdoS8hc8mg+5ygO2XoT6Cy4XWhSXGspK49FnEpT/xAc6y75me17c6REw0ZRPBs9RNi9zy3m/A1PZYLQAHap+4lUSIqCRnaZZldgh6t2gL/xgg15gscNJU/bx9Ez2jDG7GEm4QgvVsMv1Y4afJ79Vasv5eHWt/tSlsQw5BcA5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4vHYK3h; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4vHYK3h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYl175MkBz2yMl;
	Wed, 25 Nov 2026 01:04:27 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 097AD41826;
	Tue, 24 Nov 2026 14:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2F11F000D8;
	Tue, 24 Nov 2026 14:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795529065;
	bh=uFq9iZYwqLr+1Gr6UEwgMrMnckIbLB1v4c17MlJoT5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=n4vHYK3heastXfUTv5ny6Odmn4GhFeJjsWDMvoOM4rq57czIeBM1uX2HwsKI+5Of6
	 cWfdqCZutIWrR6o55wcXmgJrwrdNSktSGUMRKVoh80VBsF4YY+clnUFeJleIQ5c0MW
	 0+b9p1+KSNZLSUsm22avuAek7Op1+S83SkVZMJWwhVOyCJY32gIwdaPgwZ+ALwflXa
	 gqUlui6d+xapAgBLj1odarv5GFRZCzZgdga7a5+A2vYj1SnTurtnVRV//J72baeZNd
	 hnTATXOXy01iGcgrYea8kx6/WiYu5rZpkGu5B1iSu0OsY2oRoN9yYVGK42FF/VOfnw
	 Vxw0CovUU3hTA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 14:02:47 +0000
Subject: [PATCH v2 04/13] x86/sgx: convert vepc mmap hook to mmap_prepare
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
Message-Id: <20261124-late-2026-mmap_prepare-v2-4-0b0d99d655f9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716; i=ljs@kernel.org;
 h=from:subject:message-id; bh=otXI3L6hiu1+e3GUvlFZNkY4uUSscpdDKkVudqTwPU8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZZ4p/3pO/9eQqxrjic48NLedd6HjU0Ze0iJ3x4YSX9
 xZPYfpv3FHKwiDGxSArpsjy/Iv4/iCRsHmdF/zdYOawMoEMYeDiFICJ1OQy/FOan/Ss2I01Z1aq
 Tm3p8tSlu2uX/HXc82DW92nefIvKc48y/BXZvkmrJpdhwW+N/IYbwZ+n+Uc/yGi/WXC21+nEKm1
 9X34A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move from the deprecated mmap hook to the new mmap_prepare hook. The hook
only checks that the mapping is shared and sets VMA flags, operations and
private data.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/x86/kernel/cpu/sgx/virt.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 6a1933ddc6fc..850990519ca5 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -98,17 +98,18 @@ static const struct vm_operations_struct sgx_vepc_vm_ops = {
 	.fault = sgx_vepc_fault,
 };
 
-static int sgx_vepc_mmap(struct file *file, struct vm_area_struct *vma)
+static int sgx_vepc_mmap_prepare(struct vm_area_desc *desc)
 {
-	struct sgx_vepc *vepc = file->private_data;
+	struct sgx_vepc *vepc = desc->file->private_data;
 
-	if (!(vma->vm_flags & VM_SHARED))
+	if (!vma_desc_test(desc, VMA_SHARED_BIT))
 		return -EINVAL;
 
-	vma->vm_ops = &sgx_vepc_vm_ops;
+	desc->vm_ops = &sgx_vepc_vm_ops;
 	/* Don't copy VMA in fork() */
-	vm_flags_set(vma, VM_PFNMAP | VM_IO | VM_DONTDUMP | VM_DONTCOPY);
-	vma->vm_private_data = vepc;
+	vma_desc_set_flags(desc, VMA_PFNMAP_BIT, VMA_IO_BIT, VMA_DONTDUMP_BIT,
+			   VMA_DONTCOPY_BIT);
+	desc->private_data = vepc;
 
 	return 0;
 }
@@ -315,7 +316,7 @@ static const struct file_operations sgx_vepc_fops = {
 	.unlocked_ioctl	= sgx_vepc_ioctl,
 	.compat_ioctl	= sgx_vepc_ioctl,
 	.release	= sgx_vepc_release,
-	.mmap		= sgx_vepc_mmap,
+	.mmap_prepare	= sgx_vepc_mmap_prepare,
 };
 
 static struct miscdevice sgx_vepc_dev = {

-- 
2.56.1


