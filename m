Return-Path: <bharata@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zChfY6lhgzF0PR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 22:05:41 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 w05B55bW121280
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jan 2018 06:05:38 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fa5a1q7jk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jan 2018 06:05:37 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Fri, 5 Jan 2018 11:05:35 -0000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 mpe@ellerman.id.au, david@gibson.dropbear.id.au, anton@samba.org,
 Bharata B Rao <bharata@linux.vnet.ibm.com>
Subject: [RFC FIX v1 0/2] powerpc: Fix memory unplug failure for radix guests
Date: Fri,  5 Jan 2018 16:35:19 +0530
Message-Id: <1515150321-24894-1-git-send-email-bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an RFC patchset to fix the call trace observed during memory
unplug for radix guests. The problem and the fix is described in patch 2/2.

The ideal fix for this is to break the bigger radix mapping into smaller
mappings during memory hot removal, but in the meanwhile I am just posting
an alternate and easier solution which of course, has its own
limitations (mentioned in 2/2)

Changes in v1:
--------------
- Move mmu-early-init-devtree() ahead of scanning memory DT nodes
  so that we know if the guest is radix or not when scanning
  memory nodes.
- Make the marking of hotpluggable only if the guest is radix.

v0: http://patchwork.ozlabs.org/patch/800142/

Bharata B Rao (2):
  powerpc: Discover radix availability before scanning the memory nodes
  powerpc: Fix memory unplug failure on radix guest

 arch/powerpc/kernel/prom.c      |  6 ++++--
 arch/powerpc/mm/pgtable-radix.c | 17 ++++++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.7.4
