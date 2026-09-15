Return-Path: <linuxppc-dev+bounces-27344-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC84C982C5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 11:33:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkfzg4WyBz2yps;
	Tue, 15 Sep 2026 21:33:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789472031;
	cv=none; b=mzw0N2il+G0ZEGMZcm3szaTHFvM6VfhtcOe9n5RxKWw+Qz9KLbMbS996G28LxA/U31eHZqo/4zYOJ0Kvv10TOlCD+OBug7ywDUDD+TMbUKbl7W9BGq1PiOQWHWmIC2/FXRSiVpHHQ4E4WWK/3vdRBeAyEdgoUYB2ubZMqHjybr0+TxA9ab2AETBKJFJumt56DJEuM2IrOyHnVgDpfTNXQt3C2yYOpTlnkfSzvsxsTeMJ2S1XM67It1B/+8TiV1ExJMnhfr4I6hK0EK7F0X7Gs/juZbmyQHtgXDmKBstmPdpL2PbqR2Q1u75e4WTdzSHqxVVmKvm+oHMHOepiBUCJag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789472031; c=relaxed/relaxed;
	bh=fPUeEhZalZFbuqvBU8/iDG2tqjgIH/ueKLGrOGx0E/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J992q96xuT81fJ9dQMF8W+fCGPIHFR25PWDvDr729FaIUfebDMJho/iCbY58XJT6QPTXCg3o6y1J6tVkZXAnpj32YH3Oje2nmm+1Y5y/jIom5++SmNvJ3xSbLPRnRHgI9o1ToKP/LVhpcEtlljcVydRR7yKUkLts0nwIoE0rUBNLOSCZVP60TVgyzxCv3tNF1GgZKSHfi1PXRd1vdDNAx0FTI8wQx/R7QV2ZnSSkolaHWgB9qxjycH8O0EjRSY7Ksn6CW0Cfz79kFvryqMLrfcYO8bdHJI78txIgXZvtLtYC2zG9JTZBWGb4W1FSCcBsSjrchR9wUTFdqSBwT7sRUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nmpj4NaF; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nmpj4NaF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkfzf4VXtz2yn2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 21:33:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 88ED742A92;
	Tue, 15 Sep 2026 11:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EB01F00898;
	Tue, 15 Sep 2026 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472026;
	bh=fPUeEhZalZFbuqvBU8/iDG2tqjgIH/ueKLGrOGx0E/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Nmpj4NaFXMtUCUBJkK324vi22fpzvX6uomFULBZJOjhgDQCroZWI/8lb8hRAJVCHh
	 9EhYq/igSRVSJd0Z69cCAreFakLrT8v7g5ED2rGJFufV7eihjNzGDapElAJqkyWjpl
	 lBXB4AtsKeIiuD1UD4coI3pcXNoLmTr78UlIqOkuglt9Hw0oChJkwnEGg4w0f6UJ0f
	 E3lrRN0G+U0+0MXEDUccPLURv/tGCWrEtzl5wBa6tk79GG6qHRxEjmf3jJK1LMmPo3
	 /VFHB2tZrT068p2qgHGbLHusKwE8Tye3wqbBTFb6QOLjp++ERuzcM9sRPxtZnWLn1E
	 KgqcMBfnsrMfA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:05 +0200
Subject: [PATCH RFC POC 19/50] file: require the syscall exit hook from
 every architecture
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
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-19-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1044; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kO5/kQT0XZnIdRnIvngddyYIzT4ZNU9mDakuELDqlrQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1Kmt7K/PWBxqv33Jx9xZ93feiJvYXvn0wyGRJfor4
 xvDgz5O7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjImo8M/0t6Hp5cOHfxxr5q
 5ZTEWby+CmuzN2gtu/o25VNw3Kl5VQ8Z/ns2bzkbtn3/k1lfb3I0OE2bn/HePMr9P8+ZRZUPSuV
 nr+YCAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Every architecture now either uses the generic entry code or provides
TIF_FD_SLOTS. The fallback that deferred without ever committing
can go. Make it a build error instead. A new architecture can't grow
fd_prepare() callers without the syscall exit hook.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 6fa481d63dcf..2b041b45f225 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -652,9 +652,7 @@ static void fd_release(unsigned int fd)
 #define fd_slots_set_work()	set_thread_flag(TIF_FD_SLOTS)
 #define fd_slots_clear_work()	clear_thread_flag(TIF_FD_SLOTS)
 #else
-/* Nothing commits until the architecture provides the flag. */
-#define fd_slots_set_work()	do { } while (0)
-#define fd_slots_clear_work()	do { } while (0)
+#error "the syscall exit path must commit prepared file descriptors"
 #endif
 
 static struct fd_slot *fd_slot(struct fd_slots *slots, unsigned int idx)

-- 
2.53.0


