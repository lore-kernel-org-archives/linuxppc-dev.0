Return-Path: <klebers@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp03.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 84DB62C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 08:43:55 +1000 (EST)
Received: from /spool/local
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <klebers@linux.vnet.ibm.com>;
 Fri, 3 May 2013 19:43:50 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 324FC3520027
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 18:43:47 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r43MghGZ37945538
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 19:42:43 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r43Mhjij007078
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 19:43:46 -0300
From: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Airlie <airlied@linux.ie>,
 Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCHv5 0/2] Speed Cap fixes for ppc64
Date: Fri,  3 May 2013 19:43:11 -0300
Message-Id: <1367620993-27037-1-git-send-email-klebers@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This v5 of the patch series is based on v4 sent by Lucas Kannebley Tavares
with a few changes:

  1. Fix a compilation warning on the code from the first patch, where it was
missing a declaration of struct pci_host_bridge, used on the definition of
the function pointer pcibios_root_bridge_prepare() in
arch/powerpc/include/asm/machdep.h.
  2. Incorporate some changes proposed by Tony Breeds in
pseries_root_bridge_prepare().

The following description of the changes was extrated from v4:

This patch series does:
  1. max_bus_speed is used to set the device to gen2 speeds
  2. on power there's no longer a conflict between the pseries call and other
architectures, because the overwrite is done via a ppc_md hook
  3. radeon is using bus->max_bus_speed instead of drm_pcie_get_speed_cap_mask
for gen2 capability detection

The first patch consists of some architecture changes, such as adding a hook on
powerpc for pci_root_bridge_prepare, so that pseries will initialize it to a
function, while all other architectures get a NULL pointer. So that whenever
pci_create_root_bus is called, we'll get max_bus_speed properly setup from
OpenFirmware.

The second patch consists of simple radeon changes not to call
drm_get_pcie_speed_cap_mask anymore. I assume that on x86 machines,
the max_bus_speed property will be properly set already.

Kleber Sacilotto de Souza (2):
  ppc64: perform proper max_bus_speed detection
  radeon: use max_bus_speed to activate gen2 speeds

 arch/powerpc/include/asm/machdep.h       |    3 ++
 arch/powerpc/kernel/pci-common.c         |    8 ++++
 arch/powerpc/platforms/pseries/pci.c     |   53 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pseries.h |    4 ++
 arch/powerpc/platforms/pseries/setup.c   |    2 +
 drivers/gpu/drm/radeon/evergreen.c       |   10 ++----
 drivers/gpu/drm/radeon/r600.c            |    9 +----
 drivers/gpu/drm/radeon/rv770.c           |    9 +----
 8 files changed, 77 insertions(+), 21 deletions(-)
