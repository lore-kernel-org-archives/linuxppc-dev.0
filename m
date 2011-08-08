Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 3A631B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Aug 2011 21:47:26 +1000 (EST)
From: Julia Lawall <julia@diku.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 8/9] arch/powerpc/sysdev/ehv_pic.c: add missing kfree
Date: Mon,  8 Aug 2011 13:18:02 +0200
Message-Id: <1312802283-9107-8-git-send-email-julia@diku.dk>
Cc: kernel-janitors@vger.kernel.org, Ashish Kalra <ashish.kalra@freescale.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

At this point, ehv_pic has been allocated but not stored anywhere, so it
should be freed before leaving the function.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@exists@
local idexpression x;
statement S,S1;
expression E;
identifier fl;
expression *ptr != NULL;
@@

x = \(kmalloc\|kzalloc\|kcalloc\)(...);
...
if (x == NULL) S
<... when != x
     when != if (...) { <+...kfree(x)...+> }
     when any
     when != true x == NULL
x->fl
...>
(
if (x == NULL) S1
|
if (...) { ... when != x
               when forall
(
 return \(0\|<+...x...+>\|ptr\);
|
* return ...;
)
}
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/powerpc/sysdev/ehv_pic.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
index af1a5df..b6731e4 100644
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -280,6 +280,7 @@ void __init ehv_pic_init(void)
 
 	if (!ehv_pic->irqhost) {
 		of_node_put(np);
+		kfree(ehv_pic);
 		return;
 	}
 
