Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B7C1ADE450
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:19:06 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 3D4CC8810
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 20:19:14 +0400 (SAMT)
Date: Thu, 24 Jan 2008 18:18:50 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v5 0/5] device_type/compatible cleanups
Message-ID: <20080124151850.GA15190@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

This is v5. It's tested on MPC8360E-RDK and MPC8568E-MDS.

Here is diffstat summary:

 Documentation/powerpc/booting-without-of.txt   |   26 +--
 arch/powerpc/boot/dts/mpc832x_mds.dts          |   11 -
 arch/powerpc/boot/dts/mpc832x_rdb.dts          |   11 -
 arch/powerpc/boot/dts/mpc836x_mds.dts          |   11 -
 arch/powerpc/boot/dts/mpc836x_rdk.dts          |   10 -
 arch/powerpc/boot/dts/mpc8568mds.dts           |   10 -
 arch/powerpc/sysdev/fsl_soc.c                  |  191 +++++++++++++++----------
 b/Documentation/powerpc/booting-without-of.txt |   11 -
 b/arch/powerpc/boot/dts/mpc8313erdb.dts        |    4
 b/arch/powerpc/boot/dts/mpc832x_mds.dts        |    9 -
 b/arch/powerpc/boot/dts/mpc832x_rdb.dts        |   10 -
 b/arch/powerpc/boot/dts/mpc8349emitx.dts       |    4
 b/arch/powerpc/boot/dts/mpc8349emitxgp.dts     |    4
 b/arch/powerpc/boot/dts/mpc834x_mds.dts        |    4
 b/arch/powerpc/boot/dts/mpc836x_mds.dts        |   10 -
 b/arch/powerpc/boot/dts/mpc836x_rdk.dts        |    1
 b/arch/powerpc/boot/dts/mpc8568mds.dts         |   10 -
 b/arch/powerpc/kernel/legacy_serial.c          |    3
 b/arch/powerpc/platforms/83xx/mpc832x_mds.c    |   11 -
 b/arch/powerpc/platforms/83xx/mpc832x_rdb.c    |   11 -
 b/arch/powerpc/platforms/83xx/mpc836x_mds.c    |   11 -
 b/arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   32 ++--
 b/arch/powerpc/sysdev/fsl_soc.c                |    5
 b/arch/powerpc/sysdev/qe_lib/qe.c              |   64 +++++---
 b/drivers/net/ucc_geth_mii.c                   |    4
 b/drivers/spi/spi_mpc83xx.c                    |   10 -
 26 files changed, 284 insertions(+), 204 deletions(-)


Changes since v4:
- Now I'm not removing device_type = "qe", because I realized that there
  was a period of time (month or so?) where libfdt-enabled u-boots were
  searching for it;
- new patch that prepares the code for device_type = "soc" removal
  from the device trees. We can't remove it now, because of backward
  compatibility. Though, MPC8360E-RDK is exception here.

Changes since v3:
- Thanks to reviewers, few glitches found and fixed;
- New conversion: device_type = "qeic" to compatible = "fsl,qe-ic";
- Documentation updated.

Changes since v2:
- SPI conversion fixed and actually tested on MPC8323E-RDB to not
  break anything;
- Few more users of device_type = "qe" converted to
  compatible = "fsl,qe";
- Got Ack on SPI part from David Brownell.

Changes since v1:
- Device tree lookup changes should be backward compatible with
  older dtbs;
- Few of_put_node() cleanups;
- cell-index property added to spi nodes;
- cpm-muram{,-data} added as an addition to qe-muram{,-data}.


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
