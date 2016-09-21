Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfYRd2QvczDshZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 07:58:52 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8LLwTWN072821
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:58:50 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25kqvpq8ww-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:58:50 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 21 Sep 2016 15:58:48 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 052CB3E40044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 15:58:47 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8LLwkKF11993430
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 14:58:46 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB5916E045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 15:58:46 -0600 (MDT)
Received: from oc1376853207.ibm.com (unknown [9.53.92.233])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id AEDC26E041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 15:58:46 -0600 (MDT)
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Resend: [PATCH V7 0/8] powerpc/devtree: Add support for 2 new DRC
 properties
Date: Wed, 21 Sep 2016 16:58:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <c77dcd04-b878-476c-ad49-bf4a6def1116@linux.vnet.ibm.com>
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

"ibm,architecture.vec": Bidirectional communication mechanism between
the host system and the front end processor indicating what features
the host system supports and what features the front end processor will
actually provide.  In this case, we are indicating that the host system
can support the new device tree structures "ibm,drc-info" and
"ibm,dynamic-memory-v2".

[V1: Initial presentation of PAPR 2.7 changes to device tree.]
[V2: Revise constant names.  Fix some syntax errors.  Improve comments.]
[V3: Revise tests for presence of new properties to always scan devicetree
     instead of depending upon architecture vec, due to reboot issues.]
[V4: Rearrange some code changes in patches to better match application,
     and other code cleanup.]
[V5: Resynchronize patches.]
[V6: Resync to latest kernel commit code]
[V7: Correct mail threading]

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



-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
