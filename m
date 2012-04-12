Return-Path: <key@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 12560B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2012 02:01:44 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Thu, 12 Apr 2012 12:01:42 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A49FA38C803A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 12:01:38 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3CFZhCA286522
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 12:01:38 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3CExJO2026582
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2012 08:59:20 -0600
Message-ID: <1334242825.18090.4.camel@key-ThinkPad-W510>
Subject: [PATCH v3 00/17] Platform Facilities Option and crypto accelerators
From: Kent Yoder <key@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 12 Apr 2012 10:00:25 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: key@linux.vnet.ibm.com, rcj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series adds support for a new device type, the Platform
Facilities Option (PFO).  PFO resources are a set of accelerators that
share some system resources managed by the VIO bus.  This patchset
includes the basic support for the devices in the VIO bus code along
with drivers for the random number generator and the cryptographic
accelerators.

Thanks,
Kent

ChangeLog for v3:
- reorder patches putting nx driver first (Dave Miller)

ChangeLog for v2:
- move crypto driver sysfs stuff to debugfs (Greg K-H)
- Remove CONFIG_ dependencies for the CMO bits (Anton Blanchard)
- move nx driver code to drivers/crypto (Kumar Gala)
- Add inline comment for nx_build_sg_list (Rob Jennings)
- make sure kmalloc'd pointers are aligned (Rob Jennings)
- get rid of bitfields in nx_csbcpb.h (Rob Jennings)
- Compile against Ben Herrenschmidt's ppc device naming patch
- Rebase against latest upstream

Kent Yoder (12):
  powerpc: crypto: nx driver code supporting nx encryption
  powerpc: crypto: AES-CBC mode routines for nx encryption
  powerpc: crypto: AES-CCM mode routines for nx encryption
  powerpc: crypto: AES-CTR mode routines for nx encryption
  powerpc: crypto: AES-ECB mode routines for nx encryption
  powerpc: crypto: AES-GCM mode routines for nx encryption
  powerpc: crypto: AES-XCBC mode routines for nx encryption
  powerpc: crypto: SHA256 hash routines for nx encryption
  powerpc: crypto: SHA512 hash routines for nx encryption
  powerpc: crypto: debugfs routines and docs for the nx device driver
  powerpc: crypto: Build files for the nx device driver
  powerpc: crypto: enable the PFO-based encryption device

Michael Neuling (1):
  hwrng: pseries - PFO-based hwrng driver

Robert Jennings (4):
  powerpc: Add new hvcall constants to support PFO
  powerpc: Add pseries update notifier for OFDT prop changes
  powerpc: Add PFO support to the VIO bus
  pseries: Enabled the PFO-based RNG accelerator

 Documentation/ABI/testing/debugfs-pfo-nx-crypto |   45 ++
 arch/powerpc/Makefile                           |    1 +
 arch/powerpc/include/asm/hvcall.h               |   25 +-
 arch/powerpc/include/asm/pSeries_reconfig.h     |   12 +
 arch/powerpc/include/asm/vio.h                  |   46 ++
 arch/powerpc/kernel/prom_init.c                 |    9 +-
 arch/powerpc/kernel/vio.c                       |  273 ++++++++--
 arch/powerpc/platforms/pseries/reconfig.c       |    7 +
 drivers/char/hw_random/Kconfig                  |   13 +
 drivers/char/hw_random/Makefile                 |    1 +
 drivers/char/hw_random/pseries-rng.c            |   96 +++
 drivers/crypto/Kconfig                          |   17 +
 drivers/crypto/nx/Makefile                      |   11 +
 drivers/crypto/nx/nx-aes-cbc.c                  |  140 +++++
 drivers/crypto/nx/nx-aes-ccm.c                  |  465 +++++++++++++++
 drivers/crypto/nx/nx-aes-ctr.c                  |  177 ++++++
 drivers/crypto/nx/nx-aes-ecb.c                  |  138 +++++
 drivers/crypto/nx/nx-aes-gcm.c                  |  353 +++++++++++
 drivers/crypto/nx/nx-aes-xcbc.c                 |  234 ++++++++
 drivers/crypto/nx/nx-sha256.c                   |  244 ++++++++
 drivers/crypto/nx/nx-sha512.c                   |  263 +++++++++
 drivers/crypto/nx/nx.c                          |  711 +++++++++++++++++++++++
 drivers/crypto/nx/nx.h                          |  192 ++++++
 drivers/crypto/nx/nx_csbcpb.h                   |  205 +++++++
 drivers/crypto/nx/nx_debugfs.c                  |  103 ++++
 25 files changed, 3739 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-pfo-nx-crypto
 create mode 100644 drivers/char/hw_random/pseries-rng.c
 create mode 100644 drivers/crypto/nx/Makefile
 create mode 100644 drivers/crypto/nx/nx-aes-cbc.c
 create mode 100644 drivers/crypto/nx/nx-aes-ccm.c
 create mode 100644 drivers/crypto/nx/nx-aes-ctr.c
 create mode 100644 drivers/crypto/nx/nx-aes-ecb.c
 create mode 100644 drivers/crypto/nx/nx-aes-gcm.c
 create mode 100644 drivers/crypto/nx/nx-aes-xcbc.c
 create mode 100644 drivers/crypto/nx/nx-sha256.c
 create mode 100644 drivers/crypto/nx/nx-sha512.c
 create mode 100644 drivers/crypto/nx/nx.c
 create mode 100644 drivers/crypto/nx/nx.h
 create mode 100644 drivers/crypto/nx/nx_csbcpb.h
 create mode 100644 drivers/crypto/nx/nx_debugfs.c
