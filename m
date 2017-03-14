Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj1Qc5ptLzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 15:07:04 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2E3xHCi028533
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 00:06:51 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2955muc5mb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 00:06:51 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 14 Mar 2017 09:36:48 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2E45YrQ11730962
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 09:35:34 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2E46htJ016056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 09:36:44 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: [PATCH 0/3] cxl: Provide user-space r/o access to the AFU descriptor
Date: Tue, 14 Mar 2017 09:36:03 +0530
Message-Id: <20170314040606.16894-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patch-set provides a fix for libcxl github issue#20 
"libcxl doesn't handle a mmio read of 0xfffffff... (all 1's) correctly" at
https://github.com/ibm-capi/libcxl/issues/20.

The issue arises as libcxl uses mmio read values from problem-state-area(PSA) to
determine if the card had fenced or not. When it reads a value of 0xFFs (all 1)
it assumes that the card has fenced and returns an error for the mmio read.
Unfortunately 0xFFs can be a valid value in PSA of some some AFUs and in such
cases libcxl incorrectly assumes the card to be fenced and indicate and error to
the caller.

To fix this issue, the patch-set provides direct and read-only access of the afu
descriptor to libcxl via a binary sysfs attribute named 'afu_desc'. Libcxl can
mmap this attribute to process address space and if an mmio read returns 0xFFs
it tries reading contents of afu_desc at an offset whose contents != ~0x0ULL. If
the card is fenced read of the same offset will have contents == ~0x0ULL in
which case libcxl can indicate an error to the caller about the fenced card else
the read of 0xFFs is a valid read.


There are three patchset in this series:

- First patch refactors the function cxl_pci_afu_err_buffer() and moves its
  implementation to 'native.c'. It also moves the core logic of the function
  to a new function __aligned_memcpy().

- Second patch introduces a new sysfs attribute named afu_desc to be used by
  libcxl to read raw contents of afu descriptor.

- Third patch provides native implementations for new cxl backend-ops introduced
  in the previous patch. Most importantly it implements the afu_desc_mmap 
  backend-op thats mmaps the afu descriptor to a given vma.

Additional related changes apart from this patch-set:

- Corresponding libcxl changes are posted as a pull request#25 
  "libcxl: Check afu link when read from PSA mmio return all FFs" at
  https://github.com/ibm-capi/libcxl/pull/25

- Patch "kernfs: Check KERNFS_HAS_RELEASE before calling kernfs_release_file()"
  which fixes a kernel oops occurring while removing a bin_attribute from sysfs
  at https://patchwork.ozlabs.org/patch/738536/.

Vaibhav Jain (3):
  cxl: Re-factor cxl_pci_afu_read_err_buffer()
  cxl: Introduce afu_desc sysfs attribute
  cxl: Provide user-space access to afu descriptor on bare metal

 Documentation/ABI/testing/sysfs-class-cxl |  9 ++++
 drivers/misc/cxl/cxl.h                    | 15 ++++--
 drivers/misc/cxl/native.c                 | 89 ++++++++++++++++++++++++++++++-
 drivers/misc/cxl/pci.c                    | 47 ++--------------
 drivers/misc/cxl/sysfs.c                  | 45 ++++++++++++++++
 5 files changed, 157 insertions(+), 48 deletions(-)

-- 
2.9.3
