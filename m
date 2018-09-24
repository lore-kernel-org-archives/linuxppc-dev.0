Return-Path: <bharata@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JVkx4VjZzDrDD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 13:56:53 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8O3rtmC007693
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2018 23:56:51 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mphvbhwes-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Sep 2018 23:56:51 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.ibm.com>;
 Mon, 24 Sep 2018 04:56:50 +0100
From: Bharata B Rao <bharata@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@au1.ibm.com, benh@linux.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 jglisse@redhat.com, linuxram@us.ibm.com,
 Bharata B Rao <bharata@linux.ibm.com>
Subject: [RFC PATCH v0 0/3] KVMPPC HMM driver to manage secure guest pages
Date: Mon, 24 Sep 2018 09:26:38 +0530
Message-Id: <20180924035641.14572-1-bharata@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

A pseries guest can be run as a secure guest on Ultravisor-enabled
POWER platforms. On such platforms, this driver will be used to manage
the movement of guest pages between the normal memory managed by
hypervisor (HV) and secure memory managed by Ultravisor (UV).

This is an early post of HMM driver patches that manage page migration
between normal and secure memory.

Private ZONE_DEVICE memory equal to the amount of secure memory
available in the platform for running secure guests is created
via a HMM device. The movement of pages between normal and secure
memory is done by ->alloc_and_copy() callback routine of migrate_vma().

The page-in or page-out requests from UV will come to HV as hcalls and
HV will call back into UV via uvcalls to satisfy these page requests.

The implementation of uvcall themselves are not present in this post
and will be posted separately.

Regards,
Bharata.

Bharata B Rao (3):
  kvmppc: HMM backend driver to manage pages of secure guest
  kvmppc: H_SVM_INIT_START and H_SVM_INIT_DONE hcalls
  kvmppc: Handle memory plug/unplug to secure VM

 arch/powerpc/include/asm/hvcall.h    |   9 +-
 arch/powerpc/include/asm/kvm_host.h  |  11 +
 arch/powerpc/include/asm/kvm_ppc.h   |  34 ++-
 arch/powerpc/include/asm/ucall-api.h |  31 ++
 arch/powerpc/kvm/Makefile            |   3 +
 arch/powerpc/kvm/book3s.c            |   5 +-
 arch/powerpc/kvm/book3s_hv.c         | 105 ++++++-
 arch/powerpc/kvm/book3s_hv_hmm.c     | 531 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_pr.c         |   3 +-
 arch/powerpc/kvm/powerpc.c           |   2 +-
 10 files changed, 726 insertions(+), 8 deletions(-)
 create mode 100644 arch/powerpc/include/asm/ucall-api.h
 create mode 100644 arch/powerpc/kvm/book3s_hv_hmm.c

-- 
2.14.3
