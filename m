Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5E5162C0097
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 16:35:01 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Fri, 7 Mar 2014 11:04:59 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 1844CE0044
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 11:08:38 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s275Z09s7471368
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 11:05:00 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s275YuiY027101
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Mar 2014 11:04:56 +0530
Subject: [PATCH 0/2] Enable powernv based platform sensors
To: linuxppc-dev@lists.ozlabs.org
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Fri, 07 Mar 2014 11:03:14 +0530
Message-ID: <20140307053236.3547.55729.stgit@neelegup-tp-t420.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: sbhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset contains the enablement code to expose platform sensor data
on powernv platform. First patch fetches the sensor data from the firmware
and second patch being an hwmon driver, enables the sysfs interfaces.

---

Neelesh Gupta (1):
      powerpc/powernv: Enable fetching of platform sensor data

Shivaprasad G Bhat (1):
      powerpc/powernv: hwmon driver for power values, fan rpm and temperature


 arch/powerpc/include/asm/opal.h                |    4 
 arch/powerpc/platforms/powernv/Makefile        |    2 
 arch/powerpc/platforms/powernv/opal-sensor.c   |   64 +++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 
 drivers/hwmon/Kconfig                          |    8 
 drivers/hwmon/Makefile                         |    1 
 drivers/hwmon/ibmpowernv.c                     |  529 ++++++++++++++++++++++++
 7 files changed, 608 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-sensor.c
 create mode 100644 drivers/hwmon/ibmpowernv.c

-- 
Signature
