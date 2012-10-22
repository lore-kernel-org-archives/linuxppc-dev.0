Return-Path: <benh@kernel.crashing.org>
Message-ID: <1350865950.2476.145.camel@pasglop>
Subject: [PATCH] of/fdt: Don't copy garbage after "/" in root node path
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: devicetree-discuss@lists.ozlabs.org
Date: Mon, 22 Oct 2012 11:32:30 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The root node path must be internally converted to "/", or various
pieces of code looking for it that way will fail. The code to do
that however had a bug where we might incorrectly append pieces
of the original path from the fdt to the "/".

We should probably add a proper dedicated accessor for the root node
but in the meantime this patch should fix it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/of/fdt.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 91a375f..c2b08dc 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -186,6 +186,7 @@ static unsigned long unflatten_dt_node(struct boot_param_header *blob,
 			 */
 			fpsize = 1;
 			allocl = 2;
+			l = 0;
 		} else {
 			/* account for '/' and path size minus terminal 0
 			 * already in 'l'
