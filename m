Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3C959DDE11
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 03:34:04 +1100 (EST)
Date: Tue, 18 Mar 2008 19:34:03 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v3] fsl_elbc_nand: fix mtd name
Message-ID: <20080318163403.GA13244@localhost.localdomain>
References: <20080318154344.GA31173@localhost.localdomain>
	<20080318155814.GA5223@localhost.localdomain>
	<20080318161139.GD17944@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080318161139.GD17944@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently fsl_elbc_nand doesn't initialize mtd->name, and this causes
nand_get_flash_type() to assign name that is equal to chip type, like
this:

   root@b1:~# cat /proc/mtd
   dev:    size   erasesize  name
   mtd0: 00800000 00010000 "fe000000.flash"
   mtd1: 02000000 00004000 "NAND 32MiB 3,3V 8-bit"

mtd0 is physmap_of flash (normal name), and mtd1 is fsl_elbc_nand.

Despite inconsistency, with mtd name like this specifying paritions
from the kernel command line becomes a torture (though, I didn't tried
and not sure if mtdparts= can handle spaces at all). Plus, this causes
real bugs when multiple fsl_elbc_nand chips registered.

With this patch applied fsl_elbc_nand chip will have proper name:

   root@b1:~# cat /proc/mtd
   dev:    size   erasesize  name
   mtd0: 00800000 00010000 "fe000000.flash"
   mtd1: 02000000 00004000 "e0600000.flash"

p.s. We can't use priv->dev->bus_id as in physmap_of, because
fsl_elbc_nand pretends to be a localbus controller, so its bus_id is
"address.localbus", which is incorrect and thus will also not work
for multiple chips.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Tue, Mar 18, 2008 at 11:11:39AM -0500, Scott Wood wrote:
> On Tue, Mar 18, 2008 at 06:58:14PM +0300, Anton Vorontsov wrote:
> > Oops, forgot the NULL checking.
> [snip] 
> > +	if (priv->mtd.name)
> > +		kfree(priv->mtd.name);
> > +
> 
> Not needed; kfree(NULL) is a no-op.

D'oh, right. Also, we should fill the name prior to nand_scan_ident,
otherwise if error happened between nand_scan_ident and kasprintf
then we'll kfree chip's type name.

 drivers/mtd/nand/fsl_elbc_nand.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index b025dfe..9c86d9b 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -974,6 +974,8 @@ static int fsl_elbc_chip_remove(struct fsl_elbc_mtd *priv)
 
 	nand_release(&priv->mtd);
 
+	kfree(priv->mtd.name);
+
 	if (priv->vbase)
 		iounmap(priv->vbase);
 
@@ -1034,6 +1036,12 @@ static int fsl_elbc_chip_probe(struct fsl_elbc_ctrl *ctrl,
 		goto err;
 	}
 
+	priv->mtd.name = kasprintf(GFP_KERNEL, "%x.flash", res.start);
+	if (!priv->mtd.name) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
 	ret = fsl_elbc_chip_init(priv);
 	if (ret)
 		goto err;
-- 
1.5.2.2
