Return-Path: <bauerman@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3tL4CnWzF3RH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:39:54 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8K4dbDS086755
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 00:39:52 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mm3h7jd48-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 00:39:43 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.ibm.com>;
 Thu, 20 Sep 2018 00:39:18 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Ram Pai <linuxram@us.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH] powerpc/pkeys: Fix reading of ibm,
 processor-storage-keys property
Date: Thu, 20 Sep 2018 01:38:58 -0300
Message-Id: <20180920043858.28773-1-bauerman@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

scan_pkey_feature() uses of_property_read_u32_array() to read the
ibm,processor-storage-keys property and calls be32_to_cpu() on the
value it gets. The problem is that of_property_read_u32_array() already
returns the value converted to the CPU byte order.

The value of pkeys_total ends up more or less sane because there's a min()
call in pkey_initialize() which reduces pkeys_total to 32. So in practice
the kernel ignores the fact that the hypervisor reserved one key for
itself (the device tree advertises 31 keys in my test VM).

This is wrong, but the effect in practice is that when a process tries to
allocate the 32nd key, it gets an -EINVAL error instead of -ENOSPC which
would indicate that there aren't any keys available

Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/mm/pkeys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 333b1f80c435..b271b283c785 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -45,7 +45,7 @@ static void scan_pkey_feature(void)
 	 * Since any pkey can be used for data or execute, we will just treat
 	 * all keys as equal and track them as one entity.
 	 */
-	pkeys_total = be32_to_cpu(vals[0]);
+	pkeys_total = vals[0];
 	pkeys_devtree_defined = true;
 }
 
