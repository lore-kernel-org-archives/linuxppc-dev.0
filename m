Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 426A4DDDFA
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Dec 2008 07:54:55 +1100 (EST)
Date: Sun, 21 Dec 2008 21:54:45 +0100 (CET)
From: Julia Lawall <julia@diku.dk>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] arch/powerpc/platforms/85xx: Add local_irq_restore in
	error handling code
Message-ID: <Pine.LNX.4.64.0812212154240.3635@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

There is a call to local_irq_restore in the normal exit case, so it would
seem that there should be one on an error return as well.

The semantic patch that makes this change is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
expression l;
expression E,E1,E2;
@@

local_irq_save(l);
... when != local_irq_restore(l)
    when != spin_unlock_irqrestore(E,l)
    when any
    when strict
(
if (...) { ... when != local_irq_restore(l)
               when != spin_unlock_irqrestore(E1,l)
+   local_irq_restore(l);
    return ...;
}
|
if (...)
+   {local_irq_restore(l);
    return ...;
+   }
|
spin_unlock_irqrestore(E2,l);
|
local_irq_restore(l);
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/powerpc/platforms/85xx/smp.c |    1 +
 1 file changed, 1 insertion(+)

diff -u -p a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -58,6 +58,7 @@ smp_85xx_kick_cpu(int nr)
 
 	if (cpu_rel_addr == NULL) {
 		printk(KERN_ERR "No cpu-release-addr for cpu %d\n", nr);
+		local_irq_restore(flags);
 		return;
 	}
 
