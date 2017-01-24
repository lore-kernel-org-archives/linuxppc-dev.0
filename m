Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7JTn533ZzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 06:41:49 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0OJNqwN137851
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 14:41:46 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2868vfmsrf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 14:41:46 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 24 Jan 2017 12:41:45 -0700
Subject: Re: [PATCH V9 0/8] powerpc/devtree: Add support for 2 new DRC
 properties
To: linuxppc-dev@lists.ozlabs.orgltc-virtual-io,
 ltc-virtual-io@lists.linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 ""@lists.linux.ibm.com
References: <148109469581.193207.1684012254014049364.stgit@powerkvm6.aus.stglabs.ibm.com>
Cc: nfont@linux.vnet.ibm.com
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Tue, 24 Jan 2017 13:41:41 -0600
MIME-Version: 1.0
In-Reply-To: <148109469581.193207.1684012254014049364.stgit@powerkvm6.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <8cb08b2f-141f-01df-1330-e1b3b5ae588c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ping

On 12/07/2016 01:13 AM, Michael Bringmann wrote:
> Several properties in the DRC device tree format are replaced by
> more compact representations to allow, for example, for the encoding
> of vast amounts of memory, and or reduced duplication of information
> in related data structures.
> 
> "ibm,drc-info": This property, when present, replaces the following
> four properties: "ibm,drc-indexes", "ibm,drc-names", "ibm,drc-types"
> and "ibm,drc-power-domains".  This property is defined for all
> dynamically reconfigurable platform nodes.  The "ibm,drc-info" elements
> are intended to provide a more compact representation, and reduce some
> search overhead.
> 
> "ibm,dynamic-memory-v2": This property replaces the "ibm,dynamic-memory"
> node representation within the "ibm,dynamic-reconfiguration-memory"
> property provided by the BMC.  This element format is intended to provide
> a more compact representation of memory, especially, for systems with
> massive amounts of RAM.  To simplify portability, this property is
> converted to the "ibm,dynamic-memory" property during system boot.
> 
> "ibm,architecture.vec": Bidirectional communication mechanism between
> the host system and the front end processor indicating what features
> the host system supports and what features the front end processor will
> actually provide.  In this case, we are indicating that the host system
> can support the new device tree structures "ibm,drc-info" and
> "ibm,dynamic-memory-v2".
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> 
> Michael Bringmann (8):
>   powerpc/firmware: Add definitions for new firmware features.
>   powerpc/memory: Parse new memory property to register blocks.
>   powerpc/memory: Parse new memory property to initialize structures.
>   pseries/hotplug init: Convert new DRC memory property for hotplug runtime
>   pseries/drc-info: Search new DRC properties for CPU indexes
>   hotplug/drc-info: Add code to search new devtree properties
>   powerpc: Check arch.vec earlier during boot for memory features
>   powerpc: Enable support for new DRC devtree properties
> ---
> Changes in V9:
>   -- Various code cleanup measures
> 
>  arch/powerpc/include/asm/firmware.h             |    5 -
>  arch/powerpc/include/asm/prom.h                 |   38 ++++
>  arch/powerpc/kernel/prom.c                      |  103 ++++++++++--
>  arch/powerpc/kernel/prom_init.c                 |    3 
>  arch/powerpc/mm/numa.c                          |  168 ++++++++++++++++---
>  arch/powerpc/platforms/pseries/firmware.c       |    2 
>  arch/powerpc/platforms/pseries/pseries_energy.c |  202 ++++++++++++++++++++---
>  drivers/pci/hotplug/rpadlpar_core.c             |   13 +
>  drivers/pci/hotplug/rpaphp.h                    |    4 
>  drivers/pci/hotplug/rpaphp_core.c               |  108 +++++++++---
>  10 files changed, 543 insertions(+), 103 deletions(-)
> 
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
