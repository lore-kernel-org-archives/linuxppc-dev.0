Return-Path: <ivan@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypJpn6WKLzDsG1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 02:58:41 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB1FnLTv056658
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 10:58:39 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ek8wgmg8r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Dec 2017 10:58:38 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ivan@de.ibm.com>;
 Fri, 1 Dec 2017 15:58:36 -0000
From: Ivan Mikhaylov <ivan@de.ibm.com>
To: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 3/4] 44x/fsp2: tvsense workaround for dd1
Date: Fri, 1 Dec 2017 18:58:26 +0300
Message-Id: <20171201155827.57979-3-ivan@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

TVSENSE(temperature and voltage sensors) reset is blocked (clock gated)
by the POR default of the TVS sleep config bit. As a consequence,
TVSENSE will provide erratic sensor values, which may result in
spurious (parity) errors recorded in the CMU FIR and leading to
erroneous interrupt requests once the CMU interrupt is unmasked.
Purpose of this to set up CMU in working state in any cases even
in case of parity errors.

Reviewed-by: Alistair Popple <alistair@popple.id.au>
Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
---
 arch/powerpc/platforms/44x/fsp2.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/44x/fsp2.c b/arch/powerpc/platforms/44x/fsp2.c
index baed409..7c9bc93 100644
--- a/arch/powerpc/platforms/44x/fsp2.c
+++ b/arch/powerpc/platforms/44x/fsp2.c
@@ -59,6 +59,23 @@ static int __init fsp2_probe(void)
 	mtdcr(DCRN_PLB6_HD, 0xffff0000);
 	mtdcr(DCRN_PLB6_SHD, 0xffff0000);
 
+	/* TVSENSE reset is blocked (clock gated) by the POR default of the TVS
+	 * sleep config bit. As a consequence, TVSENSE will provide erratic
+	 * sensor values, which may result in spurious (parity) errors
+	 * recorded in the CMU FIR and leading to erroneous interrupt requests
+	 * once the CMU interrupt is unmasked.
+	 */
+
+	/* 1. set TVS1[UNDOZE] */
+	val = mfcmu(CMUN_TVS1);
+	val |= 0x4;
+	mtcmu(CMUN_TVS1, val);
+
+	/* 2. clear FIR[TVS] and FIR[TVSPAR] */
+	val = mfcmu(CMUN_FIR0);
+	val |= 0x30000000;
+	mtcmu(CMUN_FIR0, val);
+
 	/* L2 machine checks */
 	mtl2(L2PLBMCKEN0, 0xffffffff);
 	mtl2(L2PLBMCKEN1, 0x0000ffff);
-- 
1.7.1
