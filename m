Return-Path: <xyjxie@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJHjD48tHzDqX1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 23:37:04 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4UDY4HP031869
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:37:02 -0400
Message-Id: <201605301337.u4UDY4HP031869@mx0a-001b2d01.pphosted.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 238k6un6qf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 09:37:02 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xyjxie@linux.vnet.ibm.com>;
 Mon, 30 May 2016 19:06:59 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 755501258065
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 19:09:16 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4UDatqh39845968
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 19:06:55 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4UDalgS004562
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 19:06:54 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joro@8bytes.org, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, alistair@popple.id.au, ruscur@russell.cc,
 kevin.tian@intel.com, David.Laight@ACULAB.COM
Subject: [PATCH v2 1/6] PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
Date: Mon, 30 May 2016 21:32:08 +0800
In-Reply-To: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1464615133-12050-1-git-send-email-xyjxie@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We introduce a new pci_bus_flags, PCI_BUS_FLAGS_MSI_REMAP
which indicates interrupts of all devices on the bus are
managed by the hardware enabling IRQ remapping(intel naming).
When the capability is enabled, a given PCI device can only
shoot the MSIs assigned for it. In other words, the hardware
can protect system from invalid MSIs of the device by checking
the target address and data when there is something wrong
with MSI part in device or device driver.

There is a existing flag for this capability in the IOMMU space:

enum iommu_cap {
	IOMMU_CAP_CACHE_COHERENCY,
--->	IOMMU_CAP_INTR_REMAP,
	IOMMU_CAP_NOEXEC,
};

and Eric also posted a patchset [1] to abstract it on MSI
controller side for ARM. But it would make sense to have a
more common flag like PCI_BUS_FLAGS_MSI_REMAP so that we can
use a universal flag to test this capability on PCI side for
different archs.

With this flag enabled, we can easily know whether it's safe
to expose MSI-X tables of PCI BARs to userspace. Some usespace
drivers such as VFIO may benefit from this.

[1] https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1138820.html

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 include/linux/pci.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 932ec74..4ec37da 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -187,6 +187,7 @@ typedef unsigned short __bitwise pci_bus_flags_t;
 enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_MSI   = (__force pci_bus_flags_t) 1,
 	PCI_BUS_FLAGS_NO_MMRBC = (__force pci_bus_flags_t) 2,
+	PCI_BUS_FLAGS_MSI_REMAP = (__force pci_bus_flags_t) 4,
 };
 
 /* These values come from the PCI Express Spec */
-- 
1.7.9.5
