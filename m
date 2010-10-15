Return-Path: <nacc@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2235CB6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 11:49:03 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9F0frsT022218
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 20:41:53 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9F0n0D4291464
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 20:49:00 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9F0mxB6030940
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 21:49:00 -0300
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH v2] pseries: don't override CONFIG_PPC_PSERIES_DEBUG
Date: Thu, 14 Oct 2010 17:48:52 -0700
Message-Id: <1287103733-7121-1-git-send-email-nacc@us.ibm.com>
Cc: Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	Brian King <brking@linux.vnet.ibm.com>,
	Linas Vepstas <linasvepstas@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

eeh and pci_dlpar #undef DEBUG, but I think they were added before the
ability to control this from Kconfig. It's really annoying to only get
some of the debug messages from these files. Leave the lpar.c #undef
alone as it produces so much output as to make the kernel unusable.
Update the Kconfig text to indicate this particular quirk :)

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/platforms/pseries/Kconfig     |    6 ++++++
 arch/powerpc/platforms/pseries/eeh.c       |    2 --
 arch/powerpc/platforms/pseries/pci_dlpar.c |    2 --
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index c667f0f..3139814 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -47,6 +47,12 @@ config LPARCFG
 config PPC_PSERIES_DEBUG
 	depends on PPC_PSERIES && PPC_EARLY_DEBUG
 	bool "Enable extra debug logging in platforms/pseries"
+        help
+	  Say Y here if you want the pseries core to produce a bunch of
+	  debug messages to the system log. Select this if you are having a
+	  problem with the pseries core and want to see more of what is
+	  going on. This does not enable debugging in lpar.c, which must
+	  be manually done due to its verbosity.
 	default y
 
 config PPC_SMLPAR
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 34b7dc1..17a11c8 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -21,8 +21,6 @@
  * Please address comments and feedback to Linas Vepstas <linas@austin.ibm.com>
  */
 
-#undef DEBUG
-
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/list.h>
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 4b7a062..5fcc92a 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -25,8 +25,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#undef DEBUG
-
 #include <linux/pci.h>
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>
-- 
1.7.1
