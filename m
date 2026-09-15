Return-Path: <linuxppc-dev+bounces-27361-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6B6C88E7B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:36:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkg2867TSz3bZs;
	Tue, 15 Sep 2026 21:36:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472160;
	cv=none; b=YQDmaXcuQKBvPeoc/LcSKB0K5esOcutOxjcRDfH4zy/aWi/5R+DaWCqhmRQrlR9Ga94sjgMs1SMCKDGNv9sgqGtsQQ2glvehx0PSAHeNl69SEBKJp8Si61PusaBOzqzN2h+Y5JET1HGPwZAzEm1sBlfoVigogeQkQ0gyLRTdDYNsW8vzOnM2DjjQn7pleyVRJvbugXswKogjJ2kNcrBS0EmKcWbxPT1JiSGd663yx7bQqZCam47moVfn4THa7FrhIIY6Ukv2mVBYERk9rXA20i+A0ZZhd0lzEJ3vqnvjwV6MajFQPMAqaAWGBsrpalsexNLv4zpgltTHfXd2UtVhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472160; c=relaxed/relaxed;
	bh=b40qx/awPhHY3pAbyOLJ2VCQCA5LCLOxDhc9IZ5eVmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JP6OLQF7h5xD8yU7m6MSL8H0te8vBKoOxSU9S22MH7A7cAZ1vMEdom6DBKaBHJCm+syyr1mNA4ZTzBcqziVF5s/HaWWB4zWL74MKYjVFsgOc+2AozsGU1E1JGh9bh/W0Z89HKMnFZSK47ay1yTC1R07RWWewRVnlhEjHWL42Ff4+uUA/zhkeosMO5WG6R14Qf35T7tQA1e6RaUPKa3Cwz9sHd2h7CSzmA6vMmI3V49UNzQT5Sba7+ONmQByY5/V5+N/s8bll8uyaMmtBTSbwvk1xXvUYtPFbaVSbhWMUuD/50PUcVx+c+bY0UhR6NkbzTlfi5YPlEPAbaeCt1hlrVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DP7k+2oY; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DP7k+2oY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkg280ZKGz30Pn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:36:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 95CAD419C6;
	Tue, 15 Sep 2026 11:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B05B1F000FF;
	Tue, 15 Sep 2026 11:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472158;
	bh=b40qx/awPhHY3pAbyOLJ2VCQCA5LCLOxDhc9IZ5eVmE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DP7k+2oYU08PDg3XHLYvBCrc74ArLylq263ZQfhfXbqRVkmDQErCOMCCjVwzRS3TV
	 Y8Y1vhMdhR6mX1rzdLqcAsmQNs12N3hdTVztl8RasOi+yrl66kgtJvAm30HiqkZulb
	 BeZJvaqfhTtzMk7k9vathecezVTk0f7HRyPRJBoxuaSPdxLiJQMLNsbQRaHiPb0ydM
	 Bs/kN8QurhjzxM80pFu9PHszrjXHegO9Dn6LZ3pRg5VWri7b/KneuctABvHx5t6aU8
	 tZLPUAdsUnZNPuONncunNV8jM+2yLhEhGWV0UDmSzPkb9+7dEf6jOyeVoYut8bPYY5
	 6Fs/9ju++IrEA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:22 +0200
Subject: [PATCH RFC POC 36/50] nitro_enclaves: install the enclave
 descriptor when the ioctl returns
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-36-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2840; i=brauner@kernel.org;
 h=from:subject:message-id; bh=06X+neGC1JeQjfUMZrHZWaV7oELS9OsBJ6UQD7zSi4E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Knzubs1YsvpZZZH3i8+78BV7P4vtpYxKWmuZeMPN
 v7juhcdO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi/YThf2b/jhn+T+e6nmr7
 eXfahbUvovRN4zg2RHUHPFri9vTunR6G/1ElTBHnt53eUxYocDY8j1mnxvWvpfIKaanlW1376r2
 dWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 33 ++++++++++++-------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index c91300a73f50..93c3f00f5443 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -1589,7 +1589,7 @@ static const struct file_operations ne_enclave_fops = {
 static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 __user *slot_uid)
 {
 	struct ne_pci_dev_cmd_reply cmd_reply = {};
-	int enclave_fd = -1;
+	const struct fd_slot *enclave_fd = NULL;
 	struct file *enclave_file = NULL;
 	unsigned int i = 0;
 	struct ne_enclave *ne_enclave = NULL;
@@ -1647,9 +1647,9 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 __user *slot_ui
 		goto free_cpumask;
 	}
 
-	enclave_fd = get_unused_fd_flags(O_CLOEXEC);
-	if (enclave_fd < 0) {
-		rc = enclave_fd;
+	enclave_fd = fd_prepare(O_CLOEXEC);
+	if (IS_ERR(enclave_fd)) {
+		rc = PTR_ERR(enclave_fd);
 
 		dev_err_ratelimited(ne_misc_dev.this_device,
 				    "Error in getting unused fd [rc=%d]\n", rc);
@@ -1664,7 +1664,7 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 __user *slot_ui
 		dev_err_ratelimited(ne_misc_dev.this_device,
 				    "Error in anon inode get file [rc=%d]\n", rc);
 
-		goto put_fd;
+		goto free_cpumask;
 	}
 
 	rc = ne_do_request(pdev, SLOT_ALLOC,
@@ -1688,27 +1688,20 @@ static int ne_create_vm_ioctl(struct ne_pci_dev *ne_pci_dev, u64 __user *slot_ui
 
 	list_add(&ne_enclave->enclave_list_entry, &ne_pci_dev->enclaves_list);
 
-	if (copy_to_user(slot_uid, &ne_enclave->slot_uid, sizeof(ne_enclave->slot_uid))) {
-		/*
-		 * As we're holding the only reference to 'enclave_file', fput()
-		 * will call ne_enclave_release() which will do a proper cleanup
-		 * of all so far allocated resources, leaving only the unused fd
-		 * for us to free.
-		 */
-		fput(enclave_file);
-		put_unused_fd(enclave_fd);
+	fd_stage(enclave_fd, enclave_file);
 
+	/*
+	 * The failed ioctl drops the descriptor and with it the only reference
+	 * to 'enclave_file', so ne_enclave_release() does a proper cleanup of
+	 * all so far allocated resources.
+	 */
+	if (copy_to_user(slot_uid, &ne_enclave->slot_uid, sizeof(ne_enclave->slot_uid)))
 		return -EFAULT;
-	}
-
-	fd_install(enclave_fd, enclave_file);
 
-	return enclave_fd;
+	return fd_prepare_fd(enclave_fd);
 
 put_file:
 	fput(enclave_file);
-put_fd:
-	put_unused_fd(enclave_fd);
 free_cpumask:
 	free_cpumask_var(ne_enclave->vcpu_ids);
 	for (i = 0; i < ne_enclave->nr_parent_vm_cores; i++)

-- 
2.53.0


