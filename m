Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E7F606A337
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyoADFGo
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLFHK2wX1z2xH7;
	Fri, 06 Nov 2026 08:06:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793912813;
	cv=none; b=cbDHfeLT8OzzOmI09OouCZuUIcUNb36N5XazKyWd5LGBxKY9hu7BCP8dmusmGne5ARTvPeQDV4OIEQjc/stodZ/i5XIOGkrkt+Da7x0MHKAqt5wAlAGxSDMw66k7KlHbINfa9Ke56QmIbXdqEa592OT3ziQ+1Gov9uju+5+Rb3P8gusjDYBZvY3i/phZVwkrQURAuxdpFRMZyORGNFEVo3pgYxOGs0f3qY5TLyxstljDomrycErz3beEEnN5eqKMoqVZfUCBi1+lvMlJz6qu8ge8OE/9uaDfgEw6cEFl5vNraBfqOvs5BBHgZdWbNjKd0u06quKt0LPTC3zTRzayyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793912813; c=relaxed/relaxed;
	bh=lMfCHuJWDITAzVX5MILlRUAfVtlxLQX6U8OJOyztS0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R5lQnBih214i3GvprNwGa4AjyTcZtXE6OhOYq5PFVIx8/Ur0zkkTjC35ftla021ZCVjNbhSG+qt4LqAlWOpSzrjOUDAQacICM8cbygcFTWMcJs2zuhT3rZGI2fd/hbvNmVJhvnkLWH/TPfMCA58VOdxvQJ2e0uDSnpKO22WsmOUkTLThkkidD+omlnfVID6mDjDCt3JWeMM7G9RBZXOQHEwe3OnSJppf6VilRj+us9Fqz6/sK8x/e82eQtWbcIHycmMILFmXiwmZxPsk1tIHyzak0XfqAYuHdcGpiAxKByoRH1pTC+BbP2+xiLHhXdbZlQirEhqrLmV+eX5dnsBnwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyoADFGo; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyoADFGo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLFHJ4Pvkz2xKx;
	Fri, 06 Nov 2026 08:06:52 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B47AC605F7;
	Thu,  5 Nov 2026 21:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70931F008A2;
	Thu,  5 Nov 2026 21:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912810;
	bh=lMfCHuJWDITAzVX5MILlRUAfVtlxLQX6U8OJOyztS0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hyoADFGoZhaTWJkzXcW3KcbEavv04p8OShbOv92vBdUSDNLHC33p5UKp1V2NVcrld
	 kDlm4+Dh0N0ewg6c+CsYgrDJ3ZyQfeLnEMeGuWWhUOa1JWAqXOF3EIa9dU7hEYQurC
	 UD8uUTqIpkS8973AB0tlJQaOj0TVHyTL25qiKUL5PD3kHvTGhvyIEbBHKWXDn6uHka
	 RoxnfP2r7Ju1UsLJ3jtzSicq0aWOqHOlTJAt5o8ROmzR1tSO11ZVBsg+5OZeT4rkNp
	 9MHuwVurtm4FxobT/XptLLk7AHWfQIwdo04JpdFyuH/BI40j4CP1PTKjHXSsUS4XXm
	 oJDzW5rZ2ElnQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:05:35 +0000
Subject: [PATCH 04/14] vduse: convert IOVA domain mmap hook to mmap_prepare
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
Message-Id: <20261105-late-2026-mmap_prepare-v1-4-c56aadfbab8a@kernel.org>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
To: Juergen Gross <jgross@suse.com>, 
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
 op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527; i=ljs@kernel.org;
 h=from:subject:message-id; bh=f+7KpJr4q75MSHX3Bd7fDuPR7a/rNIIIf/bMN+NEgYc=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLevF8du8y356wo75UohnvW1WmG2azZxoEG9l+mvHw8c
 ZHxmh0fOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRiBOMDB0R1y2sCsxZCz9d
 WmjgP+cKZ4HBz+NXpWMcv1wV1woTUGNk+FWtznBzgiPz5WrBrQefRpSzaacb3N2dE78n6eYhful
 ubgA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move from the deprecated mmap hook to the new mmap_prepare hook. The hook
only sets VMA flags, operations and private data.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index b6c958224b7c..64465f690a4d 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -575,13 +575,13 @@ static const struct vm_operations_struct vduse_domain_mmap_ops = {
 	.fault = vduse_domain_mmap_fault,
 };
 
-static int vduse_domain_mmap(struct file *file, struct vm_area_struct *vma)
+static int vduse_domain_mmap_prepare(struct vm_area_desc *desc)
 {
-	struct vduse_iova_domain *domain = file->private_data;
+	struct vduse_iova_domain *domain = desc->file->private_data;
 
-	vm_flags_set(vma, VM_DONTDUMP | VM_DONTEXPAND);
-	vma->vm_private_data = domain;
-	vma->vm_ops = &vduse_domain_mmap_ops;
+	vma_desc_set_flags(desc, VMA_DONTDUMP_BIT, VMA_DONTEXPAND_BIT);
+	desc->private_data = domain;
+	desc->vm_ops = &vduse_domain_mmap_ops;
 
 	return 0;
 }
@@ -606,7 +606,7 @@ static int vduse_domain_release(struct inode *inode, struct file *file)
 
 static const struct file_operations vduse_domain_fops = {
 	.owner = THIS_MODULE,
-	.mmap = vduse_domain_mmap,
+	.mmap_prepare = vduse_domain_mmap_prepare,
 	.release = vduse_domain_release,
 };
 

-- 
2.56.0


