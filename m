Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECFA606A33A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bE1mtiJS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLFGs5VCxz2xNC;
	Fri, 06 Nov 2026 08:06:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793912789;
	cv=none; b=Gkd+KeWZiifPk9m0jiRU3F3uShnxJ5RWBErSf/PS1+gA/zaGS9YHVGb3yVj8VGGC0cNjjvtnrSGGBodh2Z8pxhC9wHNIcmKnlVI9QGV2CgXC+QAdzl+KeOlOwiKV396uIoXaJHaturzdD6QYpkZFWpGL6am/dr5hxWaXuSG0c43O6EbvgnECM8thdi1itM9W4UtTGAv5UntItwcA5LGM4cRJeGnedhQBAtbz7I7R6+BS2KPzRKnQnlNoVZeDY6i/39YjEW+DOHNr9aaP8pNx0oVP3jktsotSGits5l7su1s3dt4G2diCSy+aVN/t36DxAjuq+y9aMyyrsrO9WO3LuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793912789; c=relaxed/relaxed;
	bh=ndCCV29odaVqmbn+iX3MfTT/qeX9oKJWHuVF4KdBH5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TiUIblgKZprg1wUg9D6NOemCfQreLVzG/3WQtPQVNP4BQQhCrMgMG6hYuwQ62oFVesawORdbdFg99QDNlJjTJCMK5/Fco0uOJdM3072t2ryVSnAJoAToxnXAsiRrroIRPeY04UG+iGd6+aGNhFMhX0Dv0HrbHy0h9xHcktkskzcJJ4dsv0acpnsi5wFJhqMWtxWzDOMzygimsOZPnviumNPbzbvh7jUe1wvcE5bevsMxJyi25hGH8L2vchVMoyURqa4iOfH+JAaw05qSupJLNON0iP/qj5027uLT6Jy2zhUDhlypaqJjf1x3jYuif+ut2uDK25zjiy5N5bfKaEarww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bE1mtiJS; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bE1mtiJS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLFGr6v0tz2xH7;
	Fri, 06 Nov 2026 08:06:28 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 340EF40474;
	Thu,  5 Nov 2026 21:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7721F008A2;
	Thu,  5 Nov 2026 21:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912786;
	bh=ndCCV29odaVqmbn+iX3MfTT/qeX9oKJWHuVF4KdBH5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bE1mtiJSdVH/EQ/is2LWkUZ/C3yxYBYfLOhHqUTt/CwFIy/gYmtLkJHHuxmtn0qas
	 yO9fbotB7tujrxXdc0dnkvxIV/RhktA0O7/IfKUxqgjQUPFOkQ5XnXZtbaWRijR9Vy
	 rvAxbTT+4e6PNwgjL8QIvMIHw/zcPa1VPCvof+TgcikwT7sEhMMTQsb3zg5PapYZUW
	 2Lseo41qjhjCwu9T0ZH9xcwi/0hu1ZabSEnBK24mSHLfxURPoVykJcET2IhZ4Wtq9c
	 Hnu7ks+Oht5PHDx5NhOAkrNMXAA5S32BMROuJexLAy02FIr8+q5JXl7F26smYgLgC3
	 Q7zdGqQgYr71w==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:05:33 +0000
Subject: [PATCH 02/14] KVM: PPC: Book3S: convert spapr TCE mmap hook to
 mmap_prepare
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
Message-Id: <20261105-late-2026-mmap_prepare-v1-2-c56aadfbab8a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=ljs@kernel.org;
 h=from:subject:message-id; bh=isNjWX1+rq7D/LCFpxyPlaDLPeXkCD+W3Ok7FRCKcJw=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLevF+9xW/CppYO03VXA+4cXPbxVIsu56wVs7KfZZ3ol
 1lwXPt+bkcpC4MYF4OsmCLL8y/i+4NEwuZ1XvB3g5nDygQyhIGLUwAm8pOXkWGz4+UDqey9qzes
 Xb+fSYpFRlBEUvKQQ1qUfs3xhguqITcY/vus+TRh5qs94ifijyrfz1sVcMt/v+Lr5WJTS9on9iz
 /dooNAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move from the deprecated mmap hook to the new mmap_prepare hook. The hook
only sets the VMA operations.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/powerpc/kvm/book3s_64_vio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index c5f3f5b29d89..05f6f2c9a432 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -247,9 +247,9 @@ static const struct vm_operations_struct kvm_spapr_tce_vm_ops = {
 	.fault = kvm_spapr_tce_fault,
 };
 
-static int kvm_spapr_tce_mmap(struct file *file, struct vm_area_struct *vma)
+static int kvm_spapr_tce_mmap_prepare(struct vm_area_desc *desc)
 {
-	vma->vm_ops = &kvm_spapr_tce_vm_ops;
+	desc->vm_ops = &kvm_spapr_tce_vm_ops;
 	return 0;
 }
 
@@ -282,7 +282,7 @@ static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
 }
 
 static const struct file_operations kvm_spapr_tce_fops = {
-	.mmap           = kvm_spapr_tce_mmap,
+	.mmap_prepare	= kvm_spapr_tce_mmap_prepare,
 	.release	= kvm_spapr_tce_release,
 };
 

-- 
2.56.0


