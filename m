Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406Nq50CdPzF1wm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 21:54:56 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2MAsg9C192770
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:54:53 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gv9bqd1fd-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:54:53 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 10:54:52 -0000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linux@roeck-us.net
Cc: linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, stewart@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 0/3] Add support to disable sensor groups in P9
Date: Thu, 22 Mar 2018 16:24:32 +0530
Message-Id: <1521716075-807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series adds support to enable/disable OCC based
inband-sensor groups at runtime. The environmental sensor groups are
managed in HWMON and the remaining platform specific sensor groups are
managed in /sys/firmware/opal.

The firmware changes required for this patch is posted below:
https://lists.ozlabs.org/pipermail/skiboot/2018-March/010812.html

Shilpasri G Bhat (3):
  powernv:opal-sensor-groups: Add support to enable sensor groups
  hwmon: ibmpowernv: Add attributes to enable/disable sensor groups
  powernv: opal-sensor-groups: Add attributes to disable/enable sensors

 .../ABI/testing/sysfs-firmware-opal-sensor-groups  |  34 ++++++
 Documentation/hwmon/ibmpowernv                     |  31 ++++-
 arch/powerpc/include/asm/opal-api.h                |   4 +-
 arch/powerpc/include/asm/opal.h                    |   2 +
 .../powerpc/platforms/powernv/opal-sensor-groups.c | 104 ++++++++++++-----
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   1 +
 drivers/hwmon/ibmpowernv.c                         | 127 +++++++++++++++++++--
 7 files changed, 265 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups

-- 
1.8.3.1
