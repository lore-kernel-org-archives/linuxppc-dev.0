Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCTZ645W1zDt24
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 10:44:46 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA7Nif34076168
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 18:44:44 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26jvc4mkk1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 18:44:44 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 16:44:43 -0700
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 devicetree@vger.kernel.org, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] enable movable nodes on non-x86 configs
Date: Mon,  7 Nov 2016 17:44:32 -0600
Message-Id: <1478562276-25539-1-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset allows more configs to make use of movable nodes. When
CONFIG_MOVABLE_NODE is selected, there are two ways to introduce such
nodes into the system:

1. Discover movable nodes at boot. Currently this is only possible on
   x86, but we will enable configs supporting fdt to do the same.

2. Hotplug and online all of a node's memory using online_movable. This
   is already possible on any config supporting memory hotplug, not 
   just x86, but the Kconfig doesn't say so. We will fix that.

We'll also remove some cruft on power which would prevent (2).

/* changelog */

v6:
* Add a patch enabling the fdt to describe hotpluggable memory.

v5:
* http://lkml.kernel.org/r/1477339089-5455-1-git-send-email-arbab@linux.vnet.ibm.com

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

Reza Arbab (4):
  powerpc/mm: allow memory hotplug into a memoryless node
  mm: remove x86-only restriction of movable_node
  mm: enable CONFIG_MOVABLE_NODE on non-x86 arches
  of/fdt: mark hotpluggable memory

 Documentation/kernel-parameters.txt |  2 +-
 arch/powerpc/mm/numa.c              | 13 +------------
 arch/x86/kernel/setup.c             | 24 ++++++++++++++++++++++++
 drivers/of/fdt.c                    |  6 ++++++
 mm/Kconfig                          |  2 +-
 mm/memory_hotplug.c                 | 20 --------------------
 6 files changed, 33 insertions(+), 34 deletions(-)

-- 
1.8.3.1
