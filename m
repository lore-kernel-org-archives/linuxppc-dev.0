Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4293vr6mjnzF3HQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:52 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8C1IY5j038002
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:51 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2meqcyueqn-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 21:23:50 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 12 Sep 2018 02:23:49 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w8C1NZf067043582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 01:23:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0782B4C040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:27 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9B564C046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:26 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 04:23:26 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A42D7A0123
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 11:23:32 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/14] EEH refactoring 3
Date: Wed, 12 Sep 2018 11:23:19 +1000
MIME-Version: 1.0
Message-Id: <cover.1536715396.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everyone,

Here is another set of minor fixes and cleanups for the EEH code. There should
be no significant changes in behaviour.

I'm not sure if all of these are worth doing, and I don't want to add
unnecessary churn so please comment if you have an opinion or better approach.

The set is based on powerpc next.

Cheers,
Sam

Sam Bobroff (14):
  powerpc/eeh: Fix possible null deref in eeh_dump_dev_log()
  powerpc/eeh: Fix null deref for devices removed during EEH
  powerpc/eeh: Fix use of EEH_PE_KEEP on wrong field
  powerpc/eeh: Cleanup EEH_POSTPONED_PROBE
  powerpc/eeh: Cleanup unused field in eeh_dev
  powerpc/eeh: Cleanup eeh_add_virt_device()
  powerpc/eeh: Cleanup list_head field names
  powerpc/eeh: Cleanup field names in eeh_rmv_data
  powerpc/eeh: Cleanup logic in eeh_rmv_from_parent_pe()
  powerpc/eeh: Cleanup eeh_enabled()
  powerpc/eeh: Cleanup unnecessary eeh_pe_state_mark_with_cfg()
  powerpc/eeh: Cleanup eeh_pe_state_mark()
  powerpc/eeh: Cleanup eeh_ops.wait_state()
  powerpc/eeh: Cleanup control flow in eeh_handle_normal_event()

 arch/powerpc/include/asm/eeh.h               |  24 +-
 arch/powerpc/include/asm/ppc-pci.h           |   1 +
 arch/powerpc/kernel/eeh.c                    |  42 ++--
 arch/powerpc/kernel/eeh_dev.c                |   2 -
 arch/powerpc/kernel/eeh_driver.c             | 237 +++++++++----------
 arch/powerpc/kernel/eeh_pe.c                 | 160 +++++++------
 arch/powerpc/platforms/powernv/eeh-powernv.c |  62 +----
 arch/powerpc/platforms/pseries/eeh_pseries.c |  66 +-----
 arch/powerpc/platforms/pseries/msi.c         |   3 +-
 arch/powerpc/platforms/pseries/pci.c         |   1 +
 drivers/pci/hotplug/pnv_php.c                |   2 +-
 11 files changed, 250 insertions(+), 350 deletions(-)

-- 
2.19.0.2.gcad72f5712
