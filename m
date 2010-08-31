Return-Path: <julia@diku.dk>
From: Julia Lawall <julia@diku.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/4] arch/powerpc/platforms/chrp/nvram.c: Add of_node_put to
	avoid memory leak
Date: Tue, 31 Aug 2010 17:48:58 +0200
Message-Id: <1283269738-14612-5-git-send-email-julia@diku.dk>
In-Reply-To: <1283269738-14612-1-git-send-email-julia@diku.dk>
References: <1283269738-14612-1-git-send-email-julia@diku.dk>
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

Add a call to of_node_put in the error handling code following a call to
of_find_node_by_type.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r exists@
local idexpression x;
expression E,E1,E2;
statement S;
@@

*x = 
(of_find_node_by_path
|of_find_node_by_name
|of_find_node_by_phandle
|of_get_parent
|of_get_next_parent
|of_get_next_child
|of_find_compatible_node
|of_match_node
|of_find_node_by_type
|of_find_node_with_property
|of_find_matching_node
|of_parse_phandle
)(...);
...
if (x == NULL) S
<... when != x = E
*if (...) {
  ... when != of_node_put(x)
      when != if (...) { ... of_node_put(x); ... }
(
  return <+...x...+>;
|
*  return ...;
)
}
...>
(
E2 = x;
|
of_node_put(x);
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/powerpc/platforms/chrp/nvram.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/chrp/nvram.c b/arch/powerpc/platforms/chrp/nvram.c
index ba3588f..d3ceff0 100644
--- a/arch/powerpc/platforms/chrp/nvram.c
+++ b/arch/powerpc/platforms/chrp/nvram.c
@@ -74,8 +74,10 @@ void __init chrp_nvram_init(void)
 		return;
 
 	nbytes_p = of_get_property(nvram, "#bytes", &proplen);
-	if (nbytes_p == NULL || proplen != sizeof(unsigned int))
+	if (nbytes_p == NULL || proplen != sizeof(unsigned int)) {
+		of_node_put(nvram);
 		return;
+	}
 
 	nvram_size = *nbytes_p;
 
