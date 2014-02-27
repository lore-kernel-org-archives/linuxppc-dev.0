Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 76B772C008F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 08:31:38 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 14:31:36 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id BF6876E8041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 16:31:29 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1RLVYnI7405860
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 21:31:34 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1RLVX1Y030845
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 16:31:34 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>, Alexander Graf <agraf@suse.de>,
 Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 04/11] powerpc: add hvcalls for 24x7 and gpci (get
 performance counter info)
Date: Thu, 27 Feb 2014 13:04:57 -0800
Message-Id: <1393535105-7528-5-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1393535105-7528-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1393535105-7528-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: scottwood@freescale.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
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
 arch/powerpc/include/asm/hvcall.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index d8b600b..5dbbb29 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -274,6 +274,11 @@
 /* Platform specific hcalls, used by KVM */
 #define H_RTAS			0xf000
 
+/* "Platform specific hcalls", provided by PHYP */
+#define H_GET_24X7_CATALOG_PAGE	0xF078
+#define H_GET_24X7_DATA		0xF07C
+#define H_GET_PERF_COUNTER_INFO	0xF080
+
 #ifndef __ASSEMBLY__
 
 /**
-- 
1.9.0
