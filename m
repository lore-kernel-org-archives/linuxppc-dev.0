Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ypVbf2gL4zDwNS
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Dec 2017 10:19:40 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB1NJYa8032871
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Dec 2017 18:19:36 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ekf1f3fn8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Dec 2017 18:19:35 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 1 Dec 2017 18:19:16 -0500
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>, nfont@linux.vnet.ibm.com
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V6 0/4] powerpc/devtree: Add support for 'ibm,drc-info'
 property
Date: Fri, 1 Dec 2017 17:18:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <ce96da7e-d0cb-db8c-30cf-fa301d97f343@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Several properties in the DRC device tree format are replaced by
more compact representations to allow, for example, for the encoding
of vast amounts of memory, and or reduced duplication of information
in related data structures.

"ibm,drc-info": This property, when present, replaces the following
four properties: "ibm,drc-indexes", "ibm,drc-names", "ibm,drc-types"
and "ibm,drc-power-domains".  This property is defined for all
dynamically reconfigurable platform nodes.  The "ibm,drc-info" elements
are intended to provide a more compact representation, and reduce some
search overhead.

"ibm,architecture.vec": Bidirectional communication mechanism between
the host system and the front end processor indicating what features
the host system supports and what features the front end processor will
actually provide.  In this case, we are indicating that the host system
can support the new device tree structure "ibm,drc-info".

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (4):
  powerpc/firmware: Add definitions for new drc-info firmware feature.
  pseries/drc-info: Search new DRC properties for CPU indexes
  hotplug/drc-info: Add code to search new devtree property
  powerpc: Enable support for new DRC devtree property
---
Changes in V6:
  -- Simplify of_prop_next_u32 invocation
  -- Remove unnecessary WARN_ON() tests
  -- Fix some spacing within expressions
  -- Revise drc_type/drc_name checks in rpaphp_check_drc_props_v2()
