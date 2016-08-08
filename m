Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7Qr65YDTzDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 04:27:34 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u78H5ZLE044323
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Aug 2016 14:27:31 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24nb6xn6am-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 14:27:31 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 12:27:30 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] powerpc/mm: movable hotplug memory nodes
Date: Mon,  8 Aug 2016 13:27:19 -0500
Message-Id: <1470680843-28702-1-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These changes enable onlining memory into ZONE_MOVABLE on power, and the
creation of discrete nodes of movable memory.

Node hotplug is not supported on power [1]. The approach taken instead is to
create a memoryless placeholder node for the designated address range at boot.
Hotplug and onlining of the memory are then done in the usual way.

The numa code on power currently prevents hotplugging to a memoryless node.
This limitation has been questioned before [2], and judging by the response,
there doesn't seem to be a reason we can't remove it. No issues have been
found in light testing.

[1] commit 3af229f ("powerpc/numa: Reset node_possible_map to only node_online_map")
[2] http://lkml.kernel.org/r/CAGZKiBrmkSa1yyhbf5hwGxubcjsE5SmkSMY4tpANERMe2UG4bg@mail.gmail.com
    http://lkml.kernel.org/r/20160511215051.GF22115@arbab-laptop.austin.ibm.com

Reza Arbab (4):
  dt-bindings: add doc for ibm,hotplug-aperture
  powerpc/mm: create numa nodes for hotplug memory
  powerpc/mm: allow memory hotplug into a memoryless node
  mm: enable CONFIG_MOVABLE_NODE on powerpc

 .../bindings/powerpc/opal/hotplug-aperture.txt     | 26 ++++++++++++++++++++++
 Documentation/kernel-parameters.txt                |  2 +-
 arch/powerpc/mm/numa.c                             | 23 ++++++++-----------
 mm/Kconfig                                         |  2 +-
 4 files changed, 37 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/opal/hotplug-aperture.txt

-- 
1.8.3.1
