Return-Path: <lucaskt@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp05.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 67D622C00F6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 08:55:33 +1000 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <lucaskt@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 19:55:26 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id EBC641DC004E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 18:55:22 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3OMsM2l33882330
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 19:54:22 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3OMtLJR019984
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 19:55:22 -0300
From: lucaskt@linux.vnet.ibm.com
To: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "David Airlie <airlied@linux.ie> Michael Ellerman" <michael@ellerman.id.au>
Subject: [PATCHv4 0/2] Speed Cap fixes for ppc64
Date: Wed, 24 Apr 2013 19:54:48 -0300
Message-Id: <1366844090-5492-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Cc: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jerome Glisse <jglisse@redhat.com>,
 Lucas Kannebley Tavares <lucaskt@vnet.linux.ibm.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Lucas Kannebley Tavares <lucaskt@vnet.linux.ibm.com>

This patch series does:
  1. max_bus_speed is used to set the device to gen2 speeds
  2. on power there's no longer a conflict between the pseries call and other architectures, because the overwrite is done via a ppc_md hook
  3. radeon is using bus->max_bus_speed instead of drm_pcie_get_speed_cap_mask for gen2 capability detection

And I've also added the changes proposed by Michael Ellerman:
  1. Corrected Patch 1's comments
  2. Moved forward function declarations to pseries.h header
  3. Added forward references to struct pci_host_bridge, preventing compilation fails.

The first patch consists of some architecture changes, such as adding a hook on powerpc for pci_root_bridge_prepare, so that pseries will initialize it to a function, while all other architectures get a NULL pointer. So that whenever whenever pci_create_root_bus is called, we'll get max_bus_speed properly setup from OpenFirmware.

The second patch consists of simple radeon changes not to call drm_get_pcie_speed_cap_mask anymore. I assume that on x86 machines, the max_bus_speed property will be properly set already.

Lucas Kannebley Tavares (2):
  ppc64: perform proper max_bus_speed detection
  radeon: use max_bus_speed to activate gen2 speeds

 arch/powerpc/include/asm/machdep.h       |  2 ++
 arch/powerpc/kernel/pci-common.c         |  8 +++++
 arch/powerpc/platforms/pseries/pci.c     | 51 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h |  4 +++
 arch/powerpc/platforms/pseries/setup.c   |  2 ++
 drivers/gpu/drm/radeon/evergreen.c       | 10 ++-----
 drivers/gpu/drm/radeon/r600.c            |  9 ++----
 drivers/gpu/drm/radeon/rv770.c           |  9 ++----
 8 files changed, 74 insertions(+), 21 deletions(-)

-- 
1.8.1.4
