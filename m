Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A8D502C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 18:36:18 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 15 Nov 2013 17:36:12 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 98EE32BB0056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 18:36:08 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAF7IRIC7799212
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 18:18:27 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAF7a79E002648
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 18:36:07 +1100
Message-ID: <1384500964.2491.11.camel@ThinkPad-T5421>
Subject: [RFC PATCH powerpc] Fix compiling error in powernv/rng.c
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 15 Nov 2013 15:36:04 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is seen when CONFIG_SMP is not enabled:

arch/powerpc/platforms/powernv/rng.c: In function 'rng_init_per_cpu':
arch/powerpc/platforms/powernv/rng.c:74: error: implicit declaration of function 'cpu_to_chip_id'

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/rng.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
index 8844628..04430a7 100644
--- a/arch/powerpc/platforms/powernv/rng.c
+++ b/arch/powerpc/platforms/powernv/rng.c
@@ -59,6 +59,7 @@ int powernv_get_random_long(unsigned long *v)
 }
 EXPORT_SYMBOL_GPL(powernv_get_random_long);
 
+#ifdef CONFIG_SMP
 static __init void rng_init_per_cpu(struct powernv_rng *rng,
 				    struct device_node *dn)
 {
@@ -75,6 +76,13 @@ static __init void rng_init_per_cpu(struct powernv_rng *rng,
 		}
 	}
 }
+#else
+static __init void rng_init_per_cpu(struct powernv_rng *rng,
+				    struct device_node *dn)
+{
+	per_cpu(powernv_rng, 0) = rng;
+}
+#endif
 
 static __init int rng_create(struct device_node *dn)
 {
