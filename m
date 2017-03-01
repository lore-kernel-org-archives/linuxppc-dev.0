Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYF7d2vhKzDqL0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 23:27:08 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v21CLxjv013493
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 07:27:06 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28wx69gqya-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Mar 2017 07:27:03 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 1 Mar 2017 17:05:19 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D9E7C125811F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 16:39:12 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v21B7tND11075614
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 16:37:55 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v21B8wee007876
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Mar 2017 16:39:00 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsi@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [RFC v2 0/3] cxl: Reset freeze counter for the adapter before PERST
Date: Wed,  1 Mar 2017 16:38:33 +0530
Message-Id: <20170301110836.11665-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2 changes:
* Moved definition of eeh_pe_reset_freeze_counter() from eeh.h to eeh_pe.c to
  avoid adding a header dependency to 'pci-bridge.h'. The function is now
  marked as an exported gpl symbol.

* Incorporated changes as suggested by Russell Currey:
- Inserted logging for PHB and PE number inside eeh_pe_reset_freeze_counter()
- Suffixed all the function names used in comments/patch-descriptions with '()'
- Removed an un-needed conditional check of '<0' in eeh_handle_normal_event()
- Rephrased the function comment for eeh_pe_update_freeze_counter() and
  eeh_pe_reset_freeze_counter()
- Brace-wrapped a single line statement at end of eeh_pe_update_freeze_counter()

v1:
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
This function can then be called by the cxl module before issuing a
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
  powerpc/eeh: Refactor eeh_pe_update_time_stamp() to update
    freeze_count
  powerpc/eeh: Introduce function eeh_pe_reset_freeze_counter()
  cxl: Reset freeze counters before adapter PERST for flashing new image

 arch/powerpc/include/asm/eeh.h   |  7 ++++-
 arch/powerpc/kernel/eeh_driver.c | 20 ++-----------
 arch/powerpc/kernel/eeh_pe.c     | 64 ++++++++++++++++++++++++++++++----------
 drivers/misc/cxl/pci.c           | 14 +++++++++
 4 files changed, 72 insertions(+), 33 deletions(-)

-- 
2.9.3
