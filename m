Return-Path: <weiyj.lk@gmail.com>
MIME-Version: 1.0
Date: Tue, 4 Dec 2012 00:17:01 -0500
Message-ID: <CAPgLHd-QN0vH3F+Ws8DMrjZOh5vvsjEB0tMOUGFjqtbuwksn-g@mail.gmail.com>
Subject: [PATCH -next] [POWERPC] celleb: use for_each_compatible_node() macro
From: Wei Yongjun <weiyj.lk@gmail.com>
To: arnd@arndb.de, benh@kernel.crashing.org, paulus@samba.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: cbe-oss-dev@lists.ozlabs.org, yongjun_wei@trendmicro.com.cn,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use for_each_compatible_node() macro instead of open coding it.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/powerpc/platforms/cell/celleb_scc_sio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/celleb_scc_sio.c b/arch/powerpc/platforms/cell/celleb_scc_sio.c
index 3a16c5b..75d71a7 100644
--- a/arch/powerpc/platforms/cell/celleb_scc_sio.c
+++ b/arch/powerpc/platforms/cell/celleb_scc_sio.c
@@ -42,14 +42,13 @@ static struct {
 static int __init txx9_serial_init(void)
 {
 	extern int early_serial_txx9_setup(struct uart_port *port);
-	struct device_node *node = NULL;
+	struct device_node *node;
 	int i;
 	struct uart_port req;
 	struct of_irq irq;
 	struct resource res;
 
-	while ((node = of_find_compatible_node(node,
-				"serial", "toshiba,sio-scc")) != NULL) {
+	for_each_compatible_node(node, "serial", "toshiba,sio-scc") {
 		for (i = 0; i < ARRAY_SIZE(txx9_scc_tab); i++) {
 			if (!(txx9_serial_bitmap & (1<<i)))
 				continue;
