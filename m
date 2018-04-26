Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Wnj00sHvzF24b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 16:48:51 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3Q6kAAV081966
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 02:48:49 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hk9sv036w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 02:48:48 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Thu, 26 Apr 2018 00:48:48 -0600
Subject: [PATCH] powerpc: paste - Mask XERSO bit in CR
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Apr 2018 23:48:39 -0700
Mime-Version: 1.0
Message-Id: <1524725319.26204.4.camel@hbabu-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

    
NX can set 3rd bit in CR register for XER[SO] (Summation overflow)
which is not used for paste return value. So. mask this bit to get
proper return status.
    
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
