Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 106A5DDF95
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 21:34:26 +1100 (EST)
Date: Thu, 16 Oct 2008 20:36:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@linux-foundation.org>, Andrew Morton
	<akpm@linux-foundation.org>
Subject: [PATCH] tpm: don't export static functions
Message-Id: <20081016203609.0ddd419d.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: James, Rajiv Andrade <srajiv@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, Morris <jmorris@namei.org>,
	ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Today's linux-next build (powerpc_allyesconfig) failed like this:

drivers/char/tpm/tpm.c:1162: error: __ksymtab_tpm_dev_release causes a section type conflict

Caused by commit 253115b71fa06330bd58afbe01ccaf763a8a0cf1 ("The
tpm_dev_release function is only called for platform devices, not pnp")
which exported a static function.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/tpm/tpm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/tpm/tpm.c b/drivers/char/tpm/tpm.c
index 1fee703..f61c9fe 100644
--- a/drivers/char/tpm/tpm.c
+++ b/drivers/char/tpm/tpm.c
@@ -1150,7 +1150,7 @@ EXPORT_SYMBOL_GPL(tpm_dev_vendor_release);
  * Once all references to platform device are down to 0,
  * release all allocated structures.
  */
-static void tpm_dev_release(struct device *dev)
+void tpm_dev_release(struct device *dev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
 
-- 
1.5.6.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
