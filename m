Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r1WT1z38zDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 02:36:53 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4MGXjZG048433
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 12:36:50 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j4mhf04js-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 12:36:50 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 22 May 2018 10:36:49 -0600
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC v4 0/4] powerpc/drcinfo: Fix bugs 'ibm,drc-info' property
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 May 2018 11:36:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <47581596-1d6e-a1a9-9490-5b5ff0f5304f@linux.vnet.ibm.com>
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
Changes in V4:
  -- Update code for latest kernel checkins.
  -- Fix bug with virtual devices.
  -- Rebase on top of 4.17-rc5 kernel
  -- Simplify parser code for "ibm,drc-info" property
