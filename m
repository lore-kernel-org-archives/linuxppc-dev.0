Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A5E0EDE028
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 17:07:54 +1100 (EST)
Date: Sun, 4 Mar 2007 17:05:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 5/6] [POWERPC] allow xmon to build without
	CONFIG_DEBUG_BUGVERBOSE
Message-Id: <20070304170534.5c1ba10f.sfr@canb.auug.org.au>
In-Reply-To: <20070304170444.2eb423ce.sfr@canb.auug.org.au>
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
	<20070304170241.816f9802.sfr@canb.auug.org.au>
	<20070304170348.511af7cb.sfr@canb.auug.org.au>
	<20070304170444.2eb423ce.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/xmon/xmon.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 0183e5f..450f2d3 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1360,8 +1360,12 @@ static void print_bug_trap(struct pt_regs *regs)
 	if (is_warning_bug(bug))
 		return;
 
+#ifdef CONFIG_DEBUG_BUGVERBOSE
 	printf("kernel BUG at %s:%u!\n",
 	       bug->file, bug->line);
+#else
+	printf("kernel BUG at %p!\n", (void *)bug->bug_addr);
+#endif
 }
 
 void excprint(struct pt_regs *fp)
-- 
1.5.0.1
