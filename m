Return-Path: <matsumoto.hiroo@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 68FE9B6F13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 13:14:20 +1000 (EST)
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 by fgwmail8.fujitsu.co.jp (Postfix) with ESMTP id 57ABF17932C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:30:50 +0900 (JST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 821E93EE081
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:30:45 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 68B4F45DD78
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:30:45 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4FDC745DE52
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:30:45 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3B59C1DB803A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:30:45 +0900 (JST)
Received: from m0001.s.css.fujitsu.com (m0001.s.css.fujitsu.com [10.23.4.186])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id ECE411DB803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2012 11:30:44 +0900 (JST)
Message-ID: <4FBC4C86.9050206@jp.fujitsu.com>
Date: Wed, 23 May 2012 11:33:42 +0900
From: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/2] Add pcibios_device_change_notifier
Content-Type: text/plain; charset=ISO-2022-JP
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 jbarnes@virtuousgeek.org, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset is for PCI hotplug.


pcibios_setup_bus_devices which sets DMA and IRQs of PCI device is called
only when boot. DMA setting in probe for PCI driver, like dma_set_mask,
does not work on powerpc platform. So it is need to set DMA and IRQs of
PCI device when hotplug.

1. Moving pcibios_setup_bus_devices code to pcibios_device_change_notifier
   which is registered to bus notifier in pcibios_init.
2. Removing caller and callee of pcibios_setup_bus_devices bus notifier
   works instead of pcibios_setup_bus_devices.
3. Using this bus notifier for microblaze because microblaze/PCI is similer
   with powerpc/PCI.

[PATCH v2 1/2] powerpc/PCI: Add pcibios_device_change_notifier for powerpc
[PATCH v2 2/2] microblaze/PCI: Add pcibios_device_change_notifier for microblaze


Regards.

Hiroo MATSUMOTO
