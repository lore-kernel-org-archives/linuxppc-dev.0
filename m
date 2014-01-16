Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 99E9F2C0228
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 10:54:11 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 16 Jan 2014 16:54:09 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5B73738C804D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 18:54:07 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0GNs7W04063682
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 23:54:07 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0GNs6Zx015872
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 18:54:06 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/8] powerpc: add hvcalls for 24x7 and gpci (get performance
 counter info)
Date: Thu, 16 Jan 2014 15:53:49 -0800
Message-Id: <1389916434-2288-4-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1389916434-2288-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1389916434-2288-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index d8b600b..48d6efa 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -269,11 +269,15 @@
 #define H_COP			0x304
 #define H_GET_MPP_X		0x314
 #define H_SET_MODE		0x31C
-#define MAX_HCALL_OPCODE	H_SET_MODE
+#define H_GET_24X7_CATALOG_PAGE 0xF078
+#define H_GET_24X7_DATA		0xF07C
+#define H_GET_PERF_COUNTER_INFO 0xF080
+#define MAX_HCALL_OPCODE	H_GET_PERF_COUNTER_INFO
 
 /* Platform specific hcalls, used by KVM */
 #define H_RTAS			0xf000
 
+
 #ifndef __ASSEMBLY__
 
 /**
-- 
1.8.5.2
