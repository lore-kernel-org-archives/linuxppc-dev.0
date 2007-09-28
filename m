Return-Path: <dgibson@ozlabs.org>
Date: Fri, 28 Sep 2007 14:52:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: libfdt_env.h must be included first
Message-ID: <20070928045206.GA25743@localhost.localdomain>
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

libfdt.h currently includes fdt.h, then libfdt_env.h.  This is
incorrect, because depending on the environment into which libfdt is
embedded, libfdt_env.h may be needed to define datatypes used in
fdt.h.  This patch corrects the problem.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-09-27 15:23:10.000000000 +1000
+++ dtc/libfdt/libfdt.h	2007-09-27 15:23:50.000000000 +1000
@@ -51,8 +51,8 @@
  *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-#include <fdt.h>
 #include <libfdt_env.h>
+#include <fdt.h>
 
 #define FDT_FIRST_SUPPORTED_VERSION	0x10
 #define FDT_LAST_SUPPORTED_VERSION	0x11

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
