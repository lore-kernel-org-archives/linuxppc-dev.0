Return-Path: <lucaskt@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp05.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 09D112C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 23:14:00 +1000 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <lucaskt@linux.vnet.ibm.com>;
 Thu, 11 Apr 2013 10:13:53 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 353ED3520066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 09:13:50 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3BDCrqN40960012
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 10:12:53 -0300
Received: from d24av03.br.ibm.com (loopback [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3BBEBep022645
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 08:14:12 -0300
From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Airlie <airlied@linux.ie>
Subject: [PATCHv3 0/2] Speed Cap fixes for ppc64
Date: Thu, 11 Apr 2013 10:13:12 -0300
Message-Id: <1365685994-32603-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Cc: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After all the comments in the last patch series, I did a refactoring of what I was proposing and came up with this. Basically, now:
  1. max_bus_speed is used to set the device to gen2 speeds
  2. on power there's no longer a conflict between the pseries call and other architectures, because the overwrite is done via a ppc_md hook
  3. radeon is using bus->max_bus_speed instead of drm_pcie_get_speed_cap_mask for gen2 capability detection

The first patch consists of some architecture changes, such as adding a hook on powerpc for pci_root_bridge_prepare, so that pseries will initialize it to a function, while all other architectures get a NULL pointer. So that whenever whenever pci_create_root_bus is called, we'll get max_bus_speed properly setup from OpenFirmware.

The second patch consists of simple radeon changes not to call drm_get_pcie_speed_cap_mask anymore. I assume that on x86 machines, the max_bus_speed property will be properly set already.

Lucas Kannebley Tavares (2):
  ppc64: perform proper max_bus_speed detection
  radeon: use max_bus_speed to activate gen2 speeds

 arch/powerpc/include/asm/machdep.h     |    2 +
 arch/powerpc/kernel/pci-common.c       |    8 +++++
 arch/powerpc/platforms/pseries/pci.c   |   51 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c |    4 ++
 drivers/gpu/drm/radeon/evergreen.c     |    9 +----
 drivers/gpu/drm/radeon/r600.c          |    8 +----
 drivers/gpu/drm/radeon/rv770.c         |    8 +----
 7 files changed, 69 insertions(+), 21 deletions(-)

-- 
1.7.4.4
