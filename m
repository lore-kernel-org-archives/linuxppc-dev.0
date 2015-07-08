Return-Path: <vipin@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A99911A19AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 21:07:23 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Wed, 8 Jul 2015 21:07:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 843E12BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 21:07:11 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t68B73Ab196980
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2015 21:07:11 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t68B6cTP015535
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jul 2015 21:06:38 +1000
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, joel@jms.id.au, stewart@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: [PATCH v9] powerpc/powernv: Add poweroff (EPOW,
 DPO) events support for PowerNV platform
Date: Wed,  8 Jul 2015 16:36:00 +0530
Message-Id: <1436353561-19466-1-git-send-email-vipin@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for OPAL EPOW (Environmental and Power Warnings)
and DPO (Delayed Power Off) events for the PowerNV platform. These events
are generated on FSP (Flexible Service Processor) based systems. EPOW
events are generated due to various critical system conditions that
require system shutdown. A few examples of these conditions are high
ambient temperature or system running on UPS power with low UPS battery.
DPO event is generated in response to admin initiated system shutdown
request. Upon receipt of EPOW and DPO events the host kernel invokes
orderly_poweroff() for performing graceful system shutdown.

Changes in v9:
 - Edited commit log for EPOW acronym expansion and reviewers list.

Changes in v8:
 - Added logic to filter events which doesn't require system shutdown
   for EPOW scenario.
 - Re-phrased patch description.

Changes in v7:
 - Fixed logic to check epow support to avoid EPOW, DPO handling path
   for BMC systems.

Changes in v6:
 - Made below changes as suggested by Michael Ellerman on previous patch.
 - Changed EPOW, DPO notifier blocks to use opal_power_control_event()
   and enhanced opal_power_control_event() to handle EPOW and DPO events.
 - Reorganized code and added/changed few variable, function names removing
   older ones.
 - Minor cleanup like removing unused headers, blank lines etc.

Changes in v5:
 - Made changes to address review comments on previous patch.

Changes in v4:
 - Made changes to address review comments on previous patch.

Changes in v3:
 - Made changes to immediately call orderly_poweroff upon receipt of
   OPAL EPOW, DPO notifications.
 - Made code changes to address review comments on previous patch.
 - Made code changes to use existing OPAL EPOW API.
 - Removed patch to extract EPOW event timeout from OPAL device-tree.

Changes in v2:
 - Made code changes to improve code as per previous review comments.
 - Added patch to obtain EPOW event timeout values from OPAL device-tree.

Vipin K Parashar (1):
  powerpc/powernv: Add poweroff (EPOW, DPO) events support for PowerNV
    platform

 arch/powerpc/include/asm/opal-api.h            |  40 +++++++
 arch/powerpc/include/asm/opal.h                |   3 +-
 arch/powerpc/platforms/powernv/opal-power.c    | 147 ++++++++++++++++++++++---
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 4 files changed, 173 insertions(+), 18 deletions(-)

-- 
1.9.3
