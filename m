Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6935260A5BEB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDqI3wph
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYl2N0ylFz3bhq;
	Wed, 25 Nov 2026 01:05:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795529132;
	cv=none; b=RXEVwGQRQcxinjUJGmRSV2OoAqVLGx4/w+U8+ZVKMaFtR95w2kYZBDhcDpoVppvlJwhl4ERyLtq8WDP6J4U7G+Str5ecocw7orAqyGQ3Y1orTn03ns4cFzhRp0deoEHM4/BJPR4uSHhsLRIfQsGlECu1lvAAeRcHUKfC0FF+Dbe3YcQWUbYuNf+Xt04uHK4x8qI7uSMPpB9a2YqTSgFcgLQonfT1NfYQsYkVo8m3NH1FWnL6jd+x8FthKWcvXh8FWsfUMMrF+enuNjuSnI7kqiNS1UNh8LJHR0pobspok/C+b5XcC4qsqukUq1oLyqBj2v1LZ/FMNM8Flz2lKLVAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795529132; c=relaxed/relaxed;
	bh=SrYlGGY0gACro/+moR4ki8LLaruR+DRcq/Omm4chfzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZfbAuQoV1m0+nl7pt+aFM1Iy1WnlpW2SMSKlChXeUursi4nvsvMHw+3B4sE0ZptY6kzCvCJgIRk9tSF9R4/RyrEzu53hX0fulKQvPAJ7OntT44EPHEsp6dRl39269ShY/AeSSHEYQr8iKZ0Y4a4dkIdAK6JZZIU2ShRwMK6y0P0AWqbj3H26y/TljKSCLbX/ssM6MoMV3XaUCBEC1TS6GPIGrIVwxITOfzCz19dE48hLOS/MLKGCaENcq4od1IdM/NUPw1U9GtzhfPpsprKDVs0tM1zvhUkMQRyJRYnTKOUkEH9pJDHsNEm9+2K4FgL7RlWVjlp7MAozyM6OubwEuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDqI3wph; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDqI3wph;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYl2M2wSMz2xN4;
	Wed, 25 Nov 2026 01:05:31 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D9FF741B45;
	Tue, 24 Nov 2026 14:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83991F000EE;
	Tue, 24 Nov 2026 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795529129;
	bh=SrYlGGY0gACro/+moR4ki8LLaruR+DRcq/Omm4chfzc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cDqI3wph5w7mSk7+SA/9MbSHsr7FMUNedC7vWKFhxrOIlpLi/Jg4MsG1xI0bxGAWy
	 qUiRaEAEH9wspwamO2MBPTiaLlH+o8/BVteTJUZpqSzXmShf0FdMFnZW3UEQJcz7qC
	 f0q+icWXYKtjYOrK50ZhDj/QKBpyCbqFkfEyHMExa5AY7OG1tFqiudHtdUMmkTRev9
	 aGc5oo1L+3PAwfFOjRq5w+19u+ENdztRn8Q+pxEcrA7oJco/+Rjiqm6mmh5CB+kEqL
	 sIffKObc49Vrs4vWH7Uf0X1GOMC5zvZdhqnNg0SOOT3TWCwu12uPxmZxl+e1i6P7ig
	 N7AdOF2UuX5WA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 24 Nov 2026 14:02:51 +0000
Subject: [PATCH v2 08/13] soc: aspeed: convert LPC and P2A control mmap
 hooks to mmap_prepare
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
Message-Id: <20261124-late-2026-mmap_prepare-v2-8-0b0d99d655f9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4097; i=ljs@kernel.org;
 h=from:subject:message-id; bh=s32LdAaaGb1M+/iwl2Ev3ih3n8WWn5YLe6Ixr8jPsP8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJZZ4rzb1g8Sfr0brEfn7ZbKupLCrGYKk8Tb2y48VJl3
 jY9zdPzO0pZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCR19MY/hnu+fP5693M5Yyr
 ejU5//XJhc6sqJ6o9PpW5fE7dQeKBLMZGc4t57X/s8jJhD/YdFVqu/caTalFBt/OvYpdl9D1e27
 EOQYA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move from the deprecated mmap hook to the new mmap_prepare hook for both
the LPC control and P2A control drivers.

Both remap a range of their reserved memory region, so use the PFN remap
mmap action to do so, retaining the -EAGAIN error on failure via the action
error override.

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 20 +++++++++-----------
 drivers/soc/aspeed/aspeed-p2a-ctrl.c | 22 ++++++++--------------
 2 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
