Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2nCL3CLDzDvjW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 06:58:22 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9OJroEi108373
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 15:58:19 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 269kjvu8p5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 15:58:19 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Mon, 24 Oct 2016 13:58:19 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Subject: [PATCH v5 0/3] powerpc/mm: movable hotplug memory nodes
Date: Mon, 24 Oct 2016 14:58:06 -0500
Message-Id: <1477339089-5455-1-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These changes enable the dynamic creation of movable nodes on power.

On x86, the ACPI SRAT memory affinity structure can mark memory
hotpluggable, allowing the kernel to possibly create movable nodes at
boot.

While power has no analog of this SRAT information, we can still create
a movable memory node, post boot, by hotplugging all of the node's
memory into ZONE_MOVABLE.

In v1, this patchset introduced a new dt compatible id to explicitly
create a memoryless node at boot. Here, things have been simplified to
be applicable regardless of the status of node hotplug on power. We
still intend to enable hotadding a pgdat, but that's now untangled as a
separate topic.

v5:
* Drop the patches which recognize the "status" property of dt memory
  nodes. Firmware can set the size of "linux,usable-memory" to zero instead.

v4:
* http://lkml.kernel.org/r/1475778995-1420-1-git-send-email-arbab@linux.vnet.ibm.com

* Rename of_fdt_is_available() to of_fdt_device_is_available().
  Rename of_flat_dt_is_available() to of_flat_dt_device_is_available().

* Instead of restoring top-down allocation, ensure it never goes
  bottom-up in the first place, by making movable_node arch-specific.

* Use MEMORY_HOTPLUG instead of PPC64 in the mm/Kconfig patch.

v3:
* http://lkml.kernel.org/r/1474828616-16608-1-git-send-email-arbab@linux.vnet.ibm.com

* Use Rob Herring's suggestions to improve the node availability check.

* More verbose commit log in the patch enabling CONFIG_MOVABLE_NODE.

* Add a patch to restore top-down allocation the way x86 does.

v2:
* http://lkml.kernel.org/r/1473883618-14998-1-git-send-email-arbab@linux.vnet.ibm.com

* Use the "status" property of standard dt memory nodes instead of
  introducing a new "ibm,hotplug-aperture" compatible id.

* Remove the patch which explicitly creates a memoryless node. This set
  no longer has any bearing on whether the pgdat is created at boot or
  at the time of memory addition.

v1:
* http://lkml.kernel.org/r/1470680843-28702-1-git-send-email-arbab@linux.vnet.ibm.com

Reza Arbab (3):
  powerpc/mm: allow memory hotplug into a memoryless node
  mm: make processing of movable_node arch-specific
  mm: enable CONFIG_MOVABLE_NODE on non-x86 arches

 arch/powerpc/mm/numa.c | 13 +------------
 arch/x86/mm/numa.c     | 35 ++++++++++++++++++++++++++++++++++-
 mm/Kconfig             |  2 +-
 mm/memory_hotplug.c    | 31 -------------------------------
 4 files changed, 36 insertions(+), 45 deletions(-)

-- 
1.8.3.1
