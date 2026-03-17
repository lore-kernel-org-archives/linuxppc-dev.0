Return-Path: <linuxppc-dev+bounces-18329-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FABFED9FD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 18:07:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fb0Kj4vwxz2yhV;
	Wed, 18 Mar 2026 05:07:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773770841;
	cv=none; b=aZTqKLshSisGCeqI9hFEYy6KTfYKAfjLwRTkIGGzNjPXWex87XefNaQejNRGPdNxvShp0gszzNfxa5xnvueNNikacT5yLWb3IqQMuWSWt1tZdqO5oDD4QvhK6RsfSQfCE4qGwGRZ3EyZz2bTtLhJ8F9JjrtcGIzyOArlnRkazy3esLx2L9p4CKSWM+41UoL/Mzll+rCpr5AQAe8U0EXoGfsnW5+/HrOB6J04/AEs+aI5Y8UannagPUpt4gDvO2cPcaJnh41sHX9RbYPX+n2J/EmlK9oehiNE9YlWhO/ZI9WfgMw0jxuEaYz24cOg5J5zq1ZmfHwJA/FfeR0IVcMTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773770841; c=relaxed/relaxed;
	bh=NXSHE/k+4CHnI/zOMT8+L4DOtk+A8fV/gDV00PDxcZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9HZu9oKuN5U4kXos9U5bDpwN6Gyrl9vCQWPCXw/PDeFgaKqs7P56jT6JB1dLg3IM2cnMWhC9czInoIfjomEZfJuQy0Ogys0jTPDL2+wSIcr65psf9uBFQi7y5Z81d5rtybyjCLmWHpX0uCP5wFtkCosrEp8X8kcbKm/0KpqbN0L9Jch5c2UD/niyodipIBD3ufkEi4i/tUUPJB8fFjhc3snejpX3p0Q8IkEeV7sz0L8+xx6fDkUpBoIxYDXkP5gkRtenM6vYU1O8ieDJFtkh2uNlrfxHTrBvLiiFiDygsysalJu88Rne9nogYb13Q8zBqMpQkTr6B4NH+sFAi3IcQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vPqGNk//; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vPqGNk//;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fb0Kh48rKz2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 05:07:20 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 60FFB600AD;
	Tue, 17 Mar 2026 18:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307BEC2BC86;
	Tue, 17 Mar 2026 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770837;
	bh=msXtNh2L7yEuV8cdaHMIwp4LwRym7oKTQnwyksNEC9w=;
	h=From:To:Cc:Subject:Date:From;
	b=vPqGNk//jwOSxooeEwykbxSrewT6FRz/5Ahqb5i6NtvuR93okhibyFHsBS6DCOIWw
	 MPeC4BOP+z+sgJ0k42kfj5FbsjPn1N6Ctp6PA/bovBqOKVZhtlQnKTPBBwayZzHRtw
	 0zzszYIX/OkwBNK3XrfWlDLT0i2WfLc5a47Ekt+ymFA2VCcwKbmS025NsHWc70VUhQ
	 BAFtb+EWP45D7XBDcyvESyawdNE3e8IvCHYVYIqjhwoxqshBJFmYThLaCvKfMYQJ7k
	 4WKhLZvE3fCW45igp94OLXl9kDR9ZypORC0ofXiiF9RU/MxkVaVQPPPXKEnrZBPHTB
	 V3Y1/3djoadtg==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Simplify access_ok()
Date: Tue, 17 Mar 2026 19:07:04 +0100
Message-ID: <56dd1a892279fade2292b7eef7a52112901ae2fd.1773770778.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2382; i=chleroy@kernel.org; h=from:subject:message-id; bh=msXtNh2L7yEuV8cdaHMIwp4LwRym7oKTQnwyksNEC9w=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTunOF56ONcTRk3/bi7VkwivJWfz+VVOBVtWVS+LSFCw 0t/0jrFjlIWBjEuBlkxRZbj/7l3zej6kpo/dZc+zBxWJpAhDFycAjAR2QcMf4WYMqfP8X/tWbfQ 0fs6V67VrD+nLsSzaXys49gZxNLz7jcjw9nDKfk3tu69z7Shc8O8+rLji9+y11wr5JIO0U95f79 gMw8A
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

With the implementation of masked user access, we always have a memory
gap between user memory space and kernel memory space, so use it to
simplify access_ok() by relying on access fault in case of an access
in the gap.

Most of the time the size is known at build time.

On powerpc64, the kernel space starts at 0x8000000000000000 which is
always more than two times TASK_USER_MAX so when the size is known at
build time and lower than TASK_USER_MAX, only the address needs to be
verified. If not, a binary or of address and size must be lower than
TASK_USER_MAX. As TASK_USER_MAX is a power of 2, just check that
there is no bit set outside of TASK_USER_MAX - 1 mask.

On powerpc32, there is a garanteed gap of 128KB so when the size is
known at build time and not greater than 128KB, just check that the
address is below TASK_SIZE. Otherwise use the original formula.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/include/asm/uaccess.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 570b3d91e2e4..ec210ae62be7 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -15,8 +15,34 @@
 #define TASK_SIZE_MAX		TASK_SIZE_USER64
 #endif
 
+#define __access_ok __access_ok
+
 #include <asm-generic/access_ok.h>
 
+/*
+ * On powerpc64, TASK_SIZE_MAX is 0x0010000000000000 then even if both ptr and size
+ * are TASK_SIZE_MAX we are still inside the memory gap. So make it simple.
+ */
+static __always_inline int __access_ok(const void __user *ptr, unsigned long size)
+{
+	unsigned long addr = (unsigned long)ptr;
+
+	if (IS_ENABLED(CONFIG_PPC64)) {
+		BUILD_BUG_ON(!is_power_of_2(TASK_SIZE_MAX));
+		BUILD_BUG_ON(TASK_SIZE_MAX > 0x0010000000000000);
+
+		if (__builtin_constant_p(size))
+			return size <= TASK_SIZE_MAX && !(addr & ~(TASK_SIZE_MAX - 1));
+		else
+			return !((size | addr) & ~(TASK_SIZE_MAX - 1));
+	} else {
+		if (__builtin_constant_p(size) && size < SZ_128K)
+			return addr < TASK_SIZE;
+		else
+			return size <= TASK_SIZE && addr <= TASK_SIZE - size);
+	}
+}
+
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
-- 
2.49.0


