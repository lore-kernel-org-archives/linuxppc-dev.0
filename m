Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 350FCDDF3F
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 04:35:27 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 61F4C8810
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 22:35:35 +0400 (SAMT)
Date: Thu, 24 Jan 2008 20:35:11 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v5 0/5] device_type/compatible cleanups
Message-ID: <20080124173511.GA16288@localhost.localdomain>
References: <20080124151850.GA15190@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080124151850.GA15190@localhost.localdomain>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 24, 2008 at 06:18:50PM +0300, Anton Vorontsov wrote:
[..]
>  Documentation/powerpc/booting-without-of.txt   |   26 +--
>  arch/powerpc/boot/dts/mpc832x_mds.dts          |   11 -
>  arch/powerpc/boot/dts/mpc832x_rdb.dts          |   11 -
>  arch/powerpc/boot/dts/mpc836x_mds.dts          |   11 -
>  arch/powerpc/boot/dts/mpc836x_rdk.dts          |   10 -
>  arch/powerpc/boot/dts/mpc8568mds.dts           |   10 -
>  arch/powerpc/sysdev/fsl_soc.c                  |  191 +++++++++++++++----------
>  b/Documentation/powerpc/booting-without-of.txt |   11 -
>  b/arch/powerpc/boot/dts/mpc8313erdb.dts        |    4
>  b/arch/powerpc/boot/dts/mpc832x_mds.dts        |    9 -
>  b/arch/powerpc/boot/dts/mpc832x_rdb.dts        |   10 -
>  b/arch/powerpc/boot/dts/mpc8349emitx.dts       |    4
>  b/arch/powerpc/boot/dts/mpc8349emitxgp.dts     |    4
>  b/arch/powerpc/boot/dts/mpc834x_mds.dts        |    4
>  b/arch/powerpc/boot/dts/mpc836x_mds.dts        |   10 -
>  b/arch/powerpc/boot/dts/mpc836x_rdk.dts        |    1
>  b/arch/powerpc/boot/dts/mpc8568mds.dts         |   10 -
>  b/arch/powerpc/kernel/legacy_serial.c          |    3
>  b/arch/powerpc/platforms/83xx/mpc832x_mds.c    |   11 -
>  b/arch/powerpc/platforms/83xx/mpc832x_rdb.c    |   11 -
>  b/arch/powerpc/platforms/83xx/mpc836x_mds.c    |   11 -
>  b/arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   32 ++--
>  b/arch/powerpc/sysdev/fsl_soc.c                |    5
>  b/arch/powerpc/sysdev/qe_lib/qe.c              |   64 +++++---
>  b/drivers/net/ucc_geth_mii.c                   |    4
>  b/drivers/spi/spi_mpc83xx.c                    |   10 -
>  26 files changed, 284 insertions(+), 204 deletions(-)

Heh. `git-format-patch --stdout -5 | diffstat` doesn't work correctly.
Once I've already stumbled against this, but obviously forgot.

Here is correct diffstat summary:

 Documentation/powerpc/booting-without-of.txt |   37 +++----
 arch/powerpc/boot/dts/mpc8313erdb.dts        |    4
 arch/powerpc/boot/dts/mpc832x_mds.dts        |   20 +--
 arch/powerpc/boot/dts/mpc832x_rdb.dts        |   21 ++-
 arch/powerpc/boot/dts/mpc8349emitx.dts       |    4
 arch/powerpc/boot/dts/mpc8349emitxgp.dts     |    4
 arch/powerpc/boot/dts/mpc834x_mds.dts        |    4
 arch/powerpc/boot/dts/mpc836x_mds.dts        |   21 ++-
 arch/powerpc/boot/dts/mpc836x_rdk.dts        |   11 --
 arch/powerpc/boot/dts/mpc8568mds.dts         |   20 ++-
 arch/powerpc/kernel/legacy_serial.c          |    3
 arch/powerpc/platforms/83xx/mpc832x_mds.c    |   11 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c    |   11 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c    |   11 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   32 +++---
 arch/powerpc/sysdev/fsl_soc.c                |  142 ++++++++++++++++++---------
 arch/powerpc/sysdev/qe_lib/qe.c              |   63 ++++++++---
 drivers/net/ucc_geth_mii.c                   |    3
 drivers/spi/spi_mpc83xx.c                    |    6 -
 19 files changed, 258 insertions(+), 170 deletions(-)

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
