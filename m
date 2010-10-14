Return-Path: <nacc@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E82391007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 04:48:36 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9EHmvjY026217
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 13:48:57 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9EHmS8q128374
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 13:48:28 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o9EHmQTK015032
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2010 11:48:27 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH] ppc: don't override CONFIG_PPC_PSERIES_DEBUG
Date: Thu, 14 Oct 2010 10:48:14 -0700
Message-Id: <1287078495-11722-1-git-send-email-nacc@us.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, Frans Pop <elendil@planet.nl>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Linas Vepstas <linasvepstas@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These files undef DEBUG, but I think they were added before the ability
to control this from Kconfig. It's really annoying to only get some of
the debug messages!

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---
Because the lpar and pci_dlpar code is pretty low-level & verbose,
perhaps it makes sense to add another Kconfig variable for really
low-level stuff? But it's annoying to have DEBUG *somewhat* effective,
especially in the EEH area when doing PCI stuff.
---
 arch/powerpc/platforms/pseries/eeh.c       |    2 --
 arch/powerpc/platforms/pseries/lpar.c      |    3 ---
 arch/powerpc/platforms/pseries/pci_dlpar.c |    2 --
 3 files changed, 0 insertions(+), 7 deletions(-)

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
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index cf79b46..4b31a66 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -19,9 +19,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-/* Enables debugging of low-level hash table routines - careful! */
-#undef DEBUG
-
 #include <linux/kernel.h>
 #include <linux/dma-mapping.h>
 #include <linux/console.h>
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
