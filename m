Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN1Pg4TfJzDqb7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 04:07:51 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id y129so7181446pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 11:07:51 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] powerpc: add const to bin_attribute structures
Date: Wed,  2 Aug 2017 23:37:38 +0530
Message-Id: <1501697258-19220-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Declare bin_attribute structures as const as they are only passed as an
argument to the function sysfs_create_bin_file. This argument is of
type const, so declare the structure as const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-flash.c | 2 +-
 arch/powerpc/sysdev/mv64x60_pci.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
index 4ec6219..2fa3ac8 100644
--- a/arch/powerpc/platforms/powernv/opal-flash.c
+++ b/arch/powerpc/platforms/powernv/opal-flash.c
@@ -520,7 +520,7 @@ static ssize_t image_data_write(struct file *filp, struct kobject *kobj,
  *   update_flash	: Flash new firmware image
  *
  */
-static struct bin_attribute image_data_attr = {
+static const struct bin_attribute image_data_attr = {
 	.attr = {.name = "image", .mode = 0200},
 	.size = MAX_IMAGE_SIZE,	/* Limit image size */
 	.write = image_data_write,
diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index 330d566..f1fe172 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -70,7 +70,7 @@ static ssize_t mv64x60_hs_reg_write(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static struct bin_attribute mv64x60_hs_reg_attr = { /* Hotswap register */
+static const struct bin_attribute mv64x60_hs_reg_attr = { /* Hotswap register */
 	.attr = {
 		.name = "hs_reg",
 		.mode = S_IRUGO | S_IWUSR,
-- 
1.9.1
