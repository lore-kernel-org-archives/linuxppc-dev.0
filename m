Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 1EBBBDE09A
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 16:54:23 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <c5fdfe03bcac5d6964b6712a2a15ab0edc12ce83.1217476198.git.tony@bakeyournoodle.com>
Message-Id: <cab71ddee900c10f5594937b60ab4e7d919a66ce.1217487145.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH v2] Guard print_device_node_tree() if #if 0.
Date: Thu, 31 Jul 2008 16:54:20 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently print_device_node_tree() isn't called but it can be usful for
debuging.  Leave the function there but hide it behind '#if 0' to save
it being rewritten.  If you want to call it you're already editing this
file anyway ;P

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
Changes since v1:
 - No longer breaks CONFIG_PPC_PSERIES_DEBUG.

 arch/powerpc/platforms/pseries/eeh_driver.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 8c1ca47..0ad56ff 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -41,7 +41,7 @@ static inline const char * pcid_name (struct pci_dev *pdev)
 	return "";
 }
 
-#ifdef DEBUG
+#if 0
 static void print_device_node_tree(struct pci_dn *pdn, int dent)
 {
 	int i;
-- 
1.5.6.3
