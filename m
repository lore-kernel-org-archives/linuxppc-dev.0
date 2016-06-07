Return-Path: <anton@au1.ibm.com>
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rP9qT3vT1zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 22:29:24 +1000 (AEST)
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u57CTHPg004253
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jun 2016 08:29:21 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23drc3ufv4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jun 2016 08:29:20 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anton@au1.ibm.com>;
 Tue, 7 Jun 2016 22:29:09 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 53C402BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 22:29:03 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u57CSqkr10748206
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jun 2016 22:28:52 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u57CSlnx031528
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jun 2016 22:28:47 +1000
Date: Tue, 7 Jun 2016 22:28:42 +1000
From: Anton Blanchard <anton@au1.ibm.com>
To: Alexander Graf <agraf@suse.de>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling
 <mikey@neuling.org>, David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH 1/2] Add PowerPC AT_HWCAP2 definitions
In-Reply-To: <20160430104800.0a7c1d11@kryten>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404210928.0d9ae644@kryten>
 <F99A6122-6B6D-45A3-99E2-2F56F143FB50@suse.de>
 <20160430104800.0a7c1d11@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20160607222842.4a745724@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

We need the PPC_FEATURE2_HAS_HTM bit in a subsequent patch, so
add the PowerPC AT_HWCAP2 definitions.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/include/elf.h b/include/elf.h
index 28d448b..8533b2a 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -477,6 +477,19 @@ typedef struct {
 #define PPC_FEATURE_TRUE_LE             0x00000002
 #define PPC_FEATURE_PPC_LE              0x00000001
 
+/* Bits present in AT_HWCAP2 for PowerPC.  */
+
+#define PPC_FEATURE2_ARCH_2_07          0x80000000
+#define PPC_FEATURE2_HAS_HTM            0x40000000
+#define PPC_FEATURE2_HAS_DSCR           0x20000000
+#define PPC_FEATURE2_HAS_EBB            0x10000000
+#define PPC_FEATURE2_HAS_ISEL           0x08000000
+#define PPC_FEATURE2_HAS_TAR            0x04000000
+#define PPC_FEATURE2_HAS_VEC_CRYPTO     0x02000000
+#define PPC_FEATURE2_HTM_NOSC           0x01000000
+#define PPC_FEATURE2_ARCH_3_00          0x00800000
+#define PPC_FEATURE2_HAS_IEEE128        0x00400000
+
 /* Bits present in AT_HWCAP for Sparc.  */
 
 #define HWCAP_SPARC_FLUSH               0x00000001
