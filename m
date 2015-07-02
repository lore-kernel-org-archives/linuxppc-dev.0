Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D06AA1A1A21
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 08:40:15 +1000 (AEST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 2 Jul 2015 16:40:13 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D7EB319D8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 16:31:11 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t62MdS1356688798
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2015 15:39:28 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t62MeAEG030177
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2015 16:40:10 -0600
Date: Thu, 2 Jul 2015 15:40:09 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Dan Streetman <ddstreet@us.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gustavold@linux.vnet.ibm.com
Subject: [PATCH 3/6] nx-842-pseries: do not emit extra output if status is
 disabled
Message-ID: <20150702224009.GD1712@linux.vnet.ibm.com>
References: <20150702223800.GA1712@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150702223800.GA1712@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If the device-tree indicates the nx-842 device's status is 'disabled',
we emit two messages:

nx_compress_pseries ibm,compression-v1: nx842_OF_upd_status: status 'disabled' is not 'okay'.
nx_compress_pseries ibm,compression-v1: nx842_OF_upd: device disabled

Given that 'disabled' is a valid state, and we are going to emit that
the device is disabled, only print out a non-'okay' status if it is not
'disabled'.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

---
 drivers/crypto/nx/nx-842-pseries.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/nx/nx-842-pseries.c b/drivers/crypto/nx/nx-842-pseries.c
index e17f4d2e96e0..b84b0ceeb46e 100644
--- a/drivers/crypto/nx/nx-842-pseries.c
+++ b/drivers/crypto/nx/nx-842-pseries.c
@@ -566,8 +566,14 @@ static int nx842_OF_upd_status(struct nx842_devdata *devdata,
 	if (!strncmp(status, "okay", (size_t)prop->length)) {
 		devdata->status = AVAILABLE;
 	} else {
-		dev_info(devdata->dev, "%s: status '%s' is not 'okay'\n",
+		/*
+		 * Caller will log that the device is disabled, so only
+		 * output if there is an unexpected status.
+		 */
+		if (strncmp(status, "disabled", (size_t)prop->length)) {
+			dev_info(devdata->dev, "%s: status '%s' is not 'okay'\n",
 				__func__, status);
+		}
 		devdata->status = UNAVAILABLE;
 		ret = -ENODEV;
 	}
-- 
2.1.4
