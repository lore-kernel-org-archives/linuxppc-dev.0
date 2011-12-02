Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id CF38810094A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2011 03:29:16 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v3 07/10] powerpc/mpic: Don't open-code dcr_resource_start
Date: Fri,  2 Dec 2011 11:28:04 -0500
Message-Id: <1322843287-2745-8-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <1322795058.3729.48.camel@pasglop>
References: <1322795058.3729.48.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <michaele@au1.ibm.com>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Don't open-code the OpenFirmware "dcr-reg" property lookup trying to map
DCR resources.  This makes the code a bit easier to read.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/sysdev/mpic.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 6d42ad1..1e7584b 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -319,11 +319,8 @@ static void _mpic_map_dcr(struct mpic *mpic, struct device_node *node,
 			  struct mpic_reg_bank *rb,
 			  unsigned int offset, unsigned int size)
 {
-	const u32 *dbasep;
-
-	dbasep = of_get_property(node, "dcr-reg", NULL);
-
-	rb->dhost = dcr_map(node, *dbasep + offset, size);
+	phys_addr_t phys_addr = dcr_resource_start(node, 0);
+	rb->dhost = dcr_map(mpic->node, phys_addr + offset, size);
 	BUG_ON(!DCR_MAP_OK(rb->dhost));
 }
 
-- 
1.7.2.5
