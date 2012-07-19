Return-Path: <sjenning@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E03602C0108
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 00:46:08 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sjenning@linux.vnet.ibm.com>;
 Thu, 19 Jul 2012 08:45:53 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id EC1313E40055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 14:43:20 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6JEh33o121882
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 08:43:05 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6JEgqV9019957
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 08:42:54 -0600
From: Seth Jennings <sjenning@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/4] powerpc/crypto: IBM Power7+ in-Nest compression support
Date: Thu, 19 Jul 2012 09:42:37 -0500
Message-Id: <1342708961-28587-1-git-send-email-sjenning@linux.vnet.ibm.com>
Cc: Seth Jennings <sjenning@linux.vnet.ibm.com>,
 Kent Yoder <key@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a continuation of support for the Power7+ in-Nest
hardware accelerator.

https://lkml.org/lkml/2012/4/12/223

This patchset adds the hardware driver and the cryptographic
driver for hardware accelerated compression, which uses a
hardware-optimized algorithm named 842.

The hardware driver has limits on generic compression and is
geared toward compressing units that are of PAGE_SIZE for
in-kernel memory compression.

Based on linux-next (20120717)

Seth Jennings (4):
  powerpc: nx: rework Kconfig
  powerpc: nx: add compression support to arch vec
  powerpc: nx: add 842 hardware compression driver
  crypto: add 842 crypto driver

 MAINTAINERS                     |    6 +
 arch/powerpc/kernel/prom_init.c |    4 +-
 crypto/842.c                    |  183 +++++
 crypto/Kconfig                  |    9 +
 crypto/Makefile                 |    1 +
 drivers/crypto/Kconfig          |   20 +-
 drivers/crypto/nx/Kconfig       |   26 +
 drivers/crypto/nx/Makefile      |    5 +-
 drivers/crypto/nx/nx-842.c      | 1615 +++++++++++++++++++++++++++++++++++++++
 include/linux/nx842.h           |   11 +
 10 files changed, 1864 insertions(+), 16 deletions(-)
 create mode 100644 crypto/842.c
 create mode 100644 drivers/crypto/nx/Kconfig
 create mode 100644 drivers/crypto/nx/nx-842.c
 create mode 100644 include/linux/nx842.h

-- 
1.7.9.5
