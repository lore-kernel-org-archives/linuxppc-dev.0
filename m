Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rq7DL5zFvzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:48:34 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D5l2Xi051538
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 01:48:33 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452yp6c9d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 01:48:33 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 13 Jul 2016 15:48:30 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9D9BE2BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:48:28 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6D5mSP220643988
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:48:28 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6D5mRXX004939
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:48:28 +1000
From: alastair@au1.ibm.com
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, herbert@gondor.apana.org.au,
 davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH 0/2] Automatically load the vmx_crypto module if supported
Date: Wed, 13 Jul 2016 15:47:16 +1000
Message-Id: <1468388840-12068-1-git-send-email-alastair@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alastair D'Silva <alastair@d-silva.org>

This series allows the vmx_crypto module to be detected and automatically
loaded via UDEV if the CPU supports the vector crypto feature.

Alastair D'Silva (2):
  powerpc: Add module autoloading based on CPU features
  crypto: vmx - Convert to CPU feature based module autoloading

 arch/powerpc/Kconfig                  |  1 +
 arch/powerpc/include/asm/cpufeature.h | 70 +++++++++++++++++++++++++++++++++++
 drivers/crypto/vmx/Kconfig            |  2 +-
 drivers/crypto/vmx/vmx.c              |  6 +--
 4 files changed, 74 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cpufeature.h

-- 
2.7.4
