Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E9474DDEBF
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 23:16:25 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l87DGC2l017937
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 09:16:12 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l87DGCgV500166
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 07:16:12 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l87DGBnJ014024
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 07:16:11 -0600
Date: Fri, 7 Sep 2007 08:16:10 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull from 'for-2.6.24' branch of 4xx tree
Message-ID: <20070907081610.6f27d6bf@weaponx.rchland.ibm.com>
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

Please do

git pull \
git://git.infradead.org/users/jwboyer/powerpc.git for-2.6.24

It contains the latest 4xx patches for 2.6.24.  Support for 440EPx and
405GP boards are added, a bugfix for 440EP, and a small cleanup of some
DTS files.

josh

 arch/powerpc/boot/4xx.c                |  108 +++++
 arch/powerpc/boot/4xx.h                |    1 +
 arch/powerpc/boot/Makefile             |    5 +-
 arch/powerpc/boot/cuboot-sequoia.c     |   56 +++
 arch/powerpc/boot/dcr.h                |    5 +
 arch/powerpc/boot/dts/ebony.dts        |    4 -
 arch/powerpc/boot/dts/holly.dts        |    4 -
 arch/powerpc/boot/dts/kuroboxHD.dts    |    3 -
 arch/powerpc/boot/dts/kuroboxHG.dts    |    3 -
 arch/powerpc/boot/dts/prpmc2800.dts    |    4 -
 arch/powerpc/boot/dts/sequoia.dts      |  286 ++++++++++++
 arch/powerpc/boot/dts/walnut.dts       |  183 ++++++++
 arch/powerpc/boot/treeboot-walnut.c    |  131 ++++++
 arch/powerpc/configs/sequoia_defconfig |  776 ++++++++++++++++++++++++++++++++
 arch/powerpc/configs/walnut_defconfig  |  773 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c         |   18 +
 arch/powerpc/kernel/head_44x.S         |    2 +-
 arch/powerpc/platforms/40x/Kconfig     |   14 +-
 arch/powerpc/platforms/40x/Makefile    |    2 +-
 arch/powerpc/platforms/40x/walnut.c    |   68 +++
 arch/powerpc/platforms/44x/Kconfig     |   17 +-
 arch/powerpc/platforms/44x/Makefile    |    1 +
 arch/powerpc/platforms/44x/bamboo.c    |    2 +-
 arch/powerpc/platforms/44x/sequoia.c   |   66 +++
 arch/powerpc/platforms/Kconfig         |    2 +-
 arch/powerpc/platforms/Makefile        |    2 +-
 26 files changed, 2504 insertions(+), 32 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-sequoia.c
 create mode 100644 arch/powerpc/boot/dts/sequoia.dts
 create mode 100644 arch/powerpc/boot/dts/walnut.dts
 create mode 100644 arch/powerpc/boot/treeboot-walnut.c
 create mode 100644 arch/powerpc/configs/sequoia_defconfig
 create mode 100644 arch/powerpc/configs/walnut_defconfig
 create mode 100644 arch/powerpc/platforms/40x/walnut.c
 create mode 100644 arch/powerpc/platforms/44x/sequoia.c

Josh Boyer (6):
      [POWERPC] Remove dtc build cruft from DTS files
      [POWERPC] Fix bus probe on Bamboo board
      [POWERPC] Walnut DTS
      [POWERPC] Walnut defconfig
      [POWERPC] Walnut board support
      [POWERPC] Walnut zImage wrapper

Valentine Barshak (4):
      [POWERPC] PowerPC 440EPx: Sequoia device tree
      [POWERPC] PowerPC 440EPx: Sequoia defconfig
      [POWERPC] PowerPC 440EPx: Sequoia board support
      [POWERPC] PowerPC 440EPx: Sequoia bootwrapper
