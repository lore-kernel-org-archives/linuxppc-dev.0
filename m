Return-Path: <pfsmorigo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vT4r63vG1zDqD0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 04:59:18 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1MHs5d4142275
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 12:59:16 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28sb1nxh1k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 12:59:15 -0500
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pfsmorigo@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 14:59:13 -0300
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 7A63A1DC007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 12:59:12 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1MHxBEj36044812
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 14:59:11 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1MHx95s011761
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 14:59:10 -0300
From: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 herbert@gondor.apana.org.au, davem@davemloft.net,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Subject: [PATCH 0/2] crypto: vmx - fix vmx failures by changing fallback to
 skcipher
Date: Wed, 22 Feb 2017 14:58:20 -0300
Message-Id: <20170222175822.24040-1-pfsmorigo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, neither cbc or xts are working with upstream kernel due to a failure
in the fallback allocation. This can be fixed by changing the fallback to
skcipher.

Paulo Flabiano Smorigo (2):
  crypto: vmx - Use skcipher for cbc fallback
  crypto: vmx - Use skcipher for xts fallback

 drivers/crypto/vmx/aes_cbc.c | 41 ++++++++++++++++++++---------------------
 drivers/crypto/vmx/aes_xts.c | 32 ++++++++++++++++++--------------
 2 files changed, 38 insertions(+), 35 deletions(-)

-- 
2.9.3
