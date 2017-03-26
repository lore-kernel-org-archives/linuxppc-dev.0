Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vrgpf74yDzDqZS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 02:20:58 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2QFIWZD138192
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Mar 2017 11:20:57 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29dmhv07wt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Mar 2017 11:20:56 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sun, 26 Mar 2017 09:20:56 -0600
Subject: [PATCH 4/4] To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: ltc-virtual-io@lists.linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Date: Sun, 26 Mar 2017 10:20:51 -0500
In-Reply-To: <149054150088.117828.8160636606733671116.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <149054150088.117828.8160636606733671116.stgit@powerkvm6.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149054164652.117828.10008153000699767224.stgit@powerkvm6.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cc: nfont@linux.vnet.ibm.com
Subject: [PATCH 4/4] powerpc: Enable support for new drc-info DRC devtree property

prom_init.c: Enable support for new DRC device tree property
"ibm,drc-info" in initial handshake between the Linux kernel and
the front end processor.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 1c1b44e..102b1a1 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -869,6 +869,7 @@ struct ibm_arch_vec __cacheline_aligned ibm_architecture_vec = {
 		.mmu = 0,
 		.hash_ext = 0,
 		.radix_ext = 0,
+		.byte22 = OV5_FEAT(OV5_DRC_INFO),
 	},
 
 	/* option vector 6: IBM PAPR hints */
