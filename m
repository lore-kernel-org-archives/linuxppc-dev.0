Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t5rws4BNyzDvSw
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Oct 2016 06:56:29 +1100 (AEDT)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] powerpc/iommu: use permission-specific DEVICE_ATTR
 variants
Date: Sat, 29 Oct 2016 21:37:02 +0200
Message-Id: <1477769829-22230-9-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use DEVICE_ATTR_RW for read-write attributes.  This simplifies the
source code, improves readbility, and reduces the chance of
inconsistencies.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@rw@
declarer name DEVICE_ATTR;
identifier x,x_show,x_store;
@@

DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);

@script:ocaml@
x << rw.x;
x_show << rw.x_show;
x_store << rw.x_store;
@@

if not (x^"_show" = x_show && x^"_store" = x_store)
then Coccilib.include_match false

@@
declarer name DEVICE_ATTR_RW;
identifier rw.x,rw.x_show,rw.x_store;
@@

- DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);
+ DEVICE_ATTR_RW(x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/powerpc/kernel/iommu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 5f202a5..32f18b5 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -127,8 +127,7 @@ static ssize_t fail_iommu_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(fail_iommu, S_IRUGO|S_IWUSR, fail_iommu_show,
-		   fail_iommu_store);
+static DEVICE_ATTR_RW(fail_iommu);
 
 static int fail_iommu_bus_notify(struct notifier_block *nb,
 				 unsigned long action, void *data)
