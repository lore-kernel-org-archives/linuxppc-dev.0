Return-Path: <fin@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C3B8A2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Aug 2013 09:16:05 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fin@linux.vnet.ibm.com>;
 Wed, 7 Aug 2013 17:15:58 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 494243E40042
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 17:15:31 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r77NFrhK197102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Aug 2013 17:15:54 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r77NFqK2005677
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Aug 2013 17:15:53 -0600
Message-ID: <1375917350.16050.14.camel@what-is-leg>
Subject: [PATCH v2] drivers/crypto/nx: saves chaining value from co-processor
From: Fionnuala Gunter <fin@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 07 Aug 2013 18:15:50 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: fin@linux.vnet.ibm.com, mhcerri@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 herbert@gondor.apana.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes a bug that is triggered when cts(cbc(aes)) is used with
nx-crypto driver on input larger than 32 bytes.

The chaining value from co-processor was not being saved. This value is
needed because it is used as the IV by cts(cbc(aes)).

Signed-off-by: Fionnuala Gunter <fin@linux.vnet.ibm.com>
Reviewed-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
---
v2. changed signed-off-by to reviewed-by and added more details to
description

This bug appeared in the original submission (v3.5)
---
 drivers/crypto/nx/nx-aes-cbc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/nx/nx-aes-cbc.c
b/drivers/crypto/nx/nx-aes-cbc.c
index 35d483f..a2f99a9 100644
--- a/drivers/crypto/nx/nx-aes-cbc.c
+++ b/drivers/crypto/nx/nx-aes-cbc.c
@@ -95,6 +95,7 @@ static int cbc_aes_nx_crypt(struct blkcipher_desc
*desc,
        if (rc)
                goto out;

+       memcpy(desc->info, csbcpb->cpb.aes_cbc.cv, AES_BLOCK_SIZE);
        atomic_inc(&(nx_ctx->stats->aes_ops));
        atomic64_add(csbcpb->csb.processed_byte_count,
                     &(nx_ctx->stats->aes_bytes));
-- 
1.7.10.4
