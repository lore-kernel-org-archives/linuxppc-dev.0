Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 7A32ADE015
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 05:20:33 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 23 Oct 2007 12:20:32 -0700
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [POWERPC] Fix mv643xx_pci sysfs .read and .write functions
Message-ID: <20071023192032.GB15210@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 91a69029 introduced an additional parameter to the .read and .write
methods for sysfs binary attributes.  Two mv64x60_pci functions
were missed in that patch, resulting in these errors:
	/cache/git/linux-2.6/arch/powerpc/sysdev/mv64x60_pci.c:77: warning: initialization from incompatible pointer type
	/cache/git/linux-2.6/arch/powerpc/sysdev/mv64x60_pci.c:78: warning: initialization from incompatible pointer type

Add the missing "struct bin_attribute *" parameter.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---
 arch/powerpc/sysdev/mv64x60_pci.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index 9b3baa7..6933f9c 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -24,8 +24,9 @@
 #define MV64X60_VAL_LEN_MAX		11
 #define MV64X60_PCICFG_CPCI_HOTSWAP	0x68
 
-static ssize_t mv64x60_hs_reg_read(struct kobject *kobj, char *buf, loff_t off,
-				   size_t count)
+static ssize_t mv64x60_hs_reg_read(struct kobject *kobj,
+				   struct bin_attribute *attr, char *buf,
+				   loff_t off, size_t count)
 {
 	struct pci_dev *phb;
 	u32 v;
@@ -44,8 +45,9 @@ static ssize_t mv64x60_hs_reg_read(struct kobject *kobj, char *buf, loff_t off,
 	return sprintf(buf, "0x%08x\n", v);
 }
 
-static ssize_t mv64x60_hs_reg_write(struct kobject *kobj, char *buf, loff_t off,
-				    size_t count)
+static ssize_t mv64x60_hs_reg_write(struct kobject *kobj,
+				    struct bin_attribute *attr, char *buf,
+				    loff_t off, size_t count)
 {
 	struct pci_dev *phb;
 	u32 v;
-- 
1.5.3.4
