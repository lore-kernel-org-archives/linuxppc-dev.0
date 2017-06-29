Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyr4s30phzDr1f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 16:54:53 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5T6s0LY079657
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 02:54:51 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bcv371adj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 02:54:50 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Thu, 29 Jun 2017 16:54:46 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5T6shl911600154
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 16:54:43 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5T6sgJd027996
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 16:54:42 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
Cc: dwmw2@infradead.org, stewart@linux.vnet.ibm.com
Subject: [PATCH 4/5] powerpc/powernv: Add OPAL_BUSY to opal_error_code()
Date: Thu, 29 Jun 2017 16:54:12 +1000
In-Reply-To: <20170629065413.19845-1-cyrilbur@gmail.com>
References: <20170629065413.19845-1-cyrilbur@gmail.com>
Message-Id: <20170629065413.19845-5-cyrilbur@gmail.com>
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
