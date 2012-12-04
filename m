Return-Path: <weiyj.lk@gmail.com>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1ACFE2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 16:20:33 +1100 (EST)
Received: by mail-qc0-f179.google.com with SMTP id b14so1890416qcs.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2012 21:20:31 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 4 Dec 2012 00:20:31 -0500
Message-ID: <CAPgLHd-4S=mcXuNzs9ULZ7KZ3cs95Z2OevoOZsWt4-G0oFa+cw@mail.gmail.com>
Subject: [PATCH -next] powerpc/82xx: use for_each_compatible_node() macro
From: Wei Yongjun <weiyj.lk@gmail.com>
To: benh@kernel.crashing.org, paulus@samba.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use for_each_compatible_node() macro instead of open coding it.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/powerpc/platforms/82xx/pq2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
index fb94d10..fc8b2d6 100644
--- a/arch/powerpc/platforms/82xx/pq2.c
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -71,11 +71,11 @@ err:
 
 void __init pq2_init_pci(void)
 {
-	struct device_node *np = NULL;
+	struct device_node *np;
 
 	ppc_md.pci_exclude_device = pq2_pci_exclude_device;
 
-	while ((np = of_find_compatible_node(np, NULL, "fsl,pq2-pci")))
+	for_each_compatible_node(np, NULL, "fsl,pq2-pci")
 		pq2_pci_add_bridge(np);
 }
 #endif
