Return-Path: <linuxppc-dev+bounces-27370-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFDFC88E7B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkg3X4Xfwz3bQl;
	Tue, 15 Sep 2026 21:37:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472232;
	cv=none; b=FPBxAZIOGv02qbjsfVew/hJ73Xme1NRpW8z6IFwlls39oKDAh1Y/D88tWvF2y99s5nNSmvhEf7fnVzR1farp1ufb/ToQR+ZPLPGevuT0mnS2sB2qE19AxHDKW4GOnqRU0sRJJjEbI6tSA8RTKx4olEiyDdVVBKFX2ka1VrMcqELmvLKoVtHdYRNOpGA+z4afMMY0Ap0N3Fn8lzDDVt5seR4u3UHvSIUh3y3MWX6u0/w80mHG3EN2VRxZ3sOR+FquR1jY9175F+E5fq4uyZ/GjrScZJDxuQWhd9b59Lrt30luczbX8bUfiampGFpE3yHxr4oGsm9/cmGBpz6oV4ZKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472232; c=relaxed/relaxed;
	bh=xKFkiCa0hlTe3sMnpSzoSnXToiZbVbh61g+KJO9ieuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ooZv2A4EsvGHuNg2uz5BC4NjXUz3w9VRx+DU/JdDpBFH/OFjxe+SJPRaqevpBGaWFGeZewcDcHk7PUDe/qgO23y2onnl48zf4NJ7xTb1lmtF9EFaglyy/vDXb395pEjKH2DlccBGInUtNhirH51FHEeFS4DU8Kka33ipa94kPGq8oESf+4B9hbHe1og9PHviJpazVrq4AdwoG5Nr9p3iLfVeKwaxunBzSZvzhurv1oGDM1qB3urIfE8yhs5/w4gZuC19AcSmar/9hcwwnTmtYUzSLvlRAzusJjU5ZVXgI6Kt9Wr2kTWcmxw7ooWi53JEFc40soWtQHM/Qy5qa8qRBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOCbPxoT; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOCbPxoT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkg3W5B0Kz2yFW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:37:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CD294602C4;
	Tue, 15 Sep 2026 11:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6561F000FF;
	Tue, 15 Sep 2026 11:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472229;
	bh=xKFkiCa0hlTe3sMnpSzoSnXToiZbVbh61g+KJO9ieuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oOCbPxoTA5tRVDE1SDW2p9tC0NlFv3Be5GpoNWhYmURnweQxEsEdX5T61GQni5xDr
	 dB8oKq6yW0o0+gkex/ln8ORrTi4m/ksGAeRyzNp36yZlNMlPyIA0cXetpfDQyX5Jlw
	 kUeKik4FTXQWhScuFLMluxrSG6c9A9ZCbrTYp9zYSiEAOHtRRYECmeCyootOfrgsFF
	 4aVzqXKYOQKlcIlDUd5HFPC99RpSLMKbQX+NeTk8Ib6ernTnIZhKKs5s66GAw9HT8a
	 aS1v8S5YrjxrTs7D5UvVddV+Ou7n/rKAkdnUoUpvZBcB6uDYitfeHcIW+Z9u4N80Fg
	 U5N4JdROMjYmQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:31 +0200
Subject: [PATCH RFC POC 45/50] accel/habanalabs: stop putting the dma-buf
 descriptor back on failure
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
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-45-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ydrjF0IvCagPMk+8W3Lo5F+Om/GvHyzFN7KTNwOeZ+c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kn/suYdZ5X5676SLT84zbaJW7EmM036Hiq6ZOOqB
 ZPZLiWKdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEfjfD/8KDx3tMQu5s8Nvq
 pTQrXEN8zcGDu7l3Sq29EHzMOo0/S5yR4VJD+//LnadWytZe1frxs+H8kb1LmHzvH1hrULDM+7H
 3NRYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/accel/habanalabs/common/memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/habanalabs/common/memory.c b/drivers/accel/habanalabs/common/memory.c
index 361cff577381..1559442cd56f 100644
--- a/drivers/accel/habanalabs/common/memory.c
+++ b/drivers/accel/habanalabs/common/memory.c
@@ -1861,11 +1861,13 @@ static int export_dmabuf(struct hl_ctx *ctx,
 {
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct hl_device *hdev = ctx->hdev;
-	CLASS(get_unused_fd, fd)(flags);
+	const struct fd_slot *fd = fd_prepare(flags);
 
-	if (fd < 0) {
-		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf, %d\n", fd);
-		return fd;
+	if (IS_ERR(fd)) {
+		int rc = PTR_ERR(fd);
+
+		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf, %d\n", rc);
+		return rc;
 	}
 
 	exp_info.ops = &habanalabs_dmabuf_ops;
@@ -1889,8 +1891,7 @@ static int export_dmabuf(struct hl_ctx *ctx,
 	 */
 	get_file(ctx->hpriv->file_priv->filp);
 
-	*dmabuf_fd = fd;
-	fd_install(take_fd(fd), hl_dmabuf->dmabuf->file);
+	*dmabuf_fd = fd_stage(fd, hl_dmabuf->dmabuf->file);
 
 	return 0;
 }

-- 
2.53.0


