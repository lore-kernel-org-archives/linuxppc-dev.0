Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5SNm3kdGzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 11:31:36 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6A1SZJM031074
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Jul 2017 21:31:34 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bjux3rmnr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Jul 2017 21:31:33 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Mon, 10 Jul 2017 11:31:31 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6A1VSgA11599908
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 11:31:28 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6A1VR4Z030317
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 11:31:28 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Cc: benh@kernel.crashing.org, stewart@linux.vnet.ibm.com, dwmw2@infradead.org,
 rlippert@google.com, alistair@popple.id.au
Subject: [PATCH v2 09/10] powerpc/powernv: Add OPAL_BUSY to opal_error_code()
Date: Mon, 10 Jul 2017 11:31:05 +1000
In-Reply-To: <20170710013106.27276-1-cyrilbur@gmail.com>
References: <20170710013106.27276-1-cyrilbur@gmail.com>
Message-Id: <20170710013106.27276-10-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 59684b4af4d1..f87e000e7c28 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -930,6 +930,7 @@ int opal_error_code(int rc)
 
 	case OPAL_PARAMETER:		return -EINVAL;
 	case OPAL_ASYNC_COMPLETION:	return -EINPROGRESS;
+	case OPAL_BUSY:
 	case OPAL_BUSY_EVENT:		return -EBUSY;
 	case OPAL_NO_MEM:		return -ENOMEM;
 	case OPAL_PERMISSION:		return -EPERM;
-- 
2.13.2
