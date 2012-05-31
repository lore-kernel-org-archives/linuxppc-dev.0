Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 95419B6FD1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2012 05:52:07 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 31 May 2012 19:46:45 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4VJq4Ux48103542
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2012 05:52:04 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4VJq3Tm018444
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jun 2012 05:52:04 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 anton@samba.org
Subject: [Early RFC 5/6] arch/powerpc: Make KERN_VIRT_SIZE not dependend on
 PGTABLE_RANGE
Date: Fri,  1 Jun 2012 01:20:40 +0530
Message-Id: <1338493841-9926-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1338493841-9926-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1338493841-9926-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

As we keep increasing PGTABLE_RANGE we need not increase the virual
map area for kernel.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index c420561..8af1cf2 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -41,7 +41,7 @@
 #else
 #define KERN_VIRT_START ASM_CONST(0xD000000000000000)
 #endif
-#define KERN_VIRT_SIZE	PGTABLE_RANGE
+#define KERN_VIRT_SIZE	ASM_CONST(0x0000100000000000)
 
 /*
  * The vmalloc space starts at the beginning of that region, and
-- 
1.7.10
