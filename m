Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zd27W4jxyzF19L
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 15:26:15 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w194PmeY041139
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Feb 2018 23:26:13 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g0yd0uqgk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Feb 2018 23:26:12 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 9 Feb 2018 04:26:10 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@linux.ibm.com>
Subject: [PATCH 0/3] Provide ability to enable PSL traces on card probe
Date: Fri,  9 Feb 2018 09:55:32 +0530
Message-Id: <20180209042535.16845-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch-set updates the cxl adapter probe procedure to selectively enable
PSL-traces at the end of a successful probe for a PSL9 based adapter. This would
let implementors of AFUs that use in-kernel apis to interact with the CXL
adapter get early debug data.

This feature is controlled via a new module parameter named 'enable_psltrace'
which is enabled by default. During adapter probe is this parameter is set
cxl will start PSL-traces on the adapter via PSL_TRACECFG register. The needed
sequence values written to the register was provided by the PSL h/w team.

This patch set is based on an earlier patch titled
"cxl: Remove function write_timebase_ctrl_psl9() for PSL9" available at [1].

Ref: [1] http://patchwork.ozlabs.org/patch/871199/ 
Vaibhav Jain (3):
  cxl: Introduce various enums/defines for PSL9 trace arrays
  cxl: Introduce module parameter 'enable_psltrace'
  cxl: Provide implementation for sl_ops.start_psltrace on PSL9

 drivers/misc/cxl/cxl.h    | 31 ++++++++++++++--
 drivers/misc/cxl/main.c   |  4 +++
 drivers/misc/cxl/native.c |  8 ++---
 drivers/misc/cxl/pci.c    | 91 ++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 119 insertions(+), 15 deletions(-)

-- 
2.14.3
