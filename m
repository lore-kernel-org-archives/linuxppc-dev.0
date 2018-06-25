Return-Path: <kernelfans@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Dcz12Rq0zF18f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 15:23:39 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id a14-v6so5551946pgw.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 22:23:39 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] drivers/base: bugfix for supplier<-consumer ordering in
 device_kset
Date: Mon, 25 Jun 2018 13:23:04 +0800
Message-Id: <1529904187-18673-1-git-send-email-kernelfans@gmail.com>
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

I tried to fix this issue in pci subsystem, and it turns out to be wrong.
Thanks to Christoph Hellwig, he enlightens me that it should be a bug in
driver core.

To ease the review, I organize the patch as the following
[3/3] reflects the root cause of this bug. if [2/3] is not acceptable,
we still need some way to fix it.
[2/3] introduce a algorithm to reorder device
[1/3] some trivial help routine


Pingfan Liu (3):
  drivers/base: introduce some help routines for reordering a group of
    dev
  drivers/base: reorder consumer and its children behind suppliers
  drivers/base: only reordering consumer device when probing

 drivers/base/base.h |   1 +
 drivers/base/core.c | 135 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c   |   9 +---
 3 files changed, 138 insertions(+), 7 deletions(-)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
-- 
2.7.4
