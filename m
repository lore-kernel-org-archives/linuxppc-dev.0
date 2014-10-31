Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4F931A06B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 17:50:21 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 31 Oct 2014 06:50:17 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1C0BD2190045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 06:49:50 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9V6oEwX16777612
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 06:50:14 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9V6oEHS022739
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 00:50:14 -0600
Subject: [PATCH] hwrng: pseries - port to new read API and fix stack corruption
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 31 Oct 2014 07:50:11 +0100
Message-ID: <20141031063233.1884.86309.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org, Herbert Xu <herbert@gondor.apana.org.au>,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The add_early_randomness() function in drivers/char/hw_random/core.c passes
a 16-byte buffer to pseries_rng_data_read(). Unfortunately, plpar_hcall()
returns four 64-bit values and trashes 16 bytes on the stack.

This bug has been lying around for a long time. It got unveiled by:

commit d3cc7996473a7bdd33256029988ea690754e4e2a
Author: Amit Shah <amit.shah@redhat.com>
Date:   Thu Jul 10 15:42:34 2014 +0530

    hwrng: fetch randomness only after device init

It may trig a oops while loading or unloading the pseries-rng module for both
PowerVM and PowerKVM guests.

This patch does two things:
- pass an intermediate well sized buffer to plpar_hcall(). This is acceptalbe
  since we're not on a hot path.
- move to the new read API so that we know the return buffer size for sure.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---

Cc'ing stable as I could reproduce back to 3.15.10

 drivers/char/hw_random/pseries-rng.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/pseries-rng.c b/drivers/char/hw_random/pseries-rng.c
index 6226aa0..bcf86f9 100644
--- a/drivers/char/hw_random/pseries-rng.c
+++ b/drivers/char/hw_random/pseries-rng.c
@@ -25,18 +25,21 @@
 #include <asm/vio.h>
 
 
-static int pseries_rng_data_read(struct hwrng *rng, u32 *data)
+static int pseries_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
+	u64 buffer[PLPAR_HCALL_BUFSIZE];
+	size_t size = max < 8 ? max : 8;
 	int rc;
 
-	rc = plpar_hcall(H_RANDOM, (unsigned long *)data);
+	rc = plpar_hcall(H_RANDOM, (unsigned long *)buffer);
 	if (rc != H_SUCCESS) {
 		pr_err_ratelimited("H_RANDOM call failed %d\n", rc);
 		return -EIO;
 	}
+	memcpy(data, buffer, size);
 
 	/* The hypervisor interface returns 64 bits */
-	return 8;
+	return size;
 }
 
 /**
@@ -55,7 +58,7 @@ static unsigned long pseries_rng_get_desired_dma(struct vio_dev *vdev)
 
 static struct hwrng pseries_rng = {
 	.name		= KBUILD_MODNAME,
-	.data_read	= pseries_rng_data_read,
+	.read		= pseries_rng_read,
 };
 
 static int __init pseries_rng_probe(struct vio_dev *dev,
