Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtpCF2q0MzDqjM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 03:16:24 +1000 (AEST)
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Bates <sbates@raithlin.com>, Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 22 Jun 2017 10:48:10 -0600
Message-Id: <20170622164817.25515-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 0/7] cleanup issues with io{read|write}64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Presently, the 64bit IO functions are not very usable in drivers because
they are not universally available in all architectures. This leads to
a bunch of hacks in the kernel to work around this. (See the last 3
patches in this series.) As part of my switchtec_ntb submission which
added another one of these warts, Greg asked me to look into fixing
it[1].

So this patchset attempts to solve this issue by filling in the missing
implementations in iomap.c and io.h. After that, the alpha architecture is
the only one I found that also needed a fix for this. Finally, this
patchset removes the hacks that have accumulated in the kernel,
thus far, for working around this.

This set is based off of v4.12-rc6.

Thanks,

Logan

[1] https://marc.info/?l=linux-kernel&m=149774601910663&w=2

Logan Gunthorpe (7):
  drm/tilcdc: don't use volatile with iowrite64
  iomap: implement ioread64 and iowrite64
  asm-generic/io.h: make ioread64 and iowrite64 universally available
  alpha: provide ioread64 and iowrite64 implementations
  ntb: ntb_hw_intel: remove ioread64 and iowrite64 hacks
  drm/tilcdc: clean up ifdef hacks around iowrite64
  crypto: caam: cleanup CONFIG_64BIT ifdefs when using io{read|write}64

 arch/alpha/include/asm/io.h          |  2 ++
 arch/alpha/kernel/io.c               | 18 +++++++++++
 arch/powerpc/include/asm/io.h        |  2 ++
 drivers/crypto/caam/regs.h           | 29 -----------------
 drivers/gpu/drm/tilcdc/tilcdc_regs.h |  8 +----
 drivers/ntb/hw/intel/ntb_hw_intel.c  | 30 -----------------
 include/asm-generic/io.h             | 54 ++++++++++++++++++++++++-------
 include/asm-generic/iomap.h          |  4 ---
 lib/iomap.c                          | 62 ++++++++++++++++++++++++++++++++++++
 9 files changed, 127 insertions(+), 82 deletions(-)

--
2.11.0
