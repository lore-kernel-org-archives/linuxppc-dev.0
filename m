Return-Path: <linuxppc-dev+bounces-27372-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749CCC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkg3r4Fvwz3bjg;
	Tue, 15 Sep 2026 21:37:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472248;
	cv=none; b=opdizK4yoVf1QqEm6oNQRkKrkxBKyglfAAwgu2qfvaPFcuDtMbfnf7cGsFodn7nPbPx2plhc/V2VvoQmYvIr8wj3C/fDxPvtPky8mYlLgqsRoYpOOAdRPTuDKtaCLIvRDUvePJ4SF/lWLsTkCksTQISQNqAa2/hP4MERzVDMQ8P/CYhmn0UA3fKg7KXcdhqaApACHfjXLQk3gLKoQUws0BmjeEKB7RyXM8UMOmp+x628FmxWkbf7HYT/IRrpphOB9BiX6ALun0RFny04Ylt0/ExPLxoPtu9395VWP2ui7/HcdgNKIi7EqoWjTKHEMID6FZaYofOTlGiSM985rwQ0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472248; c=relaxed/relaxed;
	bh=mjqLYqkFC5yCbrRzMMvOpmvK8b+wb1Az5sELRN6Iqmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e7hSIg8jrR7gg2X60qIGpHYysHDtE31KaEk05gveKpXg3iH5oXuLXGkWckI4/pNmfxBsswI7bJv4ArfhIPMjlX0Kc33kyyECDEpyMhon6qdZuTe3vW0EyZvdJO56n9iOggBmXv88D6rl3bQyMomeIcbfpviB7GtJaD0ZdvYy+nv4TennNKedaxiYsNM75+NcsgDRA/Cnh8fIOBeDEChnSEc9SBY0bHyrg9b1EFAp6GuUiKAL1X8XaFH2oJLjrWK5k0THstDdBVFPCyJwNh/WXoHYA7PIRkhhTOgEJ16uvcadcQrDHpqBGaCdPcRv1Ez2x7Y/voHnzfYVikt0W/N2gA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNFTQOJL; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fNFTQOJL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkg3q533Nz2yFW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:37:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B699B602C5;
	Tue, 15 Sep 2026 11:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE621F00893;
	Tue, 15 Sep 2026 11:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472245;
	bh=mjqLYqkFC5yCbrRzMMvOpmvK8b+wb1Az5sELRN6Iqmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fNFTQOJL+iGGO+zzzm7cDe+/taoDcFY7fewDCdDuBMLNk844/5YTOXExel7EKsF9S
	 oLRnzjguOrHBG/PK7ZC549dR4lB6cSOioaIssgENRRB/BPi7+UG74t/yS8GmkCNH9C
	 SYkWW/2u8YiYHbyNYlVSLFpnBvaUvCIp4Mwu/abM5lLuo8GHPpD/0L9dCr6/bh0kxz
	 Ano4WmSOQb609KJxhLhb4QylzFqFY4npF26OT03shrB8BqGetnHALS1L68dHSQxDHf
	 lkgeVcI6ujFF+0WS99WYyuepbVTQzAmtrQq19Z8PUhZtIGApiugszVbmJFY6aacriE
	 TeUsi9M9eNUTQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:33 +0200
Subject: [PATCH RFC POC 47/50] iio: buffer: install the buffer descriptor
 when the ioctl returns
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
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-47-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RM8/Ryi0JBjisB2tI5DXR2rE8sCF/AliS5Zp4F8Qhf4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KkPFJZ6IZfMtyJ0UsaFFiuPoGWsPxtn3v1o+e3z3
 stfX0943lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR6LMM/yNudM+8naelq7Sn
 g+X00Zpv+usvL13mfINZZtGLrdYV3KkMfzjPLfxTceTH7fV1ATe3FQTfd1Vd7vTqOWPz3spdkTu
 WLmIFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/iio/industrialio-buffer.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 2c9ec93dff47..9fb15bf82d0a 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2041,7 +2041,7 @@ static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg
 	int __user *ival = (int __user *)arg;
 	struct iio_dev_buffer_pair *ib;
 	struct iio_buffer *buffer;
-	int fd, idx, ret;
+	int idx, ret, fdno;
 
 	if (copy_from_user(&idx, ival, sizeof(idx)))
 		return -EFAULT;
@@ -2067,26 +2067,18 @@ static long iio_device_buffer_getfd(struct iio_dev *indio_dev, unsigned long arg
 	ib->indio_dev = indio_dev;
 	ib->buffer = buffer;
 
-	fd = anon_inode_getfd("iio:buffer", &iio_buffer_chrdev_fileops,
-			      ib, O_RDWR | O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
+	FD_PREPARE(fdf, O_RDWR | O_CLOEXEC,
+		   anon_inode_getfile("iio:buffer", &iio_buffer_chrdev_fileops,
+				      ib, O_RDWR | O_CLOEXEC));
+	if (IS_ERR(fdf)) {
+		ret = PTR_ERR(fdf);
 		goto error_free_ib;
 	}
 
-	if (copy_to_user(ival, &fd, sizeof(fd))) {
-		/*
-		 * "Leak" the fd, as there's not much we can do about this
-		 * anyway. 'fd' might have been closed already, as
-		 * anon_inode_getfd() called fd_install() on it, which made
-		 * it reachable by userland.
-		 *
-		 * Instead of allowing a malicious user to play tricks with
-		 * us, rely on the process exit path to do any necessary
-		 * cleanup, as in releasing the file, if still needed.
-		 */
+	fdno = fd_prepare_fd(fdf);
+	/* The staged file is dropped with its descriptor if this faults. */
+	if (copy_to_user(ival, &fdno, sizeof(fdno)))
 		return -EFAULT;
-	}
 
 	return 0;
 

-- 
2.53.0


