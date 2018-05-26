Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40t98Y4sNrzDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2018 14:27:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: greg@kroah.com
Cc: stable@vger.kernel.org,
	tglx@linutronix.de,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.14 v2 03/23] powerpc/powernv: Support firmware
 disable of RFI flush
Date: Sat, 26 May 2018 14:27:29 +1000
Message-Id: <20180526042749.5324-4-mpe@ellerman.id.au>
In-Reply-To: <20180526042749.5324-1-mpe@ellerman.id.au>
References: <20180526042749.5324-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit eb0a2d2620ae431c543963c8c7f08f597366fc60 upstream.

Some versions of firmware will have a setting that can be configured
to disable the RFI flush, add support for it.

Fixes: 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush settings")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 7966a314d93a..37a7f5ef00b7 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -79,6 +79,10 @@ static void pnv_setup_rfi_flush(void)
 		if (np && of_property_read_bool(np, "disabled"))
 			enable--;
 
+		np = of_get_child_by_name(fw_features, "speculation-policy-favor-security");
+		if (np && of_property_read_bool(np, "disabled"))
+			enable = 0;
+
 		of_node_put(np);
 		of_node_put(fw_features);
 	}
-- 
2.14.1
