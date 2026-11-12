Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665E6606A89A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCDGyKKY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQQzx2yZgz30WT;
	Fri, 13 Nov 2026 03:38:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794501485;
	cv=none; b=kkWisT786+X0F7m6Ozz/yv6+IILU4xVTGm79AWnOFP8rsBb80z/YiLkYVy2O9XpqjUGJRyjHh+SE7m8SkvjOTjHDTeALoTBTljPb1vcfcwelMvzv9KnVzXRpKSAfAGlQ3cFP3EyTdGocmoWLpWGoGYGdrHiad+5NypD1ytWdWXuU+Cy6X9/oq8unFbpor3k25BK6QMGVA1tyimHYVQHra9QYnTgVTAq5Gv9MG3K3kXaJlcFopHUswv37dM+JFIT98j/YcbbeG0D/Ev4xMf1sAzGZQsEXJFt+z1/1+ypIogK/iPiCmdBFqEzGN+KwKZuCYO9ouHUBfP/EUWmJ6vYUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794501485; c=relaxed/relaxed;
	bh=P2GAXQL+CRALZ6ktolsI+wkJgETtKYVg5/S1WwdnjP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxVR0crLClM3212orSqSeIqHrNqVOaJdo0lTKd7B+5XY3Q/6TgJ/SsIYyGi83jXLTfFmHFvQRcxNoT10Q/kOsuQUla62gClA4AzL6BOSuG29lt2Sq/aZ0Y/lfPW6pC8CrtZLLJJZnU5568T+41I+fbGkzJedTXW5JpLhTsBoFRwCvNYOmb5ka3J7BzmSoGCN+Kqb1QvXWDZXYZ+13XOi6N6bRVy+FsIL9oWq9P52EYcmn7u8G9S/QTJv1Uo5+AsX6kqbArf5ytVo4yFdmqy9SOlrnJbZJBIuYPkM9vW1KGK2iXCdFU4/QiC2WExY6Yx6WE3X0NwXCYYhOhjRZTAK9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCDGyKKY; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCDGyKKY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQQzw5lhqz30WS
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 03:38:04 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DE86445050;
	Thu, 12 Nov 2026 16:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460611F000C6;
	Thu, 12 Nov 2026 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501482;
	bh=P2GAXQL+CRALZ6ktolsI+wkJgETtKYVg5/S1WwdnjP8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lCDGyKKYBC8Fs6CZs83hFW2kfQvIWzrbx55R2xhY23bPVejs4jP03UhTMbPYwkdFq
	 6QnSYzu3WeVqWx+Ar0edjh2cqOYYgzZqe/DZ5+wO5as7ByI7SvXh6bulOXMCzm12Eu
	 kASOJRtSewIDlEzyPzzCY1AdAWX/EVv1Af43bEp/TzGRyu8tlqudESjSsVdhjFBpbc
	 gPakCksrVRPklHGcZFFoijOXgWwbOd12WzoiKbEcn8WBWaclGOUWPLB0E7xNqJ2ACq
	 pLxZ0JI0ySEeRWv9k3TGyTyi5fx1EhNiDCo/FW3wSZW06JeHOMYn6a8E5q27+Wxlkv
	 sJ5MuJnwBIRmA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Nov 2026 17:37:08 +0100
Subject: [PATCH RFC 2/4] sh/crash_dump: check ioremap() in
 copy_oldmem_page()
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
Message-Id: <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Breno Leitao <leitao@debian.org>, Chris Mason <mason@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
 kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003; i=brauner@kernel.org;
 h=from:subject:message-id; bh=q6FpWygcFHpF/XYp2OeRsrvJ/y8aBzOdxnvKzJI5CUg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9fR2ZXPfx+k0nz9UdCcufZi5bEfNP4/gkpZxGBe7ty
 U5mqhMMO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCX8DIsO3Srhdppo67Nmsn
 CMzvSEg8stFmw5lYXa2tcWbPH7+Ou8Pwv/BN4KTdgsEMAr8vHor9ftTa73Deda0PH0/LeesVzJZ
 gZQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

copy_oldmem_page() maps a page of the old kernel with ioremap() and
copies from it without checking whether the mapping worked. If it
didn't, the copy reads from an offset into the NULL page.

Return -ENOMEM like the other architectures do. read_from_oldmem() turns
that into -EFAULT like any other short copy.

Fixes: 4d5ade5b29c6 ("sh: kdump support.")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/sh/kernel/crash_dump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sh/kernel/crash_dump.c b/arch/sh/kernel/crash_dump.c
index 19ce6a950aaca..85c0e58f1a59f 100644
--- a/arch/sh/kernel/crash_dump.c
+++ b/arch/sh/kernel/crash_dump.c
@@ -20,6 +20,9 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
 		return 0;
 
 	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
+	if (!vaddr)
+		return -ENOMEM;
+
 	csize = copy_to_iter(vaddr + offset, csize, iter);
 	iounmap(vaddr);
 

-- 
2.53.0


