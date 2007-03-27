Return-Path: <mgreer@mvista.com>
Date: Tue, 27 Mar 2007 15:31:41 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Routine to find the devtree node of a linux,phandle
Message-ID: <20070327223141.GC1266@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

This depends on Scott Wood's patch
	'[PATCH 02/17] bootwrapper: Add dt_ops methods.'
from March 16 that adds 'find_node_by_prop_value()' and friends.

 ops.h |    6 ++++++
 1 file changed, 6 insertions(+)
---

diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index dae0e3b..ba516a6 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -140,6 +140,12 @@ static inline void *find_node_by_devtype(const void *prev,
 	return find_node_by_prop_value_str(prev, "device_type", type);
 }
 
+static inline void *find_node_by_linuxphandle(const u32 linuxphandle)
+{
+	return find_node_by_prop_value(NULL, "linux,phandle",
+			(char *)&linuxphandle, sizeof(u32));
+}
+
 static inline void *malloc(u32 size)
 {
 	return (platform_ops.malloc) ? platform_ops.malloc(size) : NULL;
