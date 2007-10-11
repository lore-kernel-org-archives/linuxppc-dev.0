Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4781EDE101
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 04:45:19 +1000 (EST)
Date: Thu, 11 Oct 2007 13:44:40 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.24' branch [updated]
In-Reply-To: <Pine.LNX.4.64.0710110918500.11335@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0710111343580.27057@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0710110918500.11335@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Added the two patches to use PAGE_OFFSET and set TASK_SIZE to 3GB)

Please pull from 'for-2.6.24' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.24

to receive the following updates:

 arch/powerpc/Kconfig                       |    3
 arch/powerpc/boot/dts/mpc8272ads.dts       |    2
 arch/powerpc/boot/dts/mpc8541cds.dts       |   36 ++++++
 arch/powerpc/boot/dts/mpc8555cds.dts       |   36 ++++++
 arch/powerpc/boot/dts/mpc8560ads.dts       |   82 +++++++-------
 arch/powerpc/configs/mpc8560_ads_defconfig |   23 +++
 arch/powerpc/kernel/head_32.S              |   18 +--
 arch/powerpc/kernel/head_40x.S             |    6 -
 arch/powerpc/kernel/head_44x.S             |    6 -
 arch/powerpc/kernel/head_fsl_booke.S       |   11 -
 arch/powerpc/platforms/85xx/Kconfig        |    1
 arch/powerpc/platforms/85xx/mpc8540_ads.h  |   35 ------
 arch/powerpc/platforms/85xx/mpc85xx_ads.c  |  168 +++++++++++++++--------------
 arch/powerpc/platforms/85xx/mpc85xx_ads.h  |   60 ----------
 arch/powerpc/platforms/85xx/mpc85xx_cds.c  |   10 +
 arch/powerpc/platforms/85xx/mpc85xx_cds.h  |   43 -------
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   |    1
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    1
 include/asm-powerpc/cpm2.h                 |    4
 include/asm-powerpc/fs_pd.h                |    2
 include/asm-powerpc/mpc85xx.h              |   45 -------
 21 files changed, 259 insertions(+), 334 deletions(-)

Kumar Gala (4):
      [POWERPC] 85xx: Killed <asm/mpc85xx.h>
      [POWERPC] 85xx: Enable FP emulation in MPC8560 ADS defconfig
      [POWERPC] Use PAGE_OFFSET to tell if an address is user/kernel in SW TLB handlers
      [POWERPC] Adjust TASK_SIZE on ppc32 systems to 3GB that are capable

Scott Wood (3):
      [POWERPC] mpc8272ads: Remove muram from the CPM reg property.
      [POWERPC] 85xx: Convert mpc8560ads to the new CPM binding.
      [POWERPC] 85xx: Add cpm nodes for 8541/8555 CDS
