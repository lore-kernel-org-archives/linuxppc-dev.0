Return-Path: <fin@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 572AE2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 06:58:19 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fin@linux.vnet.ibm.com>;
 Fri, 2 Aug 2013 21:58:15 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4128C38C8054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 16:58:11 -0400 (EDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r72KwC8n181650
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Aug 2013 16:58:12 -0400
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r72KwBh5028160
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Aug 2013 14:58:11 -0600
Message-ID: <1375477090.32477.10.camel@what-is-leg>
Subject: [PATCH] drivers/crypto/nx: saves chaining value from co-processor
From: Fionnuala Gunter <fin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 02 Aug 2013 15:58:10 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The chaining value from co-processor was not being saved. This value is
needed because it is used as the IV, for example by cts i.e.
cts(cbc(aes)).

Signed-off-by: Fionnuala Gunter <fin@linux.vnet.ibm.com>
Signed-off-by: Marcelo Cerri <mhcerri@linux.vnet.ibm.com>
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
