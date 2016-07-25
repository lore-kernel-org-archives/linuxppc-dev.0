Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rywh32zmHzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 08:21:05 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PMJg11049535
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 18:21:02 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24c4nrntq3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 18:21:02 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 25 Jul 2016 16:21:01 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 64AE419D803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 16:20:33 -0600 (MDT)
To: linuxppc-dev@lists.ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH 0/8] powerpc/devtree: Add support for 2 new DRC properties
Date: Mon, 25 Jul 2016 17:20:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <14a1af8c-d749-b9fa-59f9-61b9451aea77@linux.vnet.ibm.com>
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

"ibm,dynamic-memory-v2": This property replaces the "ibm,dynamic-memory"
node representation within the "ibm,dynamic-reconfiguration-memory"
property provided by the BMC.  This element format is intended to provide
a more compact representation of memory, especially, for systems with
massive amounts of RAM.  To simplify portability, this property is
converted to the "ibm,dynamic-memory" property during system boot.

"ibm,architecture.vec": Bit flags are added to this data structure
by the front end processor to inform the kernel as to whether to expect
the changes to one or both of the device tree structures "ibm,drc-info"
and "ibm,dynamic-memory-v2".

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (8):
  powerpc/firmware: Add definitions for new firmware features.
  powerpc/memory: Parse new memory property to register blocks.
  powerpc/memory: Parse new memory property to initialize structures.
  pseries/hotplug init: Convert new DRC memory property for hotplug runtime
  pseries/drc-info: Search new DRC properties for CPU indexes
  hotplug/drc-info: Add code to search new devtree properties
  powerpc: Check arch.vec earlier during boot for memory features
  powerpc: Enable support for new DRC devtree properties
