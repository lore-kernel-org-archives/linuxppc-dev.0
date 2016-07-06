Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkqGX5LrnzDqx9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 15:35:32 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u665XbHn091510
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 01:35:30 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 240nm91cnv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 01:35:29 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Wed, 6 Jul 2016 15:35:26 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E73E32CE805D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 15:35:24 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u665ZOfU2032124
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 15:35:24 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u665ZOgK023672
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 15:35:24 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: david@gibson.dropbear.id.au
Cc: anton@au1.ibm.com, mikey@neuling.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/3] spapr: Disable ibm, pa-features HTM bit
Date: Wed,  6 Jul 2016 15:35:21 +1000
In-Reply-To: <cover.1467783317.git.sam.bobroff@au1.ibm.com>
References: <cover.1467695915.git.sam.bobroff@au1.ibm.com>
 <cover.1467783317.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1467783317.git.sam.bobroff@au1.ibm.com>
References: <cover.1467783317.git.sam.bobroff@au1.ibm.com>
Message-Id: <70a13eeab01913de030d9848aaea04a6acea37b4.1467783317.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are a few issues with our handling of the ibm,pa-features
HTM bit:

- We don't support transactional memory in PR KVM, so don't tell
  the OS that we do.

- In full emulation we have a minimal implementation of HTM that always
  fails, so for performance reasons lets not tell the OS that we
  support it either.

- In HV KVM mode, we should mirror the host HTM enabled state by
  checking a KVM capability or looking at the AT_HWCAP2 bit.

For now unconditionally disable it by removing HTM from the
pa-features bits.  It will be re-enabled in a subsequent patch
specifically for HV KVM.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 78ebd9e..704aae7 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -635,7 +635,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
         0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
         0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
     uint8_t *pa_features;
     size_t pa_size;
 
-- 
2.1.0
