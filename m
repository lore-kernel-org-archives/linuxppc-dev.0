Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXV046DBJzDqH7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 18:03:00 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1S6sTeT076707
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 02:02:58 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28w2hc4gpc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 02:02:58 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 28 Feb 2017 12:32:55 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 444EAE005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 12:34:37 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1S71loU17039486
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 12:31:47 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1S72qU2020651
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 12:32:53 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
 frederic.barrat@fr.ibm.com
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andonnel@au1.ibm.com>, Ian Munsie <ianmunsi@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [RFC 0/3] cxl: Reset freeze counter for the adapter before PERST
Date: Tue, 28 Feb 2017 12:32:19 +0530
Message-Id: <20170228070222.21126-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Presently to flash a cxl adapter with a new FPGA image a warm pcie reset is
requested on the adapter, once the bitstream is loaded to card flash memory.
This issues a pci-fundamental reset to the card slot signaling the card
controller to reconfigure the fpga with the new bitstream. However
pci-fundamental reset of the slot also results in a fenced PHB that raises an
eeh event triggering the core eeh flow.

The core eeh also maintains a counter named freeze_count for each PE inside
struct eeh_pe. The counter is incremented every time an eeh error is reported on
the PE domain and if the counter reaches the threshold limit, the device is
permanently disabled. The threshold limit is enforced by the variable
eeh_max_freeze variable that can be manipulated via debugfs.

This creates problem for cxl adapters as:

* This puts a limit on number of times a fpga image can be re-flashed which is
  by default 5-time/Hour.

* Since after each reset the adapter can potentially acquire a new personality,
  the freeze_count of older fpga image shouldn't be carried over to newer image.

To fix these problems the proposed patch-set introduces a new function named
eeh_pe_reset_freeze_counter that resets freeze counter for the eeh_pe struct.
This function can then be called by the cxl module the cxl module before issuing
pci-fundamental reset to the card slot for loading the new fpga image.

Test Runs
==========
* Without the patchset:

# for i in $(seq 0 6); do echo 1 > /sys/class/cxl/card0/reset; sleep 20; done
bash: /sys/class/cxl/card0/reset: No such file or directory
# dmesg
...
EEH: Fenced PHB#22 detected, location: N/A
EEH: PHB#22-PE#0 has failed 1 times in the last hour
...
EEH: PHB#22-PE#0 has failed 2 times in the last hour
...
EEH: PHB#22-PE#0 has failed 3 times in the last hour
...
EEH: PHB#22-PE#0 has failed 4 times in the last hour
...
EEH: PHB#22-PE#0 has failed 5 times in the last hour
...
EEH: PHB#22-PE#0 has failed 6 times in the last hour
and has been permanently disabled.


* With the patchset:

# for i in $(seq 0 6); do echo 1 > /sys/class/cxl/card0/reset; sleep 20; done
# dmesg
...
cxl-pci 0022:01:00.0: Resetting freeze counters for the PHB
EEH: Fenced PHB#22 detected, location: N/A
EEH: PHB#22-PE#0 has failed 1 times in the last hour
...
cxl-pci 0022:01:00.0: Resetting freeze counters for the PHB
EEH: Fenced PHB#22 detected, location: N/A
EEH: PHB#22-PE#0 has failed 1 times in the last hour
...
cxl-pci 0022:01:00.0: Resetting freeze counters for the PHB
EEH: Fenced PHB#22 detected, location: N/A
EEH: PHB#22-PE#0 has failed 1 times in the last hour
...
cxl-pci 0022:01:00.0: Resetting freeze counters for the PHB
EEH: Fenced PHB#22 detected, location: N/A
EEH: PHB#22-PE#0 has failed 1 times in the last hour
...
cxl-pci 0022:01:00.0: Resetting freeze counters for the PHB
EEH: Fenced PHB#22 detected, location: N/A
EEH: PHB#22-PE#0 has failed 1 times in the last hour
...
cxl-pci 0022:01:00.0: Resetting freeze counters for the PHB
EEH: Fenced PHB#22 detected, location: N/A
EEH: PHB#22-PE#0 has failed 1 times in the last hour

---
Vaibhav Jain (3):
  powerpc/eeh: Refactor eeh_pe_update_time_stamp to update freeze_count
  powerpc/eeh: Introduce function eeh_pe_reset_freeze_counter
  cxl: Reset freeze counters before adapter PERST for flashing new image

 arch/powerpc/include/asm/eeh.h   | 11 ++++++++-
 arch/powerpc/kernel/eeh_driver.c | 20 +++-------------
 arch/powerpc/kernel/eeh_pe.c     | 50 ++++++++++++++++++++++++++--------------
 drivers/misc/cxl/pci.c           | 15 ++++++++++++
 4 files changed, 61 insertions(+), 35 deletions(-)

-- 
2.9.3
