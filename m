Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4E25A67C1C
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 18:00:05 +1100 (EST)
Date: Mon, 27 Nov 2006 17:59:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: arnd@arndb.de
Subject: [POWERPC] We should only execute init_spu_base on cell
Message-Id: <20061127175955.a5a668cc.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
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
 arch/powerpc/platforms/cell/spu_base.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

This is enough to make a combined kernel boot on legacy iSeries.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index 841ed35..bd7bffc 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -663,6 +663,9 @@ static int __init init_spu_base(void)
 {
 	int i, ret;
 
+	if (!spu_management_ops)
+		return 0;
+
 	/* create sysdev class for spus */
 	ret = sysdev_class_register(&spu_sysdev_class);
 	if (ret)
-- 
1.4.4
