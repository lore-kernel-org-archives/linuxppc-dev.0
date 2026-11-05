Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9BC606D801
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFtPRv+v
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLFJz2qgNz30WJ;
	Fri, 06 Nov 2026 08:08:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793912899;
	cv=none; b=TwJ4HADlwkypD+JUTq1N+rOdjwiQi8PYGxCea2+uHur5qUgexBzedghRpKRym9EZk8e666TzJfsfI4EjKYoMuHsjQtfV7/lKsR4Ub/v2DQfojd9JJ2eYWxBQh9cdE1Z7AY6y26Q+HHpkwmVIcFNY6T4hVxjQJe6SaZeDU3RIbW+Egwon/Zg+Q448TUeFvbAlW8EPlKV4XFU30KfsrkfFLlHjpvimn44zcKMO7kMbk6wjdoS/fltjRCFZNhPdEKDVEx7qJF5XACOrTDRi6dzNFxDErqzoK5WejDyC/mKi3yYq8en90ofLhqaCInSdRGQQBdBm+xi6R9jdRN9Y9Xtptg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793912899; c=relaxed/relaxed;
	bh=RBvzqqEVktGOwLM5OpYBfN5N4ekxKtBbieuNh5yiCZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jQLrnzpvyREpjXUkjnoSZx3WxGkjf8xqZVtSwK2G4Do9GDSCEn+pJoKNkCnpqYpkKf39OEn0GJmumL8gedo3oPvLVO87cswS0ODB4zqBvTaO/+g4HJmrazSscbKZmgTtZhTZudA5TXV7BQ1h16Nx8LTNVhnfcVZrNl4CXhXGrWP8toWwhIoExmqiEbexmUDffisw+7w8pwIDn5g40hJ/A1cwHkttga0PWJJ9B0mcKbGKqM+YL/9XTmAqSuS1uRKH85iTnnikhD8Z030/YcgNk3WcYmSzRCuxjB5oM+Qk18rRuZOpjyEvUFXimCJCPtHOg4Ykkm478VfD9oN6Kka/tg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFtPRv+v; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFtPRv+v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLFJy4LVZz3byP;
	Fri, 06 Nov 2026 08:08:18 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AF7D360A63;
	Thu,  5 Nov 2026 21:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DED61F008BD;
	Thu,  5 Nov 2026 21:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912896;
	bh=RBvzqqEVktGOwLM5OpYBfN5N4ekxKtBbieuNh5yiCZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kFtPRv+vDCqA4I5+7Ba5v1oinPquBwNlu0qv3u1pswQ05uBi8FuxynMX1Au0gqEq1
	 GNXzlN8uFqSJSkJeLpBlJWDZzthZT1QYCXHTFJpJfWyomWsTXudAv/0qXIrV+l9VV5
	 VF2TBnLkW7OziZTahtTdvm/Fn5QH8mhXKLp8QhXY0Hyb/snkD00bpMyAE1rQGFuYCw
	 ngKcgCmFZhysfGBUK8uVX24hJfLxdMi0u0jCBy+ukszMXCOfZPfMf+Kqm78OIzM0tn
	 RxPiN2jic03BG/QtPw6o+SbdcC1jd9rBy5GjZqyDDQ8JEFbdtYwrd4ZQ7qVlg2U+Ut
	 GK2nqGNNO/c5g==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:05:42 +0000
Subject: [PATCH 11/14] tee: convert shm mmap hook to mmap_prepare
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
Message-Id: <20261105-late-2026-mmap_prepare-v1-11-c56aadfbab8a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=ljs@kernel.org;
 h=from:subject:message-id; bh=2RLQC1bSA3UhuwZbggzNroMh6l6JITaynZarCSoVuAM=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLevF/zLjZTWyx1cX6TOl+BpvzBu+qXr/bqSR+fKzhJ4
 VdhWI5PRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACZS68PIcLlhWdCvuI8njsvz
 mpsrWjeVPPbtMH501Wkee5q85d6Dpgz/M7corpQ8r5YdLpejWb5uisP052unmkTtMXCZ9+B2usA
 hdgA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move from the deprecated mmap hook to the new mmap_prepare hook, using the
PFN remap mmap action to map the shared memory.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/tee/tee_shm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daa4af1e089e..8fcbf0232aeb 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -567,10 +567,9 @@ static int tee_shm_fop_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int tee_shm_fop_mmap(struct file *filp, struct vm_area_struct *vma)
+static int tee_shm_fop_mmap_prepare(struct vm_area_desc *desc)
 {
-	struct tee_shm *shm = filp->private_data;
-	size_t size = vma->vm_end - vma->vm_start;
+	struct tee_shm *shm = desc->file->private_data;
 
 	/* Refuse sharing shared memory provided by application */
 	if (shm->flags & TEE_SHM_USER_MAPPED)
@@ -580,17 +579,18 @@ static int tee_shm_fop_mmap(struct file *filp, struct vm_area_struct *vma)
 		return -EINVAL;
 
 	/* check for overflowing the buffer's size */
-	if (vma->vm_pgoff + vma_pages(vma) > shm->size >> PAGE_SHIFT)
+	if (desc->pgoff + vma_desc_pages(desc) > shm->size >> PAGE_SHIFT)
 		return -EINVAL;
 
-	return remap_pfn_range(vma, vma->vm_start, shm->paddr >> PAGE_SHIFT,
-			       size, vma->vm_page_prot);
+	mmap_action_remap_full(desc, shm->paddr >> PAGE_SHIFT);
+
+	return 0;
 }
 
 static const struct file_operations tee_shm_fops = {
 	.owner = THIS_MODULE,
 	.release = tee_shm_fop_release,
-	.mmap = tee_shm_fop_mmap,
+	.mmap_prepare = tee_shm_fop_mmap_prepare,
 };
 
 /**

-- 
2.56.0


