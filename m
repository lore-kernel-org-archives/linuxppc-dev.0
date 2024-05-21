Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D77C25B77
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2024 03:06:35 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=COX99QEW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vjzg96s9Bz3gBM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2024 12:59:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=COX99QEW;
	dkim-atps=neutral
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VjzfK4NCgz3ftk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2024 12:58:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716260322;
	bh=7kHB/B7pdEbxFksZxcWfPUa01xxD95y0BrxFKM1OMoY=;
	h=From:To:Cc:Subject:Date:From;
	b=COX99QEWSMbpjgoX/Hyr0QExd9jKANW/+lqZMj6opdUETQumAc+ytuURis6vetyrK
	 8x9aqVarCqG97FIYFHRUcGo6hOz/ei/hyF1kvxLWx0x/puBoIQFqWoxBZgpMmuS5M9
	 lwHkenJolSQosv5kl5/U5sef0Slpslszdjvqb+uWsV3dTfgvOBQS4zVy5IQVQRZ87d
	 aH3npmjbNPVvGjbhDZ/NwiZ7gg2fd2pLAucO8GdGSP/vc4X7+piLQbG5LxTAiGY8bz
	 hgbaBK05cg6tmRtIwegk8KpArgcuzXRSjuyEYZOUAzxG63PdA5S+kHUI4gpdPwlbdy
	 d2n42LFwj6RgA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VjzfB4yz5z4wjF;
	Tue, 21 May 2024 12:58:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linux-kselftest@vger.kernel.org>,
	<skhan@linuxfoundation.org>
Subject: [PATCH] selftests/overlayfs: Fix build error on ppc64
Date: Tue, 21 May 2024 12:26:16 +1000
Message-ID: <20240521022616.45240-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fix build error on ppc64:
  dev_in_maps.c: In function ‘get_file_dev_and_inode’:
  dev_in_maps.c:60:59: error: format ‘%llu’ expects argument of type
  ‘long long unsigned int *’, but argument 7 has type ‘__u64 *’ {aka ‘long
  unsigned int *’} [-Werror=format=]

By switching to unsigned long long for u64 for ppc64 builds.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
index 759f86e7d263..2862aae58b79 100644
--- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__ // Use ll64
 
 #include <inttypes.h>
 #include <unistd.h>
-- 
2.45.1

