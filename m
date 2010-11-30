Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 67A981007D1
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:52 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id oAU5goDw021499
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:42:50 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAU5lpDY2342928
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:51 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oAU5lpqK013242
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2010 16:47:51 +1100
From: benh@kernel.crashing.org
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/13] powerpc/nvram: Ensure that the partition header/block
	size is right
Date: Tue, 30 Nov 2010 16:47:34 +1100
Message-Id: <1291096063-14386-4-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1291096063-14386-1-git-send-email-benh@kernel.crashing.org>
References: <1291096063-14386-1-git-send-email-benh@kernel.crashing.org>
Cc: jkensito@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Use BUILD_BUG_ON to ensure the structure representing a partition
header have the right size.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/nvram_64.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index a5a5587..f753882 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -565,6 +565,8 @@ static int __init nvram_init(void)
 	int error;
 	int rc;
 	
+	BUILD_BUG_ON(NVRAM_BLOCK_LEN != 16);
+
 	if (ppc_md.nvram_size == NULL || ppc_md.nvram_size() <= 0)
 		return  -ENODEV;
 
-- 
1.7.1
