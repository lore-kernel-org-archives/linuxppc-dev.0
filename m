Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B77A01A1A24
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 08:42:32 +1000 (AEST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 2 Jul 2015 16:42:30 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 073F61FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 16:33:38 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t62Mflvb42729674
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2015 15:41:47 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t62MgR0L018980
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2015 16:42:27 -0600
Date: Thu, 2 Jul 2015 15:42:26 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Dan Streetman <ddstreet@us.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gustavold@linux.vnet.ibm.com
Subject: [PATCH 6/6] nx-842-platform: if NX842 platform drivers are not
 modules, don't try to load them
Message-ID: <20150702224225.GG1712@linux.vnet.ibm.com>
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

Based off the CONFIG_SPU_FS_MODULE code, only attempt to load platform
modules if the nx-842 pseries/powernv drivers are built as modules.

Otherwise, if CONFIG_DEV_NX_COMPRESS=y,
CONFIG_DEV_NX_COMPRESS_PSERIES=y, CONFIG_DEV_NX_POWERNV=y, the following
message is emitted at boot:

nx_compress: no nx842 driver found.

even though the drivers successfully loads.

This is because in the =y case, the module_init() calls get converted to
initcalls and the nx842_init() runs before the platform driver
nx842_pseries_init() or nx842_powernv_init() functions, which are what
normally set the static platform driver.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Dan Streetman <ddstreet@us.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/crypto/nx/nx-842-platform.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/nx/nx-842-platform.c b/drivers/crypto/nx/nx-842-platform.c
index 664f13dd06ed..5363c72593b4 100644
--- a/drivers/crypto/nx/nx-842-platform.c
+++ b/drivers/crypto/nx/nx-842-platform.c
@@ -53,6 +53,7 @@ void nx842_platform_driver_unset(struct nx842_driver *_driver)
 }
 EXPORT_SYMBOL_GPL(nx842_platform_driver_unset);
 
+#if defined(CONFIG_CRYPTO_DEV_NX_COMPRESS_PSERIES_MODULE) || defined(CONFIG_CRYPTO_DEV_NX_COMPRESS_POWERNV_MODULE)
 bool nx842_platform_driver_get(void)
 {
 	bool ret = false;
@@ -66,7 +67,6 @@ bool nx842_platform_driver_get(void)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(nx842_platform_driver_get);
 
 void nx842_platform_driver_put(void)
 {
@@ -77,6 +77,17 @@ void nx842_platform_driver_put(void)
 
 	spin_unlock(&driver_lock);
 }
+#else
+bool nx842_platform_driver_get(void)
+{
+	return true;
+}
+
+void nx842_platform_driver_put(void)
+{
+}
+#endif
+EXPORT_SYMBOL_GPL(nx842_platform_driver_get);
 EXPORT_SYMBOL_GPL(nx842_platform_driver_put);
 
 MODULE_LICENSE("GPL");
-- 
2.1.4
