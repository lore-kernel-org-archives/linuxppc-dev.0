Return-Path: <weiyj.lk@gmail.com>
MIME-Version: 1.0
Date: Tue, 4 Dec 2012 00:16:18 -0500
Message-ID: <CAPgLHd-bpkWo6PeKrB1VqCiYMxCvphvMbs34Raoh89Wm0ubK-A@mail.gmail.com>
Subject: [PATCH -next] TTY: hvsi: use for_each_compatible_node() macro
From: Wei Yongjun <weiyj.lk@gmail.com>
To: gregkh@linuxfoundation.org, grant.likely@secretlab.ca,
 rob.herring@calxeda.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
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
 drivers/tty/hvc/hvsi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index 5b95b4f..70e0ef7 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -1187,9 +1187,7 @@ static int __init hvsi_console_init(void)
 	hvsi_wait = poll_for_state; /* no irqs yet; must poll */
 
 	/* search device tree for vty nodes */
-	for (vty = of_find_compatible_node(NULL, "serial", "hvterm-protocol");
-			vty != NULL;
-			vty = of_find_compatible_node(vty, "serial", "hvterm-protocol")) {
+	for_each_compatible_node(vty, "serial", "hvterm-protocol") {
 		struct hvsi_struct *hp;
 		const uint32_t *vtermno, *irq;
 
