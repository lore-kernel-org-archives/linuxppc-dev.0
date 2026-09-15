Return-Path: <linuxppc-dev+bounces-27366-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED09C982C5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:37:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkg2x0FFtz3bfF;
	Tue, 15 Sep 2026 21:36:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472200;
	cv=none; b=LmAFQ8LqS1WlRf+NgMh44zz4kgPQ1/XubhBJ+1BsAQ7TS49D1laVGkBXLBZZd5fFt5/6nCdGlEU/XsXX2v6KHrrUEtyhLk6Toi1J58NJxZ8TA6XM0i7v4Gd87o6yVoGl712RIThbJJUpQlT9yd1HI5SqUdTgc6pmdZ9K5Sdy8ZOhDa5jfHfV9SkrUqfnYo+dtiNOJ702qmO5JwKZap+SyVsdN4FeRvoD5VYPKrUCVezCiAynjftH4Sl6gHKvH0RKJsp7Qcb0yKVC2m/ODQ+9VwmvWLGGZqz26rEUZ2wKNJOLqmwHwn4qVTum6rvh4IT4r2XLw1YyGNEBf9uYbfRDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472200; c=relaxed/relaxed;
	bh=dR2AT7slAh5QiQGKBciNLhR24TAk5bJ3ys4Ah5Rt7mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JjxVtfuHdkfrbvSH+FyBfhFFjt17dnz7N3gVzJW7tmVO82lrcuxXz2kdMr+sCG57FV9y3R/sYll77Znwzbyd68TXlDB1EDatcmeIkirswOXphsY4kVukj70wjABizE0c8+Kep2ssSDwh3QUqRZaVkdekYIeXiddZLY+41Z8efLEpTYy/Smrq1amZoLjhE6qXGAo75S7kXOTkjfV+YDcUO0GmBVPF8pQMuVAA45nF7+ZKcOweiwJK9uwUBKi0xtP29mj0o6KSNdhuZyDO/lcnLKCsidPA6Lp9bUkQieg9I76tP+NpzygjaTM9MbqPZhMtK3QyMsEzwZzv+qCWNp87dA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keM2MELZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keM2MELZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkg2w10TSz3bf8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:36:40 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 459BC602D0;
	Tue, 15 Sep 2026 11:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948881F00893;
	Tue, 15 Sep 2026 11:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472198;
	bh=dR2AT7slAh5QiQGKBciNLhR24TAk5bJ3ys4Ah5Rt7mE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=keM2MELZ8tMeEj63s6rILS1a6ikUND0cm/hSBjQN5i9zsMHRwumL2LpgndOJca1Aa
	 97kIpfNmItf2JE76ybod5HhCCbaR3uSYEM810jrmgilIii5FRWRh1O86tNdM0FYWJl
	 38f1UHzSPEd+hj/T0Nlt8QEoyRs4wb5r4JVdV9i/rSIOmEYhsfaqAD31KqLx/f0h3O
	 ACHfbLbzGXb+++iV7WaxfM+tTIGP+WsUWGxYSjDxuYEbOqm0MVVuZjc4buiK4jUw7O
	 C9LHTBiZSEultvzvuQBhaDEJQMVPhyftCJPppnofTMl7IPUPEYHfgCv4gmlMrEOmjT
	 oPjncB8aAwY0Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:27 +0200
Subject: [PATCH RFC POC 41/50] KVM: guest_memfd: stop putting the
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
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-41-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KLCbLLJNzFhK9KnJoDv8kDUlKXi4pqPjbkN6aCwr8bo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kk/tfzHImu/Gp6ZRSssN5fyinw4ruUhZCIkyWFT3
 bH7k9a5jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8sWZk6GKcxbHPfdfrbYrn
 f0Zr1u290KLF8etT65HPSeyxa5JK9zH8jwg7xHPKv6v/9/8HHp3fHOUXznI3MuD7/nrNS8a/OUU
 arAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on the fd exit path machinery.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 virt/kvm/guest_memfd.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 625e62e1a031..e0d1cb869342 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -526,17 +526,16 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	struct gmem_file *f;
 	struct inode *inode;
 	struct file *file;
-	int fd, err;
+	const struct fd_slot *fd;
+	int err;
 
-	fd = get_unused_fd_flags(0);
-	if (fd < 0)
-		return fd;
+	fd = fd_prepare(0);
+	if (IS_ERR(fd))
+		return PTR_ERR(fd);
 
 	f = kzalloc_obj(*f);
-	if (!f) {
-		err = -ENOMEM;
-		goto err_fd;
-	}
+	if (!f)
+		return -ENOMEM;
 
 	/* __fput() will take care of fops_put(). */
 	if (!fops_get(&kvm_gmem_fops)) {
@@ -575,8 +574,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	xa_init(&f->bindings);
 	list_add(&f->entry, &GMEM_I(inode)->gmem_file_list);
 
-	fd_install(fd, file);
-	return fd;
+	return fd_stage(fd, file);
 
 err_inode:
 	iput(inode);
@@ -584,8 +582,6 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	fops_put(&kvm_gmem_fops);
 err_gmem:
 	kfree(f);
-err_fd:
-	put_unused_fd(fd);
 	return err;
 }
 

-- 
2.53.0


