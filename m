Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17726.62952.416387.74258@cargo.ozlabs.ibm.com>
Date: Wed, 25 Oct 2006 15:28:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: raisch@de.ibm.com, schickhj@de.ibm.com, rdreier@cisco.com
Subject: [PATCH] Fix eHCA driver compilation for uniprocessor
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The eHCA driver does not compile for a uniprocessor configuration
(CONFIG_SMP=n), due to H_SUCCESS and other symbols being undefined.
This fixes it.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/drivers/infiniband/hw/ehca/ehca_tools.h b/drivers/infiniband/hw/ehca/ehca_tools.h
index 809da3e..973c4b5 100644
--- a/drivers/infiniband/hw/ehca/ehca_tools.h
+++ b/drivers/infiniband/hw/ehca/ehca_tools.h
@@ -63,6 +63,7 @@ #include <asm/abs_addr.h>
 #include <asm/ibmebus.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
+#include <asm/hvcall.h>
 
 extern int ehca_debug_level;
 
