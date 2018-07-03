Return-Path: <kernelfans@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KZXh0jpJzF1LM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 16:51:31 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id w8-v6so541811ply.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 23:51:31 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer ordering in
 device_kset
Date: Tue,  3 Jul 2018 14:50:38 +0800
Message-Id: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 52cdbdd49853 ("driver core: correct device's shutdown order")
places an assumption of supplier<-consumer order on the process of probe.
But it turns out to break down the parent <- child order in some scene.
E.g in pci, a bridge is enabled by pci core, and behind it, the devices
have been probed. Then comes the bridge's module, which enables extra
feature(such as hotplug) on this bridge.
This will break the parent<-children order and cause failure when
"kexec -e" in some scenario.

v2 -> v3:
It is a little hard to impose both "parent<-child" and "supplier<-consumer"
on devices_kset. Hence v3 drops this method, postpones the issue to shutdown
time instead of probing, and utilizes device-tree info during shutdown
instead of the item's seq inside devices_kset.

Pingfan Liu (4):
  drivers/base: fold the routine of device's shutdown into a func
  drivers/base: utilize device tree info to shutdown devices
  drivers/base: clean up the usage of devices_kset_move_last()
  Revert "driver core: correct device's shutdown order"

 drivers/base/base.h    |   1 -
 drivers/base/core.c    | 196 +++++++++++++++++++++++--------------------------
 drivers/base/dd.c      |   8 --
 include/linux/device.h |   1 +
 4 files changed, 92 insertions(+), 114 deletions(-)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org

-- 
2.7.4
