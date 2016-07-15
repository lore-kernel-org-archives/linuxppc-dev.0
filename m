Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrVGJ2gBVzDrq2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 21:10:00 +1000 (AEST)
Date: Fri, 15 Jul 2016 14:09:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 Kent Yoder <key@linux.vnet.ibm.com>
Cc: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: [patch] crypto: nx - off by one bug in nx_of_update_msc()
Message-ID: <20160715110912.GE9258@mwanda>
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

The props->ap[] array is defined like this:

	struct alg_props ap[NX_MAX_FC][NX_MAX_MODE][3];

So we can see that if msc->fc and msc->mode are == to NX_MAX_FC or
NX_MAX_MODE then we're off by one.

Fixes: ae0222b7289d ('powerpc/crypto: nx driver code supporting nx encryption')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/crypto/nx/nx.c b/drivers/crypto/nx/nx.c
index 0794f1c..42f0f22 100644
--- a/drivers/crypto/nx/nx.c
+++ b/drivers/crypto/nx/nx.c
@@ -392,7 +392,7 @@ static void nx_of_update_msc(struct device   *dev,
 		     ((bytes_so_far + sizeof(struct msc_triplet)) <= lenp) &&
 		     i < msc->triplets;
 		     i++) {
-			if (msc->fc > NX_MAX_FC || msc->mode > NX_MAX_MODE) {
+			if (msc->fc >= NX_MAX_FC || msc->mode >= NX_MAX_MODE) {
 				dev_err(dev, "unknown function code/mode "
 					"combo: %d/%d (ignored)\n", msc->fc,
 					msc->mode);
