Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sWWB1hRdzF1Rv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:49 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4P35gTl114521
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:47 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j684wcexh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:47 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 25 May 2018 04:11:45 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w4P3Bgtd7274894
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:11:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 441944C058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:03:20 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FF264C046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:03:19 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:03:19 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 5C5DDA0146
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:40 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 00/13] EEH refactoring 2
Date: Fri, 25 May 2018 13:11:27 +1000
Message-Id: <cover.1527217866.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everyone,

Here is a second, somewhat deeper, set of cleanups for the EEH code
(mostly eeh_drver.c).

These changes are not intended to significantly alter the actual processing,
but rather to improve the readability and maintainability of the code. They are
subjective by nature so I would appreciate comments and suggestions.

The earlier changes are mostly to support the last patch, where we're finally
able to use a common infrastructure for the reporting functions (basically
wrappers around the driver's handlers). This allows removal of a fair bit of
code, and the easy addition of some useful messaging which should make future
maintenance easier (as an example, a recent fix in this area "powerpc/eeh: Fix
race with driver un/bind" would have required adding two lines rather than
42+/26-).

Cheers,
Sam.

Patch set changelog follows:

====== v1 -> v2: ======

Patch 1/13: powerpc/eeh: Add eeh_max_freezes to initial EEH log line

Patch 2/13: powerpc/eeh: Add final message for successful recovery

Patch 3/13: powerpc/eeh: Fix use-after-release of EEH driver

Patch 4/13: powerpc/eeh: Remove unused eeh_pcid_name()

Patch 5/13: powerpc/eeh: Strengthen types of eeh traversal functions

Patch 6/13: powerpc/eeh: Add message when PE processing at parent

Patch 7/13: powerpc/eeh: Clean up pci_ers_result handling
* Added the value, and missing newline, to some WARN()s.
* Improved name of merge_result() to pci_ers_merge_result().
* Adjusted the result priorities so that unknown doesn't overlap with _NONE.

Patch 8/13: powerpc/eeh: Introduce eeh_for_each_pe()

Patch 9/13: powerpc/eeh: Introduce eeh_edev_actionable()

Patch 10/13: powerpc/eeh: Introduce eeh_set_channel_state()

Patch 11/13: powerpc/eeh: Introduce eeh_set_irq_state()
* Reorganised eeh_set_irq_state() to reduce nesting depth.

Patch 12/13: powerpc/eeh: Cleaner handling of EEH_DEV_NO_HANDLER

Patch 13/13: powerpc/eeh: Refactor report functions
* Better name for eeh_infoline() and implement using a function.
* Move the core of eeh_pe_report() into a new function to improve readability.
* pci_ers_result_name(): match parameter name to eeh_result_priority(), correct and improve warning message.

====== v1: ======

Patch 1/13: powerpc/eeh: Add eeh_max_freezes to initial EEH log line
Patch 2/13: powerpc/eeh: Add final message for successful recovery
Patch 3/13: powerpc/eeh: Fix use-after-release of EEH driver
Patch 4/13: powerpc/eeh: Remove unused eeh_pcid_name()
Patch 5/13: powerpc/eeh: Strengthen types of eeh traversal functions
Patch 6/13: powerpc/eeh: Add message when PE processing at parent
Patch 7/13: powerpc/eeh: Clean up pci_ers_result handling
Patch 8/13: powerpc/eeh: Introduce eeh_for_each_pe()
Patch 9/13: powerpc/eeh: Introduce eeh_edev_actionable()
Patch 10/13: powerpc/eeh: Introduce eeh_set_channel_state()
Patch 11/13: powerpc/eeh: Introduce eeh_set_irq_state()
Patch 12/13: powerpc/eeh: Cleaner handling of EEH_DEV_NO_HANDLER
Patch 13/13: powerpc/eeh: Refactor report functions

Sam Bobroff (13):
  powerpc/eeh: Add eeh_max_freezes to initial EEH log line
  powerpc/eeh: Add final message for successful recovery
  powerpc/eeh: Fix use-after-release of EEH driver
  powerpc/eeh: Remove unused eeh_pcid_name()
  powerpc/eeh: Strengthen types of eeh traversal functions
  powerpc/eeh: Add message when PE processing at parent
  powerpc/eeh: Clean up pci_ers_result handling
  powerpc/eeh: Introduce eeh_for_each_pe()
  powerpc/eeh: Introduce eeh_edev_actionable()
  powerpc/eeh: Introduce eeh_set_channel_state()
  powerpc/eeh: Introduce eeh_set_irq_state()
  powerpc/eeh: Cleaner handling of EEH_DEV_NO_HANDLER
  powerpc/eeh: Refactor report functions

 arch/powerpc/include/asm/eeh.h   |  11 +-
 arch/powerpc/kernel/eeh.c        |  19 +-
 arch/powerpc/kernel/eeh_driver.c | 493 +++++++++++++++++++++------------------
 arch/powerpc/kernel/eeh_pe.c     |  26 +--
 4 files changed, 294 insertions(+), 255 deletions(-)

-- 
2.16.1.74.g9b0b1f47b
