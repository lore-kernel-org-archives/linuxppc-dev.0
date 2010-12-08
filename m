Return-Path: <Deepak_Saxena@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay1.mentorg.com",
	Issuer "Entrust Certification Authority - L1B" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 48B52B70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 07:01:27 +1100 (EST)
Date: Wed, 8 Dec 2010 11:29:03 -0800
From: Deepak Saxena <deepak_saxena@mentor.com>
To: devicetree-discuss@ozlabs.org
Subject: [PATCH 0/5] Hide devices with non-available status from kernel
Message-ID: <20101208192903.GA32473@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: deepak_saxena@mentor.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Device tree nodes can have a "status" property that is currently checked
for in several places in the kernel. This patch set centralizes handling
of the property and simply does not call a driver's probe() function 
if a device is not available. This is of particular use in environments
where we may want to hide certain devices, for example, a multi-core
AMP environment where we are partitioning the system. The patchset
exposes all the devices in the system in /proc as that is a useful
debug tool to have in case the bootloader or user does something wrong.

Deepak Saxena (5):
  of/device: Centralize checking of 'status' properties
  of/device: make for_each_node* check status properties
  of/device: Make of_get_next_child() check status properties
  of/device: Create _of_get_next_child()
  of/device: Show even unavailable nodes in procfs

 arch/powerpc/kernel/pci_of_scan.c         |    2 -
 arch/powerpc/platforms/83xx/suspend.c     |    3 --
 arch/powerpc/platforms/83xx/usb.c         |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |   13 +------
 arch/powerpc/sysdev/fsl_pci.c             |    5 ---
 arch/powerpc/sysdev/ppc4xx_pci.c          |   15 --------
 drivers/mmc/host/sdhci-of-core.c          |    3 --
 drivers/net/gianfar.c                     |    2 +-
 drivers/net/ibm_newemac/core.c            |    2 +-
 drivers/of/base.c                         |   55 +++++++++++++++++++++++++++--
 drivers/of/platform.c                     |    7 +++-
 fs/proc/proc_devtree.c                    |    2 +-
 include/linux/of.h                        |    2 +
 13 files changed, 65 insertions(+), 48 deletions(-)
