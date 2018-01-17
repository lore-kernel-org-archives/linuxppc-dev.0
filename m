Return-Path: <srs0=4i2n=em=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLs656LMyzF0W9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 13:50:53 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zLs652C6Vz8tHL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 13:50:53 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zLs644sL4z9s82
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 13:50:52 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0H2nJiK077242
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2018 21:50:49 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fhrf6vagk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2018 21:50:49 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 16 Jan 2018 21:50:48 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] Implement FTW driver
Date: Tue, 16 Jan 2018 18:50:38 -0800
Message-Id: <1516157443-17716-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Virtual Accelerator Switchboard (VAS) subsystem in the POWER9 processor
provides a low latency Core-to-core wakeup" mechanism which allows a thread
on one core the processor to efficiently send a message to a thread waiting
on another core.

This Fast thread-wakeup (FTW) driver provides user space applications an
interface to the Core-to-core wakeup mechanism. The FTW driver uses the
"external" interfaces provided by the VAS driver to interact with the VAS
hardware.

PATCH 5/5 documents the API.

The ftw-next branch on my github has some initial test cases for the
driver:

	https://github.com/sukadev/linux/tree/ftw-next

Thanks to input from Ben Herrenschmidt, Michael Ellerman, Michael
Neuling and Robert Blackmore.

Sukadev Bhattiprolu (5):
  powerpc/vas: Remove a stray line in Makefile
  powerpc/ftw: Define FTW_SETUP ioctl API
  powerpc/ftw: Implement a simple FTW driver
  powerpc/ftw: Add a couple of trace points
  powerpc/ftw: Document FTW API/usage

 Documentation/powerpc/ftw-api.txt       | 283 +++++++++++++++++++++++++
 MAINTAINERS                             |   8 +
 arch/powerpc/platforms/powernv/Makefile |   1 -
 drivers/misc/Kconfig                    |   1 +
 drivers/misc/Makefile                   |   1 +
 drivers/misc/ftw/Kconfig                |  16 ++
 drivers/misc/ftw/Makefile               |   4 +
 drivers/misc/ftw/ftw-trace.h            |  75 +++++++
 drivers/misc/ftw/ftw.c                  | 352 ++++++++++++++++++++++++++++++++
 include/uapi/misc/ftw.h                 |  31 +++
 10 files changed, 771 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/powerpc/ftw-api.txt
 create mode 100644 drivers/misc/ftw/Kconfig
 create mode 100644 drivers/misc/ftw/Makefile
 create mode 100644 drivers/misc/ftw/ftw-trace.h
 create mode 100644 drivers/misc/ftw/ftw.c
 create mode 100644 include/uapi/misc/ftw.h

-- 
2.7.4
