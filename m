Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405ytR0QNmzF1qL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 05:26:22 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LIOpR9035736
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 14:26:19 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gurspkg05-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 14:26:19 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 14:26:18 -0400
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [RFC v2 0/4] powerpc/drcinfo: Fix bugs 'ibm,drc-info' property
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 21 Mar 2018 13:26:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <9ed45428-fdad-a945-55df-3d47959204fb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set corrects some errors and omissions in the previous
set of patches adding support for the "ibm,drc-info" property to
powerpc systems.

Unfortunately, some errors in the previous patch set break things
in some of the DLPAR operations.  In particular when attempting to
hot-add a new CPU or set of CPUs, the original patch failed to
properly calculate the available resources, and aborted the operation.
In addition, the original set missed several opportunities to compress
and reuse common code, especially, in the area of device processing.

Signed-off-by: Michael W. Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V2:
  -- Update code for v4.16 kernel checkins.
  -- Fix bug with virtual devices.
