Return-Path: <linuxppc-dev+bounces-17476-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA22FD0075
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2026 19:34:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPC1Z298sz2yFK;
	Mon, 02 Mar 2026 06:34:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772393666;
	cv=none; b=Y9Y6WHC2vIPn67n2XLLJWgfYlARMsUP4bQmW/fgbCBA3bS61eQBVT9gwx5IufY3reCxv7LwjwqmXo8Q2GiwgnNClgcIUJcX+81bMeHkh25miChrY7gxavrcT1aGcCrvEfu+vyQexkKqEBKY7LpR9X4KXYoqk5S9iAR0jEMOkmhToiwgJyhL+2B2+1ILCD7dETjdeP0kIMRdOSF+01zqhLQDPXKx0Ildc1mBe1yV1IMGX/O1fgJfG5s8sWvRDPprrMewXg4InhsinacnThz3gxKANlHUyAxB4BV8GXIJUs48ak1dk805HfLf9z/5Q3cxOKZY41NVpSV7RDNOf0RjagA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772393666; c=relaxed/relaxed;
	bh=CUm9HzLUU22F5cVwjfz4Zoc4xR/667vc4nney7zidvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NN4iVEMKR7+yrZszce/ijE+g9j+ld6GSQg+OvR/pEkOETcfqBBPCQQJV8ON7XK1S7i26WN2T6PtMT42dqIPgRXTBuXot4HxAUFWS4H6uBsoGCI5dTq4A3O8TbVpsYdUHIZDfKeShdyeGq43fw8N19B8lk4TiwIbQXvwfvW7rda3vMMvP7Pq1L8ceQC34ipe6i3m8Ba6U4Yk1ryV5o+3HLaFlhAMxPRH/fFOMpbuUjQBN0gM5F+9GTyC9/BqvIkT92CjDIImUEwNNSwKxc0jY4v/YCnSTqXBAdrcFhIie26lIBWxVQROQckuudFaBFmfc4XgLdKYE149kD2eIhX62Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fBMoKZh/; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fBMoKZh/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPC1X6YbYz2xqm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2026 06:34:24 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 245B560008;
	Sun,  1 Mar 2026 19:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D9BC116C6;
	Sun,  1 Mar 2026 19:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772393656;
	bh=BS3ZMwHlDBcAakH4xSCy5YZLU7NRjvFZNyLUzpzSoag=;
	h=From:To:Cc:Subject:Date:From;
	b=fBMoKZh/LWCvwocBJu3/DdC0EKLnEGnsvFsFINLPykRPzdRWemfcP23uVosUvNyQU
	 LRS5bvFJZDxSZkMlwzOw4Q9gcfCc9YeJPDZ595R+nFJuTlGbuECzRBOyUNBixZFt5D
	 iE6iCR4qfZsuoqEikqKYjCmQqHupeKgd5ohtJHLAKZG9ct5D+lRrUezJ2xNtVUijBa
	 Af6pXyHwm+tJZeEEamUZy10vahwIWTBFKZnBtk749nsFwX6r3fnDReMFMlj+wF5hhC
	 s98itWgns3vCxpdLt7eM0O1669ALiZebwBSZ8BHviYayyJ1j0E9NlR26Z/ra4XBWdC
	 Zj+TlcM/lie1Q==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andre Almeida <andrealmeid@igalia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] uaccess: Fix build of scoped user access with const pointer
Date: Sun,  1 Mar 2026 20:33:58 +0100
Message-ID: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2510; i=chleroy@kernel.org; h=from:subject:message-id; bh=BS3ZMwHlDBcAakH4xSCy5YZLU7NRjvFZNyLUzpzSoag=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQumbKswe2Zuf6EuTudmqtKPfYcXrNP0W3Fv5jev4WbX s0s28pV0lHKwiDGxSArpshy/D/3rhldX1Lzp+7Sh5nDygQyhIGLUwAmkpLB8D+a+w/zg3+ige3h eQsXCTO+PXiEYyrjCsvO1ltzHW5ZPPvO8IspVKT412bj9XLyP/d83ZRVd+LX0vcHZX+6RcXGh8T 9EmYFAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

After converting powerpc checksum wrappers to scoped user access,
following build failure happens:

	  CC      arch/powerpc/lib/checksum_wrappers.o
	In file included from arch/powerpc/lib/checksum_wrappers.c:12:
	arch/powerpc/lib/checksum_wrappers.c: In function 'csum_and_copy_from_user':
	./include/linux/uaccess.h:691:1: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
	  691 | ({                                                                      \
	      | ^
	./include/linux/uaccess.h:755:37: note: in expansion of macro '__scoped_user_access_begin'
	  755 |         for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
	      |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
	./include/linux/uaccess.h:770:9: note: in expansion of macro '__scoped_user_access'
	  770 |         __scoped_user_access(read, usrc, size, elbl)
	      |         ^~~~~~~~~~~~~~~~~~~~
	arch/powerpc/lib/checksum_wrappers.c:17:9: note: in expansion of macro 'scoped_user_read_access_size'
	   17 |         scoped_user_read_access_size(src, len, efault)
	      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cast __scoped_user_access_begin() to (void __user *) to fix it.

Fixes: e497310b4ffb ("uaccess: Provide scoped user access regions")
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
Thomas, I encountered this problem while preparing some patches to start using
scope user access widely on powerpc in order to benefit more from masked user
access. Can you make this patch go into 7.0 as a fix in order avoid dependency
on this change when we start using scoped user access ?

 include/linux/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1f3804245c06..5d9f6d45d301 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -752,7 +752,8 @@ USER_ACCESS_GUARD(rw)
  */
 #define __scoped_user_access(mode, uptr, size, elbl)					\
 for (bool done = false; !done; done = true)						\
-	for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
+	for (void __user *_tmpptr = (void __user *)					\
+				    __scoped_user_access_begin(mode, uptr, size, elbl); \
 	     !done; done = true)							\
 		for (CLASS(user_##mode##_access, scope)(_tmpptr); !done; done = true)	\
 			/* Force modified pointer usage within the scope */		\
-- 
2.49.0


