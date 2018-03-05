Return-Path: <sam.bobroff@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwH1v1K8RzF15Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 10:59:14 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w25NuRGG015671
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 18:59:13 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ghawvkq59-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Mar 2018 18:59:12 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Mon, 5 Mar 2018 23:59:10 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w25Nx8Wp10747962
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Mar 2018 23:59:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72308AE055
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:49:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FC47AE051
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:49:46 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:49:46 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B0C08A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 10:59:06 +1100 (AEDT)
Date: Tue, 6 Mar 2018 10:59:05 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/9] powerpc/eeh: Fix misleading comment in
 __eeh_addr_cache_get_device()
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
Message-Id: <a08f33ca4af93b1a6ec066b8091953c855d52f45.1520294174.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit "0ba178888b05 powerpc/eeh: Remove reference to PCI device"
removed a call to pci_dev_get() from __eeh_addr_cache_get_device() but
did not update the comment to match.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 arch/powerpc/kernel/eeh_cache.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index d4cc26618809..201943d54a6e 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -84,8 +84,7 @@ static inline struct eeh_dev *__eeh_addr_cache_get_device(unsigned long addr)
  * @addr: mmio (PIO) phys address or i/o port number
  *
  * Given an mmio phys address, or a port number, find a pci device
- * that implements this address.  Be sure to pci_dev_put the device
- * when finished.  I/O port numbers are assumed to be offset
+ * that implements this address.  I/O port numbers are assumed to be offset
  * from zero (that is, they do *not* have pci_io_addr added in).
  * It is safe to call this function within an interrupt.
  */
-- 
2.16.1.74.g9b0b1f47b
