Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D63606A33E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqBNxwV+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL5mS0kHRz2xN4;
	Fri, 06 Nov 2026 02:28:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793892488;
	cv=none; b=WlIUU8wWwrCHqpUyAU8VBrV44WAMVOH/Z1nL6sgkxrnOrOIw/9+W3wlMlHAFbY1r5NS0HYfR3yllIFDAMJlC2/g/9Kk4RMXKVsRwh0ec5AdDFi6J99su6M3vUzHCaMBvGJHULKil0UYoLIk/hA2Zn9RVgWPYo3EJY2WSeg6vV5lUDQYZYw9NIBFmQRkB/Y//Aod9DXWxSeqmRIoa2znq16aXy310kqTe3z1CjmGo7lhbhBd9JRM79VHUecduNBq0ZpeYLOuOz2Fu2df9aPJLd02lGlR3KWfoqg+UDXusbyIiGQKTIKjCRVXQgar8uK0Jr+KdSp9BPAxbZgezR4iVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793892488; c=relaxed/relaxed;
	bh=+16/xh1x9+viQmW1Od4l3PfPuAdn7sLqIJr4E41Pb38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQTZ/pIZmBQ0djrLIWwlH2TIUui1Tv36trEYNQS7XjtsGIUkTH/q0vV/4NYFEFIoCJLm/5IyR5/zO/c1WsG2tFvUvH6DP9AucT4JhGMoIb8Lv6uygFN0LfyIJYMgm+HZDIRRJU1w1KvrddN7MpLJGzhi9FW9L9xFRbrhm56GoOitJvzQmzOKzf4NbnPmjwkcVl51N0YynVDsy5cEeVZxdgP35sscUhynZMe184k7OIw5DCKWyit3QCBpT0ecPWjySb12MV3YYPVuiPfI/Qsujw43O1s4bDYgSRsLm/8/XmjetFxDukDBdfVpt8xtLKFMAZKVEH820w+mlalhIp4Q3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqBNxwV+; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqBNxwV+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL5mR1t2Jz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 02:28:07 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2D401609D5;
	Thu,  5 Nov 2026 15:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFD61F00A16;
	Thu,  5 Nov 2026 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892483;
	bh=+16/xh1x9+viQmW1Od4l3PfPuAdn7sLqIJr4E41Pb38=;
	h=From:To:Cc:Subject:Date;
	b=XqBNxwV+ZKyYMzyvNQtukt1M/M1h7JEcqBKgnFfI1rZvkaFvqzHnBhDwj0zXMtXLX
	 89zOMlckL9TnEuSFE+kQvJ7SDX+TbNHUbJ9JswH1rX8V/eMD+TjnZDpOdo4tanpAz6
	 EBRAEvOco2rUbcNzI4dwTNX62byJVQyGAEwewy08okPdoPulW03BRqD9Nw63V3nMsD
	 /AYGb2tc4CKgw01LbRWZMZo+qn4w/RivkyNHYiWxt6iYi2gC1gn5yGM66kOS4a0R+X
	 GK8+wZoRA4raCrNsBe6ndCEaL49qkZrv626B4trBkLpQRAIEJ0UZWvwwVU4WJrp1m1
	 0rfCRSMuVTzSA==
From: Thorsten Blum <blum@kernel.org>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/ps3: Remove dead printf() calls from the bootwrapper
Date: Thu,  5 Nov 2026 16:27:38 +0100
Message-ID: <20261105152737.359236-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116; i=blum@kernel.org; h=from:subject; bh=/woHg1H5FOYeLNQv7p3oVvU09lNSexbmuU5FdjtVxtc=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlvFmSmScXPODLJveUJs0zKt/Jqva7Y7Sc5T8+XXvfSv jSJfaFORykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEzEdBnD/0xRhgNykfd8vY0/ xy7Y+3Lx4qvxrCuKFNjPBXB2pMVJejAynJf82v/u2wP+/qyY0t6/ubJFJnMtUp1zlgdfkllktPU /KwA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The bootwrapper uses an empty console write callback, so its printf()
calls produce no output. Remove them and the empty ps3_console_write()
callback. Also leave console_ops.write unset and remove now-unused
header includes.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/boot/ps3.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/powerpc/boot/ps3.c b/arch/powerpc/boot/ps3.c
index 89ff46b8b225..c557f90cdd82 100644
--- a/arch/powerpc/boot/ps3.c
+++ b/arch/powerpc/boot/ps3.c
@@ -6,12 +6,10 @@
  *  Copyright 2007 Sony Corp.
  */
 
-#include <stdarg.h>
 #include <stddef.h>
 #include "types.h"
 #include "elf.h"
 #include "string.h"
-#include "stdio.h"
 #include "page.h"
 #include "ops.h"
 
@@ -37,18 +35,10 @@ static void prep_cmdline(void *chosen)
 		getprop(chosen, "bootargs", cmdline, BOOT_COMMAND_LINE_SIZE-1);
 	else
 		setprop_str(chosen, "bootargs", cmdline);
-
-	printf("cmdline: '%s'\n", cmdline);
-}
-
-static void ps3_console_write(const char *buf, int len)
-{
 }
 
 static void ps3_exit(void)
 {
-	printf("ps3_exit\n");
-
 	/* lv1_panic will shutdown the lpar. */
 
 	lv1_panic(0); /* zero = do not reboot */
@@ -83,12 +73,6 @@ static int ps3_repository_read_rm_size(u64 *rm_size)
 		0x7075000000000000ULL, ppe_id, 0x726d5f73697a6500ULL, rm_size,
 		&v2);
 
-	printf("%s:%d: ppe_id  %lu \n", __func__, __LINE__,
-		(unsigned long)ppe_id);
-	printf("%s:%d: lpar_id %lu \n", __func__, __LINE__,
-		(unsigned long)lpar_id);
-	printf("%s:%d: rm_size %llxh \n", __func__, __LINE__, *rm_size);
-
 	return result ? -1 : 0;
 }
 
@@ -107,11 +91,8 @@ void platform_init(void)
 	unsigned long ft_addr;
 	u64 rm_size;
 
-	console_ops.write = ps3_console_write;
 	platform_ops.exit = ps3_exit;
 
-	printf("\n-- PS3 bootwrapper --\n");
-
 	simple_alloc_init(_end, heapsize, 32, 64);
 	fdt_init(_dtb_start);
 
@@ -131,8 +112,6 @@ void platform_init(void)
 
 	ps3_copy_vectors();
 
-	printf(" flat tree at 0x%lx\n\r", ft_addr);
-
 	((kernel_entry_t)0)(ft_addr, 0, NULL);
 
 	ps3_exit();

