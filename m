Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425DWS48wGzF3Fw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 05:37:56 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id c190-v6so15917846oig.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 12:37:56 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/21] powerpc: 4xx: get cpu node with of_get_cpu_node
Date: Wed,  5 Sep 2018 14:37:29 -0500
Message-Id: <20180905193738.19325-13-robh@kernel.org>
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"device_type" use is deprecated for FDT though it has continued to be used
for nodes like cpu nodes. Use of_get_cpu_node() instead which works using
node names by default. This will allow the eventually removal of cpu
device_type properties.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/powerpc/platforms/4xx/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/4xx/soc.c b/arch/powerpc/platforms/4xx/soc.c
index 5e36508b2a70..1844bf502fcf 100644
--- a/arch/powerpc/platforms/4xx/soc.c
+++ b/arch/powerpc/platforms/4xx/soc.c
@@ -200,7 +200,7 @@ void ppc4xx_reset_system(char *cmd)
 	u32 reset_type = DBCR0_RST_SYSTEM;
 	const u32 *prop;

-	np = of_find_node_by_type(NULL, "cpu");
+	np = of_get_cpu_node(0, NULL);
 	if (np) {
 		prop = of_get_property(np, "reset-type", NULL);

--
2.17.1
