Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33D5AB6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 31 May 2011 18:01:57 +1000 (EST)
Subject: [PATCH] powerpc/pmac: Don't register pmac PIC syscore ops when HW
	not present
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 31 May 2011 18:01:23 +1000
Message-ID: <1306828883.7481.663.camel@pasglop>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Apple custom PIC only exist in some earlier machine models,
anything with an MPIC will crash on suspend if we register those
syscore ops unconditionally.

This is a regression caused by:

f5a592f7d74e38c5007876c731e6bf5580072e63
PM / PowerPC: Use struct syscore_ops instead of sysdevs for PM

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Linus, can you just pop that in ? I can put it in a git tree tomorrow
if you prefer...

 arch/powerpc/platforms/powermac/pic.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 9089b04..7667db4 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -715,7 +715,8 @@ static struct syscore_ops pmacpic_syscore_ops = {
 
 static int __init init_pmacpic_syscore(void)
 {
-	register_syscore_ops(&pmacpic_syscore_ops);
+	if (pmac_irq_hw[0])
+		register_syscore_ops(&pmacpic_syscore_ops);
 	return 0;
 }
 
