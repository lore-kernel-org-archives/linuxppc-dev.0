Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3XMC3KjbzDvJG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 12:22:47 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9Q1J9a6049279
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 21:22:44 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26abruwbsa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 21:22:44 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 26 Oct 2016 11:22:42 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 649B73578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 12:22:40 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9Q1MeOc18677884
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 12:22:40 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9Q1MdgS027833
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 12:22:40 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, clsoto@us.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v3 0/2] Disable VF's memory space on updating IOV BARs
Date: Wed, 26 Oct 2016 12:15:34 +1100
Message-Id: <1477444536-29612-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves pcibios_sriov_enable() to the point before VF and VF BARs
are enabled on PowerNV platform. Also, pci_update_resource() is used
to update IOV BARs on PowerNV platform, the PF might have been functional
when the function is called. We shouldn't disable PF's memory decoding
at that point. Instead, the VF's memory space should be disabled.

Changelog
=========
v3:
  * Disable VF's memory space when IOV BARs are updated in
    pcibios_sriov_enable().
v2:
  * Added one patch calling pcibios_sriov_enable() before the VF
    and VF BARs are enabled.

Gavin Shan (2):
  PCI: Call pcibios_sriov_enable() before IOV BARs are enabled
  PCI: Disable VF's memory space on updating IOV BAR in
    pci_update_resource()

 drivers/pci/iov.c       | 14 +++++++-------
 drivers/pci/setup-res.c | 28 ++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 15 deletions(-)

-- 
2.1.0
