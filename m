Return-Path: <kernelfans@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Dh9Q4ZfjzF18l
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 17:47:54 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id x23-v6so2145646pfn.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 00:47:54 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv2 0/2] drivers/base: bugfix for supplier<-consumer ordering in
 device_kset
Date: Mon, 25 Jun 2018 15:47:37 +0800
Message-Id: <1529912859-10475-1-git-send-email-kernelfans@gmail.com>
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

note: This series has some lock issue, should be fixed in next version

v1 -> v2:
  refragment

Pingfan Liu (2):
  drivers/base: only reordering consumer device when probing
  drivers/base: reorder consumer and its children behind suppliers

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
