Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xMJv57BlzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 19:16:15 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4V4TCc9127994
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 00:29:21 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ja9269x68-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 00:29:21 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Thu, 31 May 2018 00:29:21 -0400
Subject: powerpc/powernv: copy/paste - Mask XERS0 bit in CR
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, sukadev@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 30 May 2018 21:29:16 -0700
Mime-Version: 1.0
Message-Id: <1527740956.5945.12.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

    
NX can set 3rd bit in CR register for XER[SO] (Summation overflow)
which is not related to paste request. The current paste function
returns failure for the successful request when this bit is set.
So mask this bit and check the proper return status.

Fixes: 2392c8c8c045 ("powerpc/powernv/vas: Define copy/paste interfaces")
Cc: stable@vger.kernel.org # v4.14+    
Signed-off-by: Haren Myneni <haren@us.ibm.com>

diff --git a/arch/powerpc/platforms/powernv/copy-paste.h b/arch/powerpc/platforms/powernv/copy-paste.h
index c9a5036..82392e3 100644
--- a/arch/powerpc/platforms/powernv/copy-paste.h
+++ b/arch/powerpc/platforms/powernv/copy-paste.h
@@ -9,7 +9,8 @@
 #include <asm/ppc-opcode.h>
 
 #define CR0_SHIFT	28
-#define CR0_MASK	0xF
+#define CR0_MASK	0xE /* 3rd bit undefined or set for XER[SO] */
+
 /*
  * Copy/paste instructions:
  *
