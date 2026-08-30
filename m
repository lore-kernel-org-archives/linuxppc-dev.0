Return-Path: <linuxppc-dev+bounces-26195-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D736FC61DE2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2026 07:48:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hXkkv6r2Yz2yft;
	Sun, 30 Aug 2026 17:48:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788076103;
	cv=none; b=DoPDeJKm9d87hhajnkAfMXIfXTWLUEfDNgRn6UyOFf3a4YkxIe9jqI3Dx9k0No/SPuBLJhwgG9/XgcCqYMVRyw2gomG5x033VWMCyX2lxR/IGW1SnaANuO5AZPFHiAIuGduFoilXGUV176HUltXTRdGSB4/+VLQLnSly4Nlz5KuNL/rmQeg0D3zwZR+kY+GMu/QjM7k/rnO9yzF5THDaOTKyMfGWLmcttMszE1043rHcj70n2DamkvXGuOWOM4l6i2P+rHSjcD+kfHrwcG20pTwS/njbMB0rqYGuB7uTh1MflofOaaRXlvV0gFlFIUtDQCMgCwdqFQCRUP0WiEbPAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788076103; c=relaxed/relaxed;
	bh=XPiSY9Bg2IUmtzWz3D0CJ/RjIxKOrrK01Vto+HJVySQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZLttKQj7+4UGPcwSZsAyYUqZ3TylOioKlXTE9icFenCcQvUvJgUeVwlORW1giVc4z85VGRBSOuLZEq1ZdLfVFrCGvHujCQEbvbL4TIUMAuiUIU8LBX6hhbZqsUykZKxc16/UH8G921/eCenNSRHdi9mc3vsTxxkzlMeYAUAW+BxVjb090kMHN8QepNEPF26N01ArT8DWFLZPIBWkqYHf2znpPT/qBR9+WTPusjTWgjG5AssBDwEq8qAearNw1xyuzQwFbacJDhjG+0s3q5H1rLipEO81PMEvGcFP1kl5Wa6XYWRDiHxPUhLX90p/pmZflnmBjz2qvzNfN/A43Ebvaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4ktx4jy; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j4ktx4jy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hXkkv11s9z2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 17:48:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 18CFD600AE;
	Sun, 30 Aug 2026 07:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE301F000E9;
	Sun, 30 Aug 2026 07:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076100;
	bh=XPiSY9Bg2IUmtzWz3D0CJ/RjIxKOrrK01Vto+HJVySQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j4ktx4jyXz/KrmL0BMXIAcnNMVGRcpncozoVazBsVEq0DQ1QMoznmPt00il0SqMro
	 arr9cHkcyoymqcJ7BKnbvNLt/5eB9ELfo9e1chMcnXFryp65iza5Vr36r/p7nGHSUd
	 E1W/jtNNZ/nDz3QsyrEGQkBzP3ex3xlnQeNx4MoAQ+bVpj1m+WnjY8aeTQ4VwF705C
	 b/zq9GLiTWwMg+cW5bKsBjq409aTTR2X0/KHXY2j/rMvJ1g9dKJbnJtfzGB1f+77c2
	 PMBlzPeOA/s/3CQAtDVgX9FJpYyLHYQqzq5DVfe2ALOw7yBY7XaFnzqkmYro7l04Gv
	 kWPhAqASy764g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 30 Aug 2026 10:48:01 +0300
Subject: [PATCH 4/4] platform: goldfish: pipe: replace __get_free_page()
 with kmalloc()
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
Message-Id: <20260830-char-misc-v1-4-05e2ce44f291@kernel.org>
References: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
In-Reply-To: <20260830-char-misc-v1-0-05e2ce44f291@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Brad Warrum <bwarrum@linux.ibm.com>, 
 Eli Billauer <eli.billauer@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michal Simek <michal.simek@amd.com>, Ritu Agarwal <rituagar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.17-dev

goldfish_pipe_open() allocates the per-pipe command buffer and
goldfish_pipe_device_init() allocates the buffers the device shares with
the host. Both are passed to the host as physical addresses and must be
physically contiguous, which kmalloc() guarantees.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

While on it, size both allocations after the structures they hold instead
of always taking a full page.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/platform/goldfish/goldfish_pipe.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index fa241ca8feb0..3f34db896ece 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -708,12 +708,11 @@ static int goldfish_pipe_open(struct inode *inode, struct file *file)
 	init_waitqueue_head(&pipe->wake_queue);
 
 	/*
-	 * Command buffer needs to be allocated on its own page to make sure
-	 * it is physically contiguous in host's address space.
+	 * The command buffer is passed to the host as a physical address, so
+	 * it must be physically contiguous, which kmalloc() guarantees.
 	 */
 	BUILD_BUG_ON(sizeof(struct goldfish_pipe_command) > PAGE_SIZE);
-	pipe->command_buffer =
-		(struct goldfish_pipe_command *)__get_free_page(GFP_KERNEL);
+	pipe->command_buffer = kmalloc_obj(*pipe->command_buffer);
 	if (!pipe->command_buffer) {
 		status = -ENOMEM;
 		goto err_pipe;
@@ -749,7 +748,7 @@ static int goldfish_pipe_open(struct inode *inode, struct file *file)
 	dev->pipes[id] = NULL;
 err_id_locked:
 	spin_unlock_irqrestore(&dev->lock, flags);
-	free_page((unsigned long)pipe->command_buffer);
+	kfree(pipe->command_buffer);
 err_pipe:
 	kfree(pipe);
 	return status;
@@ -770,7 +769,7 @@ static int goldfish_pipe_release(struct inode *inode, struct file *filp)
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	filp->private_data = NULL;
-	free_page((unsigned long)pipe->command_buffer);
+	kfree(pipe->command_buffer);
 	kfree(pipe);
 	return 0;
 }
@@ -833,13 +832,12 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 
 	/*
 	 * We're going to pass two buffers, open_command_params and
-	 * signalled_pipe_buffers, to the host. This means each of those buffers
-	 * needs to be contained in a single physical page. The easiest choice
-	 * is to just allocate a page and place the buffers in it.
+	 * signalled_pipe_buffers, to the host as physical addresses. This means
+	 * each of those buffers needs to be physically contiguous, which
+	 * kmalloc() guarantees.
 	 */
 	BUILD_BUG_ON(sizeof(struct goldfish_pipe_dev_buffers) > PAGE_SIZE);
-	dev->buffers = (struct goldfish_pipe_dev_buffers *)
-		__get_free_page(GFP_KERNEL);
+	dev->buffers = kmalloc_obj(*dev->buffers);
 	if (!dev->buffers) {
 		kfree(dev->pipes);
 		misc_deregister(&dev->miscdev);
@@ -867,7 +865,7 @@ static void goldfish_pipe_device_deinit(struct platform_device *pdev,
 {
 	misc_deregister(&dev->miscdev);
 	kfree(dev->pipes);
-	free_page((unsigned long)dev->buffers);
+	kfree(dev->buffers);
 }
 
 static int goldfish_pipe_probe(struct platform_device *pdev)

-- 
2.53.0


