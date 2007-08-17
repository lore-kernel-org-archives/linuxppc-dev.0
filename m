Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 690F5DDDE7
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 23:46:31 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7HDkRtA026523
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 09:46:27 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7HDkPgc269058
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 07:46:26 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7HDkPNP000740
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 07:46:25 -0600
Date: Fri, 17 Aug 2007 08:46:23 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull from 'for-2.6.24' branch
Message-ID: <20070817084623.3e9835d0@weaponx.rchland.ibm.com>
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

Please pull from the 'for-2.6.24' branch of

	git://git.infradead.org/~jwboyer/powerpc.git for-2.6.24

It contains the patches sent in

http://ozlabs.org/pipermail/linuxppc-dev/2007-August/040512.html

rebased on top of your for-2.6.24 branch with the acks from David
included in the commits. Diffstat and shortlog below.

josh

 arch/powerpc/Makefile                          |    2 +-
 arch/powerpc/boot/44x.c                        |   85 ---
 arch/powerpc/boot/44x.h                        |    5 +-
 arch/powerpc/boot/4xx.c                        |  192 ++++++
 arch/powerpc/boot/4xx.h                        |   21 +
 arch/powerpc/boot/Makefile                     |    7 +-
 arch/powerpc/boot/bamboo.c                     |   45 ++
 arch/powerpc/boot/dcr.h                        |   13 +
 arch/powerpc/boot/dts/bamboo.dts               |  244 ++++++++
 arch/powerpc/boot/ebony.c                      |    3 +-
 arch/powerpc/boot/treeboot-bamboo.c            |   27 +
 arch/powerpc/configs/bamboo_defconfig          |  775 ++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile                   |    2 +-
 arch/powerpc/kernel/{head_4xx.S => head_40x.S} |    3 +-
 arch/powerpc/kernel/ppc_ksyms.c                |    2 +-
 arch/powerpc/kernel/time.c                     |    2 +-
 arch/powerpc/mm/{4xx_mmu.c => 40x_mmu.c}       |    4 +-
 arch/powerpc/mm/Makefile                       |    2 +-
 arch/powerpc/platforms/{4xx => 40x}/Kconfig    |   77 ---
 arch/powerpc/platforms/{4xx => 40x}/Makefile   |    0 
 arch/powerpc/platforms/44x/Kconfig             |   15 +-
 arch/powerpc/platforms/44x/Makefile            |    1 +
 arch/powerpc/platforms/44x/bamboo.c            |   66 ++
 arch/powerpc/platforms/Kconfig.cputype         |    1 +
 include/asm-powerpc/mmu-40x.h                  |   65 ++
 include/asm-powerpc/mmu.h                      |    3 +
 include/asm-powerpc/time.h                     |    2 +-
 27 files changed, 1477 insertions(+), 187 deletions(-)
 delete mode 100644 arch/powerpc/boot/44x.c
 create mode 100644 arch/powerpc/boot/4xx.c
 create mode 100644 arch/powerpc/boot/4xx.h
 create mode 100644 arch/powerpc/boot/bamboo.c
 create mode 100644 arch/powerpc/boot/dts/bamboo.dts
 create mode 100644 arch/powerpc/boot/treeboot-bamboo.c
 create mode 100644 arch/powerpc/configs/bamboo_defconfig
 rename arch/powerpc/kernel/{head_4xx.S => head_40x.S} (100%)
 rename arch/powerpc/mm/{4xx_mmu.c => 40x_mmu.c} (97%)
 rename arch/powerpc/platforms/{4xx => 40x}/Kconfig (68%)
 rename arch/powerpc/platforms/{4xx => 40x}/Makefile (100%)
 create mode 100644 arch/powerpc/platforms/44x/bamboo.c
 create mode 100644 include/asm-powerpc/mmu-40x.h

Josh Boyer (10):
      Rename 4xx paths to 40x
      4xx Kconfig cleanup
      Rename 44x bootwrapper
      4xx bootwrapper reworks
      40x MMU
      40x decrementer fixes
      Fix 40x build
      Bamboo DTS
      Bamboo board support
      Bamboo zImage wrapper
