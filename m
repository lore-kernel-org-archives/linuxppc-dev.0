Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybhzl5PR9zDqlR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 20:29:39 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAE9TZWn118006
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 04:29:37 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e7un4xnc6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 04:29:36 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 14 Nov 2017 09:29:27 -0000
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v4 0/3] ppc64le: Add REL24 relocation support of livepatch
 symbols
Date: Tue, 14 Nov 2017 04:29:07 -0500
Message-Id: <20171114092910.20399-1-kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset drop the approach of creating new stub type for livepatch
symbols and offloads the issue of handling local function becoming global
to kpatch tool via gcc-plugin.

In function restore_r2(), a check for sibling call is added and also
improves the error message on unexpected op-code.

v4:
 - Drop creation of stubs for livepatch symbols and offload solution
   to kpatch tool.
 - Introduce check for sibling call, when restoring r2 after branch. (Josh)
 - Improve error message in restore_r2(). (Josh)

v3:
 - Defined FUNC_DESC_OFFSET to calculate func_desc offset from
   struct ppc64le_klp_stub_entry.
 - Replaced BUG_ON() with WARN_ON() in klp_stub_for_addr().
 - Major commit message re-write.

v2:
 - Changed klp_stub construction to re-use livepatch_handler and
   additional patch code required for klp_stub, instead of duplicating it.
 - Minor comments and commit body edit.

Josh Poimboeuf (2):
  powerpc/modules: Don't try to restore r2 after a sibling call
  powerpc/modules: Improve restore_r2() error message

Kamalesh Babulal (1):
  kernel/modules: Add REL24 relocation support of livepatch symbols

 arch/powerpc/kernel/module_64.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.9.3
