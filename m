Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AE78CB7109
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 29 Aug 2010 20:22:02 +1000 (EST)
From: Julia Lawall <julia@diku.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/7] arch/powerpc/platforms/powermac/pfunc_core.c: Add
	of_node_put to avoid memory leak
Date: Sun, 29 Aug 2010 11:52:43 +0200
Message-Id: <1283075566-27441-5-git-send-email-julia@diku.dk>
In-Reply-To: <1283075566-27441-1-git-send-email-julia@diku.dk>
References: <1283075566-27441-1-git-send-email-julia@diku.dk>
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
of_find_node_by_phandle.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r exists@
local idexpression x;
expression E,E1;
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
of_node_put(x);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/powerpc/platforms/powermac/pfunc_core.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pfunc_core.c b/arch/powerpc/platforms/powermac/pfunc_core.c
index cec6359..b0c3777 100644
--- a/arch/powerpc/platforms/powermac/pfunc_core.c
+++ b/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -837,8 +837,10 @@ struct pmf_function *__pmf_find_function(struct device_node *target,
 		return NULL;
  find_it:
 	dev = pmf_find_device(actor);
-	if (dev == NULL)
-		return NULL;
+	if (dev == NULL) {
+		result = NULL;
+		goto out;
+	}
 
 	list_for_each_entry(func, &dev->functions, link) {
 		if (name && strcmp(name, func->name))
@@ -850,8 +852,9 @@ struct pmf_function *__pmf_find_function(struct device_node *target,
 		result = func;
 		break;
 	}
-	of_node_put(actor);
 	pmf_put_device(dev);
+out:
+	of_node_put(actor);
 	return result;
 }
 
