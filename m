Return-Path: <scottwood@freescale.com>
Date: Tue, 11 Dec 2007 15:23:05 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 2/2] wrapper: Treat NULL as root node in devp_offset; add
	devp_offset_find().
Message-ID: <20071211212305.GB3661@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Many operations, as currently used in the wrapper, assume they can
pass NULL and have it be treated as the root node.  However, libfdt-wrapper
converts NULL to -1, which is only appropriate when searching for nodes,
and will cause an error otherwise.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/libfdt-wrapper.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/libfdt-wrapper.c b/arch/powerpc/boot/libfdt-wrapper.c
index 868c504..97af36c 100644
--- a/arch/powerpc/boot/libfdt-wrapper.c
+++ b/arch/powerpc/boot/libfdt-wrapper.c
@@ -48,7 +48,8 @@
 		check_err(_offset) ? NULL : (void *)(_offset+1); \
 	})
 
-#define devp_offset(devp)	(((int)(devp))-1)
+#define devp_offset_find(devp)	(((int)(devp))-1)
+#define devp_offset(devp)	(devp ? ((int)(devp))-1 : 0)
 
 static void *fdt;
 static void *buf; /* = NULL */
@@ -127,8 +128,9 @@ static void *fdt_wrapper_find_node_by_prop_value(const void *prev,
 						 const char *val,
 						 int len)
 {
-	return offset_devp(fdt_node_offset_by_prop_value(fdt, devp_offset(prev),
-							 name, val, len));
+	int offset = fdt_node_offset_by_prop_value(fdt, devp_offset_find(prev),
+	                                           name, val, len);
+	return offset_devp(offset);
 }
 
 static char *fdt_wrapper_get_path(const void *devp, char *buf, int len)
-- 
1.5.3.7
