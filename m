Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18163.9188.850104.502071@cargo.ozlabs.ibm.com>
Date: Fri, 21 Sep 2007 11:52:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Disable power management for arch/ppc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently the prep_defconfig in arch/ppc won't build due to swsusp
being broken.  This patch avoids the problem by essentially disabling
all power management on those platforms left in arch/ppc.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Does anyone have an objection to this?

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index c1b34eb..1360f17 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1012,7 +1012,7 @@ config CMDLINE
 	  some command-line options at build time by entering them here.  In
 	  most cases you will need to specify the root device here.
 
-if !44x || BROKEN
+if BROKEN
 source kernel/power/Kconfig
 endif
 
