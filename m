Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bT6B3jhLzF2RR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:34:57 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w426YBnn082337
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 02:34:55 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hq28yufv6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 02:34:55 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 2 May 2018 07:34:53 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w426Ypjt13697526
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 06:34:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8020742047
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:26:03 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E87642049
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:26:03 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:26:03 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 60788A01B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:34:49 +1000 (AEST)
Date: Wed, 2 May 2018 16:34:48 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/13] EEH refactoring 2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <cover.1525242772.git.sbobroff@linux.ibm.com>
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
 arch/powerpc/kernel/eeh_driver.c | 468 ++++++++++++++++++++-------------------
 arch/powerpc/kernel/eeh_pe.c     |  26 +--
 4 files changed, 268 insertions(+), 256 deletions(-)

-- 
2.16.1.74.g9b0b1f47b
