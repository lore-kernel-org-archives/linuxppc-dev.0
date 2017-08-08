Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRPrl4FqrzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 16:39:35 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/9] powerpc/47x: Guard 47x cputable entries with
 CONFIG_PPC_47x
Date: Tue,  8 Aug 2017 16:39:17 +1000
Message-Id: <1502174365-8293-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we build the 47x cputable entries even when CONFIG_PPC_47x is
disabled. That means a kernel built without CONFIG_PPC_47x will claim to
support a 47x CPU and start booting, only to break somewhere later
because it doesn't have 47x support compiled in.

So guard the 47x cputable entries with CONFIG_PPC_47x. Note that this is
inside the #ifdef CONFIG_44x section, because 47x depends on 44x.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/cputable.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6f849832a669..080bf51e0104 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1936,6 +1936,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
+#ifdef CONFIG_PPC_47x
 	{ /* 476 DD2 core */
 		.pvr_mask		= 0xffffffff,
 		.pvr_value		= 0x11a52080,
@@ -1992,6 +1993,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_47x,
 		.platform		= "ppc470",
 	},
+#endif /* CONFIG_PPC_47x */
 	{	/* default match */
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
-- 
2.7.4
