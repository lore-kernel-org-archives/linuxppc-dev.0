Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfq8z4JRvzDqvj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 03:16:51 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5THEA8K049208
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:16:48 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23v097vr2j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:16:48 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 11:16:47 -0600
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0B3A519D801C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 11:16:22 -0600 (MDT)
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5THGiNY52363352
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 17:16:47 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B271AE03C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:16:44 -0400 (EDT)
Received: from [9.41.92.173] (unknown [9.41.92.173])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id 5705CAE052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 13:16:44 -0400 (EDT)
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: [PATCH v2 0/2] powerpc/pseries: Auto-online hotplugged memory
Date: Wed, 29 Jun 2016 12:16:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <5774027B.6070708@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent updates to the core mm code allow for auto-onlining of added
memory, commit id 31bc3858ea3. This update to the pseries hotplug
memory code takes advantage of this by setting the config option
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y so that we online added memory
by default, this maintains the current functionality, and removes
the code that explicitly onlines added memory.

Additionally the call to memblock_add() is removed, this is already
done in memory_add().

Changes from v1:
- The memhp_auto_online variable is no longer explicitly set.
- The patch is split into two patches
    1/2 - Update to us auto-onlining capabilities
    2/2 - Remove the call to memblock_add


-Nathan
---
 configs/pseries_defconfig          |    1 
 platforms/pseries/hotplug-memory.c |   51 +++++++------------------------------
 2 files changed, 11 insertions(+), 41 deletions(-)
