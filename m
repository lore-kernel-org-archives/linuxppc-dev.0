Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400GFJ2qQtzF088
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 22:37:52 +1100 (AEDT)
Received: by mail-io0-x243.google.com with SMTP id e30so11049734ioc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Mar 2018 04:37:52 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, fbarrat@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] misc: use put_device() instead of kfree()
Date: Mon, 12 Mar 2018 17:06:51 +0530
Message-Id: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Arvind Yadav (2):
  [PATCH 1/2] misc: mic: Release reference count and memory for VOP device
  [PATCH 2/2] misc: ocxl: use put_device() instead of device_unregister()

 drivers/misc/mic/bus/vop_bus.c | 6 ++++--
 drivers/misc/ocxl/pci.c        | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
1.9.1