index 5d91ba2038d5..702fb3e85472 100644
--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -47,22 +47,20 @@ static struct aspeed_lpc_ctrl *file_aspeed_lpc_ctrl(struct file *file)
 			miscdev);
 }
 
-static int aspeed_lpc_ctrl_mmap(struct file *file, struct vm_area_struct *vma)
+static int aspeed_lpc_ctrl_mmap_prepare(struct vm_area_desc *desc)
 {
-	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
-	unsigned long vsize = vma->vm_end - vma->vm_start;
-	pgprot_t prot = vma->vm_page_prot;
+	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(desc->file);
 
-	if (vma->vm_pgoff + vma_pages(vma) > lpc_ctrl->mem_size >> PAGE_SHIFT)
+	if (desc->pgoff + vma_desc_pages(desc) >
+	    lpc_ctrl->mem_size >> PAGE_SHIFT)
 		return -EINVAL;
 
 	/* ast2400/2500 AHB accesses are not cache coherent */
-	prot = pgprot_noncached(prot);
+	desc->page_prot = pgprot_noncached(desc->page_prot);
 
-	if (remap_pfn_range(vma, vma->vm_start,
-		(lpc_ctrl->mem_base >> PAGE_SHIFT) + vma->vm_pgoff,
-		vsize, prot))
-		return -EAGAIN;
+	mmap_action_remap_full(desc,
+		(lpc_ctrl->mem_base >> PAGE_SHIFT) + desc->pgoff);
+	desc->action.error_override = -EAGAIN;
 
 	return 0;
 }
@@ -216,7 +214,7 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
 
 static const struct file_operations aspeed_lpc_ctrl_fops = {
 	.owner		= THIS_MODULE,
-	.mmap		= aspeed_lpc_ctrl_mmap,
+	.mmap_prepare	= aspeed_lpc_ctrl_mmap_prepare,
 	.unlocked_ioctl	= aspeed_lpc_ctrl_ioctl,
 };
 
diff --git a/drivers/soc/aspeed/aspeed-p2a-ctrl.c b/drivers/soc/aspeed/aspeed-p2a-ctrl.c
index efa106d37bd7..7387b0cd8666 100644
--- a/drivers/soc/aspeed/aspeed-p2a-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-p2a-ctrl.c
@@ -97,29 +97,23 @@ static void aspeed_p2a_disable_bridge(struct aspeed_p2a_ctrl *p2a_ctrl)
 	regmap_update_bits(p2a_ctrl->regmap, SCU180, SCU180_ENP2A, 0);
 }
 
-static int aspeed_p2a_mmap(struct file *file, struct vm_area_struct *vma)
+static int aspeed_p2a_mmap_prepare(struct vm_area_desc *desc)
 {
-	unsigned long vsize;
-	pgprot_t prot;
-	struct aspeed_p2a_user *priv = file->private_data;
+	struct aspeed_p2a_user *priv = desc->file->private_data;
 	struct aspeed_p2a_ctrl *ctrl = priv->parent;
 
 	if (ctrl->mem_base == 0 && ctrl->mem_size == 0)
 		return -EINVAL;
 
-	vsize = vma->vm_end - vma->vm_start;
-	prot = vma->vm_page_prot;
-
-	if (vma->vm_pgoff + vma_pages(vma) > ctrl->mem_size >> PAGE_SHIFT)
+	if (desc->pgoff + vma_desc_pages(desc) > ctrl->mem_size >> PAGE_SHIFT)
 		return -EINVAL;
 
 	/* ast2400/2500 AHB accesses are not cache coherent */
-	prot = pgprot_noncached(prot);
+	desc->page_prot = pgprot_noncached(desc->page_prot);
 
-	if (remap_pfn_range(vma, vma->vm_start,
-		(ctrl->mem_base >> PAGE_SHIFT) + vma->vm_pgoff,
-		vsize, prot))
-		return -EAGAIN;
+	mmap_action_remap_full(desc,
+		(ctrl->mem_base >> PAGE_SHIFT) + desc->pgoff);
+	desc->action.error_override = -EAGAIN;
 
 	return 0;
 }
@@ -308,7 +302,7 @@ static int aspeed_p2a_release(struct inode *inode, struct file *file)
 
 static const struct file_operations aspeed_p2a_ctrl_fops = {
 	.owner = THIS_MODULE,
-	.mmap = aspeed_p2a_mmap,
+	.mmap_prepare = aspeed_p2a_mmap_prepare,
 	.unlocked_ioctl = aspeed_p2a_ioctl,
 	.open = aspeed_p2a_open,
 	.release = aspeed_p2a_release,

-- 
2.56.1


