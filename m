Return-Path: <srs0=kcoq=cs=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ygdf62LvKzDrLW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 06:13:02 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3ygdf5449wz8t37
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Nov 2017 06:13:01 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3ygdf45zZfz9s7C
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2017 06:13:00 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAKJApa5029033
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2017 14:12:58 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ec3bhmwex-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2017 14:12:57 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 20 Nov 2017 14:12:56 -0500
Date: Mon, 20 Nov 2017 11:12:48 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, hbabu@us.ibm.com,
 Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, kernel-team@fedoraproject.org
Subject: [PATCH] powerpc/vas, export chip_to_vas_id()
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20171120191247.GD17769@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 958f8db089f4b89407fc4b89bccd3eaef585aa96 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Mon, 20 Nov 2017 12:53:15 -0600
Subject: [PATCH 1/1] powerpc/vas, export chip_to_vas_id()

Export the symbol chip_to_vas_id() to fix a build failure when
CONFIG_CRYPTO_DEV_NX_COMPRESS_POWERNV=m.

Reported-by: Haren Myneni <hbabu@us.ibm.com>
Reported-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---

This was broken by the patch https://lkml.org/lkml/2017/11/7/915.

---
 arch/powerpc/platforms/powernv/vas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
index c488621..aebbe95 100644
--- a/arch/powerpc/platforms/powernv/vas.c
+++ b/arch/powerpc/platforms/powernv/vas.c
@@ -135,6 +135,7 @@ int chip_to_vas_id(int chipid)
 	}
 	return -1;
 }
+EXPORT_SYMBOL(chip_to_vas_id);
 
 static int vas_probe(struct platform_device *pdev)
 {
-- 
2.7.4
