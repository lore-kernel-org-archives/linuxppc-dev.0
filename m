Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vf7xk1ZcRzDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 22:50:33 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v29BiEnE090054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 06:50:24 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 292gtg1x5w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Mar 2017 06:50:23 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 9 Mar 2017 21:50:21 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v29BoBCl53608526
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 22:50:19 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v29BnlmT012012
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 22:49:47 +1100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com, andrew@aj.id.au, clg@kaod.org,
 maddy@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [RFC 0/2] Add support for OCC inband sensors in P9
Date: Thu,  9 Mar 2017 17:19:13 +0530
Message-Id: <1489060155-22086-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On-Chip-Controller(OCC) is an embedded chip in POWER processors which
maintains the thermal and power safety of the chip. OCC measures
power and temperature sensors and various performance counters to
maintain healthy activity of the chip. In POWER9, OCC copies these
measured sensors periodically to main memory which can be consumend by
the host.

This patch-set provides support to export power and temperature
sensors in OCC inband sensors as standard hwmon sensors.

The skiboot patch for to add device-tree properties for this feature
is posted here:
https://lists.ozlabs.org/pipermail/skiboot/2017-March/006652.html

Shilpasri G Bhat (2):
  powerpc/powernv: Enable support for OCC inband platform sensors
  hwmon: powernv: Hwmon driver for OCC inband power and temperature
    sensors

 .../devicetree/bindings/hwmon/ibmpowernv-occ.txt   |   4 +
 Documentation/hwmon/ibmpowernv-occ                 |  24 ++
 arch/powerpc/include/asm/opal-api.h                |  36 +++
 arch/powerpc/platforms/powernv/Makefile            |   2 +-
 arch/powerpc/platforms/powernv/opal-occ-sensors.c  | 302 +++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c              |   3 +
 drivers/hwmon/Kconfig                              |  11 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/ibmpowernv-occ.c                     | 302 +++++++++++++++++++++
 9 files changed, 684 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ibmpowernv-occ.txt
 create mode 100644 Documentation/hwmon/ibmpowernv-occ
 create mode 100644 arch/powerpc/platforms/powernv/opal-occ-sensors.c
 create mode 100644 drivers/hwmon/ibmpowernv-occ.c

-- 
1.8.3.1
