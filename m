Return-Path: <julia@diku.dk>
From: Julia Lawall <julia@diku.dk>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] arch/powerpc/platforms/83xx/mpc837x_mds.c: Add missing iounmap
Date: Sun, 29 Aug 2010 21:47:18 +0200
Message-Id: <1283111238-3129-1-git-send-email-julia@diku.dk>
Cc: devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function of_iomap returns the result of calling ioremap, so iounmap
should be called on the result in the error handling code, as done in the
normal exit of the function.

The sematic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r exists@
local idexpression x;
expression E,E1;
identifier l;
statement S;
@@

*x = of_iomap(...);
...  when != iounmap(x)
     when != if (...) { ... iounmap(x); ... }
     when != E = x
     when any
(
if (x == NULL) S
|
if (...) {
  ... when != iounmap(x)
      when != if (...) { ... iounmap(x); ... }
(
  return <+...x...+>;
|
*  return ...;
)
}
)
... when != x = E1
    when any
iounmap(x);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/powerpc/platforms/83xx/mpc837x_mds.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index f9751c8..8306832 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -48,8 +48,10 @@ static int mpc837xmds_usb_cfg(void)
 		return -1;
 
 	np = of_find_node_by_name(NULL, "usb");
-	if (!np)
-		return -ENODEV;
+	if (!np) {
+		ret = -ENODEV;
+		goto out;
+	}
 	phy_type = of_get_property(np, "phy_type", NULL);
 	if (phy_type && !strcmp(phy_type, "ulpi")) {
 		clrbits8(bcsr_regs + 12, BCSR12_USB_SER_PIN);
@@ -65,8 +67,9 @@ static int mpc837xmds_usb_cfg(void)
 	}
 
 	of_node_put(np);
+out:
 	iounmap(bcsr_regs);
-	return 0;
+	return ret;
 }
 
 /* ************************************************************************
