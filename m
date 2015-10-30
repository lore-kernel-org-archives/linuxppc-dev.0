Return-Path: <linuxram@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2AB4B1A0468
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2015 09:13:24 +1100 (AEDT)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6CDD71402D2
 for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2015 09:13:23 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 30 Oct 2015 16:13:21 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 4BEBA6E8048
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2015 18:01:30 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9UMDJho58654810
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2015 22:13:19 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9UMCEMx016960
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Oct 2015 18:12:14 -0400
Date: Fri, 30 Oct 2015 15:13:12 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, hbabu@us.ibm.com, nacc@us.ibm.com
Subject: [PATCH] Endian swap ->count before handing over to the nx-842
 compressor
Message-ID: <20151030221312.GA22547@ram.oc3035372033.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The nx-842 compressor overshoots the output buffer corrupting memory. Verified
that the following patch the issue on a LE system.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 drivers/crypto/nx/nx-842-powernv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
index 3750e13..3b80ea7 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -66,7 +66,7 @@ static void setup_indirect_dde(struct data_descriptor_entry *dde,
 			       unsigned int dde_count, unsigned int byte_count)
 {
 	dde->flags = 0;
-	dde->count = dde_count;
+	dde->count = cpu_to_be32(dde_count);
 	dde->index = 0;
 	dde->length = cpu_to_be32(byte_count);
 	dde->address = cpu_to_be64(nx842_get_pa(ddl));
-- 
1.7.1
