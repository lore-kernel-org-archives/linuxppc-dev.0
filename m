Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C35EEDDE19
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Feb 2008 01:11:19 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1GEBGNN000895
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 09:11:16 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1GEBGK8191082
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 07:11:16 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1GEBFG5003751
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 07:11:16 -0700
Date: Sat, 16 Feb 2008 08:11:01 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull 'for-2.6.25' branch of 4xx tree
Message-ID: <20080216081101.5f343604@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.25

to pick up a few fixes and some defconfig cleanups for .25.  The netdev
patch was Acked by Ben and Jeff asked we take it through the powerpc
tree.

The diffstat is bloated from the defconfig cleanups.  I've also added a
multiplatform defconfig for 44x.  Eventually we might want to remove
the individual board defconfigs all together, but I'd like to leave
them for now.

thx,
josh

Josh Boyer (3):
      [POWERPC] 4xx: Update defconfigs for 2.6.25
      [POWERPC] 44x: Fix Kconfig formatting
      [POWERPC] 44x: Add multiplatform defconfig

Stefan Roese (2):
      [POWERPC] net: NEWEMAC: Remove "rgmii-interface" from rgmii matching table
      [POWERPC] 4xx: Remove "i2c" and "xxmii-interface" device_types from dts

Wolfgang Ocker (1):
      [POWERPC] PPC440EP Interrupt Triggering and Level Settings

 arch/powerpc/boot/dts/bamboo.dts       |    3 -
 arch/powerpc/boot/dts/ebony.dts        |    2 -
 arch/powerpc/boot/dts/katmai.dts       |    2 -
 arch/powerpc/boot/dts/kilauea.dts      |    3 -
 arch/powerpc/boot/dts/makalu.dts       |    3 -
 arch/powerpc/boot/dts/rainier.dts      |    4 -
 arch/powerpc/boot/dts/sequoia.dts      |    4 -
 arch/powerpc/boot/dts/taishan.dts      |    4 -
 arch/powerpc/configs/bamboo_defconfig  |   81 ++-
 arch/powerpc/configs/ebony_defconfig   |   79 ++-
 arch/powerpc/configs/ep405_defconfig   |   92 ++--
 arch/powerpc/configs/kilauea_defconfig |   69 ++-
 arch/powerpc/configs/makalu_defconfig  |   69 ++-
 arch/powerpc/configs/ppc44x_defconfig  |  904 ++++++++++++++++++++++++++++++++
 arch/powerpc/configs/rainier_defconfig |   82 ++-
 arch/powerpc/configs/sequoia_defconfig |   77 ++-
 arch/powerpc/configs/taishan_defconfig |   81 ++-
 arch/powerpc/configs/walnut_defconfig  |   81 ++-
 arch/powerpc/configs/warp_defconfig    |  139 ++++--
 arch/powerpc/platforms/44x/Kconfig     |   10 +-
 arch/ppc/platforms/4xx/ibm440ep.c      |    6 +-
 drivers/net/ibm_newemac/rgmii.c        |    1 -
 22 files changed, 1480 insertions(+), 316 deletions(-)
