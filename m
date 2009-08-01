Return-Path: <julia@diku.dk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E6A96B7B61
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  1 Aug 2009 18:58:59 +1000 (EST)
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0909DDDDA0
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Aug 2009 18:58:58 +1000 (EST)
Date: Sat, 1 Aug 2009 10:52:51 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: timur@freescale.com, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/10] arch/powerpc/sysdev/qe_lib: introduce missing kfree
Message-ID: <Pine.LNX.4.64.0908011052290.23408@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

Error handling code following a kzalloc should free the allocated data.

The semantic match that finds the problem is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@r exists@
local idexpression x;
statement S;
expression E;
identifier f,f1,l;
position p1,p2;
expression *ptr != NULL;
@@

x@p1 = \(kmalloc\|kzalloc\|kcalloc\)(...);
...
if (x == NULL) S
<... when != x
     when != if (...) { <+...x...+> }
(
x->f1 = E
|
 (x->f1 == NULL || ...)
|
 f(...,x->f1,...)
)
...>
(
 return \(0\|<+...x...+>\|ptr\);
|
 return@p2 ...;
)

@script:python@
p1 << r.p1;
p2 << r.p2;
@@

print "* file: %s kmalloc %s return %s" % (p1[0].file,p1[0].line,p2[0].line)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
---
 arch/powerpc/sysdev/qe_lib/qe_ic.c  |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 074905c..3faa42e 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -339,8 +339,10 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 
 	qe_ic->irqhost = irq_alloc_host(node, IRQ_HOST_MAP_LINEAR,
 					NR_QE_IC_INTS, &qe_ic_host_ops, 0);
-	if (qe_ic->irqhost == NULL)
+	if (qe_ic->irqhost == NULL) {
+		kfree(qe_ic);
 		return;
+	}
 
 	qe_ic->regs = ioremap(res.start, res.end - res.start + 1);
 
@@ -352,6 +354,7 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 
 	if (qe_ic->virq_low == NO_IRQ) {
 		printk(KERN_ERR "Failed to map QE_IC low IRQ\n");
+		kfree(qe_ic);
 		return;
 	}
 
