Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65046C27C79
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2024 16:32:28 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=abvyrJ/X;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W4mHG0mQyz3clL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2024 02:32:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=abvyrJ/X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W4m6g3Jrmz3cSK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2024 02:24:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5D49ECE274D;
	Thu, 20 Jun 2024 16:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB57C4AF07;
	Thu, 20 Jun 2024 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900698;
	bh=9tNBDm896BjzUxmnfvW1e6haCDwe3E/atZfPgTf6dvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abvyrJ/X+WgKBcKLB26W63xGzrJswPTiNJDtrvePABOWadxaiMVdFVIIrjjZH7EMt
	 i3yfbG9sxIhKzIMCfECn8jajIwt5EnHTKwWgtPNsnEm6eH5VPX4iHwPOT/KLGXygLR
	 Y8UtKQhQMTPuDEykuGSASDGG1jSbMq6hu59HuuOGBaXNiJXkV1zooHon61XOPITCpE
	 SFmK3OLp8gXcumhP0tivnIEFTlCHa7lpiLvSg28jj4kABCTLi6W7v8y4Et1OD6DAcD
	 5NN8lrWx/ZkRbGl97bKzVpQphPBlvW7EqUaJZymCAafGjzXa4xCR+daUY33mNKb8As
	 9i6pj/PklBLgw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] s390: remove native mmap2() syscall
Date: Thu, 20 Jun 2024 18:23:13 +0200
Message-Id: <20240620162316.3674955-13-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620162316.3674955-1-arnd@kernel.org>
References: <20240620162316.3674955-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Rich Felker <dalias@libc.org>, Andreas Larsson <andreas@gaisler.com>, Guo Ren <guoren@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-sh@vger.kernel.org, linux-csky@vger.kernel.org, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, musl@lists.openwall.com, Nicholas Piggin <npiggin@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, ltp@lists.linux.it, Brian Cain <bcain@quicinc.com>, Christian Brauner <brauner@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, libc-alpha@sourceware.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Arnd Bergmann <arnd@arndb.de>

The mmap2() syscall has never been used on 64-bit s390x and should
have been removed as part of 5a79859ae0f3 ("s390: remove 31 bit
support").

Remove it now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/kernel/syscall.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
index dc2355c623d6..50cbcbbaa03d 100644
--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -38,33 +38,6 @@
 
 #include "entry.h"
 
-/*
- * Perform the mmap() system call. Linux for S/390 isn't able to handle more
- * than 5 system call parameters, so this system call uses a memory block
- * for parameter passing.
- */
-
-struct s390_mmap_arg_struct {
-	unsigned long addr;
-	unsigned long len;
-	unsigned long prot;
-	unsigned long flags;
-	unsigned long fd;
-	unsigned long offset;
-};
-
-SYSCALL_DEFINE1(mmap2, struct s390_mmap_arg_struct __user *, arg)
-{
-	struct s390_mmap_arg_struct a;
-	int error = -EFAULT;
-
-	if (copy_from_user(&a, arg, sizeof(a)))
-		goto out;
-	error = ksys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd, a.offset);
-out:
-	return error;
-}
-
 #ifdef CONFIG_SYSVIPC
 /*
  * sys_ipc() is the de-multiplexer for the SysV IPC calls.
-- 
2.39.2

